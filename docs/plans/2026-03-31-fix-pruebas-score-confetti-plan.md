---
title: "fix: Corregir submit de pruebas y agregar confetti"
type: fix
status: completed
date: 2026-03-31
origin: docs/brainstorms/2026-03-31-pruebas-score-confetti-brainstorm.md
---

# fix: Corregir submit de pruebas y agregar confetti

## Overview

El submit de pruebas falla porque `submit-quiz/index.ts:167` referencia `d.seleccionada` que no existe en el array `detalle`. Esto causa que el insert a `intentos_prueba` falle con datos undefined, lo que impide que se muestren resultados. Ademas, agregar celebracion visual con `canvas-confetti` cuando el usuario aprueba.

## Bug: campo `seleccionada` inexistente

**Archivo:** `supabase/functions/submit-quiz/index.ts:165-169`

```typescript
// ACTUAL (roto)
respuestas: detalle.map(d => ({
  pregunta_id: d.pregunta_id,
  seleccionada: d.seleccionada,  // <- undefined, no existe en detalle
  correcta: d.acerto,
})),
```

El array `detalle` (lineas 131-136) solo tiene: `pregunta_id`, `pregunta_texto`, `acerto`, `explicacion`. El campo `opcion_seleccionada` esta en el array `respuestas` del input original.

```typescript
// FIX
respuestas: respuestas.map(r => {
  const info = correctasMap.get(r.pregunta_id)
  return {
    pregunta_id: r.pregunta_id,
    seleccionada: r.opcion_seleccionada,
    correcta: info ? r.opcion_seleccionada === info.correctIdx : false,
  }
}),
```

## Confetti

**Libreria:** `canvas-confetti` (see brainstorm: docs/brainstorms/2026-03-31-pruebas-score-confetti-brainstorm.md)

### Pruebas modulares: confetti regular

**Archivo:** `src/course/prueba.jsx`

Disparar confetti cuando `resultado.aprobado === true` al recibir el resultado del submit. Usar `useEffect` que observe `resultado`:

```jsx
import confetti from 'canvas-confetti'

useEffect(() => {
  if (resultado?.aprobado) {
    confetti({ particleCount: 150, spread: 70, origin: { y: 0.6 } })
  }
}, [resultado])
```

### Diagnostico post: fireworks

**Archivo:** `src/course/diagnostico.jsx`

Disparar fireworks al completar el diagnostico de salida (no el de entrada). Solo cuando `tipoPrueba === 'diagnostico_post'` y el resultado se recibe por primera vez (no en recarga con `yaCompletado`):

```jsx
import confetti from 'canvas-confetti'

useEffect(() => {
  if (resultado && !yaCompletado && tipoPrueba === 'diagnostico_post') {
    const duration = 3000
    const end = Date.now() + duration
    const interval = setInterval(() => {
      if (Date.now() > end) return clearInterval(interval)
      confetti({
        particleCount: 30,
        startVelocity: 30,
        spread: 360,
        origin: { x: Math.random(), y: Math.random() * 0.4 },
      })
    }, 200)
    return () => clearInterval(interval)
  }
}, [resultado])
```

## Archivos a modificar

| Archivo | Cambio |
|---------|--------|
| `supabase/functions/submit-quiz/index.ts:165-169` | Fix campo `seleccionada` — usar array `respuestas` original |
| `src/course/prueba.jsx` | Import confetti, useEffect para disparar en aprobacion |
| `src/course/diagnostico.jsx` | Import confetti, useEffect para fireworks en diag post |
| `package.json` | `npm install canvas-confetti` |

## Acceptance Criteria

- [x] Fix: `submit-quiz` guarda `seleccionada` correctamente desde el input original
- [x] Fix: Resultados se muestran despues de enviar respuestas
- [x] Fix: Retroalimentacion por pregunta visible con explicaciones
- [x] Confetti regular al aprobar prueba modular (>= 80%)
- [x] Fireworks al completar diagnostico de salida (solo primera vez)
- [x] No confetti en diagnostico de entrada ni en pruebas no aprobadas
- [x] `canvas-confetti` instalado como dependencia

## Despliegue

La edge function `submit-quiz` necesita re-desplegarse en Supabase despues del fix:

```bash
supabase functions deploy submit-quiz
```

## Sources

- **Origin brainstorm:** [docs/brainstorms/2026-03-31-pruebas-score-confetti-brainstorm.md](docs/brainstorms/2026-03-31-pruebas-score-confetti-brainstorm.md)
- Bug: `supabase/functions/submit-quiz/index.ts:167`
- Vista resultados modulares: `src/course/prueba.jsx:155-238`
- Vista resultados diagnostico: `src/course/diagnostico.jsx:134-176`
- canvas-confetti docs: https://github.com/catdad/canvas-confetti
