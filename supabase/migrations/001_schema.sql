-- ============================================================
-- LMS Copilot Chat - Schema principal
-- 7 tablas: modulos, lecciones, pruebas, preguntas,
--           progreso_usuario, intentos_prueba, entregas_reto, retos
-- ============================================================

-- MODULOS
CREATE TABLE modulos (
  id SMALLSERIAL PRIMARY KEY,
  orden SMALLINT NOT NULL UNIQUE,
  semana SMALLINT NOT NULL CHECK (semana BETWEEN 1 AND 4),
  titulo TEXT NOT NULL,
  descripcion TEXT,
  contenido JSONB,
  duracion_minutos SMALLINT NOT NULL CHECK (duracion_minutos > 0),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- LECCIONES
CREATE TABLE lecciones (
  id SMALLSERIAL PRIMARY KEY,
  modulo_id SMALLINT NOT NULL REFERENCES modulos(id) ON DELETE CASCADE,
  orden SMALLINT NOT NULL,
  titulo TEXT NOT NULL,
  tipo TEXT NOT NULL CHECK (tipo IN ('video', 'texto', 'ejercicio', 'recurso_externo')),
  contenido JSONB NOT NULL,
  duracion_minutos SMALLINT NOT NULL CHECK (duracion_minutos > 0),
  UNIQUE (modulo_id, orden)
);

-- PRUEBAS
CREATE TABLE pruebas (
  id SMALLSERIAL PRIMARY KEY,
  modulo_id SMALLINT REFERENCES modulos(id) ON DELETE CASCADE,
  tipo TEXT NOT NULL CHECK (tipo IN ('modular', 'diagnostico_pre', 'diagnostico_post')),
  titulo TEXT NOT NULL,
  preguntas_por_intento SMALLINT NOT NULL CHECK (preguntas_por_intento > 0),
  puntaje_aprobatorio SMALLINT NOT NULL DEFAULT 80 CHECK (puntaje_aprobatorio BETWEEN 0 AND 100),
  orden SMALLINT NOT NULL UNIQUE,
  CONSTRAINT pruebas_modulo_coherencia CHECK (
    (tipo = 'modular' AND modulo_id IS NOT NULL)
    OR (tipo IN ('diagnostico_pre', 'diagnostico_post') AND modulo_id IS NULL)
  )
);

-- PREGUNTAS (banco de preguntas — nunca expuesta directamente al cliente)
CREATE TABLE preguntas (
  id SERIAL PRIMARY KEY,
  prueba_id SMALLINT NOT NULL REFERENCES pruebas(id) ON DELETE CASCADE,
  texto TEXT NOT NULL,
  opciones JSONB NOT NULL,
  explicacion TEXT NOT NULL,
  CONSTRAINT preguntas_opciones_check CHECK (
    jsonb_typeof(opciones) = 'array' AND jsonb_array_length(opciones) >= 2
  )
);

-- PROGRESO_USUARIO (tracking por leccion)
CREATE TABLE progreso_usuario (
  id SERIAL PRIMARY KEY,
  usuario_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE RESTRICT,
  leccion_id SMALLINT NOT NULL REFERENCES lecciones(id) ON DELETE CASCADE,
  completado BOOLEAN NOT NULL DEFAULT false,
  completado_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (usuario_id, leccion_id),
  CONSTRAINT progreso_coherencia CHECK (
    (completado = true AND completado_at IS NOT NULL)
    OR (completado = false AND completado_at IS NULL)
  )
);

-- INTENTOS_PRUEBA (maximo 2 por usuario+prueba)
CREATE TABLE intentos_prueba (
  id SERIAL PRIMARY KEY,
  usuario_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE RESTRICT,
  prueba_id SMALLINT NOT NULL REFERENCES pruebas(id) ON DELETE RESTRICT,
  numero_intento SMALLINT NOT NULL CHECK (numero_intento IN (1, 2)),
  puntaje SMALLINT NOT NULL CHECK (puntaje BETWEEN 0 AND 100),
  respuestas JSONB NOT NULL,
  preguntas_usadas JSONB NOT NULL,
  aprobado BOOLEAN NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (usuario_id, prueba_id, numero_intento)
);

-- RETOS (pool de casos practicos)
CREATE TABLE retos (
  id SMALLSERIAL PRIMARY KEY,
  titulo TEXT NOT NULL,
  escenario TEXT NOT NULL,
  criterios_evaluacion JSONB,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- ENTREGAS_RETO (asignacion + entrega fusionadas, 1 por usuario)
CREATE TABLE entregas_reto (
  id SERIAL PRIMARY KEY,
  usuario_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE RESTRICT UNIQUE,
  reto_id SMALLINT NOT NULL REFERENCES retos(id) ON DELETE RESTRICT,
  contenido TEXT,
  estado TEXT NOT NULL DEFAULT 'borrador' CHECK (estado IN ('borrador', 'enviado')),
  puntaje SMALLINT CHECK (puntaje IS NULL OR puntaje BETWEEN 0 AND 100),
  retroalimentacion TEXT,
  assigned_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  submitted_at TIMESTAMPTZ,
  CONSTRAINT entregas_calificacion_coherencia CHECK (
    (estado = 'borrador' AND puntaje IS NULL AND retroalimentacion IS NULL)
    OR estado = 'enviado'
  )
);
