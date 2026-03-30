-- ============================================================
-- RLS Policies
-- Patron: (select auth.uid()) para activar initPlan (94-99% mas rapido)
-- ============================================================

-- Habilitar RLS en todas las tablas
ALTER TABLE modulos ENABLE ROW LEVEL SECURITY;
ALTER TABLE lecciones ENABLE ROW LEVEL SECURITY;
ALTER TABLE pruebas ENABLE ROW LEVEL SECURITY;
ALTER TABLE preguntas ENABLE ROW LEVEL SECURITY;
ALTER TABLE progreso_usuario ENABLE ROW LEVEL SECURITY;
ALTER TABLE intentos_prueba ENABLE ROW LEVEL SECURITY;
ALTER TABLE retos ENABLE ROW LEVEL SECURITY;
ALTER TABLE entregas_reto ENABLE ROW LEVEL SECURITY;

-- ==================
-- Contenido publico (lectura para cualquier usuario autenticado)
-- ==================

CREATE POLICY "authenticated_read_modulos" ON modulos
  FOR SELECT TO authenticated USING (true);

CREATE POLICY "authenticated_read_lecciones" ON lecciones
  FOR SELECT TO authenticated USING (true);

CREATE POLICY "authenticated_read_pruebas" ON pruebas
  FOR SELECT TO authenticated USING (true);

-- PREGUNTAS: Sin policy de SELECT → bloqueada por defecto
-- Solo accesible via funcion get_quiz_questions (security definer)

-- RETOS: solo leer si el usuario tiene asignacion
CREATE POLICY "users_read_assigned_reto" ON retos
  FOR SELECT TO authenticated USING (
    EXISTS (
      SELECT 1 FROM entregas_reto
      WHERE entregas_reto.reto_id = retos.id
      AND entregas_reto.usuario_id = (select auth.uid())
    )
  );

-- ==================
-- Datos del usuario (lectura/escritura propios datos)
-- ==================

-- PROGRESO_USUARIO
CREATE POLICY "users_read_own_progress" ON progreso_usuario
  FOR SELECT TO authenticated USING ((select auth.uid()) = usuario_id);

CREATE POLICY "users_insert_own_progress" ON progreso_usuario
  FOR INSERT TO authenticated WITH CHECK ((select auth.uid()) = usuario_id);

CREATE POLICY "users_update_own_progress" ON progreso_usuario
  FOR UPDATE TO authenticated USING ((select auth.uid()) = usuario_id);

-- INTENTOS_PRUEBA
CREATE POLICY "users_read_own_intentos" ON intentos_prueba
  FOR SELECT TO authenticated USING (
    (select auth.uid()) = usuario_id
    OR (select (auth.jwt()->'app_metadata'->>'role')) = 'admin'
  );

-- INSERT solo via Edge Function submit-quiz (service_role bypassa RLS)
-- No se permite INSERT directo desde el cliente

-- ENTREGAS_RETO
CREATE POLICY "users_read_own_entrega" ON entregas_reto
  FOR SELECT TO authenticated USING ((select auth.uid()) = usuario_id);

CREATE POLICY "users_update_own_entrega" ON entregas_reto
  FOR UPDATE TO authenticated USING (
    (select auth.uid()) = usuario_id AND estado = 'borrador'
  );

-- ==================
-- Admin: lectura de todos los datos
-- ==================

CREATE POLICY "admin_read_all_progress" ON progreso_usuario
  FOR SELECT TO authenticated USING (
    (select (auth.jwt()->'app_metadata'->>'role')) = 'admin'
  );

CREATE POLICY "admin_read_all_entregas" ON entregas_reto
  FOR SELECT TO authenticated USING (
    (select (auth.jwt()->'app_metadata'->>'role')) = 'admin'
  );
