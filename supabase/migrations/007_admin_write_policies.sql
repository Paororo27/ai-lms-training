-- ============================================================
-- Admin write policies + constraint mejorado de opciones
-- ============================================================

-- Admin CRUD en tablas de contenido
CREATE POLICY "admin_write_modulos" ON modulos
  FOR ALL TO authenticated
  USING ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin')
  WITH CHECK ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin');

CREATE POLICY "admin_write_lecciones" ON lecciones
  FOR ALL TO authenticated
  USING ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin')
  WITH CHECK ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin');

CREATE POLICY "admin_write_pruebas" ON pruebas
  FOR ALL TO authenticated
  USING ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin')
  WITH CHECK ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin');

-- CRITICO: admin necesita SELECT en preguntas para que CRUD retorne data
CREATE POLICY "admin_all_preguntas" ON preguntas
  FOR ALL TO authenticated
  USING ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin')
  WITH CHECK ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin');

CREATE POLICY "admin_write_retos" ON retos
  FOR ALL TO authenticated
  USING ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin')
  WITH CHECK ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin');

-- Mejorar constraint de opciones: validar estructura interna
ALTER TABLE preguntas DROP CONSTRAINT IF EXISTS preguntas_opciones_check;
ALTER TABLE preguntas ADD CONSTRAINT preguntas_opciones_check CHECK (
  jsonb_typeof(opciones) = 'array'
  AND jsonb_array_length(opciones) >= 2
  AND NOT EXISTS (
    SELECT 1 FROM jsonb_array_elements(opciones) elem
    WHERE elem->>'texto' IS NULL
      OR jsonb_typeof(elem->'es_correcta') != 'boolean'
  )
  AND (SELECT COUNT(*) FROM jsonb_array_elements(opciones) elem
       WHERE (elem->>'es_correcta')::boolean = true) = 1
);
