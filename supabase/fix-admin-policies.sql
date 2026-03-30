-- Limpiar policies anteriores (por si quedaron a medias)
DROP POLICY IF EXISTS "admin_write_modulos" ON modulos;
DROP POLICY IF EXISTS "admin_write_lecciones" ON lecciones;
DROP POLICY IF EXISTS "admin_write_pruebas" ON pruebas;
DROP POLICY IF EXISTS "admin_all_preguntas" ON preguntas;
DROP POLICY IF EXISTS "admin_write_retos" ON retos;

-- Crear policies separadas por operacion (mas confiable que FOR ALL)

-- MODULOS
CREATE POLICY "admin_insert_modulos" ON modulos FOR INSERT TO authenticated
  WITH CHECK ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin');
CREATE POLICY "admin_update_modulos" ON modulos FOR UPDATE TO authenticated
  USING ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin');
CREATE POLICY "admin_delete_modulos" ON modulos FOR DELETE TO authenticated
  USING ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin');

-- LECCIONES
CREATE POLICY "admin_insert_lecciones" ON lecciones FOR INSERT TO authenticated
  WITH CHECK ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin');
CREATE POLICY "admin_update_lecciones" ON lecciones FOR UPDATE TO authenticated
  USING ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin');
CREATE POLICY "admin_delete_lecciones" ON lecciones FOR DELETE TO authenticated
  USING ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin');

-- PRUEBAS
CREATE POLICY "admin_insert_pruebas" ON pruebas FOR INSERT TO authenticated
  WITH CHECK ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin');
CREATE POLICY "admin_update_pruebas" ON pruebas FOR UPDATE TO authenticated
  USING ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin');
CREATE POLICY "admin_delete_pruebas" ON pruebas FOR DELETE TO authenticated
  USING ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin');

-- PREGUNTAS (admin necesita SELECT + INSERT + UPDATE + DELETE)
CREATE POLICY "admin_select_preguntas" ON preguntas FOR SELECT TO authenticated
  USING ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin');
CREATE POLICY "admin_insert_preguntas" ON preguntas FOR INSERT TO authenticated
  WITH CHECK ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin');
CREATE POLICY "admin_update_preguntas" ON preguntas FOR UPDATE TO authenticated
  USING ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin');
CREATE POLICY "admin_delete_preguntas" ON preguntas FOR DELETE TO authenticated
  USING ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin');

-- RETOS
CREATE POLICY "admin_insert_retos" ON retos FOR INSERT TO authenticated
  WITH CHECK ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin');
CREATE POLICY "admin_update_retos" ON retos FOR UPDATE TO authenticated
  USING ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin');
CREATE POLICY "admin_delete_retos" ON retos FOR DELETE TO authenticated
  USING ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin');
