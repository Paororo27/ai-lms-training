-- ============================================================
-- Security fixes: auth.uid() validation, LIMIT NULL guard,
-- race condition fix, GRANT/REVOKE
-- ============================================================

-- 1. get_quiz_questions: validar auth.uid() + guard LIMIT NULL
CREATE OR REPLACE FUNCTION get_quiz_questions(p_prueba_id SMALLINT, p_usuario_id UUID)
RETURNS TABLE (
  id INT,
  texto TEXT,
  opciones JSONB
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
DECLARE
  v_preguntas_por_intento SMALLINT;
BEGIN
  -- Validar que el caller es el mismo usuario
  IF p_usuario_id != (SELECT auth.uid()) THEN
    RAISE EXCEPTION 'No autorizado';
  END IF;

  SELECT preguntas_por_intento INTO v_preguntas_por_intento
  FROM public.pruebas WHERE public.pruebas.id = p_prueba_id;

  -- Guard: si la prueba no existe, no retornar nada
  IF v_preguntas_por_intento IS NULL THEN
    RAISE EXCEPTION 'Prueba no encontrada: %', p_prueba_id;
  END IF;

  RETURN QUERY
  SELECT
    p.id,
    p.texto,
    (
      SELECT jsonb_agg(
        jsonb_build_object('texto', elem->>'texto', 'indice', idx)
      )
      FROM jsonb_array_elements(p.opciones) WITH ORDINALITY AS arr(elem, idx)
    ) AS opciones
  FROM public.preguntas p
  WHERE p.prueba_id = p_prueba_id
  AND NOT EXISTS (
    SELECT 1 FROM public.intentos_prueba ip
    WHERE ip.usuario_id = p_usuario_id
    AND ip.prueba_id = p_prueba_id
    AND p.id = ANY(
      SELECT jsonb_array_elements_text(ip.preguntas_usadas)::INT
    )
  )
  ORDER BY RANDOM()
  LIMIT v_preguntas_por_intento;
END;
$$;

-- 2. assign_challenge: validar auth.uid() + INSERT ON CONFLICT (race condition fix)
CREATE OR REPLACE FUNCTION assign_challenge(p_usuario_id UUID)
RETURNS TABLE (
  reto_id SMALLINT,
  titulo TEXT,
  escenario TEXT,
  criterios_evaluacion JSONB
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
DECLARE
  v_random_reto_id SMALLINT;
BEGIN
  -- Validar que el caller es el mismo usuario
  IF p_usuario_id != (SELECT auth.uid()) THEN
    RAISE EXCEPTION 'No autorizado';
  END IF;

  -- Seleccionar reto aleatorio
  SELECT r.id INTO v_random_reto_id
  FROM public.retos r
  ORDER BY RANDOM()
  LIMIT 1;

  IF v_random_reto_id IS NULL THEN
    RAISE EXCEPTION 'No hay retos disponibles';
  END IF;

  -- INSERT idempotente: si ya existe, no hace nada (race-safe)
  INSERT INTO public.entregas_reto (usuario_id, reto_id, estado)
  VALUES (p_usuario_id, v_random_reto_id, 'borrador')
  ON CONFLICT (usuario_id) DO NOTHING;

  -- Retornar el reto asignado (existente o recien creado)
  RETURN QUERY
  SELECT r.id, r.titulo, r.escenario, r.criterios_evaluacion
  FROM public.entregas_reto er
  JOIN public.retos r ON er.reto_id = r.id
  WHERE er.usuario_id = p_usuario_id;
END;
$$;

-- 3. check_certificate_ready: validar auth.uid()
CREATE OR REPLACE FUNCTION check_certificate_ready(p_usuario_id UUID)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
DECLARE
  v_result JSONB;
  v_missing TEXT[] := '{}';
  v_total_pruebas_modulares SMALLINT;
  v_aprobadas SMALLINT;
  v_diag_pre_done BOOLEAN;
  v_diag_post_done BOOLEAN;
  v_reto_enviado BOOLEAN;
  v_scores JSONB;
BEGIN
  -- Validar que el caller es el mismo usuario
  IF p_usuario_id != (SELECT auth.uid()) THEN
    RAISE EXCEPTION 'No autorizado';
  END IF;

  SELECT COUNT(*) INTO v_total_pruebas_modulares
  FROM public.pruebas WHERE tipo = 'modular';

  SELECT COUNT(DISTINCT ip.prueba_id) INTO v_aprobadas
  FROM public.intentos_prueba ip
  JOIN public.pruebas p ON ip.prueba_id = p.id
  WHERE ip.usuario_id = p_usuario_id
  AND ip.aprobado = true
  AND p.tipo = 'modular';

  IF v_aprobadas < v_total_pruebas_modulares THEN
    v_missing := array_append(v_missing,
      format('Pruebas modulares: %s de %s aprobadas', v_aprobadas, v_total_pruebas_modulares));
  END IF;

  SELECT EXISTS(
    SELECT 1 FROM public.intentos_prueba ip
    JOIN public.pruebas p ON ip.prueba_id = p.id
    WHERE ip.usuario_id = p_usuario_id AND p.tipo = 'diagnostico_pre'
  ) INTO v_diag_pre_done;
  IF NOT v_diag_pre_done THEN
    v_missing := array_append(v_missing, 'Diagnostico de entrada no completado');
  END IF;

  SELECT EXISTS(
    SELECT 1 FROM public.intentos_prueba ip
    JOIN public.pruebas p ON ip.prueba_id = p.id
    WHERE ip.usuario_id = p_usuario_id AND p.tipo = 'diagnostico_post'
  ) INTO v_diag_post_done;
  IF NOT v_diag_post_done THEN
    v_missing := array_append(v_missing, 'Diagnostico de salida no completado');
  END IF;

  SELECT EXISTS(
    SELECT 1 FROM public.entregas_reto
    WHERE usuario_id = p_usuario_id AND estado = 'enviado'
  ) INTO v_reto_enviado;
  IF NOT v_reto_enviado THEN
    v_missing := array_append(v_missing, 'Reto final no entregado');
  END IF;

  SELECT jsonb_build_object(
    'promedio_modular', COALESCE((
      SELECT ROUND(AVG(best.max_puntaje))
      FROM (
        SELECT MAX(ip.puntaje) as max_puntaje
        FROM public.intentos_prueba ip
        JOIN public.pruebas p ON ip.prueba_id = p.id
        WHERE ip.usuario_id = p_usuario_id AND p.tipo = 'modular'
        GROUP BY ip.prueba_id
      ) best
    ), 0),
    'diagnostico_pre', COALESCE((
      SELECT ip.puntaje FROM public.intentos_prueba ip
      JOIN public.pruebas p ON ip.prueba_id = p.id
      WHERE ip.usuario_id = p_usuario_id AND p.tipo = 'diagnostico_pre'
      LIMIT 1
    ), 0),
    'diagnostico_post', COALESCE((
      SELECT ip.puntaje FROM public.intentos_prueba ip
      JOIN public.pruebas p ON ip.prueba_id = p.id
      WHERE ip.usuario_id = p_usuario_id AND p.tipo = 'diagnostico_post'
      LIMIT 1
    ), 0)
  ) INTO v_scores;

  RETURN jsonb_build_object(
    'ready', array_length(v_missing, 1) IS NULL,
    'missing', to_jsonb(v_missing),
    'scores', v_scores
  );
END;
$$;

-- 4. GRANT/REVOKE: solo authenticated puede ejecutar estas funciones
REVOKE ALL ON FUNCTION get_quiz_questions FROM public, anon;
GRANT EXECUTE ON FUNCTION get_quiz_questions TO authenticated;

REVOKE ALL ON FUNCTION assign_challenge FROM public, anon;
GRANT EXECUTE ON FUNCTION assign_challenge TO authenticated;

REVOKE ALL ON FUNCTION check_certificate_ready FROM public, anon;
GRANT EXECUTE ON FUNCTION check_certificate_ready TO authenticated;
