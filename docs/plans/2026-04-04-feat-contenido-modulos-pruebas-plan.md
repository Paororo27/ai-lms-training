---
title: Creacion de contenido, pruebas y descripciones de calidad para 8 modulos
type: feat
status: active
date: 2026-04-04
deepened: 2026-04-04
---

## Enhancement Summary

**Deepened on:** 2026-04-04
**Research agents:** 3 (prompt engineering, Copilot tools, IA personal + diagnosticos)

### Key Improvements
1. Framework GOCE de Microsoft (Goal, Context, Expectations, Source) como base oficial para ensenar prompts
2. 30 preguntas de diagnostico completas con opciones, respuestas y justificaciones (15 entrada + 15 salida)
3. Videos verificados en YouTube en español con IDs concretos por modulo
4. Estadisticas de Shadow AI para reforzar modulo de seguridad (77% empleados filtran datos, $670K costo promedio brecha)
5. Documentacion oficial Microsoft con URLs directas para cada tema

### Recursos de research (archivos generados)
- `docs/brainstorms/2026-04-04-modulos-5-6-crear-agentes-excel-research.md` — Research modulos 5-6
- Research modulos 2-4 y modulo 7 + diagnosticos en contexto de este plan

### Videos YouTube verificados (español)

| Modulo | Video | Canal | ID |
|--------|-------|-------|----|
| 2 | Curso de Prompt Engineering | Academia IA Lab | `Rbws9lbVNAM` |
| 2 | Copilot para principiantes | Pablo Prompt | `ugQQ8Xa6hI0` |
| 2 | Formula del Prompt Perfecto | Cyberclick | `p2PqfRte46k` |
| 3 | Prompt Engineering desde cero | HolaMundo | `x-iTco25VGI` |
| 3 | Curso gratis prompt engineering | EDteam | `8Wqgr7Ry3dk` |
| 3 | Tecnicas avanzadas | DQxJGHlADLE | `DQxJGHlADLE` |
| 4 | Metodo de Google para prompts | Xavier Mitjana | `BRy7Z3ZoQZk` |
| 4 | Como usar BIEN ChatGPT - Prompt Engineering | Platzi | `7f5xF-I-S3c` |
| 6 | Copilot en Excel tutorial | Soluciones Rapidas | `6PdP7iCgWZE` |

### Documentacion oficial Microsoft (URLs directas)

- [Craft effective prompts (Training Path)](https://learn.microsoft.com/es-es/training/paths/craft-effective-prompts-copilot-microsoft-365/)
- [Copilot Lab - Ejemplos de prompts](https://copilot.cloud.microsoft/prompts)
- [Datos, privacidad y seguridad Copilot](https://learn.microsoft.com/es-es/copilot/microsoft-365/microsoft-365-copilot-privacy)
- [Seguridad para Microsoft 365 Copilot](https://learn.microsoft.com/es-es/copilot/microsoft-365/microsoft-365-copilot-ai-security)
- [Microsoft Purview para IA generativa](https://learn.microsoft.com/es-es/purview/ai-microsoft-purview)
- [Copilot Studio - Prompt Library](https://learn.microsoft.com/en-us/microsoft-copilot-studio/prompt-library)
- [Image generation in Copilot](https://support.microsoft.com/en-us/topic/using-image-generation-in-microsoft-copilot-cc337e5a-750f-4438-9caa-19096b694ab6)

### Guias de referencia en español

- [Prompt Engineering Guide (español)](https://www.promptingguide.ai/es)
- [Learn Prompting (español)](https://learnprompting.org/es/docs/introduction)
- [Few-shot vs Zero-shot comparativa](https://www.prompt.org.es/docs/vs-metods/few-shot-vs-zero-shot-prompting-comparativa)
- [Prompt Chaining (FindSkill.ai)](https://findskill.ai/es/blog/prompt-chaining-como-encadenar-prompts-para-tareas-complejas/)
- [8 consejos Microsoft LATAM para Copilot](https://news.microsoft.com/source/latam/noticias-de-microsoft/escriban-prompts-como-los-profesionales-8-consejos-y-trucos-para-trabajar-con-copilot-en-teams/)

### Estadisticas clave para contenido de seguridad

- 77% de empleados comparte datos corporativos en IA no autorizada (eSecurity Planet)
- 82% usa cuentas personales para hacerlo
- Costo promedio de brecha por Shadow AI: $670,000 USD (IBM 2025)
- Identificar fuga por IA tarda 26% mas que ciberataques tradicionales
- 34.8% de datos pegados en ChatGPT son sensibles (Stanford 2025)

### Diagnosticos: 30 preguntas completas disponibles

El research produjo 15 preguntas de entrada y 15 de salida, cada una con:
- Escenario situacional
- 4 opciones de respuesta
- Respuesta correcta con justificacion detallada

Las preguntas de SALIDA son significativamente mas dificiles, combinando multiples conceptos (prompt engineering + seguridad + etica + criterio profesional).

---

# Creacion de contenido, pruebas y descripciones de calidad

## Overview

Reestructurar el LMS de 6 a 8 modulos con contenido profesional, lecciones de texto enriquecido (RichMarkdown), videos en español, pruebas desafiantes y diagnosticos rigurosos. Todo se crea directamente en Supabase via SQL.

## Estado actual vs deseado

| # | Estado actual | Estado deseado |
|---|--------------|----------------|
| 1 | Fundamentos de Copilot | Introduccion a capacidades laborales con IA (enriquecer prueba) |
| 2 | Prompt Engineering | Prompt engineering + anonimizacion y seguridad |
| 3 | Productividad Real | Few Shot y Prompt Chaining |
| 4 | Inteligencia de Datos | Prompting avanzado: XML/JSON, imagenes, contenido |
| 5 | Etica y Seguridad en IA | Crear con Copilot: imagenes, formularios, videos, infografias |
| 6 | IA para RR.HH. y mas alla | Agentes propios y Excel con Copilot |
| 7 | — (no existe) | IA para la vida personal |
| 8 | — (no existe) | Reto final integrador (SIN prueba) |

## Consideraciones tecnicas

### Schema constraints
- `semana` tiene CHECK `1-4`. Con 8 modulos: 2 modulos por semana
- `modulo 8` NO tiene prueba — se marca solo con reto

### Formato de contenido
- Lecciones tipo `texto` usan RichMarkdown (Notion-style)
- Generar textos via skill `/markdown-generator` y guardar en `texts/`
- Insertar el markdown resultante en `lecciones.contenido.texto`

### Videos
- Requisito: español latino
- Formato en DB: YouTube video ID en `contenido.media_url`
- Creditos al autor en el texto complementario de la leccion

### Seguridad
- NUNCA recomendar herramientas externas sin advertencia de proteccion de datos
- Modulo 4 especialmente: si se menciona XML/JSON para herramientas externas, SIEMPRE incluir disclaimer de anonimizacion

## Estructura de contenido por modulo

### Modulo 1: Introduccion a la extension de capacidades laborales con IA

**Accion:** Enriquecer prueba. Contenido existente esta bien.

**Prueba (10+ preguntas de banco, 5 por intento):**
- Preguntas situacionales, no definiciones basicas
- Escenarios laborales reales donde el usuario decida si usar IA o no
- Preguntas sobre limitaciones y riesgos, no solo beneficios

**Reto:** Identificar 3 procesos de su area que se beneficiarian de IA y justificar

---

### Modulo 2: Prompt Engineering + Anonimizacion y Seguridad

**Framework base:** GOCE de Microsoft (Goal, Context, Expectations, Source)

**Lecciones (6):**
1. `video` — Que es un prompt y por que importa la estructura (`ugQQ8Xa6hI0` - Pablo Prompt, 8:33)
2. `texto` — Anatomia de un buen prompt: framework GOCE (Goal, Context, Expectations, Source) con ejemplos corporativos
3. `texto` — El escudo de la confianza: anonimizacion de datos (usar `texts/escudo-confianza-etica-ia.md` existente)
4. `texto` — Protocolo de anonimizacion: tecnicas (reemplazo por placeholders, generalizacion, seudonimizacion, datos sinteticos) + tabla de datos que NUNCA deben ir en un prompt
5. `ejercicio` — Reescribir 3 prompts inseguros aplicando anonimizacion (escenarios RRHH, ventas, finanzas)
6. `video` — Errores comunes y como evitarlos (`p2PqfRte46k` - Cyberclick, 10:39)

**Prueba (12+ preguntas, 5 por intento):**
- Dado este prompt, cual es el problema de seguridad?
- Reescribe este prompt aplicando anonimizacion
- Escenarios con PII donde el usuario identifique el riesgo

**Reto:** Crear un prompt complejo para una tarea real de su area, aplicando anonimizacion

---

### Modulo 3: Few Shot y Prompt Chaining

**Dato clave:** Dividir tareas en pasos mejora precision 20-50% (ACL 2024)

**Lecciones (6):**
1. `video` — Prompt Engineering desde cero (`x-iTco25VGI` - HolaMundo, fragmento relevante)
2. `texto` — Zero-shot vs Few-shot: tabla comparativa con regla practica (tarea univoca = zero-shot, formato especifico = few-shot)
3. `texto` — Como construir buenos ejemplos: 4 reglas (variedad, formato consistente, representatividad, 3-5 ejemplos). Ejemplo corporativo: clasificacion de quejas
4. `ejercicio` — Practica de few-shot con 3 escenarios corporativos
5. `texto` — Prompt Chaining: 4 patrones (secuencial, paralelo con merge, condicional, loop de refinamiento) con ejemplo Resumen→Analisis→Accion
6. `ejercicio` — Diseñar una cadena de 3 prompts para un proceso real de su area

**Nota:** Mover lecciones de texto del modulo 4 actual que correspondan a estos temas

**Prueba (12+ preguntas, 5 por intento):**
- Dado este resultado, que tecnica se uso? (few-shot, zero-shot, chain)
- Cual es el mejor orden para esta cadena de prompts?
- Identificar errores en ejemplos de few-shot

**Reto:** Diseñar una cadena de prompts para automatizar un proceso de 3 pasos de su area

---

### Modulo 4: Prompting avanzado para no ingenieros

**Dato clave:** XML es mas legible para no tecnicos que JSON. Ambos funcionan con Copilot.
**Shadow AI:** 77% empleados filtra datos, costo promedio brecha $670K

**Lecciones (6):**
1. `video` — Metodo de Google para prompts (`BRy7Z3ZoQZk` - Xavier Mitjana, 14:36)
2. `texto` — Estructuras XML/JSON: que son, por que mejoran resultados (reducen errores ~60%), con ejemplos corporativos (comunicado de crisis, reporte semanal)
3. `texto` — Templates con placeholders reutilizables: template de comunicados, template de reportes, concepto de Prompt Library de Copilot Studio
4. `texto` — Generacion de imagenes: estructura [SUJETO]+[CONTEXTO]+[ESTILO]+[PARAMETROS], tips para imagenes corporativas, limitaciones (logos, marcas, personas ficticias)
5. `ejercicio` — Crear un template XML reutilizable para una tarea recurrente de su area
6. `texto` — Shadow AI: el peligro oculto. Estadisticas reales, diferencias Copilot empresarial vs herramientas gratuitas (tabla comparativa), 6 reglas de oro. Caso Samsung.

**CRITICO:** Cada leccion que mencione herramientas externas debe incluir un blockquote de advertencia:
```
> IMPORTANTE: Si usas herramientas externas a Copilot, NUNCA ingreses informacion confidencial de la empresa.
> Anonimiza siempre nombres, cifras, estrategias y cualquier dato sensible antes de usar cualquier herramienta.
```

**Prueba (12+ preguntas, 5 por intento):**
- Dado este JSON, que resultado produciria?
- Cual es el riesgo de seguridad en este prompt estructurado?
- Escenarios donde elegir XML vs JSON vs texto plano

**Reto:** Crear un template reutilizable para generar un tipo de contenido de su area

---

### Modulo 5: Crear con Copilot

**Lecciones (6-7, cada tipo de contenido como leccion independiente):**
1. `texto` — Crear imagenes con Copilot (Designer/DALL-E)
2. `ejercicio` — Practica: genera 3 imagenes para una presentacion
3. `texto` — Crear formularios inteligentes con Copilot en Forms
4. `texto` — Crear videos y presentaciones con Copilot en PowerPoint
5. `texto` — Crear infografias y contenido visual
6. `ejercicio` — Reto rapido: crea una infografia sobre un tema de tu area
7. `video` — Demo de creacion de contenido multimodal

**Prueba (12+ preguntas, 5 por intento):**
- Para este tipo de contenido, cual herramienta de Copilot usarias?
- Que prompt generaria mejor resultado para una infografia?
- Escenarios practicos de creacion de contenido

**Reto:** Crear una pieza de contenido completa (imagen + texto + presentacion) para un caso real

---

### Modulo 6: Agentes y Excel con Copilot

**Dos niveles de agentes:** Simples (sin codigo en M365) y avanzados (Copilot Studio)

**Lecciones (6):**
1. `texto` — Que son los agentes de Copilot: 2 niveles (simples en M365, avanzados en Copilot Studio). Paso a paso para cada nivel
2. `texto` — Agentes para uso propio: automatizando tareas repetitivas. Casos por departamento (RRHH, Ventas, Finanzas, Marketing, Servicio al Cliente)
3. `video` — Copilot en Excel tutorial (`6PdP7iCgWZE` - Soluciones Rapidas, 26:22)
4. `texto` — Excel con Copilot: formulas, tablas dinamicas, graficos, analisis, importacion de datos. Ejemplos de prompts concretos
5. `ejercicio` — Practica: crear un agente para responder preguntas frecuentes de un documento interno
6. `texto` — Limites reales: tabla detallada de lo que NO puede hacer (alucinaciones, datos en tiempo real, dependencia de calidad de datos)

**Prueba (12+ preguntas, 5 por intento):**
- Que puede y que NO puede hacer un agente de Copilot?
- Dado este escenario, como configurarias un agente?
- Preguntas sobre limites de Excel + Copilot

**Reto:** Crear un agente funcional que resuelva una necesidad recurrente de su equipo

---

### Modulo 7: IA para la vida personal

**Dato clave:** Profesional promedio ahorra 3.6h/semana con IA. 95% de tareas cotidianas resolubles con IA gratuita.

**Lecciones (6):**
1. `texto` — Panorama 2026: tabla comparativa de herramientas (ChatGPT, Gemini, Claude, Copilot, Canva AI, CapCut) con gratis vs pago
2. `texto` — IA para productividad: Reclaim AI (calendario), Notion AI (notas), Otter.ai (reuniones), Copilot en Outlook. Dato: 40% mas tareas planificadas/semana
3. `texto` — IA para aprendizaje: Khanmigo, Duolingo Max, Perplexity AI, tecnica "Profesor personal con ChatGPT" (4 pasos)
4. `texto` — IA para salud y finanzas: Wysa (salud mental), Fintonic (gastos), Plum (ahorro automatico). Advertencia: NUNCA datos medicos/financieros reales en IA no verificada
5. `video` — Canal DotCSV o EDteam (video seleccionado sobre herramientas IA cotidianas)
6. `texto` — 7 tendencias 2026+: agentes autonomos, Edge AI, modelos especializados, computacion cuantica, regulacion, fatiga del hype, IA como commodity. Fuentes: Microsoft, IBM, Gartner

**Prueba (10+ preguntas, 5 por intento):**
- Escenarios de vida real donde la IA aplica
- Identificar limites eticos en el uso personal de IA
- Que herramienta usarias para X situacion personal?

**Reto:** Documentar como integrarias IA en 3 aspectos de tu vida diaria

---

### Modulo 8: Reto final integrador

**SIN prueba.** Solo contiene:
1. `texto` — Introduccion al reto final: contexto y expectativas
2. El reto mas desafiante del taller

**Reto final:**
- Escenario complejo que combine: prompt engineering, anonimizacion, few-shot, chaining, creacion de contenido, y uso de agentes
- Ejemplo: "Tu departamento necesita crear un proceso completo de onboarding digital usando IA. Diseña el flujo completo: desde la recopilacion de informacion (anonimizada), la generacion de materiales de capacitacion, la creacion de un agente de preguntas frecuentes, hasta la evaluacion del proceso."

**Criterios de evaluacion:**
- Aplicacion de al menos 4 tecnicas de los modulos anteriores
- Proteccion de datos corporativos en todo el proceso
- Calidad y profesionalismo del resultado final
- Documentacion clara del proceso seguido

---

## Diagnosticos

### Diagnostico de entrada (15 preguntas investigadas, 7 por intento)

**Temas cubiertos (todas situacionales, NO definiciones):**
1. Estrategia ante urgencia con datos sensibles (resumen ejecutivo con Copilot)
2. Riesgo de ChatGPT gratuito con datos contractuales (caso real: 34.8% datos sensibles)
3. Alucinaciones academicas (caso Deloitte con gobierno australiano)
4. Pensamiento critico sobre analisis de IA vs contexto de negocio
5. Confiabilidad por tipo de tarea (datos estadisticos = menos confiable)
6. Privacidad en RRHH (anonimizacion de feedback)
7. Acceso a internet de modelos (parcialmente correcto)
8. Deteccion de contenido generico de IA (tono insincero)
9. Credenciales robadas en dark web (225K+ en 2025)
10. Sesgo y discriminacion en reclutamiento (caso Amazon)
11. Tareas inapropiadas sin supervision (diagnostico medico)
12. Propiedad intelectual de contenido generado
13. Dependencia excesiva (perdida de voz autentica)
14. Verificacion de hechos (alucinaciones con fuentes respetables)
15. IA como amplificador vs reemplazo (respuesta filosofica del curso)

### Diagnostico de salida (15 preguntas investigadas, 7 por intento)

**Mas dificil: combina multiples conceptos del curso:**
1. Anonimizacion + prompt estructurado + herramienta correcta (Excel con 500 registros)
2. Few-shot + chaining + creacion (serie de 5 correos con tonos progresivos)
3. Etica en zona gris (evaluaciones de desempeno con IA)
4. Seguridad avanzada (agente externo pidiendo acceso a datos)
5. Criterio profesional complejo (chatbot con 5% error en politicas)
6. Prompt engineering + seguridad + flujo completo (clima laboral, 200 comentarios)
7. Transparencia sobre uso de IA (campana de marketing)
8. Escenario multi-variable (sistema de vigilancia de productividad)
9. Verificacion de contenido generado (informe para CEO con 8 estadisticas)
10. Agentes + limites (politicas internas, respuesta incorrecta)
11. Integracion de conceptos (automatizacion de propuestas comerciales con chaining)
12. Etica absoluta (resenas falsas con IA)
13. Seguridad arquitectonica (RBAC en IA empresarial)
14. Pensamiento critico avanzado (predicciones contradictorias sobre empleo)
15. Filosofia del curso (relacion profesional-IA ideal)

---

## Implementacion

### Fase 1: Research de contenido
- Buscar videos en español latino en YouTube
- Investigar documentacion oficial de Microsoft Copilot
- Recopilar mejores practicas de prompt engineering
- Verificar informacion actualizada (2025-2026)

### Fase 2: Crear textos con /markdown-generator
- Generar cada leccion tipo `texto` con el skill
- Guardar en `texts/{modulo}-{tema}.md`
- Enriquecer con imagenes, diagramas mermaid, tablas

### Fase 3: SQL de contenido
- UPDATE de modulos existentes (titulos, descripciones)
- INSERT/UPDATE de lecciones con contenido
- INSERT de preguntas para pruebas y diagnosticos
- Crear modulos 7 y 8

### Fase 4: Reorganizacion
- Mover lecciones del modulo 4 actual al modulo 3
- Reordenar `orden` en lecciones y modulos
- Verificar integridad de datos

## Acceptance Criteria

- [ ] 8 modulos con titulos y descripciones profesionales
- [ ] Cada modulo tiene 5-7 lecciones con contenido de calidad
- [ ] Modulo 8 NO tiene prueba, solo reto
- [ ] Pruebas con 10-12+ preguntas en banco, no basicas
- [ ] Diagnosticos con 15+ preguntas desafiantes (7 por intento)
- [ ] Videos en español latino con creditos al autor
- [ ] Advertencias de seguridad en modulos que mencionan herramientas externas
- [ ] Textos generados con /markdown-generator
- [ ] Imagenes y diagramas en lecciones de texto
- [ ] SQL ejecutable para insertar todo el contenido
