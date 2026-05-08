-- 018_certificate_admin_y_nombre.sql
-- 1. check_certificate_ready: bypass admin + retornar nombre del participante
-- 2. get_user_codes: incluir nombre

CREATE OR REPLACE FUNCTION check_certificate_ready(p_usuario_id UUID)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
DECLARE
  v_missing TEXT[] := '{}';
  v_total_pruebas_modulares SMALLINT;
  v_aprobadas SMALLINT;
  v_diag_pre_done BOOLEAN;
  v_diag_post_done BOOLEAN;
  v_reto_enviado BOOLEAN;
  v_scores JSONB;
  v_is_admin BOOLEAN;
  v_nombre TEXT;
BEGIN
  v_is_admin := COALESCE((SELECT auth.jwt()->'app_metadata'->>'role') = 'admin', false);

  IF p_usuario_id != (SELECT auth.uid()) AND NOT v_is_admin THEN
    RAISE EXCEPTION 'No autorizado';
  END IF;

  SELECT u.raw_app_meta_data->>'nombre' INTO v_nombre
  FROM auth.users u WHERE u.id = p_usuario_id;

  SELECT COUNT(*) INTO v_total_pruebas_modulares
  FROM public.pruebas p
  JOIN public.modulos m ON p.modulo_id = m.id
  WHERE p.tipo = 'modular' AND m.disponible = true;

  SELECT COUNT(DISTINCT ip.prueba_id) INTO v_aprobadas
  FROM public.intentos_prueba ip
  JOIN public.pruebas p ON ip.prueba_id = p.id
  JOIN public.modulos m ON p.modulo_id = m.id
  WHERE ip.usuario_id = p_usuario_id
  AND ip.aprobado = true
  AND p.tipo = 'modular'
  AND m.disponible = true;

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
        JOIN public.modulos m ON p.modulo_id = m.id
        WHERE ip.usuario_id = p_usuario_id AND p.tipo = 'modular' AND m.disponible = true
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
    'scores', v_scores,
    'nombre', v_nombre
  );
END;
$$;

DROP FUNCTION IF EXISTS get_user_codes(UUID[]);

CREATE FUNCTION get_user_codes(p_user_ids UUID[])
RETURNS TABLE (id UUID, code TEXT, nombre TEXT)
LANGUAGE sql
SECURITY DEFINER
SET search_path = ''
AS $$
  SELECT u.id,
         split_part(u.email, '@', 1) AS code,
         u.raw_app_meta_data->>'nombre' AS nombre
  FROM auth.users u
  WHERE u.id = ANY(p_user_ids);
$$;
