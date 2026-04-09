-- 016_modulo_disponible.sql
-- Agregar columna disponible a modulos para control de acceso por admin
-- PG 11+: ADD COLUMN NOT NULL DEFAULT es metadata-only, sin rewrite

ALTER TABLE modulos ADD COLUMN disponible BOOLEAN NOT NULL DEFAULT false;

-- Habilitar modulos 1 y 2 (semana 1)
UPDATE modulos SET disponible = true WHERE orden IN (1, 2);
