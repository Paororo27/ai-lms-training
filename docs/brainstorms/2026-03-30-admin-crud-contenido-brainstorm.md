# Brainstorm: CRUD Admin para Contenido del LMS

**Fecha:** 2026-03-30
**Estado:** Aprobado para planificacion

---

## Que estamos construyendo

Panel de administracion de contenido dentro del LMS que permite al admin gestionar desde el frontend:

- **Modulos**: crear, editar, eliminar, reordenar (drag & drop)
- **Lecciones**: crear, editar, eliminar, reordenar dentro de cada modulo (drag & drop)
- **Pruebas**: crear, editar, eliminar. Asociar a modulos o como diagnosticos
- **Preguntas**: CRUD del banco de preguntas por prueba. Opciones MCQ con respuesta correcta
- **Retos**: crear, editar, eliminar retos finales con escenarios y criterios

Todo accesible desde `/course/admin/contenido` con subrutas.

---

## Por que este enfoque

Actualmente el contenido se carga via SQL seeds, lo que requiere acceso a Supabase SQL Editor. El admin (persona de RR.HH., no tecnica) necesita poder actualizar temario, agregar preguntas al banco y gestionar retos sin depender de un desarrollador.

---

## Decisiones clave

### 1. Ubicacion: subrutas bajo /course/admin/
- `/course/admin` — dashboard de stats (ya existe)
- `/course/admin/modulos` — lista de modulos con drag & drop
- `/course/admin/modulos/:id` — editar modulo + CRUD de lecciones
- `/course/admin/pruebas` — lista de pruebas
- `/course/admin/pruebas/:id` — editar prueba + CRUD de preguntas
- `/course/admin/retos` — CRUD de retos

### 2. CRUD completo sin restricciones
- Se permite editar/eliminar incluso si hay progreso de usuarios
- Las FK con ON DELETE CASCADE manejan la limpieza (eliminar modulo elimina lecciones y progreso asociado)
- No se bloquea nada por progreso activo

### 3. Drag & drop para reordenamiento
- Libreria: `@dnd-kit/core` + `@dnd-kit/sortable` (ligera, React-native, accesible)
- Modulos se reordenan entre si (campo `orden`)
- Lecciones se reordenan dentro de su modulo (campo `orden`)

### 4. Editor Markdown para contenido
- El admin escribe en Markdown
- Se renderiza en el visor del estudiante con `react-markdown`
- No necesita WYSIWYG completo, Markdown es suficiente para texto + listas + links + negrita

### 5. Editor de preguntas MCQ
- Formulario para agregar/editar preguntas
- Cada pregunta: texto + N opciones + marcar la correcta + explicacion
- Las opciones se agregan/eliminan dinamicamente
- El campo `es_correcta` se marca con radio button

### 6. RLS para operaciones de escritura admin
- Nuevas policies INSERT/UPDATE/DELETE en todas las tablas de contenido
- Solo para usuarios con `app_metadata.role = 'admin'`

---

## Preguntas resueltas

| Pregunta | Decision |
|----------|----------|
| Alcance CRUD | Completo: crear, editar, eliminar, reordenar |
| Ubicacion | Subrutas bajo /course/admin/ |
| Reordenamiento | Drag & drop con @dnd-kit |
| Datos activos | Sin restriccion, CASCADE limpia |
| Editor | Markdown (react-markdown para render) |
| Retos | Incluidos en el CRUD |
