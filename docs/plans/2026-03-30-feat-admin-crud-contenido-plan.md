---
title: "feat: CRUD admin para contenido del LMS"
type: feat
status: active
date: 2026-03-30
deepened: 2026-03-30
origin: docs/brainstorms/2026-03-30-admin-crud-contenido-brainstorm.md
---

# feat: CRUD admin para contenido del LMS

## Enhancement Summary

**Profundizado el:** 2026-03-30
**Agentes:** framework-docs (dnd-kit, react-markdown), security-sentinel, code-simplicity-reviewer

### Cambios vs plan original
1. **Botones arriba/abajo en vez de drag & drop** — 0 dependencias, suficiente para 6 modulos
2. **3 archivos en vez de 6** — edicion inline/modal, sin paginas separadas list/edit
3. **Sin @dnd-kit** — eliminada la dependencia
4. **SELECT policy para admin en `preguntas`** — sin ella el CRUD retorna null
5. **Constraint JSONB mejorado** — valida estructura de opciones (texto + es_correcta + exactamente 1 correcta)
6. **react-markdown se mantiene** — 12KB, seguro por defecto, util para formato de lecciones

---

## Overview

Panel de gestion de contenido para el admin del LMS. CRUD completo de modulos, lecciones, pruebas, preguntas y retos desde el frontend. Reordenamiento con botones arriba/abajo. Editor Markdown para contenido de lecciones.

(ver brainstorm: `docs/brainstorms/2026-03-30-admin-crud-contenido-brainstorm.md`)

---

## Technical Approach

### Nuevas rutas

```
/course/admin              → dashboard stats (ya existe)
/course/admin/modulos      → CRUD modulos + lecciones (inline)
/course/admin/pruebas      → CRUD pruebas + preguntas (inline)
/course/admin/retos        → CRUD retos (inline)
```

### Nuevos archivos

```
src/course/admin/
├── admin-modulos.jsx      # CRUD modulos + lecciones con edicion inline
├── admin-pruebas.jsx      # CRUD pruebas + preguntas MCQ con edicion inline
└── admin-retos.jsx        # CRUD retos con edicion inline
```

### Dependencias

```bash
npm install react-markdown remark-gfm
```

> Sin @dnd-kit. Reordenamiento con botones arriba/abajo (0 dependencias extra).

### Migracion SQL: `007_admin_write_policies.sql`

```sql
-- Admin puede escribir en tablas de contenido
-- FOR ALL cubre INSERT, UPDATE, DELETE, SELECT

CREATE POLICY "admin_write_modulos" ON modulos
  FOR ALL TO authenticated
  USING ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin')
  WITH CHECK ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin');

CREATE POLICY "admin_write_lecciones" ON lecciones
  FOR ALL TO authenticated
  USING ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin')
  WITH CHECK ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin');

CREATE POLICY "admin_write_pruebas" ON pruebas
  FOR ALL TO authenticated
  USING ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin')
  WITH CHECK ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin');

-- CRITICO: admin necesita SELECT en preguntas para que CRUD retorne data
CREATE POLICY "admin_all_preguntas" ON preguntas
  FOR ALL TO authenticated
  USING ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin')
  WITH CHECK ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin');

CREATE POLICY "admin_write_retos" ON retos
  FOR ALL TO authenticated
  USING ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin')
  WITH CHECK ((select (auth.jwt()->'app_metadata'->>'role')) = 'admin');

-- Mejorar constraint de opciones: validar estructura interna
ALTER TABLE preguntas DROP CONSTRAINT IF EXISTS preguntas_opciones_check;
ALTER TABLE preguntas ADD CONSTRAINT preguntas_opciones_check CHECK (
  jsonb_typeof(opciones) = 'array'
  AND jsonb_array_length(opciones) >= 2
  AND NOT EXISTS (
    SELECT 1 FROM jsonb_array_elements(opciones) elem
    WHERE elem->>'texto' IS NULL
      OR jsonb_typeof(elem->'es_correcta') != 'boolean'
  )
  AND (SELECT COUNT(*) FROM jsonb_array_elements(opciones) elem
       WHERE (elem->>'es_correcta')::boolean = true) = 1
);
```

### Reordenamiento con botones

```jsx
const reorder = async (items, index, direction) => {
  const newItems = [...items]
  const swapIdx = index + direction
  if (swapIdx < 0 || swapIdx >= newItems.length) return items
  ;[newItems[index], newItems[swapIdx]] = [newItems[swapIdx], newItems[index]]
  // Actualizar orden en DB
  await Promise.all(newItems.map((item, i) =>
    supabase.from(tabla).update({ orden: i + 1 }).eq('id', item.id)
  ))
  return newItems
}
```

### Markdown en visor del estudiante

```jsx
// En modulo.jsx, reemplazar <p> por react-markdown
import Markdown from 'react-markdown'
import remarkGfm from 'remark-gfm'

// Donde se renderiza contenido de leccion:
<Markdown remarkPlugins={[remarkGfm]} className="prose prose-slate prose-sm max-w-none">
  {current.contenido.texto}
</Markdown>
```

---

## Implementation Phases

### Phase 1: RLS + routing + layout admin con nav

- [ ] Crear `007_admin_write_policies.sql` con policies de escritura + constraint mejorado de opciones
- [ ] Instalar `react-markdown remark-gfm`
- [ ] Actualizar `main.jsx`: agregar subrutas lazy bajo `/course/admin/*`
- [ ] Actualizar `admin.jsx`: agregar nav lateral (Stats | Modulos | Pruebas | Retos)
- [ ] Crear directorio `src/course/admin/`

### Phase 2: CRUD modulos + lecciones

- [ ] `admin-modulos.jsx`:
  - Lista de modulos con: titulo, semana, duracion, botones arriba/abajo/editar/eliminar
  - Boton "Crear modulo" → formulario inline (titulo, semana, duracion)
  - Click "Editar" → expande seccion con formulario de edicion + lista de lecciones
  - Lecciones del modulo: titulo, tipo, duracion, botones arriba/abajo/editar/eliminar
  - Boton "Crear leccion" → formulario inline (titulo, tipo, contenido Markdown, media_url, duracion)
  - Eliminar: confirmacion simple ("Esto eliminara el modulo y todo su contenido")

### Phase 3: CRUD pruebas + preguntas

- [ ] `admin-pruebas.jsx`:
  - Lista de pruebas con: titulo, tipo, modulo asociado, preguntas_por_intento
  - Boton "Crear prueba" → formulario (titulo, tipo, modulo, preguntas_por_intento, puntaje_aprobatorio)
  - Click "Editar" → expande con formulario + lista de preguntas
  - Cada pregunta: texto, opciones (lista dinamica), radio para correcta, explicacion
  - Boton "Agregar opcion" / "Eliminar opcion" en cada pregunta
  - Indicador: "Banco: X preguntas, se muestran Y por intento"
  - Validacion frontend: al menos 2 opciones, exactamente 1 correcta

### Phase 4: CRUD retos + Markdown en visor

- [ ] `admin-retos.jsx`:
  - Lista de retos con: titulo, boton editar/eliminar
  - Crear/editar: titulo, escenario (textarea), criterios (lista dinamica de strings)
- [ ] Integrar `react-markdown` + `remark-gfm` en `modulo.jsx` para renderizar contenido de lecciones

---

## Acceptance Criteria

- [ ] Admin puede CRUD modulos, lecciones, pruebas, preguntas y retos
- [ ] Reordenar modulos y lecciones con botones arriba/abajo
- [ ] Preguntas MCQ: opciones dinamicas, radio para correcta, explicacion
- [ ] Constraint DB valida estructura de opciones (texto + es_correcta + 1 correcta)
- [ ] Admin puede leer preguntas (SELECT policy)
- [ ] Contenido Markdown se renderiza en visor del estudiante
- [ ] Participantes NO pueden acceder a rutas admin
- [ ] Eliminar modulo/prueba borra contenido asociado (CASCADE)

---

## Sources

- **Brainstorm:** [docs/brainstorms/2026-03-30-admin-crud-contenido-brainstorm.md](docs/brainstorms/2026-03-30-admin-crud-contenido-brainstorm.md)
- [react-markdown docs](https://github.com/remarkjs/react-markdown)
- [remark-gfm](https://github.com/remarkjs/remark-gfm)
- Admin actual: `src/course/admin.jsx`
- RLS: `supabase/migrations/002_rls_policies.sql`
