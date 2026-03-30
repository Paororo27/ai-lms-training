# Brainstorm: Plataforma LMS para Taller de Copilot Chat

**Fecha:** 2026-03-29
**Estado:** Aprobado para planificación

---

## Qué estamos construyendo

Una plataforma LMS (Learning Management System) integrada al mismo repositorio de la landing existente, accesible desde la ruta `/course`. La plataforma permite a 200 colaboradores del equipo de Recursos Humanos de Avianca completar un taller asincrónico de 4 semanas (1 hora/semana) sobre el uso avanzado de Copilot Chat e inteligencia artificial.

**Audiencia:** Personal de RR.HH. de Avianca (nómina, selección, cultura, aprendizaje, desarrollo). Diferentes edades, ubicados en varios países de habla hispana. +15.000 empleados en la aerolínea, 200 participantes en este taller.

**Objetivo del taller:** Llevar a los participantes de un nivel básico a avanzado en el uso de IA, con foco en Copilot Chat (herramienta autorizada por la empresa), para que reduzcan el tiempo dedicado a tareas operativas.

---

## Por qué este enfoque

**Arquitectura: Supabase-first**

- React Router para SPA routing (`/` = landing intacta, `/course/*` = LMS)
- Cliente Supabase JS directo en React para lecturas (módulos, contenido, progreso)
- Supabase Auth con código como identificador (sin datos personales en la plataforma)
- Supabase Storage para videos e imágenes
- Edge Functions (Deno) solo para operaciones complejas:
  - Generación de códigos de acceso en lote
  - Asignación aleatoria de retos
  - Generación de certificados PDF
  - (Nice-to-have) Calificación de retos por IA
- RLS (Row Level Security) para aislar datos por usuario
- Deploy en Vercel

**Razón:** Maximiza lo que Supabase ofrece out-of-the-box (auth, storage, realtime, RLS) y minimiza el código backend. Edge Functions solo donde hay lógica de negocio que no puede vivir en el cliente.

---

## Decisiones clave

### 1. Autenticación sin datos personales
- Códigos pre-generados en lote (200 códigos únicos + contraseñas)
- La relación código → empleado real se mantiene FUERA de Supabase (spreadsheet interno de Avianca)
- Supabase Auth con el código como identificador (ej: `USR001@copilot.internal`)
- Esto garantiza que Supabase nunca almacena datos de empleados

### 2. Formato de contenido
- Videos demostrativos + texto enriquecido + imágenes
- Ejercicios prácticos guiados: instrucciones paso a paso para que el usuario practique en su propio Copilot
- La plataforma presenta la instrucción y recoge confirmación de completado
- Assets (videos, imágenes) almacenados en Supabase Storage
- Metadata de contenido en tablas de Supabase (permite actualizar sin redeploy)

### 3. Evaluaciones: solo opción múltiple
- Calificación 100% automática
- Pruebas asociadas 1:N a cada módulo
- Examen diagnóstico pre (al iniciar) y post (al finalizar) con preguntas diferentes pero nivel comparable
- Permite medir mejora objetiva del participante

### 4. Progresión secuencial estricta
- Debe completar módulo anterior (contenido + prueba) para desbloquear el siguiente
- Flujo: Diagnóstico inicial → Módulo 1 → Prueba 1 → Módulo 2 → ... → Módulo N → Diagnóstico final → Reto

### 5. Reto final: caso práctico escrito
- Pool de retos en la DB, asignación aleatoria por usuario
- El usuario recibe un escenario de HR y documenta cómo lo resolvería con Copilot/IA
- Entrega escrita directamente en la plataforma
- Nice-to-have: calificación y retroalimentación por IA (Edge Function con LLM)

### 6. Certificado PDF
- Se genera al completar todo el taller (módulos + pruebas + reto)
- PDF descargable con: código del participante, puntaje acumulado, fecha de completación
- Generación vía Edge Function (librería como jsPDF o similar en Deno)

### 7. Panel admin básico
- Vista protegida (credenciales de admin)
- Visualización de: progreso por usuario, puntajes por prueba, estadísticas generales
- Sin CRUD de contenido (contenido se gestiona vía seeds/SQL en Supabase)

---

## Modelo de datos (ERD conceptual)

```
usuarios (Supabase Auth)
├── id (UUID)
├── codigo (string, único)
├── created_at
└── role (participante | admin)

modulos
├── id
├── orden (int) — define secuencia
├── semana (int)
├── titulo
├── descripcion
├── contenido (jsonb) — estructura del contenido: secciones, texto, media URLs
└── duracion_minutos

lecciones
├── id
├── modulo_id (FK)
├── orden (int)
├── titulo
├── tipo (video | texto | ejercicio)
├── contenido (jsonb) — texto, media_url, instrucciones
└── duracion_minutos

pruebas
├── id
├── modulo_id (FK, nullable) — null para diagnósticos
├── tipo (modular | diagnostico_pre | diagnostico_post)
├── titulo
├── puntaje_maximo
└── puntaje_aprobatorio

preguntas (banco amplio: >= 2x preguntas por intento)
├── id
├── prueba_id (FK)
├── texto
├── opciones (jsonb) — [{texto, es_correcta}]
└── explicacion — retroalimentación post-respuesta

progreso_usuario
├── id
├── usuario_id (FK)
├── leccion_id (FK)
├── completado (boolean)
├── completado_at (timestamp)

intentos_prueba (máximo 2 por usuario+prueba)
├── id
├── usuario_id (FK)
├── prueba_id (FK)
├── numero_intento (int) — 1 o 2
├── puntaje (int)
├── respuestas (jsonb) — [{pregunta_id, opcion_seleccionada, correcta}]
├── preguntas_usadas (jsonb) — IDs de preguntas seleccionadas para este intento
├── aprobado (boolean)
└── created_at

retos
├── id
├── titulo
├── escenario (text) — descripción del caso práctico
├── criterios_evaluacion (jsonb)

asignacion_retos
├── id
├── usuario_id (FK, único) — un reto por usuario
├── reto_id (FK)
├── assigned_at

entregas_reto
├── id
├── asignacion_id (FK)
├── contenido (text) — respuesta escrita del usuario
├── puntaje (int, nullable) — si hay calificación
├── retroalimentacion (text, nullable) — feedback IA
├── submitted_at

certificados
├── id
├── usuario_id (FK, único)
├── puntaje_total (int)
├── puntaje_diagnostico_pre (int)
├── puntaje_diagnostico_post (int)
├── generated_at
├── pdf_url (text) — URL en Supabase Storage
```

---

## Estructura de módulos del taller

Basado en el temario de la landing y los objetivos del negocio:

| Semana | Módulo | Tema | Contenido clave |
|--------|--------|------|-----------------|
| 0 | Diagnóstico Pre | Examen de entrada | Evaluar nivel actual en IA y herramientas digitales |
| 1 | 1 | Fundamentos de Copilot | Qué es Copilot Chat, cómo acceder, interfaz, primeros prompts, limitaciones |
| 1 | 2 | Prompt Engineering | Técnicas de prompting: contexto, rol, formato, cadena de pensamiento, iteración |
| 2 | 3 | Productividad Real | Casos de uso en trabajo diario: resúmenes, emails, análisis de datos, automatización de tareas repetitivas |
| 2 | 4 | Inteligencia de Datos | Análisis de información con Copilot, Excel/tablas, extracción de insights, reportes |
| 3 | 5 | Ética y Seguridad en IA | Uso responsable, no comprometer info empresarial, control humano, sesgos, alucinaciones |
| 3 | 6 | IA para RR.HH. y más allá | Herramientas IA para gestión de talento + otras IA útiles fuera del trabajo |
| 4 | - | Diagnóstico Post | Examen de salida (diferente al de entrada) |
| 4 | 7 | Reto Final | Caso práctico escrito asignado aleatoriamente |

---

## Flujo de usuario completo

```
Landing (/) → Botón "Acceder al taller" → Login (/course/login)
    ↓
Dashboard (/course/dashboard)
    ├── Progreso general (barra, % completado)
    ├── Puntaje acumulado
    ├── Módulos con estado (bloqueado/disponible/completado)
    └── Diagnóstico pre (si no completado, es lo primero)
    ↓
Diagnóstico Pre (/course/diagnostico/pre)
    ↓
Módulo N (/course/modulo/:id)
    ├── Lecciones secuenciales
    │   ├── Video + texto
    │   ├── Ejercicio práctico (instrucciones + confirmación)
    │   └── Siguiente lección
    └── Prueba del módulo (/course/modulo/:id/prueba)
        ├── Preguntas MCQ
        ├── Resultado inmediato + explicaciones
        └── Si aprueba → desbloquea siguiente módulo
    ↓
[Repite para cada módulo]
    ↓
Diagnóstico Post (/course/diagnostico/post)
    ↓
Reto Final (/course/reto)
    ├── Escenario asignado aleatoriamente
    ├── Editor de texto para respuesta
    └── Enviar entrega
    ↓
Certificado (/course/certificado)
    └── Descargar PDF
```

---

## Consideraciones técnicas

### Routing SPA en Vercel
- Requiere `vercel.json` con rewrite: `"rewrites": [{"source": "/(.*)", "destination": "/index.html"}]`
- React Router v6+ con `createBrowserRouter`

### Supabase Auth con códigos
- Usar `supabase.auth.signUp({ email: `${code}@copilot.internal`, password })` para registro
- Login con el mismo patrón
- El "email" nunca se muestra al usuario, solo el código
- RLS policies basadas en `auth.uid()`

### Storage de media
- Videos alojados en YouTube como "no listados" (CDN global, sin límite de tamaño, embed gratuito)
- Imágenes en Supabase Storage (bucket público, contenido no sensible)
- Certificados PDF en Supabase Storage (bucket privado)

### Edge Functions necesarias
1. `generate-codes` — Genera N códigos únicos con contraseñas, los registra en Supabase Auth
2. `assign-challenge` — Asigna reto aleatorio no repetido al usuario cuando completa el diagnóstico post
3. `generate-certificate` — Genera PDF y lo sube a Storage
4. `grade-challenge` (nice-to-have) — Envía entrega a LLM para calificación/retroalimentación

### Reintentos de pruebas
- Máximo 2 intentos por prueba
- Cada intento muestra preguntas diferentes (seleccionadas del banco)
- El banco de preguntas por prueba debe ser >= 2x el número de preguntas por intento
- Se guarda el mejor puntaje de ambos intentos
- Puntaje mínimo de aprobación: 80%

### Generación de contenido
- Contenido textual, exámenes, preguntas y diseño de retos: generado por IA (NotebookLM CLI)
- Revisión y ajuste humano de todo el material generado
- Videos y material visual: producidos por el equipo humano
- Carga de contenido a la plataforma: vía seeds/scripts SQL en Supabase

### Capacidad: 200 usuarios
- Supabase Free tier soporta 500 conexiones simultáneas (Postgres)
- 200 usuarios concurrentes está dentro del rango cómodo
- Videos en YouTube no listado (sin impacto en storage de Supabase)

---

## Preguntas resueltas

| Pregunta | Decisión |
|----------|----------|
| Formato de contenido | Video + texto + ejercicios prácticos |
| Distribución de códigos | Pre-generados en lote |
| Tipo de evaluaciones | Solo opción múltiple, calificación automática |
| Reto final | Caso práctico escrito, nice-to-have IA para calificar |
| Panel admin | Básico: ver progreso y puntajes, sin CRUD de contenido |
| Progresión | Secuencial estricta |
| Deploy | Vercel |
| Supabase | Crear proyecto nuevo (tiene cuenta) |
| Diagnóstico | Pre y post con preguntas diferentes |
| Certificado | PDF descargable |
| Arquitectura | Supabase-first: cliente directo + Edge Functions selectivas |
| Storage de videos | YouTube no listado (embed, CDN global, sin costo) |
| Reintentos | 2 intentos máximo, preguntas diferentes por intento (banco amplio) |
| Puntaje aprobación | 80% mínimo para desbloquear siguiente módulo |
| Creación de contenido | Mixto: IA genera (NotebookLM CLI) + revisión humana + material propio |
