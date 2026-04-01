-- Admin puede borrar progreso de usuarios (reset)
CREATE POLICY "admin_delete_intentos_prueba" ON intentos_prueba
  FOR DELETE TO authenticated
  USING ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin');

CREATE POLICY "admin_delete_progreso_usuario" ON progreso_usuario
  FOR DELETE TO authenticated
  USING ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin');

CREATE POLICY "admin_delete_entregas_reto" ON entregas_reto
  FOR DELETE TO authenticated
  USING ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin');
