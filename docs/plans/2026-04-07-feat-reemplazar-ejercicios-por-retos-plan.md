---
title: "feat: Reemplazar ejercicios prácticos por retos con entrega"
type: feat
status: active
date: 2026-04-07
---

# feat: Reemplazar ejercicios prácticos por retos con entrega

## Enhancement Summary

**Deepened on:** 2026-04-07
**Agents used:** data-integrity-guardian, simplicity-reviewer, spec-flow-analyzer

### Hallazgos clave

1. **El reordenamiento de lecciones es innecesario.** Los huecos en `orden` (1,2,3,5) no violan constraints ni afectan al frontend. Eliminar Paso 2 reduce complejidad y riesgo.
2. **0 entregas y 0 registros de progreso** referencian los items a eliminar. Las operaciones DELETE son limpias.
3. **Usuarios existentes verán regresión.** Módulos "completados" volverán a "disponible" porque los nuevos retos no están enviados. Decidir si esto es aceptable.
4. **El módulo 2 no tiene prueba modular.** Verificar en producción — si es así, la progresión podría estar rota para usuarios no-admin (bug preexistente, no causado por este cambio).

## Overview

Los ejercicios prácticos (lecciones tipo `ejercicio`) solo permiten marcar como completado. Los retos permiten subir un enlace con evidencia del trabajo. Este cambio reemplaza los 7 ejercicios de los módulos 2-6 por 5 retos (uno por módulo) congruentes con el contenido actualizado.

## Estado actual

**Ejercicios a eliminar (7 lecciones tipo `ejercicio`):**

| ID | Módulo | Título |
|---|---|---|
| 91 | 2 | Práctica: reescribe prompts inseguros |
| 95 | 3 | Práctica: clasifica quejas con few-shot |
| 97 | 3 | Práctica: diseña una cadena de 3 prompts |
| 100 | 4 | Práctica: crea una plantilla XML reutilizable |
| 103 | 5 | Práctica: genera 3 imágenes para una presentación |
| 105 | 5 | Práctica: crea una infografía sobre un tema de tu área |
| 107 | 6 | Reto: Construye tu Primer Especialista Digital |

**Retos huérfanos a eliminar:**

| ID | módulo_id | Título |
|---|---|---|
| 2 | NULL | Reporte de clima organizacional |
| 3 | NULL | Capacitación con IA para el equipo |
| 4 | NULL | Optimización de comunicaciones internas |
| 5 | NULL | Análisis de rotación de personal |

## Acceptance Criteria

- [x] Lecciones tipo `ejercicio` eliminadas de módulos 2-6 (7 lecciones)
- [x] Retos huérfanos eliminados (ids 2-5)
- [x] Un reto creado para cada módulo 2-6, congruente con su contenido
- [x] El `seed.sql` actualizado con los cambios
- [x] La función `check_certificate_ready` requiere 6 retos enviados (módulos 1-6)
- [ ] El flujo de entrega de retos funciona (url_entrega via entregas_reto) — verificar manualmente en frontend

## Retos propuestos

### Módulo 2: ADN Digital — Clonación y Lógica

**Título:** Blindaje de prompts: reescribe y protege

**Escenario:** Tu jefe te envía un email con datos sensibles de un proyecto confidencial y te pide que uses Copilot para generar un resumen ejecutivo. El email contiene nombres de empleados, cifras de presupuesto y estrategias internas. Debes: (1) Reescribir el prompt original aplicando el protocolo de anonimización que aprendiste, (2) Usar el framework GOCE para estructurar la instrucción, (3) Aplicar al menos una restricción de blindaje ("NO incluyas..."), (4) Mostrar el resultado de Copilot con tu prompt mejorado. Sube una captura de pantalla o documento con el prompt original, tu prompt mejorado y la respuesta de Copilot.

**Criterios de evaluación:**
- Aplicación correcta del protocolo de anonimización
- Uso del framework GOCE en la estructura del prompt
- Presencia de restricciones de blindaje
- Calidad del resultado obtenido con Copilot

### Módulo 3: El arte de enseñarle a la IA — Few-shot y Prompt Chaining

**Título:** Cadena de prompts para un proceso real

**Escenario:** Identifica un proceso repetitivo de tu área de trabajo que puedas automatizar con Copilot (ejemplos: clasificar correos, generar reportes semanales, analizar feedback de clientes). Diseña una cadena de al menos 3 prompts donde la salida de cada uno alimenta al siguiente. Para cada prompt: usa la técnica apropiada (zero-shot o few-shot con ejemplos). Documenta el proceso completo en un documento y sube el enlace.

**Criterios de evaluación:**
- Identificación clara de un proceso real de su área
- Cadena de al menos 3 prompts conectados
- Uso apropiado de técnicas zero-shot y few-shot
- Resultado final útil y aplicable

### Módulo 4: Prompting avanzado — Estructuras y seguridad

**Título:** Template XML reutilizable para tu equipo

**Escenario:** Crea una plantilla XML reutilizable que tu equipo pueda usar para una tarea recurrente (ejemplo: generar descripciones de cargo, crear agendas de reunión, redactar comunicados internos). La plantilla debe incluir: (1) Estructura XML con campos variables claramente marcados, (2) Instrucciones de uso para que cualquier persona de tu equipo pueda utilizarla sin conocimiento técnico, (3) Un ejemplo de la plantilla completada y el resultado de Copilot. Incluye una reflexión breve sobre los riesgos de Shadow AI que identificaste en tu entorno laboral.

**Criterios de evaluación:**
- Estructura XML correcta y funcional
- Campos variables claramente identificados
- Instrucciones de uso comprensibles para no-técnicos
- Reflexión sobre Shadow AI relevante a su contexto

### Módulo 5: Crea con Copilot Chat

**Título:** Kit creativo con Copilot: imagen + presentación + infografía

**Escenario:** Elige un tema relevante para tu área de trabajo y crea un mini kit de comunicación usando Copilot que incluya: (1) Al menos 2 imágenes generadas con prompts específicos, (2) Un borrador de presentación de 3-5 diapositivas, (3) Una infografía o formulario diseñado con Copilot. Documenta los prompts exactos que usaste para cada pieza y sube los resultados en un enlace.

**Criterios de evaluación:**
- Mínimo 2 imágenes generadas con Copilot
- Presentación de 3-5 diapositivas coherente
- Infografía o formulario incluido
- Prompts documentados para cada pieza creativa

### Módulo 6: Agentes y Excel con Copilot

**Título:** Construye tu primer agente especializado

**Escenario:** Diseña y construye un agente de IA en Copilot especializado en una tarea repetitiva de tu área. El agente debe: (1) Tener un rol claro definido con una instrucción maestra, (2) Estar orientado a resolver un problema real de tu equipo (revisa el catálogo de casos de uso del módulo para inspirarte), (3) Incluir al menos 3 instrucciones base que definan su comportamiento. Documenta la configuración del agente, pruébalo con 2-3 consultas reales y sube las capturas del proceso y los resultados.

**Criterios de evaluación:**
- Instrucción maestra clara y específica
- Agente orientado a un caso de uso real del área
- Mínimo 3 instrucciones base configuradas
- Evidencia de pruebas con consultas reales

## Technical Approach

### Paso 1: Ejecutar SQL en producción

Envolver todo en una transacción atómica:

```sql
BEGIN;

-- 1. Eliminar retos huérfanos (sin entregas, verificado)
DELETE FROM retos WHERE modulo_id IS NULL;

-- 2. Eliminar lecciones tipo ejercicio (sin progreso, verificado)
DELETE FROM lecciones WHERE id IN (91, 95, 97, 100, 103, 105, 107);

-- 3. Insertar nuevos retos para módulos 2-6
INSERT INTO retos (titulo, escenario, criterios_evaluacion, modulo_id) VALUES
('Blindaje de prompts: reescribe y protege',
 'Tu jefe te envía un email con datos sensibles de un proyecto confidencial y te pide que uses Copilot para generar un resumen ejecutivo. El email contiene nombres de empleados, cifras de presupuesto y estrategias internas. Debes: (1) Reescribir el prompt original aplicando el protocolo de anonimización que aprendiste, (2) Usar el framework GOCE para estructurar la instrucción, (3) Aplicar al menos una restricción de blindaje ("NO incluyas..."), (4) Mostrar el resultado de Copilot con tu prompt mejorado. Sube una captura de pantalla o documento con el prompt original, tu prompt mejorado y la respuesta de Copilot.',
 '["Aplicación correcta del protocolo de anonimización", "Uso del framework GOCE en la estructura del prompt", "Presencia de restricciones de blindaje", "Calidad del resultado obtenido con Copilot"]'::jsonb,
 2),
('Cadena de prompts para un proceso real',
 'Identifica un proceso repetitivo de tu área de trabajo que puedas automatizar con Copilot (ejemplos: clasificar correos, generar reportes semanales, analizar feedback de clientes). Diseña una cadena de al menos 3 prompts donde la salida de cada uno alimenta al siguiente. Para cada prompt: usa la técnica apropiada (zero-shot o few-shot con ejemplos). Documenta el proceso completo en un documento y sube el enlace.',
 '["Identificación clara de un proceso real de su área", "Cadena de al menos 3 prompts conectados", "Uso apropiado de técnicas zero-shot y few-shot", "Resultado final útil y aplicable"]'::jsonb,
 3),
('Template XML reutilizable para tu equipo',
 'Crea una plantilla XML reutilizable que tu equipo pueda usar para una tarea recurrente (ejemplo: generar descripciones de cargo, crear agendas de reunión, redactar comunicados internos). La plantilla debe incluir: (1) Estructura XML con campos variables claramente marcados, (2) Instrucciones de uso para que cualquier persona de tu equipo pueda utilizarla sin conocimiento técnico, (3) Un ejemplo de la plantilla completada y el resultado de Copilot. Incluye una reflexión breve sobre los riesgos de Shadow AI que identificaste en tu entorno laboral.',
 '["Estructura XML correcta y funcional", "Campos variables claramente identificados", "Instrucciones de uso comprensibles para no-técnicos", "Reflexión sobre Shadow AI relevante a su contexto"]'::jsonb,
 4),
('Kit creativo con Copilot: imagen + presentación + infografía',
 'Elige un tema relevante para tu área de trabajo y crea un mini kit de comunicación usando Copilot que incluya: (1) Al menos 2 imágenes generadas con prompts específicos, (2) Un borrador de presentación de 3-5 diapositivas, (3) Una infografía o formulario diseñado con Copilot. Documenta los prompts exactos que usaste para cada pieza y sube los resultados en un enlace.',
 '["Mínimo 2 imágenes generadas con Copilot", "Presentación de 3-5 diapositivas coherente", "Infografía o formulario incluido", "Prompts documentados para cada pieza creativa"]'::jsonb,
 5),
('Construye tu primer agente especializado',
 'Diseña y construye un agente de IA en Copilot especializado en una tarea repetitiva de tu área. El agente debe: (1) Tener un rol claro definido con una instrucción maestra, (2) Estar orientado a resolver un problema real de tu equipo (revisa el catálogo de casos de uso del módulo para inspirarte), (3) Incluir al menos 3 instrucciones base que definan su comportamiento. Documenta la configuración del agente, pruébalo con 2-3 consultas reales y sube las capturas del proceso y los resultados.',
 '["Instrucción maestra clara y específica", "Agente orientado a un caso de uso real del área", "Mínimo 3 instrucciones base configuradas", "Evidencia de pruebas con consultas reales"]'::jsonb,
 6);

COMMIT;
```

> [!warning] No se reordena `lecciones.orden` después de los DELETEs. Los huecos (ej: 1,2,3,5) son válidos — el constraint UNIQUE(modulo_id, orden) no requiere consecutividad y el frontend ordena por `.order('orden')`.

### Paso 2: Actualizar seed.sql

Re-exportar el seed completo de producción (mismo proceso del refactor anterior) o editar manualmente el seed actual eliminando las 7 lecciones y los 4 retos huérfanos, e insertando los 5 retos nuevos.

### Paso 3: Verificar

- Abrir el frontend y navegar módulos 2-6: verificar que los retos aparecen en el sidebar
- Probar el flujo de entrega de un reto (URL + confirmar)
- Verificar que `check_certificate_ready` ahora cuenta 6 retos requeridos

## Impacto en usuarios existentes

**Regresión de progreso:** Los usuarios que ya completaron ejercicios verán que:
- El conteo de lecciones cambia (ej: de 6/6 a 4/4) — pero sigue mostrando "completado"
- Aparece un reto nuevo no enviado en el sidebar del módulo
- El botón "Ir a la prueba" requiere reto enviado (`canGoToPrueba = reto ? (allComplete && retoEnviado) : allComplete`)
- Si ya aprobaron la prueba, pueden acceder directamente al historial pero el módulo no se muestra como "completado" en el dashboard

**Decisión:** Esto es aceptable porque el taller está en curso y los usuarios deben hacer los retos como parte del aprendizaje.

## Bug preexistente detectado (fuera de alcance)

El módulo 2 no tiene prueba modular en los datos actuales (no hay registro en `pruebas` con `modulo_id=2`). Esto podría bloquear la progresión para usuarios no-admin. Verificar en producción y corregir por separado si es necesario.

## Sources & References

- Schema: `supabase/migrations/001_schema.sql`
- Retos por módulo: `supabase/migrations/011_retos_por_modulo.sql`
- Frontend retos: `src/course/modulo.jsx:23-107`
- Dashboard progresión: `src/course/dashboard.jsx:96-102`
- Certificado: `supabase/migrations/011_retos_por_modulo.sql:72-168`
- Seed actual: `supabase/seed.sql`
