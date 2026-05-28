-- ============================================================
-- Fix: get_quiz_questions devolvia 0 preguntas en el reintento
-- cuando el banco de preguntas era <= preguntas_por_intento
-- (todas las preguntas quedaban "usadas" tras el intento 1).
--
-- Nueva logica: priorizar preguntas no usadas, pero rellenar
-- con preguntas ya usadas cuando no alcanzan, garantizando
-- siempre min(banco, preguntas_por_intento) preguntas.
-- ============================================================

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
  ORDER BY
    -- Las no usadas primero (0); rellenar con usadas (1) solo si hacen falta
    CASE WHEN EXISTS (
      SELECT 1 FROM public.intentos_prueba ip
      WHERE ip.usuario_id = p_usuario_id
      AND ip.prueba_id = p_prueba_id
      AND p.id = ANY(
        SELECT jsonb_array_elements_text(ip.preguntas_usadas)::INT
      )
    ) THEN 1 ELSE 0 END,
    RANDOM()
  LIMIT v_preguntas_por_intento;
END;
$$;

REVOKE ALL ON FUNCTION get_quiz_questions FROM public, anon;
GRANT EXECUTE ON FUNCTION get_quiz_questions TO authenticated;
