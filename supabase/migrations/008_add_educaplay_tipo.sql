-- Agregar tipo 'recurso_externo' para lecciones con contenido embebido (Educaplay, Genially, etc.)
ALTER TABLE lecciones DROP CONSTRAINT lecciones_tipo_check;
ALTER TABLE lecciones ADD CONSTRAINT lecciones_tipo_check
  CHECK (tipo IN ('video', 'texto', 'ejercicio', 'recurso_externo'));
