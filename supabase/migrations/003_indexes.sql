-- ============================================================
-- Indices para queries frecuentes
-- Los UNIQUE constraints ya crean indices implicitos
-- ============================================================

CREATE INDEX idx_progreso_usuario ON progreso_usuario(usuario_id);
CREATE INDEX idx_intentos_usuario_prueba ON intentos_prueba(usuario_id, prueba_id);
CREATE INDEX idx_entregas_usuario ON entregas_reto(usuario_id);
CREATE INDEX idx_lecciones_modulo ON lecciones(modulo_id, orden);
CREATE INDEX idx_pruebas_modulo ON pruebas(modulo_id);
CREATE INDEX idx_preguntas_prueba ON preguntas(prueba_id);
