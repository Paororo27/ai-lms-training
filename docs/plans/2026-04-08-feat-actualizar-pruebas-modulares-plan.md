---
title: "feat: Actualizar pruebas modulares y diagnósticos al temario actual"
type: feat
status: active
date: 2026-04-08
---

# feat: Actualizar pruebas modulares y diagnósticos al temario actual

## Enhancement Summary

**Deepened on:** 2026-04-08
**Agents used:** data-integrity-guardian, spec-flow-analyzer

### Hallazgos criticos

1. **`submit-quiz` usa `pruebas.orden - 1` para prerequisitos.** Insertar módulo 2 con `orden=1` lo convierte en prerequisito del módulo 1 (`orden=2`), invirtiendo la cadena. Se debe renumerar TODOS los `orden` para que sean consecutivos.
2. **El gap en `orden=7`** permite que la prueba del módulo 7 (`orden=8`) se tome sin prerequisitos validados.
3. **Constraint estricto (migración 007):** Cada pregunta debe tener exactamente 1 `es_correcta: true` y campo `texto` en cada opción. Punto más probable de falla con 151 preguntas.
4. **`certificado.jsx:137`** dice "6 módulos" hardcodeado -- actualizar a 7.
5. **Usar subqueries** `(SELECT id FROM modulos WHERE orden = X)` en vez de hardcodear IDs.

## Overview

Las pruebas actuales tienen nombres y preguntas del temario original que ya no corresponden a los módulos actualizados. Además, el módulo 2 no tiene prueba modular. Se reemplazan todas las preguntas, se crea la prueba faltante, y se renumeran los valores de `orden` para corregir la cadena de prerequisitos.

## Estado actual

| Prueba ID | Módulo | orden actual | orden correcto | Título actual | Título correcto |
|---|---|---|---|---|---|
| 1 | NULL | 0 | 0 | Diagnóstico de entrada | OK |
| 3 | 1 | 2 | **1** | Prompt Engineering | Prueba: Nuevos Horizontes |
| -- | **2** | -- | **2** | **NO EXISTE** | Prueba: ADN Digital |
| 4 | 3 | 3 | 3 | Productividad Real | Prueba: Few-shot y Prompt Chaining |
| 5 | 4 | 4 | 4 | Inteligencia de Datos | Prueba: Prompting avanzado |
| 6 | 5 | 5 | 5 | Ética y Seguridad | Prueba: Crea con Copilot |
| 7 | 6 | 6 | 6 | IA para RR.HH. | Prueba: Agentes y Excel |
| 11 | 7 | 8 | **7** | IA para tu vida personal | OK |
| 8 | NULL | 9 | **8** | Diagnóstico de salida | OK |

**0 intentos de prueba** en producción -- seguro borrar y recrear todo.

## Acceptance Criteria

- [x] Prueba modular creada para módulo 2 (id=12, orden=2)
- [x] Valores de `orden` renumerados consecutivamente (0-8)
- [x] Títulos de pruebas actualizados
- [x] 136 preguntas viejas eliminadas
- [x] 151 preguntas nuevas insertadas (15 x 7 modulares + 23 x 2 diagnósticos)
- [x] Cada pregunta cumple constraint: 4 opciones, exactamente 1 correcta, campo `texto` en cada opción
- [x] `certificado.jsx` actualizado: "6 módulos" -> "7 módulos"
- [x] seed.sql actualizado (3,197 líneas)
- [x] Cadena de prerequisitos funciona correctamente en `submit-quiz` (orden consecutivo 0-8)

## Temas por prueba

### Diagnóstico pre (23 preguntas, 7 por intento)
Medir conocimiento general de IA antes del taller. Preguntas sobre: qué es IA, qué es un prompt, qué es Copilot, uso responsable de IA, conceptos básicos de seguridad de datos.

### Módulo 1: Nuevos Horizontes (15 preguntas, 5 por intento)
- Qué es Copilot y cómo funciona
- Interfaz y navegación de Copilot Chat
- Primeros prompts y buenas prácticas iniciales
- Conceptos básicos de IA generativa
- Seguridad básica al usar IA

### Módulo 2: ADN Digital (15 preguntas, 5 por intento) **NUEVA**
- Framework GOCE (Goal, Output, Context, Extras)
- Blindaje de datos y restricciones ("NO incluyas...")
- Protocolo de anonimización
- Formatos de alto impacto
- Ciclo de refinamiento e iteración

### Módulo 3: Few-shot y Prompt Chaining (15 preguntas, 5 por intento)
- Zero-shot vs few-shot: cuándo dar ejemplos
- Técnicas de prompt chaining
- Patrones de encadenamiento para tareas complejas
- Prompts aplicados a Talento Humano

### Módulo 4: Prompting avanzado (15 preguntas, 5 por intento)
- Estructuras XML para prompts
- Estructuras JSON para datos
- Templates reutilizables
- Shadow AI: riesgos y mitigación

### Módulo 5: Crea con Copilot (15 preguntas, 5 por intento)
- Generación de imágenes con Copilot
- Creación de presentaciones
- Producción de videos con IA
- Formularios e infografías
- Flujo creativo general

### Módulo 6: Agentes y Excel (15 preguntas, 5 por intento)
- Instrucción maestra para agentes
- Creación y configuración de agentes
- Casos de uso de agentes en RRHH
- Excel con Copilot

### Módulo 7: IA para tu vida personal (15 preguntas, 5 por intento)
- Herramientas de IA para uso personal
- Tendencias futuras de IA
- Aplicaciones prácticas fuera del trabajo

### Diagnóstico post (23 preguntas, 7 por intento)
Mismas áreas que el pre pero con profundidad de nivel post-taller. Evaluar lo aprendido a lo largo de los 7 módulos.

## Technical Approach

Todo en una sola transacción para evitar estado inconsistente.

### Paso 1: SQL en producción

```sql
BEGIN;

-- 1. Borrar TODAS las preguntas (0 intentos, seguro)
DELETE FROM preguntas;

-- 2. Renumerar orden de pruebas (usar +100 temporal para evitar UNIQUE)
UPDATE pruebas SET orden = orden + 100;
UPDATE pruebas SET orden = CASE id
  WHEN 1  THEN 0  -- diagnostico_pre
  WHEN 3  THEN 1  -- modulo 1
  -- modulo 2 se inserta abajo con orden=2
  WHEN 4  THEN 3  -- modulo 3
  WHEN 5  THEN 4  -- modulo 4
  WHEN 6  THEN 5  -- modulo 5
  WHEN 7  THEN 6  -- modulo 6
  WHEN 11 THEN 7  -- modulo 7
  WHEN 8  THEN 8  -- diagnostico_post
END;

-- 3. Crear prueba para módulo 2
INSERT INTO pruebas (modulo_id, tipo, titulo, preguntas_por_intento, puntaje_aprobatorio, orden)
VALUES ((SELECT id FROM modulos WHERE orden = 2), 'modular', 
        'Prueba: ADN Digital', 5, 80, 2);

-- 4. Actualizar títulos
UPDATE pruebas SET titulo = 'Prueba: Nuevos Horizontes' WHERE id = 3;
UPDATE pruebas SET titulo = 'Prueba: Few-shot y Prompt Chaining' WHERE id = 4;
UPDATE pruebas SET titulo = 'Prueba: Prompting avanzado' WHERE id = 5;
UPDATE pruebas SET titulo = 'Prueba: Crea con Copilot' WHERE id = 6;
UPDATE pruebas SET titulo = 'Prueba: Agentes y Excel' WHERE id = 7;

-- 5. Insertar 151 preguntas nuevas
-- (generadas por IA, cada una con exactamente 4 opciones, 1 correcta)
INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
-- ... 151 preguntas ...
;

COMMIT;
```

### Paso 2: Actualizar certificado.jsx

Cambiar "6 módulos" por "7 módulos" en `src/course/certificado.jsx:137`.

### Paso 3: Re-exportar seed.sql

Extraer datos actualizados de producción y regenerar `supabase/seed.sql`.

### Paso 4: Verificar

- Consultar `pruebas ORDER BY orden` y confirmar secuencia 0-8 sin gaps
- Consultar `preguntas` agrupadas por `prueba_id` y confirmar 15 o 23 por prueba
- Verificar que `submit-quiz` valida prerequisitos correctamente (la prueba de mod 2 con `orden=2` requiere mod 1 con `orden=1` aprobada)

## Impacto en el sistema

- **`submit-quiz` prerequisitos**: Con `orden` consecutivo (0-8), la cadena `orden - 1` funciona correctamente para todos los módulos
- **`check_certificate_ready`**: Pasa de 6 a 7 pruebas modulares requeridas (dinámico, sin cambios en código)
- **Dashboard progresión**: El módulo 3 ahora se desbloquea correctamente (requiere prueba del módulo 2 aprobada)
- **`certificado.jsx`**: Requiere cambio de "6 módulos" a "7 módulos"
- **0 intentos existentes**: Sin impacto en datos de usuario

## Sources & References

- Schema pruebas/preguntas: `supabase/migrations/001_schema.sql:32-56`
- Constraint opciones: `supabase/migrations/007_admin_write_policies.sql:34-44`
- Edge Function submit-quiz: `supabase/functions/submit-quiz/index.ts:65-108`
- get_quiz_questions: `supabase/migrations/006_security_fixes.sql`
- check_certificate_ready: `supabase/migrations/011_retos_por_modulo.sql:72-168`
- Certificado PDF: `src/course/certificado.jsx:137`
- Seed actual: `supabase/seed.sql`
