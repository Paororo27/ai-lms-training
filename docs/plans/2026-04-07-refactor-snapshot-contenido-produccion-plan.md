---
title: "refactor: Snapshot de contenido desde produccion"
type: refactor
status: active
date: 2026-04-07
---

# refactor: Snapshot de contenido desde produccion

## Enhancement Summary

**Deepened on:** 2026-04-07
**Agents used:** data-integrity-guardian, architecture-strategist, data-migration-expert, security-sentinel, schema-drift-detector, simplicity-reviewer, best-practices-researcher, framework-docs-researcher, Context7 (Supabase CLI)

### Cambio critico vs plan original

El plan original proponia crear una migracion `016_snapshot_contenido_produccion.sql`. **Tres revisores independientes recomendaron usar `seed.sql` en su lugar**, por una razon de seguridad critica: las migraciones se ejecutan con `supabase db push` en produccion, lo que ejecutaria un `TRUNCATE CASCADE` que destruiria todos los datos de usuario (progreso, intentos, entregas) de forma irrecuperable. El `seed.sql` solo se ejecuta con `supabase db reset` (entorno local limpio).

### Hallazgos clave

1. `supabase db dump --data-only` genera **INSERT por defecto** (no COPY). El flag `--use-copy` activa COPY.
2. `supabase db url` **no existe** como comando. La connection string se obtiene del dashboard.
3. Las migraciones 012-015 son **puramente DML** (no hay DDL). Es seguro vaciarlas.
4. Los retos solo existen en `seed.sql`, no en migraciones 012-015. Deben extraerse de produccion.
5. `TRUNCATE ... RESTART IDENTITY CASCADE` resetea secuencias automaticamente (no necesita `setval()` extra si no se usan IDs explicitos).
6. `supabase/.temp/` no esta en `.gitignore` -- riesgo de filtrar credenciales post-link.

## Overview

El contenido del LMS (modulos, lecciones, pruebas, preguntas, retos) ha divergido entre las migraciones SQL del repositorio y lo que esta publicado en produccion. Este plan consolida todo el contenido publicado en `seed.sql` como fuente de verdad para desarrollo local.

## Acceptance Criteria

- [x] `seed.sql` contiene todo el contenido de las 5 tablas tal como esta en produccion
- [x] Migraciones 012-015 estan vacias (solo comentario de referencia)
- [ ] `supabase db reset` en local genera un ambiente identico a produccion (bloqueado por bug preexistente en migracion 007)
- [x] Los IDs en local coinciden con los de produccion
- [ ] Los campos JSONB se renderizan correctamente en el frontend (requiere verificacion visual)
- [x] `supabase/.temp/` agregado a `.gitignore`

## Technical Approach

### Paso 1: Preparar el entorno

```bash
# Vincular al proyecto de produccion
supabase link --project-ref <ref-id>
# El ref-id se obtiene de: Settings > General > Reference ID en el dashboard

# Agregar .temp/ al gitignore ANTES de linkear
echo "supabase/.temp/" >> .gitignore
```

### Paso 2: Extraer contenido de produccion

**Opcion recomendada: `pg_dump` directo con `--column-inserts`**

`supabase db dump` no tiene flag `--table`, asi que para filtrar solo las 5 tablas de contenido, usar `pg_dump` directamente:

```bash
# Connection string del dashboard: Settings > Database > Connection string > URI
pg_dump "$DB_URL" \
  --data-only \
  --column-inserts \
  -t public.modulos \
  -t public.lecciones \
  -t public.pruebas \
  -t public.preguntas \
  -t public.retos \
  -f supabase/dump_produccion.sql
```

`--column-inserts` genera INSERT con nombres de columna explicitos, resiliente a cambios de orden.

**Alternativa: `supabase db dump` con exclusiones**

```bash
supabase db dump --linked --data-only \
  -x "public.progreso_usuario" \
  -x "public.intentos_prueba" \
  -x "public.entregas_reto" \
  -f supabase/dump_produccion.sql
```

> [!warning] Usar subshell para el connection string y evitar que quede en el historial de Fish:
> `pg_dump (cat .env | grep DB_URL | cut -d= -f2) ...`

### Paso 3: Generar `seed.sql`

Tomar el output de `pg_dump` y transformarlo en el seed definitivo:

```sql
-- ============================================================
-- Seed: Snapshot de contenido desde produccion (2026-04-07)
-- Reemplaza el seed anterior con datos reales.
-- Solo se ejecuta con `supabase db reset` (entorno local).
-- ============================================================

-- Limpiar contenido previo (por si las migraciones vacias dejaron algo del seed anterior)
TRUNCATE TABLE preguntas, lecciones, pruebas, retos, modulos
  RESTART IDENTITY CASCADE;

-- === MODULOS ===
INSERT INTO modulos (id, orden, semana, titulo, descripcion, contenido, duracion_minutos) VALUES
-- ... datos de produccion ...
;

-- === LECCIONES ===
INSERT INTO lecciones (id, modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
-- ... datos de produccion ...
;

-- === PRUEBAS ===
INSERT INTO pruebas (id, modulo_id, tipo, titulo, preguntas_por_intento, puntaje_aprobatorio, orden) VALUES
-- ... datos de produccion ...
;

-- === PREGUNTAS ===
INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
-- ... datos de produccion ...
;

-- === RETOS ===
INSERT INTO retos (id, titulo, escenario, criterios_evaluacion, modulo_id) VALUES
-- ... datos de produccion ...
;

-- === RESET SECUENCIAS ===
-- Necesario porque los INSERTs usan IDs explicitos
SELECT setval('modulos_id_seq',   (SELECT MAX(id) FROM modulos));
SELECT setval('lecciones_id_seq', (SELECT MAX(id) FROM lecciones));
SELECT setval('pruebas_id_seq',   (SELECT MAX(id) FROM pruebas));
SELECT setval('preguntas_id_seq', (SELECT MAX(id) FROM preguntas));
SELECT setval('retos_id_seq',     (SELECT MAX(id) FROM retos));
```

**Orden de insercion (por dependencias FK):** modulos -> lecciones, pruebas, retos -> preguntas

**Manejo de JSONB con markdown extenso:** Para lecciones tipo `texto` con markdown largo, usar `jsonb_build_object()` + dollar-quoting:

```sql
INSERT INTO lecciones (..., contenido, ...) VALUES
(..., jsonb_build_object('texto', $content$
# Titulo del contenido markdown
...
$content$), ...);
```

Usar tag `$content$` en vez de `$md$` para evitar colisiones si el markdown contiene literalmente `$md$`.

### Paso 4: Vaciar migraciones 012-015

Reemplazar el contenido de cada archivo con una sola linea:

```sql
-- Contenido movido a seed.sql (snapshot de produccion 2026-04-07)
```

**Archivos:**
- `supabase/migrations/012_contenido_modulos.sql`
- `supabase/migrations/013_preguntas_pruebas.sql`
- `supabase/migrations/014_preguntas_adicionales.sql`
- `supabase/migrations/015_videos_oficiales_y_tildes.sql`

> [!warning] Verificado: las 4 migraciones son puramente DML (INSERT/UPDATE/DELETE). No hay DDL que se pierda al vaciarlas.

### Paso 5: Validar

```bash
supabase db reset
```

Verificar:
- [ ] Reset ejecuta sin errores
- [ ] Abrir el frontend, navegar un modulo, verificar visualmente que el contenido se renderiza

### Paso 6: Limpiar

- Eliminar `supabase/dump_produccion.sql` (archivo temporal de extraccion)
- Verificar que `supabase/.temp/` esta en `.gitignore`

## Por que seed.sql y no migracion 016

| Aspecto | seed.sql | Migracion 016 |
|---|---|---|
| Cuando se ejecuta | Solo con `db reset` (local) | Con `db reset` Y `db push` (produccion) |
| Riesgo en produccion | Ninguno | TRUNCATE CASCADE destruye datos de usuario |
| Semantica | Datos de seed = correcto | Migracion de schema = incorrecto para contenido |
| Separacion natural | Supabase ya separa migrations/ y seed.sql | Mezcla schema con datos |

## Workflow futuro

Si el contenido vuelve a divergir significativamente, repetir este proceso: re-exportar y actualizar `seed.sql`.

## Rollback

Esta operacion tiene riesgo bajo porque **no toca produccion**. Todos los cambios son a archivos versionados en git.

### Contexto importante

Las migraciones 012-015 **ya estan desincronizadas** con produccion (el contenido se ha editado manualmente desde el admin panel). El rollback no restaura un estado "correcto" -- restaura el status quo donde `supabase db reset` produce un ambiente local que no coincide con produccion. Esto significa que el riesgo de avanzar es bajo: el peor caso es volver a donde ya estamos.

### Antes de empezar

```bash
# Crear un tag como punto de restauracion (estado actual, ya divergente)
git tag pre-snapshot-refactor
```

### Si algo falla durante la implementacion

```bash
# Restaurar todos los archivos modificados al estado anterior
git checkout pre-snapshot-refactor -- \
  supabase/seed.sql \
  supabase/migrations/012_contenido_modulos.sql \
  supabase/migrations/013_preguntas_pruebas.sql \
  supabase/migrations/014_preguntas_adicionales.sql \
  supabase/migrations/015_videos_oficiales_y_tildes.sql \
  .gitignore

# Verificar que el estado anterior funciona
supabase db reset
```

### Si algo falla despues del commit

```bash
# Revertir el commit manteniendo los archivos en working directory
git revert HEAD

# O volver directamente al tag
git reset --hard pre-snapshot-refactor
```

### Que puede fallar y como detectarlo

| Escenario | Deteccion | Rollback |
|---|---|---|
| JSONB corrupto en seed.sql | `supabase db reset` falla con error de sintaxis SQL | Corregir el escape en seed.sql, no necesita rollback completo |
| Contenido faltante (tabla incompleta) | Verificacion visual: modulo sin lecciones | Re-exportar la tabla faltante desde produccion |
| Secuencias desincronizadas | Admin panel falla al crear contenido nuevo (PK duplicado) | Ejecutar `setval()` manualmente en local |
| Migracion 012-015 tenia DDL oculto | `supabase db reset` falla por schema faltante | Verificado: no hay DDL. Pero si lo hubiera, restaurar con `git checkout` |

### Impacto en produccion

**Ninguno.** El `seed.sql` nunca se ejecuta en produccion. Las migraciones 012-015 ya fueron aplicadas en produccion -- vaciarlas no cambia su estado remoto (ya estan en `schema_migrations`).

## Sources & References

- Schema: `supabase/migrations/001_schema.sql`
- Migraciones de contenido: `supabase/migrations/012-015`
- Admin panel: `src/course/admin/admin-modulos.jsx`
- Seed actual: `supabase/seed.sql`
- [Supabase CLI: db dump](https://supabase.com/docs/reference/cli/supabase-db-dump)
- [Supabase CLI: migration repair](https://supabase.com/docs/reference/cli/supabase-migration-repair)
- [Supabase: Seeding Your Database](https://supabase.com/docs/guides/local-development/seeding-your-database)
- [PostgreSQL: pg_dump](https://www.postgresql.org/docs/current/app-pgdump.html)
- [PostgreSQL: TRUNCATE](https://www.postgresql.org/docs/current/sql-truncate.html)
