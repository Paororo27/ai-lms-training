---
title: "feat: Nuevo tipo de leccion educaplay con embed"
type: feat
status: completed
date: 2026-03-31
---

# feat: Nuevo tipo de leccion educaplay con embed

## Overview

Agregar un nuevo tipo de leccion `educaplay` que permita embeber juegos interactivos de la plataforma Educaplay. El admin pega un tag `<iframe>` o una URL directa, el sistema extrae y valida la URL, la almacena en el JSONB `contenido`, y el estudiante ve el juego embebido de forma responsiva.

## Motivacion

Los juegos de Educaplay complementan las lecciones teoricas con actividades interactivas (verdadero/falso, crucigramas, sopa de letras). Integrarlos directamente en la plataforma evita que el estudiante salga del flujo de aprendizaje.

## Solucion propuesta

Seguir el patron existente de tipos de leccion: agregar `'educaplay'` al constraint de DB, extender el admin CRUD, y agregar el renderizado condicional en la vista del estudiante.

### Estructura del JSONB `contenido`

```json
{ "url": "https://es.educaplay.com/juego/28494906-falso_verdadero_ia.html", "texto": "..." }
```

Consistente con el patron de `video` (`{ media_url, texto }`) y `ejercicio` (`{ instrucciones, texto }`).

### Logica de extraccion de URL (en el guardado del admin)

El admin puede pegar cualquiera de estos formatos:

- Un tag iframe completo: `<iframe ... src="https://es.educaplay.com/juego/123-nombre.html"></iframe>`
- Una URL directa: `https://es.educaplay.com/juego/123-nombre.html`

```js
function extractEducaplayUrl(input) {
  const trimmed = input.trim()
  // Si contiene un tag iframe, extraer el src
  const match = trimmed.match(/src=["']([^"']+)["']/)
  const url = match ? match[1] : trimmed
  // Validar dominio
  if (!/^https:\/\/(es\.|www\.)?educaplay\.com\//.test(url)) return null
  return url
}
```

La validacion de dominio restringe a `educaplay.com` como capa de defensa. Se ejecuta en `saveLeccion`, no en el render.

### Iframe del lado estudiante

```jsx
<iframe
  src={url}
  sandbox="allow-scripts allow-same-origin allow-popups"
  allow="fullscreen"
  referrerPolicy="strict-origin-when-cross-origin"
  className="absolute inset-0 w-full h-full border-0 rounded-xl"
/>
```

- `sandbox` restringe las capacidades del iframe (sin `allow-top-navigation` para evitar que Educaplay navegue fuera de la plataforma)
- Contenedor responsive con `aspect-ratio: 795/690` y `max-width: 795px`
- Spinner de carga que se oculta con `onLoad`

## Archivos a modificar

### 1. Nueva migracion: `supabase/migrations/008_add_educaplay_tipo.sql`

```sql
ALTER TABLE lecciones DROP CONSTRAINT lecciones_tipo_check;
ALTER TABLE lecciones ADD CONSTRAINT lecciones_tipo_check
  CHECK (tipo IN ('video', 'texto', 'ejercicio', 'educaplay'));
```

Ya hay datos en produccion, no se puede modificar `001_schema.sql` directamente.

### 2. Admin: `src/course/admin/admin-modulos.jsx`

- **Linea 7-11** — Agregar a `TIPOS_LECCION`: `{ value: 'educaplay', label: 'Educaplay', icon: Gamepad2 }`
- **Linea 126-133** (`saveLeccion`) — Agregar rama para construir `{ url: extractEducaplayUrl(input), texto }`. Mostrar error si la URL no es valida.
- **Linea 242-261** (formulario) — Agregar campo condicional: textarea para pegar iframe/URL cuando `tipo === 'educaplay'`, con placeholder descriptivo. Incluir textarea opcional de texto complementario (consistente con otros tipos).

### 3. Estudiante: `src/course/modulo.jsx`

- **Linea 77** — Agregar a `TIPO_ICONS`: `educaplay: Gamepad2`
- **Linea 78** — Agregar a `TIPO_LABELS`: `educaplay: 'Actividad interactiva'`
- **Linea 164-185** — Agregar bloque de renderizado:

```jsx
{current.tipo === 'educaplay' && current.contenido?.url && (
  <div className="mb-4 relative w-full max-w-[795px]" style={{ aspectRatio: '795/690' }}>
    {/* Spinner de carga */}
    <div className="absolute inset-0 flex items-center justify-center bg-slate-100 rounded-xl">
      <div className="animate-spin rounded-full h-8 w-8 border-t-2 border-avianca-cyan" />
    </div>
    <iframe
      src={current.contenido.url}
      sandbox="allow-scripts allow-same-origin allow-popups"
      allow="fullscreen"
      referrerPolicy="strict-origin-when-cross-origin"
      onLoad={(e) => e.target.previousElementSibling?.remove()}
      className="absolute inset-0 w-full h-full border-0 rounded-xl"
    />
  </div>
)}
```

### 4. Actualizar constraint base: `supabase/migrations/001_schema.sql`

Actualizar el CHECK inline para que el schema base refleje el estado actual (ademas de la migracion 008 que lo aplica):

```sql
tipo TEXT NOT NULL CHECK (tipo IN ('video', 'texto', 'ejercicio', 'educaplay')),
```

## Acceptance Criteria

- [x] Migracion `008` agrega `'educaplay'` al constraint de tipo
- [x] Admin puede seleccionar tipo "Educaplay" al crear/editar leccion
- [x] Admin puede pegar un iframe tag o URL directa de Educaplay
- [x] El sistema extrae y valida la URL (solo dominio `educaplay.com`)
- [x] El admin ve error si la URL no es valida
- [x] El estudiante ve el juego embebido de forma responsiva
- [x] El iframe tiene atributos `sandbox` restrictivos
- [x] Spinner visible mientras carga el iframe
- [x] Icono `Gamepad2` y label "Actividad interactiva" en sidebar y admin
- [x] Texto complementario opcional (markdown) debajo del iframe
- [x] Completado de leccion funciona igual que los otros tipos

## Decisiones de diseno

| Decision | Elegido | Alternativa descartada | Razon |
|----------|---------|----------------------|-------|
| Input del admin | Acepta iframe tag o URL directa | Solo iframe tag | Mas robusto, el admin no necesita saber extraer la URL |
| Validacion de dominio | Solo `educaplay.com` | Cualquier URL | Capa de defensa barata contra URLs maliciosas |
| Sandbox iframe | Sin `allow-top-navigation` | Con `allow-top-navigation` | Evitar que Educaplay navegue al estudiante fuera de la plataforma |
| Responsive | `aspect-ratio` + `max-width` | Dimensiones fijas | Se adapta a mobile sin romper la proporcion |
| Icono | `Gamepad2` | `Puzzle`, `Trophy` | Representa mejor una actividad interactiva/juego |

## Sources

- Patron existente de tipos: `src/course/admin/admin-modulos.jsx:7-11`, `src/course/modulo.jsx:77-78`
- Schema DB: `supabase/migrations/001_schema.sql:25`
- Renderizado condicional: `src/course/modulo.jsx:164-185`
- Guardado condicional: `src/course/admin/admin-modulos.jsx:126-133`
