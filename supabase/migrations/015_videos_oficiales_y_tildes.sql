BEGIN;

-- ============================================================
-- PASO 1: Eliminar lecciones tipo video de módulos 2-8
-- ============================================================
DELETE FROM lecciones
WHERE tipo = 'video'
AND modulo_id IN (SELECT id FROM modulos WHERE orden IN (2, 3, 4, 5, 6, 7, 8));

-- ============================================================
-- PASO 2: Desplazar lecciones existentes para hacer espacio
-- Mover a orden alto temporal para evitar conflictos de UNIQUE
-- ============================================================

-- Módulo 2: 1 video, textos empiezan en 2
UPDATE lecciones SET orden = orden + 100
WHERE modulo_id = (SELECT id FROM modulos WHERE orden = 2);
UPDATE lecciones SET orden = orden - 100 + 1
WHERE modulo_id = (SELECT id FROM modulos WHERE orden = 2);

-- Módulo 3: 1 video, textos empiezan en 2
UPDATE lecciones SET orden = orden + 100
WHERE modulo_id = (SELECT id FROM modulos WHERE orden = 3);
UPDATE lecciones SET orden = orden - 100 + 1
WHERE modulo_id = (SELECT id FROM modulos WHERE orden = 3);

-- Módulo 4: 1 video, textos empiezan en 2
UPDATE lecciones SET orden = orden + 100
WHERE modulo_id = (SELECT id FROM modulos WHERE orden = 4);
UPDATE lecciones SET orden = orden - 100 + 1
WHERE modulo_id = (SELECT id FROM modulos WHERE orden = 4);

-- Módulo 5: 5 videos, textos empiezan en 6
UPDATE lecciones SET orden = orden + 100
WHERE modulo_id = (SELECT id FROM modulos WHERE orden = 5);
UPDATE lecciones SET orden = orden - 100 + 5
WHERE modulo_id = (SELECT id FROM modulos WHERE orden = 5);

-- Módulo 6: 1 video, textos empiezan en 2
UPDATE lecciones SET orden = orden + 100
WHERE modulo_id = (SELECT id FROM modulos WHERE orden = 6);
UPDATE lecciones SET orden = orden - 100 + 1
WHERE modulo_id = (SELECT id FROM modulos WHERE orden = 6);

-- ============================================================
-- PASO 3: Insertar videos oficiales de Paola Andrea Rodríguez
-- ============================================================

-- Módulo 2: El Poder del "NO" y el Blindaje de Datos
INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 2), 1, 'El poder del "NO" y el blindaje de datos', 'video',
 '{"media_url": "3fyceNipllY", "texto": "Cómo proteger la información corporativa al usar herramientas de IA. Créditos: Paola Andrea Rodríguez."}', 10);

-- Módulo 3: ADN Digital: Clonación y Lógica
INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 3), 1, 'ADN Digital: clonación y lógica', 'video',
 '{"media_url": "F2YhpLLw8v8", "texto": "Técnicas de clonación de patrones y lógica para construir prompts efectivos con ejemplos. Créditos: Paola Andrea Rodríguez."}', 10);

-- Módulo 4: Ejemplos PE HR
INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 4), 1, 'Ejemplos de Prompt Engineering para RRHH', 'video',
 '{"media_url": "fZckiUNpeWU", "texto": "Casos prácticos de prompting avanzado aplicados a Recursos Humanos. Créditos: Paola Andrea Rodríguez."}', 10);

-- Módulo 5: 5 videos de creación con Copilot
INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 5), 1, 'Descubre todo lo que puedes crear con Copilot', 'video',
 '{"media_url": "Dt0upKgWwf8", "texto": "Panorama general de las capacidades creativas de Microsoft Copilot. Créditos: Paola Andrea Rodríguez."}', 10),
((SELECT id FROM modulos WHERE orden = 5), 2, 'Crear imágenes con Copilot', 'video',
 '{"media_url": "Sg9B9Mthzrc", "texto": "Cómo generar imágenes profesionales usando Copilot Designer. Créditos: Paola Andrea Rodríguez."}', 10),
((SELECT id FROM modulos WHERE orden = 5), 3, 'Presentaciones con Copilot', 'video',
 '{"media_url": "Cb3XGZw5XBk", "texto": "Crear presentaciones de PowerPoint con asistencia de Copilot. Créditos: Paola Andrea Rodríguez."}', 10),
((SELECT id FROM modulos WHERE orden = 5), 4, 'Formularios e infografías con Copilot', 'video',
 '{"media_url": "JpUO1qMmFkI", "texto": "Crear formularios inteligentes en Forms e infografías con Copilot. Créditos: Paola Andrea Rodríguez."}', 10),
((SELECT id FROM modulos WHERE orden = 5), 5, 'Creando vídeos con Copilot', 'video',
 '{"media_url": "UivJvdpIjr0", "texto": "Cómo producir vídeos usando las herramientas de IA de Microsoft. Créditos: Paola Andrea Rodríguez."}', 10);

-- Módulo 6: Gobernanza de Identidad en IA - Agentes
INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 6), 1, 'Gobernanza de identidad en IA y agentes', 'video',
 '{"media_url": "OGubHuV1JTs", "texto": "Gestión de identidad y gobernanza al crear y usar agentes de IA. Créditos: Paola Andrea Rodríguez."}', 10);

COMMIT;
