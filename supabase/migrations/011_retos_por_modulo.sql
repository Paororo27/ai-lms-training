-- ============================================================
-- Migrar retos de global a por modulo
-- ============================================================

-- 1. Agregar modulo_id a retos (cada modulo tiene su propio reto)
ALTER TABLE retos ADD COLUMN modulo_id SMALLINT REFERENCES modulos(id) ON DELETE CASCADE;
CREATE UNIQUE INDEX retos_modulo_id_unique ON retos(modulo_id) WHERE modulo_id IS NOT NULL;

-- 2. Cambiar entregas_reto: permitir multiples entregas por usuario (una por reto)
ALTER TABLE entregas_reto DROP CONSTRAINT entregas_reto_usuario_id_key;
ALTER TABLE entregas_reto ADD CONSTRAINT entregas_reto_usuario_reto_unique UNIQUE (usuario_id, reto_id);

-- 3. Agregar campo url_entrega para el link de OneDrive
ALTER TABLE entregas_reto ADD COLUMN url_entrega TEXT;

-- 4. Agregar campo nombre_archivo para el nombre convencional
ALTER TABLE entregas_reto ADD COLUMN nombre_archivo TEXT;

-- 5. Eliminar constraint de coherencia (ya no aplica puntaje/retroalimentacion)
ALTER TABLE entregas_reto DROP CONSTRAINT IF EXISTS entregas_calificacion_coherencia;

-- 6. Eliminar columnas que ya no aplican
ALTER TABLE entregas_reto DROP COLUMN IF EXISTS contenido;
ALTER TABLE entregas_reto DROP COLUMN IF EXISTS puntaje;
ALTER TABLE entregas_reto DROP COLUMN IF EXISTS retroalimentacion;

-- 7. Limpiar entregas huerfanas (datos de prueba previos)
DELETE FROM entregas_reto WHERE reto_id NOT IN (SELECT id FROM retos);

-- ============================================================
-- Actualizar RLS policies
-- ============================================================

-- 8. Retos: actualizar policy de lectura
DROP POLICY IF EXISTS "users_read_assigned_reto" ON retos;
CREATE POLICY "users_read_retos" ON retos
  FOR SELECT TO authenticated USING (true);

-- 9. Entregas: permitir INSERT directo (ya no via RPC)
--    Valida que el reto tenga modulo asignado y que el estado sea 'enviado'
CREATE POLICY "users_insert_own_entrega" ON entregas_reto
  FOR INSERT TO authenticated WITH CHECK (
    usuario_id = (select auth.uid())
    AND reto_id IN (SELECT id FROM retos WHERE modulo_id IS NOT NULL)
    AND estado = 'enviado'
  );

-- 10. Entregas: actualizar policy de lectura
DROP POLICY IF EXISTS "users_read_own_entrega" ON entregas_reto;
CREATE POLICY "users_read_own_entrega" ON entregas_reto
  FOR SELECT USING (usuario_id = (select auth.uid()));

-- 11. Entregas: actualizar policy de UPDATE (solo borradores)
DROP POLICY IF EXISTS "users_update_own_entrega" ON entregas_reto;
CREATE POLICY "users_update_own_entrega" ON entregas_reto
  FOR UPDATE USING (
    usuario_id = (select auth.uid())
    AND estado = 'borrador'
  );

-- ============================================================
-- Eliminar RPC obsoleta
-- ============================================================

-- 12. assign_challenge ya no se necesita
DROP FUNCTION IF EXISTS assign_challenge(UUID);

-- ============================================================
-- Actualizar check_certificate_ready para retos por modulo
-- ============================================================

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
  v_total_retos SMALLINT;
  v_retos_enviados SMALLINT;
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
  WHERE ip.usuario_id = p_usuario_id AND ip.aprobado = true AND p.tipo = 'modular';

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

  SELECT COUNT(*) INTO v_total_retos
  FROM public.retos WHERE modulo_id IS NOT NULL;

  SELECT COUNT(*) INTO v_retos_enviados
  FROM public.entregas_reto er
  JOIN public.retos r ON er.reto_id = r.id
  WHERE er.usuario_id = p_usuario_id AND er.estado = 'enviado' AND r.modulo_id IS NOT NULL;

  IF v_retos_enviados < v_total_retos THEN
    v_missing := array_append(v_missing,
      format('Retos: %s de %s enviados', v_retos_enviados, v_total_retos));
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
