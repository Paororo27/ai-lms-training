---
date: 2026-03-31
topic: pruebas-score-confetti
---

# Pruebas funcionando + Score + Confetti

## Que estamos construyendo

Corregir los bugs del sistema de pruebas (error al enviar respuestas y resultados que no se muestran) y agregar celebracion visual con canvas-confetti cuando el usuario aprueba.

## Estado actual

El sistema de pruebas tiene la estructura completa:
- `prueba.jsx` renderiza preguntas, maneja state, muestra resultados con score y retroalimentacion por pregunta
- `diagnostico.jsx` maneja pre/post diagnosticos
- `submit-quiz` (edge function) califica, guarda intentos, retorna detalle
- `quiz-question.jsx` renderiza opciones con feedback visual (verde/rojo)

**Bugs conocidos:**
1. **Error al enviar respuestas** — Posiblemente relacionado con un bug en `submit-quiz/index.ts:167` donde `d.seleccionada` nunca se popula en el array `detalle`. El campo no existe en la estructura que se construye en lineas 131-136. Esto puede causar que el insert a `intentos_prueba` falle por schema mismatch o datos null.
2. **No muestra resultados** — Si el submit falla, el componente nunca recibe el objeto `resultado` y queda en estado de loading/submitting.

## Por que este approach

Fix-first: corregir los bugs del submit para que el flujo basico funcione, luego agregar confetti como capa visual encima del flujo existente. No se necesita reestructurar nada — el sistema ya tiene la logica de calificacion y la UI de resultados.

## Decisiones clave

- **Confetti regular** en pruebas modulares cuando aprueba (puntaje >= 80%)
- **Fireworks** en la prueba final (diagnostico post) al completar
- **canvas-confetti** como libreria (ligera, sin dependencias, API simple)
- **Fix del bug** en submit-quiz antes de agregar features visuales
- **Retroalimentacion** ya existe por pregunta con explicaciones — solo asegurar que se muestre correctamente post-fix

## Alcance

### Incluido
- Fix bug `submit-quiz/index.ts` campo `seleccionada`
- Verificar que resultados se muestren correctamente post-fix
- `npm install canvas-confetti`
- Confetti en `prueba.jsx` cuando `resultado.aprobado === true`
- Fireworks en `diagnostico.jsx` (post) al completar
- Score visible y claro en pantalla de resultados

### Excluido
- Animaciones de transicion en preguntas
- Sonidos
- Badges o milestones
- Timer/countdown en pruebas

## Open Questions

*Ninguna — alcance definido.*

## Next Steps

-> `/ce:plan` para detallar la implementacion
