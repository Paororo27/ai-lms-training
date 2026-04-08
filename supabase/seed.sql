-- ============================================================
-- Seed: Snapshot de contenido desde produccion (2026-04-08)
-- Tablas: modulos, lecciones, pruebas, preguntas, retos
-- Solo se ejecuta con `supabase db reset` (entorno local).
-- ============================================================

TRUNCATE TABLE preguntas, lecciones, pruebas, retos, modulos
  RESTART IDENTITY CASCADE;

-- === MODULOS (8 filas) ===
INSERT INTO modulos (id, orden, semana, titulo, descripcion, contenido, duracion_minutos) VALUES
(1, 1, 1, 'Nuevos Horizontes: el despertar digital', 'Introducción a la extensión de capacidades laborales con IA. Qué es Copilot, cómo funciona y por qué cambia tu forma de trabajar.', '{}', 30);

INSERT INTO modulos (id, orden, semana, titulo, descripcion, contenido, duracion_minutos) VALUES
(2, 2, 1, 'ADN Digital: Clonación y Lógica ', 'Aprenderás a dirigir la tecnología con precisión. Dominarás estructuras profesionales para diseñar instrucciones que generen resultados exactos, eliminando la ambigüedad en tus procesos. Objetivos: 
Dominar el framework profesional de arquitectura de instrucciones. 
Aplicar restricciones para guiar a la IA hacia resultados específicos. 
Perfeccionar entregables complejos mediante la iteración. 
', '{}', 30);

INSERT INTO modulos (id, orden, semana, titulo, descripcion, contenido, duracion_minutos) VALUES
(3, 3, 2, 'El arte de enseñarle a la IA: Few-shot y Prompt Chaining', 'Técnicas avanzadas: cuándo dar ejemplos a la IA, cómo encadenar prompts y patrones de encadenamiento para tareas complejas.', '{}', 30);

INSERT INTO modulos (id, orden, semana, titulo, descripcion, contenido, duracion_minutos) VALUES
(4, 4, 2, 'Prompting avanzado: estructuras y seguridad', 'Estructuras XML y JSON para prompts, templates reutilizables, generación de contenido y protección contra Shadow AI.', '{}', 30);

INSERT INTO modulos (id, orden, semana, titulo, descripcion, contenido, duracion_minutos) VALUES
(5, 5, 3, 'Crea con Copilot Chat. ', 'Este curso es para quienes tienen grandes ideas pero no tienen el tiempo  para diseñarlas desde cero. Aquí aprenderás a usar Copilot como tu asistente creativo personal para convertir conceptos en imágenes, presentaciones y videos profesionales, sin que tengas que ser un experto en diseño.

', '{}', 40);

INSERT INTO modulos (id, orden, semana, titulo, descripcion, contenido, duracion_minutos) VALUES
(6, 6, 3, 'Agentes y Excel con Copilot', 'Crea agentes de IA para automatizar tareas repetitivas y domina Excel con Copilot para análisis de datos.', '{}', 40);

INSERT INTO modulos (id, orden, semana, titulo, descripcion, contenido, duracion_minutos) VALUES
(7, 7, 4, 'IA para tu vida personal', 'Panorama de herramientas de IA para uso personal: productividad, aprendizaje, salud, finanzas y el futuro de la tecnología.', '{}', 35);

INSERT INTO modulos (id, orden, semana, titulo, descripcion, contenido, duracion_minutos) VALUES
(8, 8, 4, 'Reto final: demuestra lo que aprendiste', 'El desafío integrador que pone a prueba todas las habilidades del taller. Sin prueba, solo un reto profesional.', '{}', 30);

-- === LECCIONES (27 filas) ===
INSERT INTO lecciones (id, modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
(3, 1, 1, 'Lección 1: El Arte de lo Posible.  ', 'video', jsonb_build_object('texto', $content$Bienvenido al primer paso de tu transformación digital. En este video de apertura, exploraremos cómo la innovación está redefiniendo los límites de nuestra labor en Talento Humano y por qué hoy, más que nunca, tenemos la capacidad de alcanzar metas que antes parecían inalcanzables. Es momento de cambiar la perspectiva y prepararnos para liderar el futuro. 
$content$, 'media_url', 'xGbZRpUn-LY'), 5);

INSERT INTO lecciones (id, modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
(1, 1, 2, 'Lección 2: Sincronía Digital: Domina el Lenguaje del Mañana.  ', 'recurso_externo', jsonb_build_object('url', 'https://view.genially.com/69d3e18673c013e2b218bc9f', 'modo', 'embed', 'texto', $content$Para liderar con confianza, primero debemos hablar el mismo idioma. En esta actividad interactiva de memoria, pondrás a prueba tu intuición conectando los conceptos base de la IA con su utilidad práctica en nuestro día a día. Sincroniza cada término técnico con su definición y despeja el camino para convertirte en un estratega digital en Talento Humano. $content$), 5);

INSERT INTO lecciones (id, modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
(10, 1, 3, 'Lección 3: IA en pocas palabras', 'texto', jsonb_build_object('texto', $content$La IA no "piensa" como un humano; en realidad, es un **maestro de la prediccion estadistica**. Imagina que la IA ha leido todos los libros del mundo y su trabajo es adivinar cual es la siguiente palabra mas logica en una frase.

## El flujo de aprendizaje

```mermaid
graph LR
    A[Datos Masivos] --> B(Entrenamiento)
    B --> C{Modelo de IA}
    C --> D[Tu Pregunta / Prompt]
    D --> E(Prediccion de Respuesta)
    E --> F[Resultado Util]
```

> Es como un autocompletar del celular, pero con esteroides y la capacidad de entender reglas gramaticales y contextos complejos.

---

## LLM y Tokens: Los "Ladrillos" del Lenguaje

### Que es un LLM

Significa **Large Language Model** (Modelo de Lenguaje Extenso). Es el motor principal de la IA, como el motor de un carro. Ejemplos: GPT-4, Claude o el que usa Microsoft Copilot.

### Que es un Token

La IA no lee palabras completas, lee **Tokens**. Un token es un fragmento de texto, aproximadamente 4 caracteres o 3/4 de una palabra.

![Visualizacion de tokens en el tokenizer de OpenAI, donde cada fragmento de texto se resalta en un color diferente](https://platform.openai.com/tokenizer)

Puedes experimentar con el tokenizador interactivo de OpenAI para ver como se descompone el texto en tokens.

> Cada palabra que escribes y cada palabra que la IA responde consume tokens. Los modelos tienen un "limite de equipaje".

```mermaid
graph LR
    A["Hola, como estas?"] --> B["Hol"]
    A --> C["a,"]
    A --> D[" como"]
    A --> E[" estas"]
    A --> F["?"]
    style B fill:#89D4E1,color:#1e293b
    style C fill:#FF3093,color:white
    style D fill:#F98013,color:white
    style E fill:#1D9BF0,color:white
    style F fill:#23C847,color:white
```

---

## Memoria y Ventana de Contexto

A diferencia de los humanos, los modelos de IA son **"apatridas" (stateless)**. Esto significa que cada vez que envias un mensaje, la IA "olvida" quien eres, a menos que le enviemos el historial de nuevo.

### La Ventana de Contexto

Es como la **Memoria de Corto Plazo** o un "cuaderno de notas" limitado.

```mermaid
block-beta
    columns 1
    A["Instruccion inicial (System Prompt)"]
    B["Tu primera pregunta"]
    C["Respuesta de la IA"]
    D["Tu segunda pregunta"]
    E["ESPACIO DISPONIBLE"]
    style A fill:#1e293b,color:white
    style B fill:#1D9BF0,color:white
    style C fill:#89D4E1,color:#1e293b
    style D fill:#1D9BF0,color:white
    style E fill:#23C847,color:white
```

### Que pasa cuando se llena

Imagina un balde de agua: para echar agua nueva (informacion nueva), la IA tiene que dejar salir el agua del fondo (lo primero que dijiste en la charla).

> En chats muy largos, la IA puede empezar a "olvidar" detalles del inicio de la conversacion. Por eso es importante ser conciso.

---

## Agentes: La IA que "hace" cosas

Un **Agente** es un paso mas alla de un simple chat. Es una IA a la que se le da una meta y herramientas.

| Chatbot | Agente |
|---------|--------|
| Tu preguntas, el responde | Tu le das un objetivo y el decide como lograrlo |
| Interaccion reactiva | Interaccion proactiva |
| Respuestas predefinidas | Razonamiento y planificacion |

Por ejemplo, si le dices "Organiza mi agenda", un agente puede:

1. Mirar el calendario
2. Redactar correos
3. Confirmar citas

```mermaid
flowchart TD
    U[Usuario: Organiza mi agenda] --> A{Agente de IA}
    A --> C[Revisar calendario]
    A --> E[Redactar correos]
    A --> T[Confirmar citas]
    C --> R[Agenda organizada]
    E --> R
    T --> R
```

---

## Microsoft Copilot: Tu Entorno Seguro

Cuando usas Copilot dentro de la empresa, ocurre algo especial: **tus datos estan protegidos**.

![Diagrama de arquitectura de Microsoft 365 Copilot mostrando como los datos del usuario permanecen dentro del limite de servicio de Microsoft 365](https://learn.microsoft.com/en-us/copilot/microsoft-365/media/microsoft-365-copilot-architecture/copilot-tenant-architecture.png)

| IA Publica (Gratis) | Microsoft Copilot (Empresarial) |
|---------------------|-------------------------------|
| Tus datos entrenan al modelo | Tus datos NO entrenan al modelo |
| La informacion es "publica" | Los datos quedan dentro de la empresa |
| Riesgo de fuga de privacidad | Cumple con normas de seguridad (PII) |

![Diagrama de flujo de consulta de Microsoft 365 Copilot mostrando como procesa los prompts del usuario con grounding y Microsoft Graph](https://learn.microsoft.com/en-us/copilot/microsoft-365/media/microsoft-365-copilot-architecture/copilot-query-flow.png)

> La IA es un colaborador brillante pero sin memoria a largo plazo. Dale Prompts claros, cuida su ventana de contexto y confia en Copilot para mantener la privacidad de nuestra informacion.
$content$), 5);

INSERT INTO lecciones (id, modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
(11, 1, 4, 'Lección 4: El Cinturón de Seguridad. articulo sobre seguridad.  ', 'texto', jsonb_build_object('texto', $content$En abril de 2023, **Samsung** se convirtió en el centro de una noticia que nadie en Talento Humano debería ignorar. Tres empleados, buscando optimizar su tiempo, cometieron un error crítico al usar versiones gratuitas de IA:

1. 💻 Subieron **código fuente confidencial** para buscar errores
2. 📝 Compartieron **notas de una reunión interna** estratégica
3. 📊 Pidieron un resumen de un **reporte técnico** de hardware

> ⚠️ Esos datos pasaron a formar parte del entrenamiento del modelo público. La información dejó de pertenecer a la empresa y quedó disponible para que la herramienta la revelara en respuestas a otros usuarios.

```mermaid
flowchart LR
    E["👤 Empleado"] -->|Pega datos confidenciales| IA["🌐 IA Pública"]
    IA -->|Entrena el modelo| M["🧠 Modelo Global"]
    M -->|Responde a otros usuarios| U["👥 Cualquier Persona"]
    style IA fill:#FF0000,color:white
    style U fill:#FF0000,color:white
```

📰 [Fuente: Forbes Colombia — Samsung prohíbe ChatGPT entre empleados](https://forbes.co/tecnologia/samsung-prohibe-a-chatgpt-entre-empleados)

Este evento fue un quiebre en la confianza organizacional. En Talento Humano, donde manejamos el "ADN" de las personas (salarios, historias clínicas, evaluaciones), un error de este tipo cuesta la reputación y la seguridad de nuestra gente.

---

## 🧠 Conceptos críticos: ¿Dónde estamos parados?

Para navegar con seguridad, debemos entender la diferencia fundamental entre las herramientas:

| Herramienta | Analogía | Privacidad de Datos |
|-------------|----------|---------------------|
| 🌐 IA Pública (Versión Abierta) | Hablar en una plaza llena de gente | 🚩 Riesgo alto. Todo lo que escribas entrena al modelo |
| 🏢 IA Corporativa (Copilot) | Hablar en una sala de juntas blindada | ✅ Seguro. Los datos no salen de la organización |
| 🔒 PII (Información Personal) | Tu "ADN" digital (Cédula, correo, fotos) | 🛡️ Máxima protección. Nunca debe compartirse sin filtrar |

```mermaid
flowchart TD
    subgraph RIESGO["🚩 IA Pública"]
        A[Tu Prompt] --> B[Modelo Global]
        B --> C[Entrenamiento con tus datos]
        C --> D[Exposición a terceros]
    end
    subgraph SEGURO["✅ Copilot Empresarial"]
        E[Tu Prompt] --> F[Modelo Aislado]
        F --> G[Respuesta privada]
        G --> H[Datos protegidos]
    end
    style RIESGO fill:#FF000015,stroke:#FF0000
    style SEGURO fill:#23C84715,stroke:#23C847
```

---

## 🏢 Copilot Chat: Nuestra Fortaleza Digital

La elección de la herramienta es una salvaguarda ética. **Copilot Chat es la única herramienta de IA autorizada por Avianca.**

![Diagrama de arquitectura de Microsoft 365 Copilot mostrando cómo los datos del usuario permanecen dentro del límite de servicio](https://learn.microsoft.com/en-us/copilot/microsoft-365/media/microsoft-365-copilot-architecture/copilot-tenant-architecture.png)

Al utilizar Copilot, activamos un ecosistema donde la privacidad es una **garantía contractual** que impide que la información sensible sea utilizada para entrenar modelos fuera de nuestro control.

> 🔑 Usar una IA no oficial es abrir una grieta en la privacidad de nuestra gente. Usar Copilot es honrar el compromiso de custodia que Avianca tiene con cada uno de sus miembros.

![Diagrama de acceso de usuario en Microsoft 365 Copilot mostrando que solo accede a datos que el usuario tiene permiso de ver](https://learn.microsoft.com/en-us/copilot/microsoft-365/media/microsoft-365-copilot-architecture/copilot-user-access.png)

---

## 📋 El Protocolo de Anonimización

No significa que no podamos pedirle ayuda a la IA. Significa que debemos **"limpiar" la información** antes de compartirla.

### 🔄 La técnica del "Reemplazo de Identidad"

| ❌ Incorrecto | ✅ Correcto |
|------------|----------|
| "IA, ayúdame a redactar un correo para **Carlos Rodríguez** de Nómina. Ha fallado en los cierres de mes y su jefe, **Juan**, está muy molesto." | "IA, ayúdame a redactar un correo de retroalimentación constructiva para un **analista financiero**. El colaborador ha presentado retrasos en la entrega de reportes mensuales." |

```mermaid
flowchart LR
    A["🚫 Texto con PII"] --> B["✏️ Reemplazar nombres"]
    B --> C["📂 Generalizar cargos"]
    C --> D["🧹 Remover datos únicos"]
    D --> E["✅ Texto anonimizado"]
    style A fill:#FF0000,color:white
    style E fill:#23C847,color:white
```

> 🖼️ **La Prueba de la Valla Publicitaria:** Antes de dar clic en "enviar", pregúntate: ¿Me sentiría cómodo si este texto apareciera mañana en una valla publicitaria en la entrada de la empresa? Si la respuesta es no, limpia el texto.

---

## ✨ Recomendaciones de Oro para Talento Humano

1. 🖼️ **La Prueba de la Valla Publicitaria** — Antes de enviar, pregúntate si te sentirías cómodo viendo ese texto en público. Si la respuesta es no, limpia el texto.

2. 🛡️ **Usa los Canales Oficiales** — Privilegia siempre Microsoft Copilot dentro de nuestro entorno corporativo. Es la única forma de garantizar respaldo de seguridad empresarial.

3. ⚖️ **Criterio sobre Automatización** — La IA puede redactar la estructura, pero tú eres quien debe revisar el contenido final, corregir sesgos y asegurar que el trato sea humano y digno.

---

## 🚀 Conclusión: Innovación con Responsabilidad

La Inteligencia Artificial no es un reemplazo de nuestra ética, es un **amplificador de nuestra capacidad**. Al proteger la información, estamos honrando la promesa de cuidado que le hicimos a cada colaborador.

> 💡 En Talento Humano, la tecnología pone la eficiencia, pero nosotros ponemos el escudo de la confianza.
$content$), 10);

INSERT INTO lecciones (id, modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
(12, 1, 5, 'Lección 5: Tu Cabina de Mando en Copilot', 'video', jsonb_build_object('texto', $content$Para dominar la Inteligencia Artificial, primero debemos conocer nuestra mesa de trabajo. En esta lección, aprenderás a navegar por la interfaz de Copilot. 
A lo largo de la guía conocerás cómo está distribuida la pantalla, dónde se ubican las funciones principales y cómo navegar entre las distintas secciones como el panel de chat, el menú de navegación, la Biblioteca y la sección Crear. Esta introducción te permitirá orientarte rápidamente y comprender cómo utilizar Copilot para redactar instrucciones, generar contenido y organizar tus recursos desde un solo lugar.

$content$, 'media_url', 'ccktfma7aNA'), 10);

INSERT INTO lecciones (id, modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
(88, 2, 1, 'Lección 1: Anatomía de un buen prompt: framework GOCE', 'texto', jsonb_build_object('texto', $content$# Anatomía de un buen prompt: el framework GOCE

Un prompt no es solo una pregunta. Es una **instrucción estructurada** que determina la calidad de la respuesta que obtienes de Copilot. La diferencia entre un resultado mediocre y uno extraordinario está en cómo construyes esa instrucción.

Microsoft propone un framework oficial para escribir prompts efectivos en Copilot: **GOCE**. Dominar este framework es la habilidad más importante que puedes desarrollar como usuario de IA en tu día a día laboral.

---

## El framework GOCE

GOCE es un acrónimo que representa los **cuatro componentes fundamentales** de un prompt efectivo, según la documentación oficial de Microsoft para Copilot:

| Componente | Significado | Descripción | Ejemplo en Avianca |
|---|---|---|---|
| **G** - Goal | Objetivo | Qué quieres lograr. La acción concreta que Copilot debe ejecutar. | "Redacta un correo para informar a la tripulación sobre el cambio de itinerario" |
| **O** - Context | Contexto | Información de fondo que Copilot necesita para entender la situación. | "El vuelo AV204 Bogotá-Miami fue reprogramado de 6:00 AM a 9:30 AM por mantenimiento preventivo" |
| **C** - Expectations | Expectativas | El formato, tono o estilo que esperas en la respuesta. | "Usa un tono formal pero empático, en máximo 150 palabras" |
| **E** - Source | Fuente | Documentos, datos o referencias que Copilot debe consultar. | "Básate en el protocolo de comunicación de cambios operacionales del manual de Avianca" |

> Tip: No necesitas incluir los cuatro componentes en cada prompt, pero mientras más componentes uses, mejor será la respuesta. Empieza con Goal y Context como mínimo.

---

## Prompt malo vs. prompt bueno

### Prompt malo

```
Hazme un resumen del informe de puntualidad
```

Este prompt falla porque no tiene contexto, no especifica período, no define formato y no indica la fuente de datos. Copilot tendrá que adivinar todo y probablemente entregará algo genérico e inútil.

### Prompt bueno (aplicando GOCE)

```
[Goal] Genera un resumen ejecutivo del desempeño de puntualidad operacional
[Context] para la ruta Bogotá-Cancún durante marzo 2026, considerando que
el objetivo corporativo de OTP es 85% y el resultado fue 78.3%
[Expectations] en formato de 3 párrafos: situación actual, causas principales
y recomendaciones. Usa tono profesional para presentar ante el Comité de
Operaciones.
[Source] Básate en los datos del reporte mensual de operaciones /OTP-marzo-2026.xlsx
```

La diferencia es evidente: el segundo prompt le da a Copilot toda la información que necesita para generar una respuesta precisa y accionable.

---

## Framework expandido de 5 componentes

Para situaciones más complejas, puedes usar un framework ampliado de **cinco componentes** que agrega mayor control sobre la respuesta:

```mermaid
graph TD
    A["1. Rol"] --> B["2. Contexto"]
    B --> C["3. Tarea"]
    C --> D["4. Formato"]
    D --> E["5. Restricciones"]

    style A fill:#a7c7e7,stroke:#4a7fb5,stroke-width:2px,color:#1e293b
    style B fill:#b5d8a7,stroke:#5a9e4b,stroke-width:2px,color:#1e293b
    style C fill:#f7d794,stroke:#d4a547,stroke-width:2px,color:#1e293b
    style D fill:#d4a7e7,stroke:#9b59b6,stroke-width:2px,color:#1e293b
    style E fill:#f5b7b1,stroke:#e74c3c,stroke-width:2px,color:#1e293b
```

### 1. Rol

Define **quién es** Copilot en este escenario. Esto calibra el vocabulario, la profundidad técnica y el enfoque de la respuesta.

*Ejemplo: "Actúa como un analista senior de operaciones aéreas con 10 años de experiencia en aerolíneas latinoamericanas."*

### 2. Contexto

Proporciona la **información de fondo** necesaria. Incluye datos, fechas, áreas involucradas y cualquier detalle relevante.

*Ejemplo: "Avianca está evaluando abrir una nueva ruta directa Bogotá-Toronto para el segundo semestre de 2026."*

### 3. Tarea

Indica la **acción específica** que debe realizar. Sé claro y usa verbos de acción: analiza, compara, redacta, resume, genera.

*Ejemplo: "Elabora un análisis comparativo de demanda y rentabilidad proyectada."*

### 4. Formato

Especifica **cómo quieres recibir** la respuesta: tabla, lista, párrafos, bullet points, cantidad de palabras, idioma.

*Ejemplo: "Preséntalo en una tabla con columnas: criterio, dato, fuente, y un párrafo de conclusión de máximo 100 palabras."*

### 5. Restricciones

Establece los **límites y condiciones** que la respuesta debe respetar: qué no debe incluir, qué tono usar, qué evitar.

*Ejemplo: "No incluyas proyecciones financieras específicas. Mantente en un análisis cualitativo de mercado."*

---

## El proceso de construcción de un prompt

```mermaid
flowchart LR
    A["Identificar\nla necesidad"] --> B["Definir\nel objetivo"]
    B --> C["Agregar\ncontexto"]
    C --> D["Especificar\nformato"]
    D --> E["Incluir\nfuentes"]
    E --> F["Revisar\ny enviar"]
    F --> G{"El resultado\nes util?"}
    G -- Si --> H["Listo"]
    G -- No --> I["Iterar\ny refinar"]
    I --> B

    style A fill:#a7c7e7,stroke:#4a7fb5,stroke-width:2px,color:#1e293b
    style B fill:#b5d8a7,stroke:#5a9e4b,stroke-width:2px,color:#1e293b
    style C fill:#f7d794,stroke:#d4a547,stroke-width:2px,color:#1e293b
    style D fill:#d4a7e7,stroke:#9b59b6,stroke-width:2px,color:#1e293b
    style E fill:#f5b7b1,stroke:#e74c3c,stroke-width:2px,color:#1e293b
    style F fill:#fadbd8,stroke:#d4a547,stroke-width:2px,color:#1e293b
    style G fill:#fdebd0,stroke:#e67e22,stroke-width:2px,color:#1e293b
    style H fill:#d5f5e3,stroke:#27ae60,stroke-width:2px,color:#1e293b
    style I fill:#f9e79f,stroke:#f1c40f,stroke-width:2px,color:#1e293b
```

> Tip: Un prompt rara vez es perfecto a la primera. Trata la conversación con Copilot como un diálogo iterativo: envía un prompt, evalúa la respuesta, y refina tu instrucción. Cada iteración te acerca más al resultado que necesitas. La clave no es escribir el prompt perfecto, sino mejorar progresivamente.

---

## Errores comunes y cómo corregirlos

| Error | Ejemplo malo | Corrección | Ejemplo bueno |
|---|---|---|---|
| Prompt vago sin objetivo | "Dime algo sobre la puntualidad" | Definir un objetivo concreto | "Resume las 3 principales causas de retraso en la ruta BOG-MDE en febrero 2026" |
| Sin contexto ni datos | "Haz un informe de ventas" | Agregar período, área y métricas | "Genera un informe de ventas del canal digital para el Q1 2026, enfocado en la ruta BOG-CUN" |
| No especificar formato | "Analiza estos datos" | Indicar cómo quieres la respuesta | "Analiza estos datos y preséntalos en una tabla con columnas: métrica, valor actual, meta, brecha" |
| Pedir demasiado en un solo prompt | "Haz el informe completo, la presentación, el correo y el dashboard" | Dividir en tareas individuales | "Primero, genera el resumen ejecutivo del informe de OTP de marzo 2026" |
| No iterar ante una mala respuesta | Aceptar la primera respuesta sin cuestionar | Refinar con instrucciones adicionales | "Buen inicio, pero necesito que te enfoques más en las causas operacionales y menos en las meteorológicas" |
| Olvidar el tono y la audiencia | "Explica por qué hubo retrasos" | Especificar para quién es | "Explica las causas de retraso en términos ejecutivos para presentar al VP de Operaciones" |

---

## Fuentes

- Microsoft Learn - Crear indicaciones eficaces para Microsoft 365 Copilot: [https://learn.microsoft.com/es-es/training/paths/craft-effective-prompts-copilot-microsoft-365/](https://learn.microsoft.com/es-es/training/paths/craft-effective-prompts-copilot-microsoft-365/)
- Microsoft Support - Cooking up a great prompt: [https://support.microsoft.com/en-us/topic/cooking-up-a-great-prompt-getting-the-most-from-copilot-7b614306-d5aa-4b62-8509-e46674a29165](https://support.microsoft.com/en-us/topic/cooking-up-a-great-prompt-getting-the-most-from-copilot-7b614306-d5aa-4b62-8509-e46674a29165)
- Microsoft Copilot - Galería de prompts: [https://copilot.cloud.microsoft/prompts](https://copilot.cloud.microsoft/prompts)$content$), 15);

INSERT INTO lecciones (id, modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
(115, 2, 2, 'Lección 2: El poder del "NO" y el blindaje de datos', 'video', jsonb_build_object('texto', $content$## 🛡️ Implementación Segura y Arquitectura de Blindaje

Este contenido complementa el video sobre cómo integrar la Inteligencia Artificial de forma estratégica, garantizando que la innovación nunca comprometa la integridad de la información sensible. Aquí detallamos la estructura técnica necesaria para que la eficiencia y la privacidad coexistan bajo un control total.

---

### **Conceptos Clave de la Sesión**

El núcleo de una implementación robusta radica en la **Arquitectura de Blindaje**, la cual se sostiene sobre dos pilares fundamentales:

1. **Protección de Datos Empresariales (EDP):** Es el estándar de seguridad que garantiza que cada interacción está cifrada y aislada. Bajo este protocolo, la información es propiedad exclusiva de la organización y **nunca** se utiliza para entrenar modelos públicos o externos.
2. **El Poder del "NO" (Capa de Salvaguarda):** Consiste en definir límites operativos precisos. No se trata solo de dar instrucciones, sino de establecer restricciones claras sobre qué **no** debe hacer el sistema, evitando fugas de datos confidenciales o alucinaciones en los resultados finales.

---

### **Las 4 Capas de la Arquitectura del Rol**

Para que la herramienta actúe con la precisión de un experto, es necesario estructurar cada comando en cuatro niveles distintos:

* **Capa Ontológica:** Define la personalidad, el tono y el marco ético que debe seguir la IA.
* **Capa Operativa:** Delimita el conocimiento específico y las fuentes de datos a las que tiene permiso de acceder.
* **Capa de Salvaguarda:** Establece las "líneas rojas" y los protocolos de privacidad para proteger datos críticos.
* **Capa de Entrega:** Especifica el formato, la estructura técnica y el canal donde se presentará el resultado.

---

### **Conclusión**

La privacidad no es un obstáculo para el progreso tecnológico; es la base indispensable para una automatización confiable. Al aplicar estas capas de seguridad, transformamos una herramienta genérica en una extensión digital del juicio profesional, permitiendo escalar procesos de manera ética, exacta y, sobre todo, blindada contra riesgos externos.

---
$content$, 'media_url', '3fyceNipllY'), 10);

INSERT INTO lecciones (id, modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
(90, 2, 3, 'Lección 3: Protocolo de anonimización', 'texto', jsonb_build_object('texto', $content$# Protocolo de anonimización: protege la información antes de usar IA

Cada vez que escribes un prompt, estás compartiendo información con un sistema de inteligencia artificial. Incluso dentro de un entorno corporativo como Microsoft Copilot, aplicar un protocolo de anonimización es una práctica esencial que reduce riesgos y protege a las personas detrás de los datos.

---

## Por qué anonimizar, incluso con Copilot empresarial

Microsoft Copilot para Microsoft 365 opera dentro del límite de confianza de tu organización. Tus datos no entrenan el modelo público y permanecen aislados en el tenant de Avianca. Sin embargo, hay razones concretas para anonimizar antes de enviar un prompt:

- **Principio de mínimo privilegio:** No compartas más datos de los necesarios para obtener la respuesta que buscas. Si la IA puede ayudarte sin conocer el nombre real de una persona, no lo incluyas.
- **Errores de canal:** Un prompt pensado para Copilot puede terminar pegado por accidente en una herramienta pública. Si el texto ya está anonimizado, el daño es nulo.
- **Auditoría y cumplimiento:** Los registros de uso pueden ser revisados. Un historial limpio de PII demuestra buenas prácticas ante auditorías internas y regulatorias.
- **Cultura de protección:** Anonimizar por defecto crea un hábito que protege a la organización sin depender de que cada persona recuerde qué herramienta está usando.

> La anonimización no es desconfianza hacia la herramienta. Es disciplina profesional.

---

## Cuatro técnicas de anonimización

| Técnica | Descripción | Antes | Después |
|---------|-------------|-------|---------|
| Reemplazo por placeholders | Sustituir datos reales por etiquetas genéricas entre corchetes | "Envía el reporte a Carlos Méndez, cédula 1.023.456.789" | "Envía el reporte a [NOMBRE_EMPLEADO], cédula [ID_DOCUMENTO]" |
| Generalización | Reemplazar valores específicos por rangos o categorías | "La colaboradora de 34 años gana $8.500.000 mensuales" | "La colaboradora está en el rango de 30-40 años con salario en banda salarial media" |
| Seudonimización | Sustituir identificadores reales por códigos ficticios consistentes | "María López del área de Finanzas reportó a Juan Pérez" | "Empleada A del área X reportó a Empleado B" |
| Datos sintéticos | Crear ejemplos ficticios que conservan la estructura del dato real | "Tarjeta corporativa 4532-XXXX-XXXX-7821 con cupo de USD 15.000" | "Tarjeta corporativa 0000-0000-0000-0000 con cupo de USD [MONTO]" |

> La técnica más simple y efectiva para el día a día es el reemplazo por placeholders. Las demás son útiles cuando necesitas que la IA trabaje con la estructura del dato.

---

## Datos que nunca deben ir en un prompt

Independientemente de la herramienta que uses, estos tipos de información requieren anonimización obligatoria:

- **Identificación personal:** Nombres completos, números de cédula, pasaportes, fechas de nacimiento exactas
- **Datos financieros:** Números de tarjetas de crédito, cuentas bancarias, salarios específicos, extractos
- **Información médica:** Diagnósticos, historias clínicas, resultados de exámenes, incapacidades con detalles
- **Credenciales de acceso:** Contraseñas, tokens de API, claves de cifrado, URLs internas con parámetros de autenticación
- **Acuerdos confidenciales:** Términos de contratos con proveedores, cláusulas de no divulgación, condiciones comerciales exclusivas
- **Datos de contacto directo:** Números de celular personal, direcciones de domicilio, correos personales

---

## Copilot empresarial vs. herramientas gratuitas

| Característica | Microsoft Copilot (empresarial) | ChatGPT / Gemini (versión gratuita) |
|---|---|---|
| Uso de datos para entrenamiento | No. Los datos no entrenan el modelo | Sí. Los datos pueden usarse para mejorar el modelo |
| Aislamiento de datos | Dentro del tenant de Microsoft 365 de Avianca | Sin aislamiento. Los datos circulan por infraestructura compartida |
| Cumplimiento GDPR / Ley 1581 | Sí. Contratos de procesamiento de datos (DPA) con la organización | Limitado. El usuario acepta términos individuales sin respaldo corporativo |
| Capacidad de auditoría | Sí. Registros disponibles en Microsoft Purview | No. Sin visibilidad para la organización sobre qué se compartió |
| Control de acceso | Respeta los permisos de Microsoft 365. Solo ves lo que tu rol permite | Sin integración con permisos corporativos |
| Retención y eliminación | Políticas configurables por la organización | Sujeta a las políticas del proveedor, fuera del control de Avianca |

> Que Copilot sea seguro no elimina la necesidad de anonimizar. La seguridad de la herramienta y la higiene del dato son capas complementarias, no sustitutas.

---

## Flujo de anonimización

Antes de enviar cualquier prompt, sigue este proceso mental:

```mermaid
flowchart LR
    A["Texto original"] --> B["Identificar PII"]
    B --> C["Reemplazar con placeholders"]
    C --> D["Generalizar valores específicos"]
    D --> E["Texto seguro"]
    style A fill:#fecaca,stroke:#b91c1c
    style B fill:#fed7aa,stroke:#c2410c
    style C fill:#fef08a,stroke:#a16207
    style D fill:#bbf7d0,stroke:#15803d
    style E fill:#a7f3d0,stroke:#059669
```

Cada paso actúa como un filtro. No todos los textos requieren los cuatro pasos; a veces basta con reemplazar nombres. Lo importante es que el proceso se vuelva automático.

---

## Ejercicio práctico: antes y después

### Prompt 1 -- Solicitud de retroalimentación

**Antes (con PII):**

"Ayúdame a escribir un correo de retroalimentación para Andrea Gómez, analista de Revenue Management. Su jefe directo es Roberto Castillo. Andrea ha tenido tres llegadas tarde esta semana y su evaluación de desempeño fue 2.3/5."

**Después (anonimizado):**

"Ayúdame a escribir un correo de retroalimentación para un analista del área comercial. El colaborador ha tenido tres llegadas tarde esta semana y su evaluación de desempeño fue inferior al promedio esperado."

---

### Prompt 2 -- Análisis de datos de nómina

**Antes (con PII):**

"Revisa esta tabla de nómina: Juan Pérez - CC 80.123.456 - $12.300.000; Laura Díaz - CC 52.789.012 - $9.800.000; Miguel Torres - CC 1.098.765.432 - $7.500.000."

**Después (anonimizado):**

"Revisa esta estructura de nómina con datos de ejemplo: Empleado A - [ID_1] - Banda salarial alta; Empleado B - [ID_2] - Banda salarial media; Empleado C - [ID_3] - Banda salarial base."

---

### Prompt 3 -- Consulta sobre beneficios médicos

**Antes (con PII):**

"La colaboradora Sofía Ramírez, cédula 1.045.678.901, fue diagnosticada con síndrome de burnout. Su EPS es Sura y tiene una incapacidad hasta el 15 de abril. Ayúdame a redactar la comunicación al área de bienestar."

**Después (anonimizado):**

"Una colaboradora del área operativa presenta una incapacidad médica por estrés laboral con vigencia de dos semanas. Ayúdame a redactar la comunicación al área de bienestar siguiendo el protocolo interno."

---

## La prueba de la valla publicitaria

Antes de enviar cualquier prompt, aplica esta regla:

> **Imagina que el texto que vas a enviar aparece mañana en una valla publicitaria en la entrada de la sede principal de Avianca.** Si eso te generaría incomodidad, preocupación o un problema legal, entonces el texto necesita ser anonimizado antes de enviarlo.

Esta prueba funciona porque obliga a evaluar el riesgo desde la perspectiva más expuesta posible. No importa si la herramienta es segura; lo que importa es que el contenido del prompt sea seguro por sí mismo, independientemente de dónde termine.

La valla publicitaria no es un escenario probable, pero es el estándar correcto. Un texto que pasa esta prueba está listo para cualquier herramienta, cualquier auditoría y cualquier eventualidad.

---

## Fuentes

- [Privacidad de Microsoft 365 Copilot](https://learn.microsoft.com/es-es/copilot/microsoft-365/microsoft-365-copilot-privacy) -- Cómo Microsoft gestiona los datos dentro de Copilot.
- [Protección de datos empresariales en Copilot](https://learn.microsoft.com/es-es/copilot/microsoft-365/enterprise-data-protection) -- Controles de seguridad y aislamiento del tenant.
- [Microsoft Purview para IA](https://learn.microsoft.com/es-es/purview/ai-microsoft-purview) -- Herramientas de auditoría, cumplimiento y gobernanza de datos en entornos de IA.$content$), 15);

INSERT INTO lecciones (id, modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
(124, 2, 5, ' Lección 4: Formatos de Alto Impacto (Flag Hunter)', 'recurso_externo', jsonb_build_object('url', 'https://view.genially.com/69cc777d6e0ecb6b43c20ff3', 'modo', 'embed', 'texto', $content$## 📄 Lección 4: Formatos de Alto Impacto (Flag Hunter)

En esta sesión, elevamos el estándar de interacción con la IA. Pasamos de solicitar "simples respuestas" a exigir **activos digitales estructurados**. El formato no es un adorno; es el lenguaje técnico que permite que la información sea auditable, escalable y, sobre todo, accionable sin retrabajo.

---

### **La Teoría de las Banderas: Auditoría de Resultados**

Para dominar los formatos de alto impacto, aplicamos la **Metodología de Banderas**. Esta técnica te permite evaluar la calidad de un entregable antes de integrarlo a tus procesos:

* **🟢 Banderas Verdes (Green Flags):** Son instrucciones que generan **información estructurada**. Se identifican por el uso de tablas Markdown, rúbricas de evaluación, listas de brechas o formatos de código. Una "Green Flag" garantiza que el resultado sea preciso, profesional y que llegue a tu pantalla listo para ser distribuido o pegado en un informe.
* **🔴 Banderas Rojas (Red Flags):** Son instrucciones vagas que piden "un texto", "un resumen" o se centran solo en el tono. Estas generan respuestas ambiguas, cargadas de subjetividad y que requieren **carpintería digital** (edición manual pesada). Una "Red Flag" es sinónimo de ineficiencia y falta de estructura técnica.



---

### **Técnica Maestra: Few-Shot Prompting**

La forma más efectiva de asegurar una **Bandera Verde** es el **Few-Shot Prompting**. Esta técnica consiste en "entrenar" a la IA entregándole uno o dos ejemplos reales del formato que esperas recibir. Al ver la estructura, la profundidad y el orden que requieres, la IA deja de adivinar y empieza a replicar activos digitales con precisión quirúrgica.

---

### **🚩 Actividad: Desafío Flag Hunter**

Es hora de poner a prueba tu ojo clínico. En la gestión de datos, un resultado visualmente atractivo puede ser una "Bandera Roja" disfrazada. En este desafío, actuarás como un auditor técnico: tu misión es identificar inconsistencias, detectar alucinaciones y dominar la transición del texto plano a la estructura de alto impacto.


---

### **Conclusión**

El dominio de los formatos de alto impacto es lo que separa a un usuario casual de un experto est$content$), 10);

INSERT INTO lecciones (id, modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
(125, 2, 6, 'Lección 5: El Ciclo de Refinamiento (Iteración y Feedback)', 'texto', jsonb_build_object('texto', $content$## 🔄 Lección 5: El Ciclo de Refinamiento (Iteración y Feedback)

Muchos usuarios abandonan la Inteligencia Artificial porque el primer resultado que obtienen es "regular". En esta lección aprenderás que el verdadero potencial de Copilot no está en su primera respuesta, sino en tu capacidad para **dialogar y refinar**. Descubrirás cómo usar el feedback iterativo para perfeccionar cualquier tarea sin necesidad de reiniciar el chat desde cero.

---

### **1. La IA no adivina, se entrena en vivo**

En el entorno profesional, sabemos que un proyecto rara vez es perfecto en su primer borrador sin recibir retroalimentación. Con la IA ocurre lo mismo. El **Ciclo de Refinamiento** es el proceso de dar instrucciones adicionales sobre un resultado previo para ajustarlo a tus necesidades exactas.

> **💡 Regla de oro:** Si la respuesta de la IA no te convence, **no borres el chat**. Dale una instrucción de mejora.



---

### **2. Los 3 Niveles de Refinamiento**

Para pulir un resultado de forma profesional, puedes iterar en tres dimensiones diferentes:

#### **A. Refinamiento de Tono y Estilo**
Si el contenido es correcto pero la "música" no suena bien, ajusta la personalidad.
* **Ejemplo:** *"Me gusta la información, pero suena muy robótica. Reescríbela para que suene más empática y cercana, como si fuera un mensaje de un líder a su equipo de confianza."*

#### **B. Refinamiento de Estructura y Formato**
Si la información está completa pero es difícil de leer, cámbiale la forma.
* **Ejemplo:** *"El texto es muy largo. Por favor, resume los puntos clave en una lista de viñetas (bullets) y pon en negrita los plazos de entrega."*

#### **C. Refinamiento de Contenido (Agregar o Quitar)**
Si falta un detalle crítico o hay información que sobra, pídelo específicamente.
* **Ejemplo:** *"Está muy bien, pero olvidaste mencionar que el beneficio de teletrabajo solo aplica para quienes hayan pasado el periodo de prueba. Incluye esa restricción en el segundo párrafo."*

---

### **3. El Método del "Feedback Constructivo" para la IA**

Para que el ciclo de refinamiento sea efectivo, tu feedback debe ser específico. En lugar de decir "No me gusta", utiliza la estructura: **[Lo que está bien] + [Lo que debe cambiar]**.

* **❌ Mal ejemplo:** *"Hazlo otra vez, no me sirve."* (La IA volverá a adivinar y fallará de nuevo).
* **✅ Buen ejemplo:** *"El resumen del perfil del candidato es correcto **[Lo que está bien]**, pero ahora necesito que profundices más en su experiencia con herramientas de nómina y descartes la parte de sus estudios básicos **[Lo que debe cambiar]**."*



---

### **4. Cómo evitar el "Agotamiento del Contexto"**

A medida que iteras muchas veces en un mismo chat, la IA puede empezar a confundirse (lo que se conoce como el límite de la **Ventana de Contexto**).

**¿Cuándo parar de refinar y reiniciar el chat?**
* Si después de 3 o 4 intentos la IA sigue sin entender un cambio sencillo.
* Si notas que la IA "olvida" las restricciones o instrucciones que le diste al principio.
* Si vas a cambiar radicalmente de tema (por ejemplo, pasar de un tema legal a uno creativo).

---

### **5. Resumen Táctico para el Equipo**

* **La primera respuesta es solo un borrador.** No esperes perfección al inicio; espera una base sobre la cual construir.
* **Itera sobre lo construido.** Usa frases conectoras como: *"Ahora añade..."*, *"Cambia el tono a..."*, o *"Resume esto en..."*.
* **Sé específico en tu crítica.** Dile a la IA exactamente qué palabra, frase o sección no encaja en tu objetivo.
* **Usa la "Escoba" con sabiduría.** El botón de "Nuevo Tema" se usa solo cuando hayas agotado el refinamiento o cambies totalmente de objetivo.$content$), 10);

INSERT INTO lecciones (id, modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
(116, 3, 1, 'Lección 1: ADN Digital: clonación y lógica', 'video', jsonb_build_object('texto', $content$## 🚀 ADN Digital: clonación y lógica

Hasta ahora hemos aprendido que la Inteligencia Artificial no es un buscador, sino un colaborador que procesa intenciones. Pero, ¿cómo transformamos una idea en un resultado perfecto? La respuesta está en el **Prompt Engineering**.

Este término, que a veces suena complejo, es en realidad el arte de **diseñar instrucciones** que actúen como un puente entre tu necesidad y la capacidad de procesamiento de la IA. No se trata simplemente de escribir, sino de estructurar el pensamiento.

---

### **¿Qué es realmente un Prompt?**

Un *prompt* es el punto de partida; es el conjunto de palabras, datos y contexto que le entregamos a la herramienta para definir su comportamiento. En este nivel introductorio, debemos entender tres conceptos fundamentales:

1.  **La IA no tiene contexto previo:** A diferencia de un colega que lleva años trabajando contigo, la IA comienza cada "Nuevo Tema" desde cero. Lo que no explicas en el prompt, la IA lo tiene que "adivinar".
2.  **Claridad sobre Ambigüedad:** Un prompt efectivo elimina las interpretaciones dobles. Cuanto más específica sea la instrucción, más predecible será el resultado.
3.  **El Rol del Diseñador:** En esta etapa del curso, dejas de ser un usuario que hace preguntas y te conviertes en un **diseñador de instrucciones**. Tu objetivo es configurar el entorno para que la IA brille.



---

### **Sobre este Video**

En el siguiente recurso visual, exploraremos la lógica detrás de una buena interacción. Veremos cómo la estructura de nuestras palabras afecta directamente la calidad de lo que recibimos. Este video es la base conceptual necesaria antes de sumergirnos en las técnicas avanzadas de ingeniería de prompts que transformarán tu productividad.

---

### **Conclusión**

El *Prompt Engineering* es la habilidad más importante en la era de la inteligencia artificial. No necesitas ser programador para dominarlo, pero sí necesitas ser un comunicador excepcional. Aprender a dar instrucciones es, en última instancia, aprender a delegar con éxito en un entorno digital.$content$, 'media_url', 'F2YhpLLw8v8'), 10);

INSERT INTO lecciones (id, modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
(94, 3, 2, 'Zero-shot vs Few-shot: cuándo dar ejemplos a la IA', 'texto', jsonb_build_object('texto', $content$# Zero-shot vs Few-shot: cuándo y por qué dar ejemplos a la IA

Cuando le pides algo a la IA, tienes dos caminos fundamentales: darle solo la instrucción o acompañarla con ejemplos. Esta decisión impacta directamente la calidad y consistencia de la respuesta.

---

## Qué es Zero-shot

Zero-shot significa darle a la IA **únicamente la instrucción**, sin ningún ejemplo previo. Confías en que el modelo ya "sabe" cómo resolver la tarea gracias a su entrenamiento.

```
Clasifica el siguiente texto como positivo, negativo o neutro:

"El vuelo llegó a tiempo y el servicio fue excelente."
```

La IA interpreta la tarea y responde directamente. Funciona bien cuando la tarea es clara y no hay ambigüedad en el formato o los criterios esperados.

---

## Qué es Few-shot

Few-shot significa incluir **entre 2 y 5 ejemplos resueltos** antes de presentar la tarea real. Le estás mostrando al modelo exactamente qué formato y criterio esperas.

```
Clasifica el sentimiento del texto.

Texto: "Me encantó la comida del vuelo."
Sentimiento: Positivo

Texto: "Perdieron mi maleta y nadie me ayudó."
Sentimiento: Negativo

Texto: "El vuelo duró 3 horas."
Sentimiento: Neutro

Texto: "El vuelo llegó a tiempo y el servicio fue excelente."
Sentimiento:
```

Los ejemplos actúan como una **guía implícita**: el modelo detecta el patrón y lo replica.

---

## Comparación directa

| Aspecto | Zero-shot | Few-shot |
|---------|-----------|----------|
| Ejemplos necesarios | Ninguno | 2 a 5 |
| Consumo de tokens | Bajo | Moderado |
| Velocidad de escritura | Rápida | Requiere preparación |
| Consistencia de formato | Variable | Alta |
| Ideal para | Tareas genéricas y claras | Clasificación, formatos específicos |
| Riesgo principal | Formato impredecible | Sesgo si los ejemplos son malos |
| Complejidad del prompt | Baja | Media |

---

## Regla práctica

La decisión se reduce a una pregunta: **¿la tarea tiene una única interpretación posible?**

- **Tarea unívoca** (resumir, traducir, corregir ortografía): usa **zero-shot**. La IA ya entiende qué hacer.
- **Formato o clasificación específica** (categorizar quejas, generar tablas con estructura definida, etiquetar datos): usa **few-shot**. Los ejemplos eliminan la ambigüedad.

> Si al leer tu instrucción alguien podría responder de tres formas distintas y todas serían "correctas", necesitas few-shot para anclar la respuesta al formato que esperas.

---

## Flujo de decisión

```mermaid
flowchart TD
    A[Tienes una tarea para la IA] --> B{La tarea tiene una sola<br/>interpretación posible?}
    B -- Sí --> C[Zero-shot:<br/>solo instrucción]
    B -- No --> D{Necesitas un formato<br/>o clasificación específica?}
    D -- Sí --> E[Few-shot:<br/>incluir 3 a 5 ejemplos]
    D -- No --> F[Zero-shot con<br/>instrucciones detalladas]
    C --> G[Enviar prompt]
    E --> G
    F --> G
    style A fill:#e0f2fe,stroke:#0284c7
    style B fill:#fef3c7,stroke:#d97706
    style C fill:#dcfce7,stroke:#16a34a
    style D fill:#fef3c7,stroke:#d97706
    style E fill:#f3e8ff,stroke:#9333ea
    style F fill:#dcfce7,stroke:#16a34a
    style G fill:#e0f2fe,stroke:#0284c7
```

---

## Comparación de flujos: Zero-shot vs Few-shot

```mermaid
flowchart LR
    subgraph ZS["Zero-shot"]
        direction TB
        Z1[Instrucción] --> Z2[Modelo procesa] --> Z3[Respuesta]
    end
    subgraph FS["Few-shot"]
        direction TB
        F1[Ejemplos resueltos] --> F2[Instrucción + tarea real] --> F3[Modelo detecta patrón] --> F4[Respuesta consistente]
    end
    style ZS fill:#dcfce7,stroke:#16a34a
    style FS fill:#f3e8ff,stroke:#9333ea
    style Z1 fill:#bbf7d0,stroke:#16a34a
    style Z2 fill:#bbf7d0,stroke:#16a34a
    style Z3 fill:#bbf7d0,stroke:#16a34a
    style F1 fill:#e9d5ff,stroke:#9333ea
    style F2 fill:#e9d5ff,stroke:#9333ea
    style F3 fill:#e9d5ff,stroke:#9333ea
    style F4 fill:#e9d5ff,stroke:#9333ea
```

---

## Ejemplo completo: clasificación de quejas de pasajeros

Supongamos que necesitas clasificar quejas de pasajeros en cuatro categorías: **[Equipaje]**, **[Retraso]**, **[Servicio a bordo]** y **[Reservas]**.

### Prompt few-shot con 5 ejemplos

```
Clasifica la queja del pasajero en una de estas categorías: [Equipaje], [Retraso], [Servicio a bordo], [Reservas].
Responde únicamente con la categoría entre corchetes.

Queja: "Mi maleta llegó con una rueda rota y el cierre dañado."
Categoría: [Equipaje]

Queja: "El vuelo BOG-MDE salió con 4 horas de retraso y no nos dieron información."
Categoría: [Retraso]

Queja: "La comida estaba fría y el auxiliar de vuelo fue grosero cuando lo mencioné."
Categoría: [Servicio a bordo]

Queja: "Compré un tiquete por la app y me cobraron dos veces sin generar confirmación."
Categoría: [Reservas]

Queja: "Llevamos 2 horas esperando en la puerta de embarque sin ninguna actualización."
Categoría: [Retraso]

Queja: "En el vuelo AV204 el sistema de entretenimiento no funcionaba y los asientos estaban sucios."
Categoría:
```

La respuesta esperada es `[Servicio a bordo]`. Observa cómo los 5 ejemplos:

- Cubren las **4 categorías** (no se repite siempre la misma).
- Mantienen un **formato idéntico**: "Queja: ... / Categoría: [...]".
- Son **representativos** de quejas reales en una aerolínea.
- La tarea real sigue el mismo formato exacto.

---

## Las 4 reglas para construir buenos ejemplos few-shot

### 1. Variedad

Los ejemplos deben cubrir **todas o la mayoría de las categorías posibles**. Si tienes 4 categorías, no pongas 5 ejemplos de la misma; distribúyelos.

### 2. Formato consistente

Cada ejemplo debe seguir **exactamente la misma estructura**. Si el primero usa "Queja: ... / Categoría: [...]", todos deben hacerlo igual. Una inconsistencia confunde al modelo.

### 3. Representatividad

Los ejemplos deben parecerse a los **casos reales** que la IA va a encontrar. No uses ejemplos triviales o artificiales; usa lenguaje y situaciones que reflejen la realidad.

### 4. Cantidad óptima: 3 a 5 ejemplos

Menos de 3 no establece un patrón claro. Más de 5 consume tokens sin mejorar significativamente la calidad. El punto óptimo está entre **3 y 5 ejemplos**.

| Regla | Qué hacer | Qué evitar |
|-------|-----------|------------|
| Variedad | Cubrir todas las categorías | 5 ejemplos de la misma clase |
| Formato consistente | Misma estructura en cada ejemplo | Mezclar formatos o estilos |
| Representatividad | Casos reales y típicos | Ejemplos inventados o extremos |
| Cantidad óptima | 3 a 5 ejemplos | 1 solo ejemplo o más de 7 |

---

## Errores comunes

### Muy pocos ejemplos

Dar solo 1 ejemplo no es few-shot, es un caso aislado. El modelo no tiene suficiente información para detectar un patrón. Usa al menos 3.

### Todos los ejemplos de la misma categoría

Si tus 5 ejemplos son de `[Equipaje]`, el modelo va a sesgar sus respuestas hacia esa categoría. Distribuye los ejemplos entre todas las opciones.

### Formato inconsistente entre ejemplos

Si un ejemplo usa "Categoría:" y otro usa "Tipo:", el modelo no sabe cuál formato seguir. Mantén la estructura idéntica en cada ejemplo y en la tarea real.

### Ejemplos que contradicen la instrucción

Si la instrucción dice "responde solo con la categoría" pero en los ejemplos agregas explicaciones, el modelo va a imitar los ejemplos, no la instrucción. Los ejemplos siempre ganan.

---

## Fuentes

- [Prompting Guide - Few-shot Prompting](https://www.promptingguide.ai/es/techniques/fewshot)
- [Prompting Guide - Zero-shot Prompting](https://www.promptingguide.ai/es/techniques/zeroshot)
- [Microsoft Learn - Aprendizaje Zero-shot](https://learn.microsoft.com/es-es/dotnet/ai/conceptual/zero-shot-learning)
- [Prompt.org.es - Few-shot vs Zero-shot: comparativa](https://www.prompt.org.es/docs/vs-metods/few-shot-vs-zero-shot-prompting-comparativa)$content$), 15);

INSERT INTO lecciones (id, modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
(126, 3, 3, 'Lección 2:  Prompts para Talento Humano (Ejemplos Prácticos)', 'video', jsonb_build_object('texto', $content$## 🎓 Prompts para Talento Humano (Ejemplos Prácticos)

En esta lección, dejamos de lado la teoría para ver cómo la Inteligencia Artificial se convierte en un **copiloto estratégico** en el día a día de la gestión de personas. No se trata solo de hacer preguntas, sino de aplicar ingeniería de instrucciones para obtener resultados de nivel experto.

A través de este video, exploramos la aplicación real de las **4 técnicas esenciales de Prompt Engineering** diseñadas específicamente para los desafíos de nuestra área:

---

### **📌 Las 4 Técnicas en Acción:**

1. **Instrucciones Claras (Contexto y Rol):** Veremos cómo definir la "personalidad" de la IA para que actúe como un consultor senior de compensación o un experto en desarrollo organizacional, eliminando respuestas genéricas.
2. **Few-Shot Prompting (Aprender con Ejemplos):** Aprenderás a entregarle a la IA modelos previos de tus reportes o correos para que replique exactamente tu estilo y estructura institucional sin errores.
3. **Pensamiento Paso a Paso (Chain of Thought):** Desglosaremos procesos complejos, como el análisis de una brecha de competencias, pidiéndole a la IA que razone antes de concluir, garantizando lógica en cada recomendación.
4. **Meta Prompting (La IA como Diseñadora):** Descubrirás cómo pedirle a la propia IA que mejore tus instrucciones o que cree la estructura perfecta para un proceso de *Onboarding* desde cero.


---

### **¿Qué aprenderás en este video?**

* Cómo transformar una descripción de cargo plana en un perfil de alto impacto.
* El método para generar guiones de entrevistas conductuales que realmente detecten el potencial.
* Técnicas para redactar comunicaciones internas sensibles (como cambios en beneficios o políticas) con el tono humano y empático adecuado.
* El arte de convertir datos crudos de una encuesta en un plan de acción estructurado en segundos.

---

### **Conclusión**

El dominio de estos ejemplos prácticos es lo que marca la diferencia entre usar la IA como un buscador y usarla como un **motor de productividad**. Al finalizar este video, tendrás las herramientas necesarias para automatizar la "carpintería" de tus procesos y enfocar tu energía en lo que realmente importa: la estrategia y la conexión con las personas.

---
$content$, 'media_url', 'fZckiUNpeWU'), 10);

INSERT INTO lecciones (id, modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
(96, 3, 5, 'Prompt Chaining: divide y vencerás con la IA', 'texto', jsonb_build_object('texto', $content$# Prompt Chaining: divide y vencerás con la IA

Cuando un problema es complejo, la mejor estrategia no es pedirle todo a la IA de una sola vez. La técnica de **Prompt Chaining** consiste en dividir una tarea grande en pasos más pequeños, donde **la salida de un prompt se convierte en la entrada del siguiente**.

Es como una línea de ensamblaje: cada estación hace una cosa bien hecha, y el resultado final es superior a intentar hacerlo todo en un solo paso.

> Según estudios presentados en ACL 2024, dividir tareas complejas en pasos encadenados mejora la precisión de las respuestas entre un 20% y un 50% comparado con un único prompt monolítico.

---

## Por qué funciona mejor

Cuando le pides a la IA que haga todo en un solo mensaje, está repartiendo su "atención" entre múltiples objetivos. Al encadenar prompts:

- Cada paso tiene un **objetivo claro y acotado**
- Puedes **verificar la calidad** de cada resultado intermedio antes de continuar
- Reduces la posibilidad de que la IA "alucine" o pierda el foco

```mermaid
graph LR
    A[Tarea compleja] --> B[Prompt 1]
    B --> C[Resultado 1]
    C --> D[Prompt 2]
    D --> E[Resultado 2]
    E --> F[Prompt 3]
    F --> G[Resultado final]
    style A fill:#f8b4b4
    style C fill:#93c5fd
    style E fill:#93c5fd
    style G fill:#86efac
```

---

## Patrones de encadenamiento

Existen cuatro patrones principales que puedes aplicar según el tipo de tarea:

| Patrón | Flujo | Ejemplo en aerolínea |
|--------|-------|---------------------|
| **Secuencial** | A -> B -> C | Extraer datos de quejas -> Analizar tendencias -> Recomendar acciones |
| **Paralelo con merge** | A + B -> C | Analizar quejas de pasajeros + Analizar métricas de puntualidad -> Generar reporte unificado |
| **Condicional** | Si X entonces Y, si no Z | Si la queja es por equipaje -> Proceso de reclamo; si es por retraso -> Calcular compensación |
| **Loop de refinamiento** | A -> Revisar -> Ajustar -> Final | Borrador de respuesta -> Revisar tono corporativo -> Ajustar lenguaje -> Versión final para el pasajero |

---

## Ejemplo completo: Análisis de quejas de pasajeros

Veamos cómo aplicar el patrón **Secuencial** (Resumen -> Análisis -> Acción) para procesar una queja real.

### Paso 1: Resumir y extraer datos clave

```
Tengo la siguiente queja de un pasajero de Avianca:

"Viajé el 15 de marzo en el vuelo AV204 de Bogotá a Lima. Mi maleta
no llegó. Llevo 3 días esperando y nadie me da respuesta. Llamé 4
veces al call center y cada vez me dicen algo diferente. Soy viajero
frecuente LifeMiles Gold desde hace 6 años y nunca me había pasado
algo así. Estoy considerando cambiarme de aerolínea."

Extrae la siguiente información en formato estructurado:
- Número de vuelo
- Ruta
- Fecha
- Tipo de problema
- Nivel de urgencia (alto/medio/bajo)
- Categoría de pasajero
- Sentimiento general
```

### Paso 2: Analizar con el contexto extraído

```
Con base en los datos extraídos del paso anterior:

- Vuelo: AV204
- Ruta: Bogotá - Lima
- Fecha: 15 de marzo
- Problema: Equipaje perdido, 3 días sin respuesta
- Urgencia: Alta
- Pasajero: LifeMiles Gold, 6 años de antigüedad
- Sentimiento: Frustración alta, riesgo de deserción

Analiza:
1. Cuál es el riesgo real de perder a este cliente
2. Qué políticas de compensación aplican para un Gold con este tipo de incidente
3. Qué falló en el proceso si llamó 4 veces sin respuesta consistente
```

### Paso 3: Generar plan de acción

```
Según el análisis anterior, el pasajero es Gold con alto riesgo de
deserción, tiene un equipaje perdido hace 3 días y ha recibido
información inconsistente en 4 llamadas.

Genera un plan de acción concreto que incluya:
1. Respuesta inmediata al pasajero (tono empático y profesional)
2. Compensación recomendada según su categoría
3. Acciones internas para evitar que se repita la inconsistencia en
   call center
4. Seguimiento a 7 días

Formato: lista numerada con responsable y plazo para cada acción.
```

### Flujo completo del ejemplo

```mermaid
flowchart TD
    Q["Queja del pasajero (texto libre)"]
    Q --> P1["Prompt 1: Extraer datos clave"]
    P1 --> R1["Vuelo, ruta, problema, urgencia, categoría"]
    R1 --> P2["Prompt 2: Analizar riesgo y contexto"]
    P2 --> R2["Riesgo de deserción, políticas aplicables, fallas"]
    R2 --> P3["Prompt 3: Plan de acción"]
    P3 --> R3["Respuesta + Compensación + Acciones internas"]
    style Q fill:#f8b4b4
    style R1 fill:#93c5fd
    style R2 fill:#93c5fd
    style R3 fill:#86efac
    style P1 fill:#e2e8f0
    style P2 fill:#e2e8f0
    style P3 fill:#e2e8f0
```

---

## Cuándo NO encadenar

No toda tarea necesita una cadena. Usar chaining para algo simple agrega complejidad innecesaria.

**Usa un solo prompt cuando:**

- La tarea es directa: "Resume este correo en 3 puntos"
- No necesitas verificar pasos intermedios
- La respuesta esperada es corta y concreta

**Usa chaining cuando:**

- La tarea tiene múltiples etapas lógicas
- Necesitas diferentes "roles" o perspectivas en cada paso
- El resultado final depende de análisis previos
- Quieres poder corregir el rumbo entre pasos

---

## Tips para encadenar de forma efectiva

### 1. Sé específico con el formato en cada paso

Indicar el formato de salida esperado facilita que el siguiente prompt lo consuma correctamente.

```
Responde SOLO en formato de tabla con columnas:
| Campo | Valor |
```

### 2. Referencia explícitamente el resultado anterior

No asumas que la IA "recuerda" el contexto. Copia o resume la salida del paso anterior al inicio del siguiente prompt.

```
Con base en los datos extraídos en el paso anterior:
[pegar aquí el resultado del Prompt 1]

Ahora analiza...
```

### 3. Valida antes de avanzar

Revisa el resultado de cada paso antes de pasarlo al siguiente. Si el Paso 1 extrajo mal un dato, todo lo demás se construye sobre una base errónea.

### 4. Mantené cada prompt enfocado en una sola tarea

Si un prompt intenta hacer dos cosas a la vez, dividilo en dos. Mejor tres prompts simples que uno confuso.

---

## Fuentes

- [Prompting Guide - Chain of Thought](https://www.promptingguide.ai/techniques/cot)
- [FindSkill - Prompt Chaining: cómo encadenar prompts para tareas complejas](https://findskill.ai/es/blog/prompt-chaining-como-encadenar-prompts-para-tareas-complejas/)
- [DataStudios - Microsoft Copilot Prompting Techniques](https://www.datastudios.org/post/microsoft-copilot-prompting-techniques-structure-grounding-and-workflow-optimisation)$content$), 15);

INSERT INTO lecciones (id, modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
(99, 4, 3, 'Lección 1: Estructuras XML y JSON para prompts', 'texto', jsonb_build_object('texto', $content$# Estructuras XML y JSON para prompts: organiza tus instrucciones como un profesional

Cuando le pides algo a una IA escribiendo texto libre, es como darle instrucciones verbales a alguien en medio de un aeropuerto ruidoso: la idea general llega, pero los detalles se pierden. Las **estructuras XML y JSON** son formas de organizar tus instrucciones para que la IA entienda exactamente qué necesitas, sin ambigüedad.

En este módulo vas a aprender a usar estas estructuras sin necesidad de saber programar. Piensa en ellas como **formularios inteligentes** que le dicen a Copilot qué rol asumir, qué contexto considerar y qué formato debe tener la respuesta.

---

## Qué son XML y JSON (explicación sin tecnicismos)

### XML: etiquetas que envuelven instrucciones

XML usa **etiquetas** (palabras entre signos `< >`) para separar y nombrar cada parte de tu instrucción. Funciona como un formulario donde cada campo tiene un nombre claro.

Imagina que llenas una solicitud interna: hay un campo para "Nombre", otro para "Área", otro para "Descripción". XML hace exactamente lo mismo, pero para la IA.

### JSON: listas organizadas con llaves y corchetes

JSON usa **llaves `{ }`** para agrupar información y **dos puntos `:`** para asignar valores a cada campo. Es como una lista de datos estructurada donde cada elemento tiene un nombre y un valor.

Piensa en una hoja de cálculo donde la columna A tiene los nombres de los campos y la columna B tiene los valores. JSON organiza la información de esa forma.

---

## Por qué las estructuras mejoran los resultados de la IA

Investigaciones en técnicas de prompting estructurado muestran que organizar las instrucciones en formato XML o JSON reduce los errores de interpretación de la IA en aproximadamente un **60%** comparado con texto libre.

La razón es simple: cuando la IA recibe un prompt estructurado, no tiene que "adivinar" dónde empieza el contexto y dónde termina la tarea. Cada sección está claramente delimitada.

```mermaid
flowchart LR
    A["Texto libre\n(ambiguo)"] --> B["Prompt\nestructurado"]
    B --> C["Respuesta precisa\ny completa"]
    A -.->|"Sin estructura"| D["Respuesta genérica\no incompleta"]
    style A fill:#fecaca,stroke:#ef4444
    style B fill:#bfdbfe,stroke:#3b82f6
    style C fill:#bbf7d0,stroke:#22c55e
    style D fill:#fef3c7,stroke:#f59e0b
```

---

## Ejemplo XML: prompt de comunicación de crisis para una aerolínea

Este es un prompt estructurado con etiquetas XML para generar una comunicación de crisis. Cada etiqueta delimita una sección con un propósito específico.

```xml
<rol>
Eres un experto en comunicaciones corporativas de crisis
para la industria de aviación comercial.
</rol>

<contexto>
Avianca ha experimentado una demora masiva en el hub de Bogotá
debido a condiciones meteorológicas severas. Hay 2,500 pasajeros
afectados en 15 vuelos. Las redes sociales están activas con quejas.
</contexto>

<tarea>
Redacta un comunicado oficial para publicar en redes sociales
y enviar por correo a los pasajeros afectados.
</tarea>

<formato>
- Longitud: máximo 200 palabras
- Tono: empático, profesional y proactivo
- Incluir: disculpa, causa, acciones tomadas, siguiente paso
- Idioma: español formal
</formato>

<restricciones>
- No prometer compensaciones específicas sin autorización
- No mencionar montos económicos
- No culpar a terceros ni entidades gubernamentales
- Mantener coherencia con la voz de marca de Avianca
</restricciones>
```

Observa cómo cada etiqueta actúa como un "cajón" con nombre propio. La IA sabe exactamente qué información corresponde a cada parte del problema.

---

## Ejemplo JSON: creación de agenda de capacitación

JSON permite crear estructuras con datos anidados, lo que es útil cuando necesitas organizar información con múltiples niveles de detalle.

```json
{
  "solicitud": "Crear agenda de capacitación",
  "parametros": {
    "tema": "Uso de Microsoft Copilot para equipos de servicio al cliente",
    "duracion": "4 horas",
    "audiencia": "Agentes de servicio al cliente de Avianca",
    "nivel": "Básico",
    "formato_entrega": "Virtual con ejercicios prácticos"
  },
  "estructura_requerida": {
    "modulos": 4,
    "por_cada_modulo": [
      "Título del módulo",
      "Objetivo de aprendizaje",
      "Duración estimada",
      "Actividad práctica",
      "Recurso de apoyo"
    ]
  },
  "restricciones": {
    "herramienta_principal": "Microsoft Copilot Chat",
    "idioma": "Español",
    "incluir_pausas": true,
    "tiempo_maximo_teoria": "30% del total"
  }
}
```

La ventaja de JSON es que permite agrupar parámetros relacionados dentro de un mismo bloque. Por ejemplo, todas las restricciones quedan juntas en su propia sección.

---

## Comparación: XML vs JSON vs Texto libre

| Criterio | XML | JSON | Texto libre |
|---|---|---|---|
| **Legibilidad para no técnicos** | Alta. Las etiquetas se leen como títulos | Media. Requiere familiaridad con llaves y comillas | Alta. Es lenguaje natural |
| **Precisión de resultados** | Muy alta | Muy alta | Variable |
| **Cuándo usarlo** | Prompts largos con secciones narrativas | Prompts con datos, listas y parámetros numéricos | Preguntas simples y directas |
| **Complejidad de escritura** | Baja. Solo requiere abrir y cerrar etiquetas | Media. Hay que respetar comas, comillas y llaves | Ninguna |
| **Mejor para** | Comunicaciones, reportes, documentos | Agendas, formularios, configuraciones | Consultas rápidas del día a día |

**Conclusión práctica:** XML es generalmente más intuitivo para usuarios no técnicos porque las etiquetas se leen como títulos de sección. JSON es más eficiente cuando trabajas con datos numéricos o listas. Ambos funcionan perfectamente con Copilot. Para preguntas simples, el texto libre sigue siendo válido.

---

## Plantillas maestras: el concepto de "formulario reutilizable"

Una **plantilla maestra** es un prompt estructurado donde ciertos valores se reemplazan con marcadores de posición (placeholders). Esto permite reutilizar la misma estructura una y otra vez, cambiando solo los datos específicos de cada situación.

Los marcadores siguen el formato `[NOMBRE_DEL_CAMPO]` en mayúsculas para que sean fáciles de identificar y reemplazar.

```mermaid
flowchart TD
    A["Plantilla maestra\ncon placeholders"] --> B["Reemplazar\n[CAMPO_1]"]
    B --> C["Reemplazar\n[CAMPO_2]"]
    C --> D["Prompt listo\npara Copilot"]
    D --> E["Respuesta\nprecisa"]
    style A fill:#e0e7ff,stroke:#6366f1
    style B fill:#dbeafe,stroke:#3b82f6
    style C fill:#dbeafe,stroke:#3b82f6
    style D fill:#d1fae5,stroke:#10b981
    style E fill:#bbf7d0,stroke:#22c55e
```

---

## Plantilla 1: Comunicaciones de crisis

Esta plantilla está diseñada para generar comunicados rápidos ante situaciones operacionales. Solo necesitas llenar los campos entre corchetes.

```xml
<rol>
Eres un especialista en comunicaciones de crisis
para [NOMBRE_AEROLINEA].
</rol>

<contexto>
Situación: [DESCRIPCION_SITUACION]
Pasajeros afectados: [NUMERO_PASAJEROS]
Vuelos involucrados: [LISTA_VUELOS]
Canal de comunicación: [CANAL]
Hora del incidente: [HORA]
</contexto>

<tarea>
[TIPO_COMUNICADO]: redacta un mensaje [TONO] que informe
a los pasajeros sobre la situación y las acciones tomadas.
</tarea>

<formato>
- Longitud máxima: [MAX_PALABRAS] palabras
- Estructura: disculpa, explicación, acciones, siguiente paso
- Idioma: [IDIOMA]
</formato>

<restricciones>
- No prometer compensaciones sin autorización de [AREA_RESPONSABLE]
- No revelar información técnica interna
- Mantener coherencia con la guía de estilo corporativa
- [RESTRICCION_ADICIONAL]
</restricciones>
```

**Ejemplo de uso:** para un retraso por mantenimiento en Cartagena, simplemente reemplaza `[DESCRIPCION_SITUACION]` por "Retraso de 3 horas en vuelo AV204 Bogotá-Cartagena por revisión técnica programada", `[NUMERO_PASAJEROS]` por "180" y así sucesivamente.

---

## Plantilla 2: Reporte semanal de área

Esta plantilla genera reportes semanales estandarizados. Útil para cualquier área que necesite entregar informes periódicos.

```xml
<rol>
Eres un analista de gestión que redacta reportes ejecutivos
claros y orientados a resultados.
</rol>

<contexto>
Área: [NOMBRE_AREA]
Período: Semana del [FECHA_INICIO] al [FECHA_FIN]
Responsable: [NOMBRE_RESPONSABLE]
</contexto>

<tarea>
Genera un reporte semanal ejecutivo basado en los siguientes datos:

Logros de la semana:
- [LOGRO_1]
- [LOGRO_2]
- [LOGRO_3]

Indicadores clave:
- [KPI_1]: [VALOR_1]
- [KPI_2]: [VALOR_2]

Bloqueos o riesgos:
- [BLOQUEO_1]

Plan para la próxima semana:
- [PLAN_1]
- [PLAN_2]
</tarea>

<formato>
- Formato: tabla resumen + párrafos breves
- Tono: profesional, directo, sin adjetivos innecesarios
- Longitud: máximo [MAX_PALABRAS] palabras
- Incluir: semáforo de estado (verde/amarillo/rojo) por cada KPI
</formato>

<restricciones>
- No inventar datos que no se proporcionaron
- Si falta información, indicar "Dato pendiente" en lugar de suponer
- Usar terminología estándar de [NOMBRE_AEROLINEA]
</restricciones>
```

---

> **Advertencia sobre seguridad de datos:** Cuando utilices plantillas con herramientas de IA externas (fuera de Copilot empresarial), nunca incluyas datos reales de pasajeros, empleados, números de vuelo activos ni información financiera en los placeholders. Copilot Chat de Microsoft dentro del entorno corporativo de Avianca protege tus datos, pero cualquier herramienta externa podría almacenarlos o usarlos para entrenamiento. Ante la duda, usa datos ficticios o consúltalo con tu líder.

---

## Fuentes

- CodeConductor. *Structured Prompting Techniques: XML & JSON*. [https://codeconductor.ai/blog/structured-prompting-techniques-xml-json/](https://codeconductor.ai/blog/structured-prompting-techniques-xml-json/)
- Microsoft Learn. *Prompt Library - Microsoft Copilot Studio*. [https://learn.microsoft.com/en-us/microsoft-copilot-studio/prompt-library](https://learn.microsoft.com/en-us/microsoft-copilot-studio/prompt-library)
- VisualSP. *Comprehensive Guide to Effective Microsoft Copilot Prompts*. [https://www.visualsp.com/blog/comprehensive-guide-to-effective-microsoft-copilot-prompts/](https://www.visualsp.com/blog/comprehensive-guide-to-effective-microsoft-copilot-prompts/)$content$), 15);

INSERT INTO lecciones (id, modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
(101, 4, 5, 'Lección 2: Shadow AI: el peligro oculto en tu empresa', 'texto', jsonb_build_object('texto', $content$# Shadow AI: el peligro oculto en tu empresa

Cada día, miles de empleados usan herramientas de IA gratuitas para resolver tareas laborales sin que el área de TI lo sepa. Esta práctica tiene nombre: **Shadow AI**, y representa uno de los riesgos de ciberseguridad más críticos de la era actual.

---

## Qué es Shadow AI

Shadow AI es el uso de **cualquier herramienta de inteligencia artificial que no ha sido autorizada ni supervisada por el área de Tecnología** de la organización. Esto incluye:

- ChatGPT en su versión gratuita o con cuenta personal
- Google Gemini sin licencia corporativa
- Aplicaciones móviles que integran IA (editores de texto, resumidores, traductores)
- Extensiones de navegador con funciones de IA
- Bots de terceros en Telegram, WhatsApp u otras plataformas

El problema no es la IA en sí misma, sino que estas herramientas operan **fuera del perímetro de seguridad** de la empresa, sin controles de acceso, sin cifrado corporativo y sin políticas de retención de datos.

---

## Las cifras que deberían preocuparnos

La magnitud del problema no es teórica. Estos son datos respaldados por investigaciones recientes:

| Indicador | Dato | Fuente |
|-----------|------|--------|
| Empleados que comparten datos corporativos en herramientas de IA no autorizadas | **77%** | eSecurity Planet, 2024 |
| Empleados que usan cuentas personales para IA laboral | **82%** | eSecurity Planet, 2024 |
| Costo promedio de una brecha originada por Shadow AI | **$670,000 USD** | IBM Cost of a Data Breach, 2025 |
| Tiempo adicional para identificar filtraciones vía IA vs. ciberataques tradicionales | **26% más lento** | IBM, 2025 |
| Porcentaje de datos pegados en ChatGPT que son sensibles | **34.8%** | Stanford, 2025 |

> Casi 8 de cada 10 empleados ya están exponiendo información corporativa en herramientas de IA sin autorización. La pregunta no es si va a pasar una filtración, sino cuándo.

---

## Caso real: Samsung y la filtración que cambió las reglas

En abril de 2023, tres ingenieros de **Samsung Semiconductor** usaron ChatGPT en su versión gratuita para tareas laborales cotidianas:

1. Un ingeniero pegó **código fuente confidencial** para buscar errores
2. Otro compartió **notas de una reunión estratégica interna** para generar un resumen
3. Un tercero subió un **reporte técnico de hardware** para optimizarlo

El resultado fue devastador: toda esa información pasó a formar parte de los datos de entrenamiento del modelo público. Samsung perdió el control sobre propiedad intelectual crítica, y la información quedó potencialmente disponible para cualquier usuario de ChatGPT en el mundo.

La consecuencia inmediata fue la **prohibición total de herramientas de IA generativa** en Samsung, afectando a más de 100,000 empleados. El daño reputacional y la pérdida de ventaja competitiva fueron incalculables.

Este caso demuestra que el riesgo no proviene de hackers externos, sino de **empleados bien intencionados** que buscan ser más productivos sin comprender las implicaciones de seguridad.

---

## Cómo funciona la filtración

El mecanismo de exposición es más simple de lo que parece:

```mermaid
flowchart TD
    A["Empleado pega datos\nen IA no autorizada"] --> B["Los datos viajan\na servidores externos"]
    B --> C["La herramienta usa los datos\npara entrenar su modelo"]
    C --> D["La información queda\nen el modelo global"]
    D --> E["Terceros pueden acceder\na esa información"]
    style A fill:#e0f2fe,stroke:#0284c7
    style B fill:#fef3c7,stroke:#d97706
    style C fill:#fecaca,stroke:#dc2626
    style D fill:#fecaca,stroke:#dc2626
    style E fill:#fecaca,stroke:#dc2626
```

Cada vez que un empleado pega información en una herramienta gratuita, esos datos salen del control de la empresa. No hay forma de recuperarlos, eliminarlos ni rastrear quién más pudo acceder a ellos.

---

## Copilot Empresarial vs. herramientas gratuitas

No todas las herramientas de IA son iguales. La diferencia entre una solución corporativa y una gratuita es la diferencia entre una caja fuerte y una plaza pública.

| Característica | Copilot Empresarial | ChatGPT Gratuito | Gemini Free |
|---------------|-------------------|-----------------|-------------|
| **Datos usados para entrenamiento** | No. Contractualmente prohibido | Sí. Los datos alimentan el modelo | Sí. Google puede usar los datos |
| **Aislamiento de inquilino (tenant)** | Sí. Datos aislados por organización | No. Modelo compartido globalmente | No. Sin aislamiento corporativo |
| **Cumplimiento GDPR / regulatorio** | Sí. Certificaciones SOC 2, ISO 27001 | Limitado. Sin garantías corporativas | Limitado. Depende de la cuenta |
| **Registros de auditoría** | Sí. Logs completos para TI | No disponible | No disponible |
| **Soporte corporativo y SLA** | Sí. Soporte dedicado con SLA | No. Solo soporte comunitario | No. Solo soporte estándar de Google |
| **Control de acceso y permisos** | Sí. Integrado con Microsoft Entra ID | No. Cuenta personal del empleado | No. Cuenta personal de Google |
| **Cifrado de datos en tránsito y reposo** | Sí. Cifrado empresarial | Básico | Básico |

> Cuando usas Copilot dentro del entorno corporativo de Avianca, tus datos permanecen dentro del perímetro de seguridad de la empresa. Cuando usas ChatGPT gratuito, tus datos dejan de pertenecerte en el momento en que presionas "Enviar".

---

## 6 reglas de oro para empleados de Avianca

Estas son las prácticas obligatorias para proteger la información de la empresa y de nuestros pasajeros:

### 1. Usa únicamente las herramientas aprobadas por TI

Microsoft Copilot es la herramienta de IA autorizada por Avianca. Si no está en la lista de herramientas aprobadas, no la uses para trabajo.

### 2. Nunca pegues datos de pasajeros en ninguna IA

Nombres, números de documento, itinerarios, datos de pago, historiales de vuelo: nada de esto debe ingresarse en herramientas de IA, ni siquiera en Copilot, sin verificar que el caso de uso está permitido.

### 3. No uses cuentas personales para IA laboral

Tu cuenta personal de ChatGPT, Gemini o cualquier otra herramienta no tiene las protecciones del entorno corporativo. Usarla para trabajo es una brecha de seguridad automática.

### 4. Si la herramienta pide datos para "mejorar", probablemente entrena con ellos

Muchas herramientas gratuitas incluyen cláusulas donde los datos ingresados se usan para entrenamiento del modelo. Si ves opciones como "ayúdanos a mejorar" o "compartir datos de uso", asume que tu información está siendo recopilada.

### 5. Consulta con TI antes de probar nuevas aplicaciones de IA

Antes de instalar una extensión, registrarte en un servicio nuevo o usar una app que promete funciones de IA, verifica con el área de Tecnología si está autorizada. Una consulta de 5 minutos puede evitar un incidente de seguridad.

### 6. Nunca confíes ciegamente en la IA para datos regulatorios o de aviación

La IA puede generar información incorrecta con total confianza. Para datos críticos de aviación, regulaciones aeronáuticas, normativas de seguridad o procedimientos operativos, siempre valida con fuentes oficiales.

---

## Flujo de decisión: herramienta de IA segura o no

```mermaid
flowchart TD
    A["Necesito usar IA\npara una tarea laboral"] --> B{"¿La herramienta está\naprobada por TI?"}
    B -->|Sí| C{"¿Los datos que voy\na ingresar son sensibles?"}
    B -->|No| D["No la uses.\nConsulta con TI"]
    C -->|No| E["Procede con\nprecaución"]
    C -->|Sí| F{"¿He anonimizado\nla información?"}
    F -->|Sí| E
    F -->|No| G["Anonimiza primero.\nElimina nombres, documentos\ny datos identificables"]
    G --> F
    style A fill:#e0f2fe,stroke:#0284c7
    style D fill:#fecaca,stroke:#dc2626
    style E fill:#dcfce7,stroke:#16a34a
    style G fill:#fef3c7,stroke:#d97706
```

---

## Fuentes

- [eSecurity Planet — Shadow AI: ChatGPT & DLP](https://www.esecurityplanet.com/news/shadow-ai-chatgpt-dlp/) — Estadísticas de 77% de empleados compartiendo datos y 82% usando cuentas personales
- [IBM — Cost of a Data Breach Report 2025](https://www.ibm.com/reports/data-breach) — Costo promedio de $670,000 USD y 26% más lento en detección
- [Stanford HAI — AI Index Report 2025](https://aiindex.stanford.edu/report/) — 34.8% de datos sensibles pegados en ChatGPT
- [Forbes Colombia — Samsung prohíbe ChatGPT entre empleados](https://forbes.co/tecnologia/samsung-prohibe-a-chatgpt-entre-empleados) — Caso de filtración de código fuente
- [Microsoft — Seguridad en Microsoft 365 Copilot](https://learn.microsoft.com/es-es/copilot/microsoft-365/microsoft-365-copilot-ai-security) — Arquitectura de seguridad empresarial
- [Microsoft — Privacidad y protecciones de Copilot](https://learn.microsoft.com/es-es/copilot/privacy-and-protections) — Políticas de privacidad y no entrenamiento
- [7Experts — Riesgos de seguridad y privacidad de ChatGPT en empresas](https://www.7experts.com/riesgos-seguridad-privacidad-chatgpt-empresas/) — Análisis de riesgos corporativos$content$), 15);

INSERT INTO lecciones (id, modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
(118, 5, 1, 'Lección 1: Crea con Copilot. ', 'video', jsonb_build_object('texto', $content$## 🚀 Lección 1: Crea con Copilot Chat. 

A menudo, la mayor barrera para la innovación no es la falta de visión, sino la fricción técnica que implica materializar una idea. En esta sesión, descubriremos cómo **Copilot** se transforma en tu socio estratégico de creación, permitiéndote dar el salto de la ejecución operativa a la **dirección de activos digitales**.

El objetivo no es que Copilot trabaje por ti, sino que potencie tu capacidad de entrega, eliminando el peso de la "hoja en blanco" y permitiéndote producir resultados profesionales con una agilidad sin precedentes.

---

### **De la Carpintería Digital a la Visión Estratégica**

Con Copilot, tu rol evoluciona. Dejas de invertir horas en el diseño básico o la estructuración manual para convertirte en un **Arquitecto de Soluciones**. Tú defines el propósito, el mensaje y el estándar de calidad; Copilot actúa como el motor que procesa esa intención y la traduce en productos finales de alta fidelidad, listos para impactar en la organización.



---

### **Tu Nuevo Ecosistema de Creación**

Estamos iniciando la fase más dinámica del programa. En los próximos módulos, aprenderás la arquitectura técnica detrás de cada formato que Copilot es capaz de Crear. 





---

$content$, 'media_url', 'Dt0upKgWwf8'), 10);

INSERT INTO lecciones (id, modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
(119, 5, 2, 'Lección 2: Crear imágenes con Copilot', 'video', jsonb_build_object('texto', $content$# Crear imágenes con Copilot Designer

Microsoft Copilot integra un generador de imágenes basado en **DALL-E 3**, el modelo de OpenAI especializado en crear imágenes a partir de descripciones textuales. Esto significa que puedes generar ilustraciones, fotografías conceptuales y gráficos directamente desde la interfaz de Copilot, sin necesidad de herramientas externas de diseño.

Para el entorno corporativo, esta capacidad resuelve un problema concreto: obtener imágenes personalizadas para presentaciones, comunicaciones internas y publicaciones en redes sociales sin depender de bancos de imágenes genéricas ni del equipo de diseño para cada solicitud.

---

## Cómo funciona la generación de imágenes

Cuando describes una imagen en Copilot, el texto pasa por el modelo DALL-E 3, que interpreta la descripción y genera una imagen original. El proceso interno funciona así:

1. Copilot recibe tu descripción en lenguaje natural
2. El modelo analiza los elementos descritos: sujeto, contexto, estilo y parámetros técnicos
3. DALL-E 3 genera varias opciones de imagen basadas en tu descripción
4. Copilot te presenta las opciones para que selecciones o ajustes

La calidad del resultado depende directamente de la calidad de tu descripción. Un prompt vago produce imágenes genéricas; un prompt estructurado produce imágenes útiles para el contexto corporativo.

---

## Estructura de un prompt efectivo para imágenes

Un buen prompt de imagen sigue cuatro componentes que, combinados, le dan a DALL-E la información necesaria para generar exactamente lo que necesitas.

```mermaid
flowchart LR
    A["SUJETO\nQué aparece"] --> B["CONTEXTO\nDónde y cuándo"]
    B --> C["ESTILO VISUAL\nCómo se ve"]
    C --> D["PARAMETROS\nDetalles técnicos"]
    D --> E["Imagen\ngenerada"]
    style A fill:#dbeafe,stroke:#3b82f6
    style B fill:#e0e7ff,stroke:#6366f1
    style C fill:#ede9fe,stroke:#8b5cf6
    style D fill:#fae8ff,stroke:#c084fc
    style E fill:#d1fae5,stroke:#10b981
```

| Componente | Qué describe | Ejemplo |
|---|---|---|
| **Sujeto** | El elemento principal de la imagen | "Un equipo diverso de profesionales en una sala de reuniones" |
| **Contexto** | El escenario, ambiente o situación | "En una oficina moderna con ventanales grandes y luz natural" |
| **Estilo visual** | La estética y tipo de imagen | "Fotografía profesional corporativa, iluminación cálida" |
| **Parámetros** | Detalles técnicos y restricciones | "Formato horizontal 16:9, colores predominantes rojo y blanco" |

La fórmula general es:

**[SUJETO]** + **[CONTEXTO]** + **[ESTILO VISUAL]** + **[PARAMETROS]**

No es necesario incluir los cuatro componentes en cada prompt, pero mientras más información relevante incluyas, más preciso será el resultado.

---

## Ejemplo 1: Imagen para diapositiva de presentación

**Escenario:** Necesitas una imagen para la portada de una presentación sobre transformación digital en Avianca.

**Prompt:**

```
Crea una imagen de un equipo diverso de profesionales de aerolínea
colaborando frente a pantallas digitales con gráficos de datos y
dashboards. Oficina corporativa moderna con ventanales panorámicos
y vista a una pista de aterrizaje al fondo. Fotografía profesional
corporativa con iluminación suave y tonos cálidos. Formato horizontal
16:9, paleta de colores que incluya rojo corporativo y blanco.
```

**Por qué funciona:** El prompt especifica el sujeto (equipo diverso), el contexto (oficina con vista a pista), el estilo (fotografía profesional) y los parámetros (formato, colores). DALL-E tiene suficiente información para generar algo alineado con la identidad visual de la empresa.

---

## Ejemplo 2: Imagen para publicación en redes sociales

**Escenario:** El equipo de comunicaciones necesita una imagen para una publicación de LinkedIn sobre la cultura de innovación.

**Prompt:**

```
Crea una imagen de una mujer profesional de mediana edad usando una
tablet en el lobby de un aeropuerto moderno, con aviones visibles a
través de los ventanales. La persona tiene una expresión de confianza
y concentración. Estilo de fotografía editorial para revista de
negocios, iluminación natural. Formato cuadrado 1:1, tonos limpios
con acentos en rojo.
```

**Por qué funciona:** Para redes sociales, la imagen necesita un sujeto con el que la audiencia se identifique, un contexto reconocible y un formato adecuado al canal (cuadrado para feed de LinkedIn).

---

## Ejemplo 3: Imagen para comunicación interna

**Escenario:** Recursos Humanos necesita una imagen para un correo interno sobre el programa de bienestar laboral.

**Prompt:**

```
Crea una imagen de un grupo pequeño de empleados de diferentes
edades y orígenes étnicos en un espacio de descanso corporativo,
conversando de manera relajada con tazas de café. El ambiente es
luminoso y acogedor, con plantas y mobiliario moderno. Ilustración
digital con estilo flat design, líneas limpias y colores pastel
con acentos en rojo y azul claro. Formato horizontal.
```

**Por qué funciona:** Para comunicación interna se puede usar un estilo más informal como ilustración en lugar de fotografía. El flat design es amigable y no genera confusión sobre si las personas son empleados reales.

---

## Tips para imágenes corporativas

### Especifica "fotografía profesional" cuando necesites realismo

Si no indicas el estilo, DALL-E puede generar una mezcla de ilustración y fotografía. Usar la frase "fotografía profesional corporativa" o "fotografía editorial" orienta el modelo hacia resultados más adecuados para el contexto empresarial.

### Describe la diversidad de forma explícita

Para que la imagen refleje la diversidad real de la organización, descríbela en el prompt: "equipo diverso en edad, género y origen étnico". Si no lo especificas, el modelo puede generar resultados homogéneos que no representan al equipo.

### Incluye los colores de marca

Mencionar los colores corporativos en el prompt ayuda a que la imagen se integre visualmente con las presentaciones y materiales de la empresa. Usa frases como "paleta de colores con rojo corporativo y blanco" o "acentos en los colores institucionales".

### Evita prompts excesivamente detallados

DALL-E funciona mejor con descripciones claras y concretas que con listas exhaustivas de detalles. Si agregas demasiados elementos, el modelo intenta incluirlos todos y el resultado pierde coherencia. Prioriza los 3 o 4 elementos más importantes.

### Itera en lugar de intentar el prompt perfecto

Es más efectivo generar una primera versión y luego ajustar el prompt que intentar escribir la descripción perfecta de entrada. Usa frases como "Igual que la imagen anterior pero con..." para refinar el resultado.

---

## Limitaciones que debes conocer

Antes de usar Copilot Designer para generar imágenes corporativas, ten en cuenta estas restricciones técnicas y legales:

| Limitación | Detalle |
|---|---|
| **Texto en imágenes** | DALL-E no genera texto legible de forma confiable. Los logotipos, títulos o etiquetas dentro de la imagen pueden salir distorsionados o con errores ortográficos. Si necesitas texto, agrégalo después en PowerPoint o Canva. |
| **Marcas registradas** | El modelo no puede reproducir logotipos ni marcas registradas con precisión. No intentes generar el logo de Avianca ni de ninguna otra empresa. Usa los archivos oficiales del manual de marca. |
| **Personas ficticias** | Todas las personas generadas por DALL-E son ficticias. No puedes solicitar que genere imágenes de personas reales, celebridades o empleados específicos. |
| **Consistencia entre imágenes** | Cada generación es independiente. Si necesitas varias imágenes con el mismo estilo, incluye la misma descripción de estilo en cada prompt, pero los resultados no serán idénticos. |
| **Derechos de uso** | Las imágenes generadas con Copilot en el entorno empresarial de Microsoft 365 pueden usarse para fines comerciales según los términos de servicio de Microsoft. Verifica con tu área legal ante cualquier duda. |

> **Importante:** Nunca utilices imágenes generadas por IA como fotografías de empleados reales. En comunicaciones internas o externas, si usas una imagen generada, indícalo con una nota como "Imagen generada con IA con fines ilustrativos". Presentar personas ficticias como empleados reales viola principios de transparencia y puede generar problemas legales y de confianza.

---

## Cómo acceder a Copilot Designer

Copilot Designer está disponible en varios puntos de acceso dentro del ecosistema Microsoft. La funcionalidad es la misma, pero el punto de entrada varía según dónde estés trabajando.

### Desde Copilot en la web

1. Ingresa a [copilot.microsoft.com](https://copilot.microsoft.com) con tu cuenta corporativa
2. En el campo de chat, escribe tu descripción de imagen
3. Copilot detecta automáticamente que quieres una imagen y activa Designer
4. Selecciona la imagen que prefieras de las opciones generadas

### Desde Microsoft Edge

1. Abre el navegador Microsoft Edge
2. Haz clic en el icono de Copilot en la barra lateral derecha
3. Escribe tu prompt de imagen directamente en el chat
4. Las imágenes se generan en el panel lateral sin salir de tu página actual

### Desde Microsoft Designer

1. Ingresa a [designer.microsoft.com](https://designer.microsoft.com)
2. Selecciona "Crear con IA" o usa el campo de descripción
3. Designer ofrece opciones adicionales de edición posterior: recortar, agregar texto, aplicar filtros
4. Puedes descargar la imagen en varios formatos y resoluciones

### Desde Microsoft Teams

1. En una conversación o canal de Teams, abre el panel de Copilot
2. Describe la imagen que necesitas
3. Copilot genera las opciones dentro de la misma interfaz de Teams
4. Puedes compartir la imagen directamente en la conversación

```mermaid
flowchart TD
    U["Usuario necesita\nuna imagen"] --> W["Copilot Web\ncopilot.microsoft.com"]
    U --> E["Microsoft Edge\nBarra lateral"]
    U --> D["Designer\ndesigner.microsoft.com"]
    U --> T["Microsoft Teams\nPanel de Copilot"]
    W --> R["Imagen generada"]
    E --> R
    D --> R
    T --> R
    style U fill:#dbeafe,stroke:#3b82f6
    style W fill:#e0e7ff,stroke:#6366f1
    style E fill:#e0e7ff,stroke:#6366f1
    style D fill:#e0e7ff,stroke:#6366f1
    style T fill:#e0e7ff,stroke:#6366f1
    style R fill:#d1fae5,stroke:#10b981
```

---

## Fuentes

- Microsoft Support. *Using image generation in Microsoft Copilot*. [https://support.microsoft.com/en-us/topic/using-image-generation-in-microsoft-copilot-cc337e5a-750f-4438-9caa-19096b694ab6](https://support.microsoft.com/en-us/topic/using-image-generation-in-microsoft-copilot-cc337e5a-750f-4438-9caa-19096b694ab6)
- Microsoft Designer. *Herramienta de diseño con IA*. [https://designer.microsoft.com/](https://designer.microsoft.com/)$content$, 'media_url', 'Sg9B9Mthzrc'), 10);

INSERT INTO lecciones (id, modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
(122, 5, 3, 'Lección 3: Creando vídeos con Copilot', 'video', jsonb_build_object('texto', $content$# 🎬 Lección 3:Creando vídeos con Copilot

En esta sesión, descubriremos que **Copilot** no solo escribe o diseña imágenes, sino que actúa como un **Director y Editor Automatizado**. A diferencia de la generación de imágenes desde cero, la creación de videos en Copilot funciona mediante un proceso de **curaduría y ensamblaje inteligente**. 

Copilot utiliza inteligencia artificial para interpretar tu necesidad, redactar un guion profesional, seleccionar clips de video de stock de alta calidad, generar una locución (voz en off) y unirlo todo en una pieza coherente que puedes personalizar por completo en **Microsoft Clipchamp**.

---

## ⚙️ Cómo funciona la creación de video (El Flujo con Clipchamp)

El proceso no se basa en el "dibujo" de fotogramas, sino en la **orquestación de recursos profesionales**:

1. **Generación de Guion:** Copilot redacta una narrativa técnica basada en tu instrucción (prompt).
2. **Curaduría de Stock:** La IA busca en la biblioteca profesional de Microsoft los clips de video que mejor representen visualmente cada parte del mensaje.
3. **Voz en Off y Audio:** Se genera una locución con IA (Text-to-Speech) y se sincroniza con una pista de música de fondo adecuada.
4. **Ensamblaje Automático:** Se crea una línea de tiempo con transiciones, subtítulos y efectos básicos.
5. **Edición Final en Clipchamp:** El proyecto se abre automáticamente en **Microsoft Clipchamp**, donde tienes el control total para ajustar, cambiar clips o añadir material propio.

---

## 📝 Estructura de un prompt efectivo para video

Para que Copilot elija los mejores recursos y redacte el mensaje correcto, tu instrucción debe ser rica en **contexto narrativo**:

| Componente | Qué describe | Ejemplo |
|---|---|---|
| **Objetivo** | El propósito del video | "Un video de bienvenida para nuevos pilotos" |
| **Audiencia** | A quién va dirigido | "Nuevos integrantes del equipo de operaciones" |
| **Tono** | La personalidad del video | "Inspirador, épico y muy profesional" |
| **Mensajes Clave** | La información esencial | "Hablar sobre la seguridad y el orgullo de pertenecer a la aerolínea" |

### **Fórmula recomendada:**
> **"Crea un video para [Objetivo] dirigido a [Audiencia]. El tono debe ser [Tono] y debe incluir los siguientes mensajes: [Puntos Clave]."**

---

## 🚀 Ejemplo Práctico: Video de Cultura Organizacional

**Escenario:** Necesitas un clip de 30 segundos para una reunión de equipo sobre seguridad.

**Prompt:**
> "Crea un video de 30 segundos sobre la importancia del trabajo en equipo en el hangar. El tono debe ser motivador e inspirador. Usa videos de stock que muestren mecánicos colaborando, aviones en mantenimiento y tecnología moderna. El guion debe resaltar que la seguridad es un logro de todos. Incluye música de fondo cinematográfica y una voz en off profesional."

---

## 🛠️ El Toque Final: El Poder de la Edición

Una vez que Copilot hace el trabajo pesado de buscar y armar la estructura inicial, tú asumes el rol de **Director** dentro de Clipchamp para asegurar la excelencia:

* **Personalización Real:** Reemplaza clips de stock por videos reales de tus oficinas, hangares o tripulación para generar mayor cercanía y veracidad.
* **Ajuste de Locución:** Cambia el idioma, el acento o el género de la voz de la IA para que conecte mejor con la cultura y el lenguaje de tu equipo local.
* **Identidad de Marca:** Añade el logo de la empresa, cortinillas institucionales y ajusta los colores de los subtítulos según tu manual de marca corporativo.

---

## 💡 Conclusión: De Editor a Director Estratégico

Dominar la creación de video con **Copilot y Clipchamp** no se trata de aprender a editar desde cero, sino de aprender a **comunicar con impacto**. La verdadera ventaja competitiva de este flujo es que elimina la "parálisis técnica": ya no necesitas pelear con una línea de tiempo vacía. 

Al delegar la búsqueda y el montaje inicial a Copilot, recuperas el tiempo para lo que realmente importa: **la calidad estratégica del mensaje y la conexión emocional con tu equipo.**

---$content$, 'media_url', 'UivJvdpIjr0'), 10);

INSERT INTO lecciones (id, modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
(121, 5, 4, 'Lección 5: Formularios e infografías con Copilot', 'video', jsonb_build_object('texto', $content$# Lección 5 Formularios e Infografias con Copilot

Microsoft Copilot no solo sirve para redactar textos o analizar datos. También puede ayudarte a crear **formularios profesionales** en Microsoft Forms y **presentaciones ejecutivas** en PowerPoint, reduciendo drásticamente el tiempo de preparación. En esta lección vas a aprender a usar Copilot como asistente en estas dos herramientas, con flujos paso a paso y ejemplos aplicados a Avianca.

---

## PARTE 1: Microsoft Forms + Copilot

### Qué puede hacer Copilot en Forms

Copilot en Microsoft Forms funciona como un asistente de diseño de encuestas. En lugar de crear cada pregunta manualmente, **le describes lo que necesitas en lenguaje natural** y Copilot genera el formulario completo: preguntas, tipos de respuesta, opciones y estructura lógica.

Esto es especialmente útil cuando necesitas crear encuestas de satisfacción, formularios de registro, evaluaciones internas o solicitudes estandarizadas, y no quieres partir desde cero.

### Flujo de trabajo: 7 pasos para crear un formulario con Copilot

```mermaid
flowchart TD
    A["1. Describir\nQué necesitas y para quién"] --> B["2. Generar\nCopilot crea el borrador"]
    B --> C["3. Revisar\nVerificar preguntas y opciones"]
    C --> D["4. Personalizar\nAjustar redacción y diseño"]
    D --> E["5. Agregar lógica\nRamificación condicional"]
    E --> F["6. Distribuir\nCompartir por enlace o Teams"]
    F --> G["7. Analizar resultados\nCopilot resume las respuestas"]
    style A fill:#dbeafe,stroke:#3b82f6
    style B fill:#e0e7ff,stroke:#6366f1
    style C fill:#fef3c7,stroke:#d97706
    style D fill:#fce7f3,stroke:#db2777
    style E fill:#ede9fe,stroke:#7c3aed
    style F fill:#d1fae5,stroke:#10b981
    style G fill:#ccfbf1,stroke:#14b8a6
```

### Paso a paso detallado

**1. Describir:** Abre Microsoft Forms y selecciona la opción de Copilot. Escribe una descripción clara de lo que necesitas. Mientras más específico seas, mejor será el resultado. Incluye el propósito del formulario, la audiencia objetivo y los tipos de preguntas que esperas.

**2. Generar:** Copilot analiza tu descripción y genera un borrador completo del formulario con preguntas, tipos de respuesta (opción múltiple, escala, texto abierto) y opciones predefinidas.

**3. Revisar:** Lee cada pregunta generada. Verifica que las opciones de respuesta cubran todos los casos relevantes y que la redacción sea clara para tu audiencia.

**4. Personalizar:** Ajusta la redacción para que coincida con el tono corporativo de Avianca. Modifica opciones de respuesta, agrega instrucciones adicionales o elimina preguntas que no apliquen.

**5. Agregar lógica:** Configura ramificación condicional cuando sea necesario. Por ejemplo, si un empleado responde "No" a una pregunta de satisfacción, puedes dirigirlo a una pregunta abierta para que explique su respuesta.

**6. Distribuir:** Comparte el formulario mediante un enlace directo, por correo electrónico o integrado en un canal de Microsoft Teams.

**7. Analizar resultados:** Una vez recopiladas las respuestas, Copilot puede generar resúmenes automáticos, identificar tendencias y destacar los puntos que requieren atención.

### Ejemplo práctico: encuesta de satisfacción para empleados de una aerolínea

Supongamos que Recursos Humanos necesita medir la satisfacción de los empleados de operaciones en tierra. Este sería el prompt para Copilot en Forms:

> Crea una encuesta de satisfacción laboral para empleados de operaciones en tierra de una aerolínea. Incluye preguntas sobre ambiente laboral, relación con supervisores, carga de trabajo, oportunidades de crecimiento y bienestar general. Usa una combinación de preguntas de escala del 1 al 5, opción múltiple y al menos 2 preguntas abiertas. La encuesta debe poder completarse en menos de 5 minutos.

Copilot generaría un formulario con preguntas como:

| Pregunta | Tipo | Opciones |
|----------|------|----------|
| En una escala del 1 al 5, ¿qué tan satisfecho estás con tu ambiente laboral? | Escala | 1 (Muy insatisfecho) a 5 (Muy satisfecho) |
| ¿Cuál es el aspecto que más valoras de tu trabajo? | Opción múltiple | Estabilidad, Equipo de trabajo, Beneficios, Oportunidades de crecimiento, Otro |
| ¿Con qué frecuencia recibes retroalimentación de tu supervisor? | Opción múltiple | Semanalmente, Quincenalmente, Mensualmente, Rara vez, Nunca |
| ¿Consideras que tu carga de trabajo es adecuada? | Escala | 1 (Excesiva) a 5 (Muy adecuada) |
| ¿Qué sugieres para mejorar tu experiencia laboral? | Texto abierto | -- |
| ¿Hay algo adicional que quieras compartir con el equipo de RR.HH.? | Texto abierto | -- |

### Tips para obtener mejores formularios con Copilot

- **Sé específico con los tipos de pregunta:** Indícale a Copilot si quieres escala de Likert (1-5 o 1-10), opción múltiple con selección única o múltiple, o preguntas abiertas. Si no lo especificas, Copilot elegirá por defecto y puede no coincidir con lo que necesitas.
- **Define la audiencia:** No es lo mismo una encuesta para pilotos que para agentes de servicio al cliente. El lenguaje, los temas y la profundidad cambian según el público.
- **Indica el tiempo estimado:** Pedirle que la encuesta "se complete en 5 minutos" limita la cantidad de preguntas y evita formularios excesivamente largos.
- **Solicita opciones de "Otro" o "N/A":** Esto evita que los encuestados se sientan forzados a elegir una opción que no los representa.

---
## PARTE 2: Microsoft Designer + Copilot (Infografías)

### Qué puede hacer Copilot en Infografías

Copilot en Microsoft Designer (y PowerPoint) funciona como un **asistente de diseño estratégico**. En lugar de pelear con un lienzo en blanco, **le describes la información que quieres visualizar** y Copilot estructura el contenido, sugiere la jerarquía visual, elige iconos y crea una disposición lógica.

Esto es especialmente útil cuando necesitas transformar procesos complejos, instructivos de seguridad o resultados operativos en piezas gráficas fáciles de digerir sin ser un diseñador experto.

### Flujo de trabajo: 7 pasos para crear una infografía con Copilot

```mermaid
flowchart TD
    A["1. Definir objetivo\n¿Qué quieres comunicar?"] --> B["2. Estructurar\nCopilot organiza el contenido"]
    B --> C["3. Generar\nCreación del borrador visual"]
    C --> D["4. Personalizar\nElegir estética y colores"]
    D --> E["5. Editar elementos\nAjustar iconos y gráficos"]
    E --> F["6. Validar marca\nAplicar estilo Avianca"]
    F --> G["7. Exportar\nGuardar y compartir"]
    style A fill:#dbeafe,stroke:#3b82f6
    style B fill:#e0e7ff,stroke:#6366f1
    style C fill:#fef3c7,stroke:#d97706
    style D fill:#fce7f3,stroke:#db2777
    style E fill:#ede9fe,stroke:#7c3aed
    style F fill:#d1fae5,stroke:#10b981
    style G fill:#ccfbf1,stroke:#14b8a6
```
### Paso a paso detallado

**1. Definir objetivo:** Identifica el mensaje central (ej: un proceso de seguridad). Tener claro el propósito ayuda a Copilot a elegir la mejor estructura visual, ya sea una línea de tiempo o una lista.

**2. Estructurar:** Pide a Copilot que sintetice tu información. Puedes tomar un reporte extenso y pedirle: "Resume los 5 puntos clave de este protocolo para una infografía de una sola página".

**3. Generar:** Abre Microsoft Designer y selecciona la opción de generar con IA. Describe el ambiente visual y Copilot generará un borrador completo con la disposición de los elementos.

**4. Personalizar:** Ajusta el diseño para que coincida con el tono de Avianca. Modifica la disposición de los bloques y elige una paleta de colores profesional.

**5. Editar elementos:** Una vez generado el borrador, puedes pedir cambios específicos como: "Cambia los iconos por unos más técnicos de aviación" o "Resalta las cifras clave en color rojo".

**6. Validar marca:** Asegúrate de que el diseño respete la identidad visual de la compañía. Revisa el uso de los rojos corporativos y añade el logo de Avianca.

**7. Exportar:** Descarga tu infografía en formato PNG o PDF de alta calidad para compartirla por correo, Teams o incluirla en una presentación.

### Ejemplo práctico: Protocolo de embarque prioritario

Supongamos que el equipo de Operaciones necesita explicar visualmente el proceso de abordaje. Este sería el prompt para Copilot en Designer:

> Crea una infografía sobre el 'Proceso de Abordaje Prioritario Avianca'. Divide el contenido en 4 etapas: Bienvenida en puerta, Verificación de grupo, Acceso preferencial y Acomodamiento en cabina. Usa un estilo visual moderno, con iconos sencillos y colores que transmitan agilidad.

Copilot generaría una estructura visual similar a esta:

| Etapa | Elemento Visual | Descripción Clave |
| :--- | :--- | :--- |
| **Bienvenida** | Icono de Agente | Recepción cálida al pasajero. |
| **Verificación** | Icono de Escáner | Confirmación rápida del grupo de viaje. |
| **Acceso** | Icono de Pasarela | Flujo ágil hacia el avión. |
| **Cabina** | Icono de Asiento | Ubicación eficiente en el lugar asignado. |

### Tips para obtener mejores infografías con Copilot

- **Usa verbos de acción:** En lugar de poner "Seguridad", usa "Protege tu integridad". Esto hace que la pieza sea más dinámica.
- **Define la jerarquía visual:** Pide explícitamente que los datos más importantes (porcentajes o alertas) tengan un tamaño de fuente mayor.
- **Solicita consistencia de estilo:** Pide que todos los iconos pertenezcan al mismo estilo (ej. todos lineales) para que la pieza se vea profesional.
- **Indica el formato:** Especifica si necesitas una infografía vertical para móviles o una horizontal para presentaciones.
$content$, 'media_url', 'JpUO1qMmFkI'), 10);

INSERT INTO lecciones (id, modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
(104, 5, 5, 'Lección 4: Presentaciones con Copilot', 'video', jsonb_build_object('texto', $content$
Lección 4: Presentaciones con Copilot

### Qué puede hacer Copilot en PowerPoint

Copilot en PowerPoint actúa como un asistente de creación de presentaciones. Puede **generar una presentación completa a partir de una descripción textual**, estructurar diapositivas, sugerir contenido y agregar imágenes relevantes. También puede tomar un documento de Word existente y convertirlo en una presentación con estructura lógica.

### Dos métodos para crear presentaciones

**Método 1: Desde PowerPoint directamente.** Abres PowerPoint, seleccionas Copilot y escribes un prompt describiendo la presentación que necesitas. Copilot genera las diapositivas con contenido, estructura y diseño inicial.

**Método 2: Desde Copilot Chat.** Usas Copilot Chat (en el navegador o en Teams) para pedirle que cree una presentación. Copilot genera un archivo de PowerPoint descargable que puedes abrir y editar.

Ambos métodos producen resultados similares, pero trabajar directamente en PowerPoint te da acceso inmediato a las herramientas de edición y diseño.

### Capacidades de Copilot en PowerPoint

| Función | Descripción |
|---------|-------------|
| **Generar desde un prompt** | Describe el tema, la audiencia y la cantidad de slides, y Copilot crea la presentación completa |
| **Crear desde un documento Word** | Sube o referencia un documento de Word y Copilot lo transforma en diapositivas estructuradas |
| **Agregar imágenes** | Copilot sugiere e inserta imágenes de stock relevantes para cada diapositiva |
| **Reestructurar contenido** | Puede reorganizar el orden de las diapositivas, dividir slides con demasiada información o fusionar slides relacionados |
| **Resumir presentaciones** | Genera un resumen ejecutivo de una presentación existente |
| **Agregar notas del orador** | Crea notas de apoyo para cada diapositiva con puntos clave para el presentador |

### Ejemplo de prompt para una presentación

> Crea una presentación de 10 slides sobre el programa de fidelización para la reunión del comité. Incluye una diapositiva de portada, los objetivos del programa, las métricas clave del último trimestre, los beneficios para los miembros, una comparativa con programas de otras aerolíneas, las mejoras propuestas para el próximo semestre y una diapositiva de cierre con próximos pasos. El tono debe ser ejecutivo y orientado a datos.

Copilot generaría una estructura como esta:

1. **Portada:** Programa de Fidelización - Informe para el Comité
2. **Agenda:** Temas a cubrir en la reunión
3. **Objetivos del programa:** Metas estratégicas y alineación con la visión corporativa
4. **Métricas clave Q4:** Miembros activos, tasa de redención, ingresos por programa
5. **Beneficios para miembros:** Niveles de membresía y propuesta de valor
6. **Satisfacción del cliente:** Resultados de encuestas de miembros del programa
7. **Benchmarking:** Comparativa con programas de LATAM, Copa y Delta
8. **Mejoras propuestas:** Iniciativas para el próximo semestre con timeline
9. **Impacto financiero esperado:** Proyecciones y retorno de inversión
10. **Próximos pasos:** Acciones inmediatas, responsables y fechas clave

### Flujo de trabajo con Copilot en PowerPoint

```mermaid
flowchart LR
    A["Definir objetivo\ny audiencia"] --> B["Escribir prompt\ndetallado"]
    B --> C{"Método"}
    C -->|"PowerPoint"| D["Copilot genera\nslides directamente"]
    C -->|"Copilot Chat"| E["Copilot genera\narchivo descargable"]
    D --> F["Revisar estructura\ny contenido"]
    E --> F
    F --> G["Ajustar diseño\nmanualmente"]
    G --> H["Presentación\nlista"]
    style A fill:#dbeafe,stroke:#3b82f6
    style B fill:#e0e7ff,stroke:#6366f1
    style C fill:#fef3c7,stroke:#d97706
    style D fill:#ede9fe,stroke:#7c3aed
    style E fill:#ede9fe,stroke:#7c3aed
    style F fill:#fce7f3,stroke:#db2777
    style G fill:#d1fae5,stroke:#10b981
    style H fill:#ccfbf1,stroke:#14b8a6
```

### Limitaciones importantes

- **Diseño visual:** Copilot genera un diseño funcional, pero no siempre coincide con la guía de marca corporativa de Avianca. Es probable que necesites ajustar colores, tipografías y logos manualmente después de la generación.
- **Imágenes genéricas:** Las imágenes insertadas provienen de bibliotecas de stock y pueden no ser específicas para el contexto de aviación. Revisa y reemplaza las que no aporten valor.
- **Contenido aproximado:** Copilot genera texto basado en su conocimiento general. Los datos específicos (métricas, cifras, KPIs) deben ser verificados y reemplazados con información real de la empresa.
- **Formato de gráficos:** Copilot no siempre genera gráficos o tablas complejas dentro de las diapositivas. Para visualizaciones de datos avanzadas, es mejor crearlas en Excel y pegarlas en la presentación.
- **Consistencia entre slides:** En presentaciones largas, el estilo visual puede variar entre diapositivas. Una revisión final de uniformidad es siempre recomendable.

> Copilot en PowerPoint es un excelente punto de partida, no un producto terminado. Úsalo para generar el 70-80% de la estructura y el contenido, y dedica tu tiempo a pulir el diseño, verificar los datos y agregar el toque profesional que diferencia una presentación buena de una excelente.

---

## Fuentes

- Microsoft Support. *Copilot en Microsoft Forms*. [https://support.microsoft.com/en-us/copilot-in-forms](https://support.microsoft.com/en-us/copilot-in-forms)
- Microsoft Support. *Copilot en PowerPoint*. [https://support.microsoft.com/en-us/copilot-powerpoint](https://support.microsoft.com/en-us/copilot-powerpoint)$content$, 'media_url', 'Cb3XGZw5XBk'), 15);

INSERT INTO lecciones (id, modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
(123, 6, 1, 'Lección1:  Instrucción Maestra', 'video', jsonb_build_object('texto', $content$# 🎯 Lección 7: La Instrucción Maestra (El ADN de tus Agentes)

Si Copilot Chat es un "estudiante brillante que sabe de todo", un **Agente** es ese mismo estudiante al que le das un contrato de trabajo específico, un manual de funciones y una oficina privada. Lo que convierte a Copilot en ese "empleado especializado" es la **Instrucción Maestra**.

---

## 📜 ¿Qué es la Instrucción Maestra?

Es una directriz avanzada escrita en lenguaje natural que define la identidad y el comportamiento permanente de la IA. No es un prompt de una sola vez; es la **Constitución** de tu asistente. 

Mientras que en el chat normal tienes que explicar quién eres y qué quieres en cada sesión, en un Agente la **Instrucción Maestra** ya tiene eso grabado en su "memoria genética".



---

## 🤖 El puente hacia los Agentes

Un **Agente** es mucho más que un chat con nombre; es una "caja" donde guardamos tres componentes esenciales:
1.  **Una Identidad:** Nombre y foto para reconocerlo en tu barra lateral.
2.  **Una Base de Conocimiento:** Tus archivos, manuales y guías de estilo (PDF, Excel, Word).
3.  **La Instrucción Maestra:** El comando "cerebro" que le dice cómo usar esos archivos y cómo comportarse.

Sin una buena Instrucción Maestra, el agente es solo un chat vacío que buscará respuestas en internet. Con ella, se convierte en un **Analista de Perfiles**, un **Redactor de Casos STAR** o un **Consultor de Políticas** de tu propia empresa.

---

## 🧠 El Modelo 80/20 en la Instrucción

La instrucción maestra está diseñada para que la IA asuma el **80% del esfuerzo operativo** (buscar información, estructurar borradores, corregir gramática, seguir formatos), para que tú puedas aportar el **20% de valor estratégico** (validar la veracidad, aplicar criterio humano y tomar la decisión final).

### **¿Por qué es vital definirla antes de crear el agente?**
* **Consistencia:** El agente siempre responderá bajo el mismo estándar de calidad.
* **Ahorro de tiempo:** Eliminas la fricción de escribir prompts largos cada vez que inicias un chat.
* **Foco:** Permite que la IA ignore el conocimiento general y se concentre exclusivamente en tus reglas de negocio.

```mermaid
graph TD
    A["Tu Idea Estratégica"] --> B["Instrucción Maestra\n(El ADN)"]
    B --> C["AGENTE PERSONALIZADO"]
    C --> D["Resultado Operativo\n(80% del trabajo)"]
    D --> E["Validación Humana\n(20% de valor)"]
    style B fill:#dbeafe,stroke:#3b82f6
    style C fill:#d1fae5,stroke:#10b981
    style E fill:#fef3c7,stroke:#f59e0b
---

## 💡 Conclusión: De Operario a Arquitecto de Soluciones

La **Instrucción Maestra** es tu nueva forma de "programar" sin necesidad de saber una sola línea de código. Es el lenguaje con el que diseñas a tus propios compañeros de trabajo digitales, asegurando que siempre actúen con el mismo nivel de excelencia y bajo tus propias reglas.



Al dominar esta técnica, dejas de ser un usuario que simplemente "hace preguntas" para convertirte en un **Arquitecto de Soluciones**. Recuerda siempre el modelo **80/20**: diseña la instrucción para que el agente asuma el 80% del esfuerzo operativo (buscar, estructurar, redactar), permitiéndote a ti brillar en el 20% restante, donde reside el verdadero valor: **la validación estratégica, el criterio humano y la toma de decisiones.**

> **Regla de oro:** No diseñes agentes para que simplemente "hagan cosas"; diseña agentes para que **"sean expertos"** en procesos específicos.$content$, 'media_url', 'OGubHuV1JTs'), 10);

INSERT INTO lecciones (id, modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
(106, 6, 2, 'Lección 2:   🤖  Creando tus propios Agentes en Copilot', 'video', jsonb_build_object('texto', $content$# Lección 2:  🤖  Creando tus propios Agentes en Copilot

Pasar de usar el chat general a crear tus propios **Agentes** es el equivalente a dejar de ser un pasajero para convertirte en el arquitecto de tu propia productividad. Un agente (o Copilot GPT) es una versión personalizada de Copilot diseñada para un rol o tarea específica, que ya "nace" con todo el contexto, reglas y archivos que tú decidas.

En la versión de Copilot para entornos empresariales, puedes crear estos asistentes de uso propio para que trabajen bajo tus condiciones sin tener que repetirles las instrucciones en cada sesión.

---

## 🏗️ Anatomía de un Agente: ¿De qué está hecho?

Configurar un agente es como "entrenar" a un especialista digital. Para que tenga éxito, debes completar cuatro secciones clave:

| Parte | ¿Qué define? | ¿Cómo completarla con éxito? |
|---|---|---|
| **Identidad** | Nombre e imagen. | Dale un nombre funcional que describa su rol (ej: "Analista de Perfiles" o "Redactor STAR"). |
| **Descripción** | Su "bio" corta. | Una frase que explique qué hace: "Experto en transformar notas en reportes de incidentes formales". |
| **Instrucciones** | El "cerebro" del agente. | Aquí escribes su **Rol**, **Objetivo** y **Restricciones** (ej: "No uses tecnicismos", "Responde siempre en español"). |
| **Conocimiento** | Su biblioteca privada. | Sube archivos (PDF, Excel, Word) que el agente usará como única fuente de verdad (manuales, guías de estilo, políticas). |



---

## 🛠️ Cómo crear tu agente paso a paso

En la interfaz de Copilot, busca la opción **"Ver todos los Copilot GPTs"** y selecciona **"Crear"**. Tendrás dos caminos:

1.  **Modo "Crear" (Chat):** Vas hablando con Copilot y él configura el agente por ti basándose en tus respuestas. Es excelente para tu primer prototipo.
2.  **Modo "Configurar" (Manual):** Es donde los expertos tienen el control total. Aquí pegas tus instrucciones detalladas. La estructura ideal de instrucción es:
    * **Rol:** "Actúa como un experto en Recursos Humanos..."
    * **Contexto:** "Utiliza siempre los manuales adjuntos para validar la información..."
    * **Formato:** "Entrega los resultados en formato de lista con viñetas..."

---

## 🧠 ¿Qué tareas delegar? Ejemplos de Agentes de Uso Propio

Un agente brilla cuando se encarga de procesos que tienen reglas claras. Aquí tienes ejemplos de qué podrías construir hoy mismo:

### **1. Agente de Descriptores de Cargo**
* **Misión:** Estandarizar la creación de vacantes.
* **Qué hace:** Tú le das una lista de tareas sueltas y él redacta el descriptor oficial siguiendo el formato de la empresa: Misión, Responsabilidades, Competencias y Requisitos.
* **Valor:** Elimina la inconsistencia entre diferentes departamentos.

### **2. Agente Redactor de Situaciones (Modelo STAR)**
* **Misión:** Convertir notas de campo en reportes ejecutivos.
* **Qué hace:** Recibe apuntes rápidos (ej: "Retraso en vuelo, falla técnica, pasajeros reubicados") y los transforma en un reporte formal bajo el modelo **Situación, Tarea, Acción y Resultado**.
* **Valor:** Asegura objetividad y profesionalismo en registros críticos.

### **3. Agente de Análisis de Políticas Internas**
* **Misión:** Consulta rápida de manuales extensos.
* **Qué hace:** Tiene cargados los PDFs de políticas de viáticos o beneficios. Tú le preguntas: "¿Qué cubre el seguro en viajes internacionales?" y él responde citando el punto exacto del manual.
* **Valor:** Ahorra horas de lectura manual.

### **4. Agente de Feedback Profesional**
* **Misión:** Pulir la comunicación interpersonal.
* **Qué hace:** Tú escribes lo que quieres decir de forma cruda, y el agente lo traduce a un mensaje empático, constructivo y profesional.

---

## ⚖️ El Semáforo de la Delegación

Usa esta guía para decidir qué tarea "clonar" en un agente y qué mantener bajo tu control total:

| 🟢 DELEGAR (Agente) | 🔴 NO DELEGAR (Humano) |
|---|---|
| Tareas repetitivas (más de 3 veces por semana). | Decisiones éticas, legales o de despido. |
| Procesos con manuales o protocolos claros. | Cifras financieras finales y cálculos críticos. |
| Búsqueda de datos en archivos muy largos. | Gestión de crisis emocionales con personas. |
| Cambios de tono (de técnico a ejecutivo). | Creatividad estratégica y visión de negocio. |

```mermaid
flowchart TD
    A["¿Debo crear un agente?"] --> B{"¿Es una tarea\nrepetitiva?"}
    B -- No --> C["Usa el chat normal"]
    B -- Sí --> D{"¿Existen reglas\no manuales claros?"}
    D -- No --> C
    D -- Sí --> E["¡Crea un Agente!"]
    style E fill:#d1fae5,stroke:#10b981$content$, 'media_url', '7dlIqXp5glY'), 20);

INSERT INTO lecciones (id, modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
(127, 6, 4, 'Lección 3: 🚀 Agentes de IA en Talento Humano: Catálogo de Casos de Uso', 'texto', jsonb_build_object('texto', $content$# Lección 3: 🚀 Agentes de IA en Talento Humano: Catálogo de Casos de Uso

En la gestión moderna de personas, el éxito radica en la capacidad de delegar la carga operativa a herramientas inteligentes. Al configurar **Agentes Propios**, el equipo de RR.HH. automatiza el **80% del esfuerzo mecánico** (procesamiento de datos, redacción de borradores, búsqueda de normativas) para concentrarse en el **20% de valor estratégico** (toma de decisiones, empatía y liderazgo).

---

## 1. Atracción de Talento: El Consultor de Selección
**Misión:** Estandarizar y agilizar el proceso de reclutamiento y captación.
* **El 80% que resuelve:** Redacción de descriptores de cargo, creación de guías de entrevistas por competencias y cribado inicial de perfiles.
* **Ejemplos:**
    1.  **Agente de Perfiles:** Al recibir una lista de funciones técnicas, redacta la vacante siguiendo exactamente el tono de marca empleadora de la compañía.
    2.  **Agente de Entrevistas:** Analiza el perfil del cargo y genera un set de 10 preguntas conductuales con una guía de respuestas esperadas para los evaluadores.
    3.  **Agente de Filtro Curricular:** Compara los requisitos de una vacante contra un grupo de hojas de vida y entrega un ranking de los candidatos más alineados al perfil.

## 2. Cultura: El Analista de Clima y Valores
**Misión:** Medir y fortalecer el ADN organizacional.
* **El 80% que resuelve:** Análisis de datos cualitativos en encuestas, redacción de comunicados de cultura y personalización de planes de bienvenida.
* **Ejemplos:**
    1.  **Agente de Sentimiento:** Procesa miles de comentarios abiertos en encuestas de clima y agrupa las principales preocupaciones o motivadores por área o sede.
    2.  **Agente de Onboarding:** Genera un itinerario personalizado de inducción para cada nuevo integrante basado en su rol y ubicación geográfica.
    3.  **Agente de Comunicación Interna:** Adapta un mensaje corporativo formal a diferentes canales (Teams, correo, carteleras) manteniendo la cercanía y los valores de la empresa.

## 3. Desempeño: El Facilitador de Feedback
**Misión:** Elevar la calidad y objetividad de las evaluaciones de progreso.
* **El 80% que resuelve:** Estructuración de comentarios constructivos, alineación de objetivos SMART y sugerencia de planes de mejora.
* **Ejemplos:**
    1.  **Agente de Redacción de Feedback:** Toma las notas rápidas de un líder sobre un colaborador y las convierte en un mensaje profesional siguiendo el modelo de "Situación-Comportamiento-Impacto".
    2.  **Agente de Objetivos:** Revisa los KPIs redactados por los jefes de área y sugiere ajustes para que sean específicos, medibles y alcanzables.
    3.  **Agente de IDP (Planes de Desarrollo):** Basado en las debilidades detectadas en una evaluación, recomienda acciones de formación específicas para cerrar brechas de competencias.

## 4. Liderazgo: El Asistente de Gestión de Equipos
**Misión:** Apoyar a los jefes de área en su rol de líderes de personas.
* **El 80% que resuelve:** Preparación de reuniones de seguimiento, sugerencias de estilos de liderazgo y resolución de dudas sobre gestión de personal.
* **Ejemplos:**
    1.  **Agente de Preparación 1 a 1:** Ayuda al líder a estructurar la agenda de sus reuniones semanales, recordando temas pendientes y sugiriendo preguntas de coaching.
    2.  **Agente de Estilos de Liderazgo:** Analiza un caso de conflicto en un equipo y sugiere si el líder debe actuar de forma directiva, participativa o delegativa según la situación.
    3.  **Agente de Simulación:** Permite al líder practicar una conversación difícil (como una amonestación) y le da retroalimentación sobre su claridad y tono.

## 5. Capacitación y Desarrollo: El Diseñador de Aprendizaje
**Misión:** Escalar el conocimiento técnico$content$), 10);

INSERT INTO lecciones (id, modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
(108, 7, 1, 'IA para tu vida personal: herramientas que ya puedes usar', 'texto', jsonb_build_object('texto', $content$# IA para tu vida personal: herramientas que ya puedes usar

La inteligencia artificial no es solo una herramienta de trabajo. Fuera de la oficina, existen decenas de aplicaciones que pueden ayudarte a organizar tu tiempo, aprender más rápido, cuidar tu bienestar y administrar mejor tus finanzas. Según datos recientes de productividad laboral y personal, los profesionales que integran herramientas de IA en su rutina diaria **ahorran en promedio 3.6 horas por semana**, tiempo que pueden dedicar a lo que realmente importa.

Este módulo es un recorrido práctico por las mejores herramientas de IA disponibles hoy para tu vida personal, organizadas por categoría, con recomendaciones claras sobre cuáles son gratuitas y cuáles vale la pena pagar.

---

## Panorama de herramientas de IA para uso personal

| Categoría | Herramienta | Plan gratuito | Plan de pago | Mejor para |
|---|---|---|---|---|
| **Chatbots** | ChatGPT (OpenAI) | Sí, GPT-4o limitado | Plus USD 20/mes | Preguntas complejas, redacción, análisis |
| **Chatbots** | Gemini (Google) | Sí, completo | Advanced USD 20/mes | Integración con Google Workspace |
| **Chatbots** | Claude (Anthropic) | Sí, limitado | Pro USD 20/mes | Textos largos, razonamiento detallado |
| **Chatbots** | Copilot (Microsoft) | Sí, integrado en Bing | Pro USD 20/mes | Búsqueda web con respuestas conversacionales |
| **Productividad** | Reclaim AI | Sí, hasta 3 calendarios | Starter USD 8/mes | Organización automática del calendario |
| **Productividad** | Notion AI | Requiere Notion (freemium) | Add-on USD 10/mes | Notas inteligentes, resumen de documentos |
| **Productividad** | Otter.ai | Sí, 300 min/mes | Pro USD 17/mes | Transcripción de reuniones en tiempo real |
| **Aprendizaje** | Khanmigo (Khan Academy) | Sí, para estudiantes | Donación sugerida | Tutor personalizado de matemáticas y ciencias |
| **Aprendizaje** | Duolingo Max | No, solo versión básica gratis | Super USD 7/mes | Práctica de idiomas con IA conversacional |
| **Aprendizaje** | Perplexity AI | Sí, búsquedas ilimitadas | Pro USD 20/mes | Investigación con fuentes verificadas |
| **Salud** | Wysa | Sí, herramientas básicas | Premium USD 100/año | Apoyo emocional y bienestar mental |
| **Finanzas** | Fintonic | Sí, completo | Premium con funciones extra | Control de gastos y presupuesto automático |
| **Creación de contenido** | Canva AI | Sí, funciones limitadas | Pro USD 13/mes | Diseño gráfico con generación de imágenes |
| **Creación de contenido** | CapCut | Sí, funciones básicas | Pro USD 10/mes | Edición de video con IA |

---

## Productividad personal: organiza tu tiempo sin esfuerzo

La productividad personal es donde la IA tiene el impacto más inmediato. Tres herramientas destacan por su utilidad práctica.

### Reclaim AI: tu calendario en piloto automático

Reclaim AI analiza tu calendario, tus hábitos y tus prioridades para **bloquear tiempo automáticamente** para tareas importantes. No se trata solo de agendar reuniones: la herramienta protege bloques para trabajo profundo, pausas, ejercicio o tiempo personal.

```mermaid
flowchart LR
    A["Tus tareas\ny prioridades"] --> B["Reclaim AI\nanaliza patrones"]
    B --> C["Bloquea tiempo\nautomáticamente"]
    C --> D["Calendario\noptimizado"]
    D --> E["Más tiempo para\nlo que importa"]
    style A fill:#dbeafe,stroke:#3b82f6
    style B fill:#e0e7ff,stroke:#6366f1
    style C fill:#ede9fe,stroke:#8b5cf6
    style D fill:#d1fae5,stroke:#10b981
    style E fill:#bbf7d0,stroke:#22c55e
```

Lo que la hace diferente de un calendario normal es que se **adapta en tiempo real**: si una reunión se mueve, Reclaim reorganiza automáticamente el resto de tu día. El plan gratuito permite conectar hasta 3 calendarios, lo cual es suficiente para la mayoría de personas.

### Notion AI: notas que trabajan por ti

Si ya usas Notion (o cualquier herramienta de notas), Notion AI le agrega una capa de inteligencia: resume documentos largos, genera listas de acción a partir de notas desordenadas, y responde preguntas sobre tu propio contenido.

Caso de uso práctico: pegas las notas de una reunión de padres de familia del colegio y le pides que extraiga las tareas pendientes con fechas. En segundos tienes una lista limpia y accionable.

### Otter.ai: transcripción inteligente de reuniones

Otter.ai transcribe reuniones en tiempo real (presenciales o virtuales) y genera resúmenes automáticos con los puntos clave y acciones a seguir. Funciona con Zoom, Google Meet y Microsoft Teams.

El plan gratuito incluye 300 minutos mensuales de transcripción. Para uso personal (reuniones de condominio, citas médicas, clases), es más que suficiente.

---

## Aprendizaje: la IA como tutor personal

### Khanmigo: tutor de Khan Academy con IA

Khanmigo no te da respuestas directas. En cambio, te hace **preguntas guiadas** para que llegues a la respuesta por tu cuenta. Es el enfoque socrático aplicado a matemáticas, ciencias, programación y más.

Es especialmente útil para padres que ayudan a sus hijos con tareas escolares: Khanmigo explica conceptos paso a paso, adaptándose al nivel del estudiante.

### Perplexity AI: investigación con fuentes reales

A diferencia de los chatbots generales, Perplexity AI está diseñado como un **motor de investigación**. Cada respuesta incluye citas con enlaces a las fuentes originales, lo que te permite verificar la información.

Ideal para: investigar temas de salud, comparar productos antes de comprar, entender temas complejos de actualidad, o preparar presentaciones con datos respaldados.

### Técnica: "Profesor personal con ChatGPT" en 4 pasos

No necesitas una herramienta especializada para aprender. Cualquier chatbot de IA puede convertirse en un tutor personal si le das las instrucciones correctas.

```mermaid
flowchart TD
    P1["Paso 1\nDefine el tema y tu nivel actual"]
    P2["Paso 2\nPide una explicación adaptada a tu nivel"]
    P3["Paso 3\nSolicita ejercicios prácticos con dificultad progresiva"]
    P4["Paso 4\nPide que evalúe tus respuestas y explique los errores"]
    P1 --> P2 --> P3 --> P4
    style P1 fill:#dbeafe,stroke:#3b82f6
    style P2 fill:#e0e7ff,stroke:#6366f1
    style P3 fill:#ede9fe,stroke:#8b5cf6
    style P4 fill:#fae8ff,stroke:#d946ef
```

**Ejemplo de prompt para el Paso 1:**

```
Quiero aprender sobre finanzas personales. Mi nivel actual es
básico: sé lo que es un presupuesto pero no entiendo conceptos
como interés compuesto, fondos de inversión o diversificación.
Explícame como si fuera la primera vez que escucho estos términos.
```

**Para el Paso 3:**

```
Ahora dame 3 ejercicios prácticos de dificultad progresiva sobre
interés compuesto. El primero muy básico, el segundo intermedio,
y el tercero que requiera pensar un poco más. No me des las
respuestas todavía.
```

La clave es mantener la conversación abierta: pregúntale tus dudas, pide que reformule lo que no entiendas, y solicita más ejercicios cuando te sientas listo.

---

## Salud y finanzas: IA con precaución

> **Advertencia importante:** Nunca ingreses datos médicos reales, diagnósticos, números de cuenta bancaria ni información financiera sensible en herramientas de IA que no hayan sido verificadas por profesionales. Estas herramientas son un complemento, no un reemplazo de médicos ni asesores financieros.

### Wysa: apoyo emocional con IA

Wysa es un chatbot de salud mental basado en técnicas de **terapia cognitivo-conductual (TCC)**. No reemplaza a un psicólogo, pero ofrece ejercicios de respiración, manejo de ansiedad, journaling guiado y técnicas de relajación disponibles las 24 horas.

Lo que distingue a Wysa de un chatbot general es que fue diseñada con supervisión clínica y no almacena conversaciones con identificadores personales. El plan gratuito incluye las herramientas de autoayuda; el premium agrega sesiones con terapeutas humanos.

### Fintonic: control de gastos automático

Fintonic se conecta a tus cuentas bancarias (con tu autorización) y **categoriza automáticamente** tus gastos: alimentación, transporte, entretenimiento, suscripciones. Te muestra gráficos claros de a dónde va tu dinero y te alerta cuando un gasto es inusual.

Es gratuito y disponible en Latinoamérica. La IA detecta patrones como suscripciones olvidadas o cobros duplicados.

### Plum: ahorro automático inteligente

Plum analiza tus ingresos y gastos para **apartar pequeñas cantidades automáticamente** en los momentos en que tu cuenta puede permitírselo. No sientes el ahorro porque las cantidades son pequeñas, pero se acumulan con el tiempo.

Funciona como un "ahorro hormiga" potenciado por IA que se adapta a tu situación financiera real.

```mermaid
flowchart LR
    subgraph "Herramientas de bienestar"
        W["Wysa\nSalud mental"]
        F["Fintonic\nControl de gastos"]
        P["Plum\nAhorro automático"]
    end
    W --> R["Mejor bienestar\nemocional"]
    F --> R2["Mejor control\nfinanciero"]
    P --> R2
    style W fill:#fce7f3,stroke:#ec4899
    style F fill:#dbeafe,stroke:#3b82f6
    style P fill:#d1fae5,stroke:#10b981
    style R fill:#fce7f3,stroke:#ec4899
    style R2 fill:#dbeafe,stroke:#3b82f6
```

---

## Gratuito vs de pago: qué ganas realmente al pagar

Una de las preguntas más frecuentes es si vale la pena pagar por estas herramientas. La respuesta corta: **las versiones gratuitas son más que suficientes para empezar**.

| Categoría | Lo que obtienes gratis | Lo que agrega el plan de pago |
|---|---|---|
| **Chatbots (ChatGPT, Gemini, Claude)** | Acceso al modelo principal con límites de uso diario, historial de conversaciones, funcionalidades básicas | Más capacidad de uso, acceso prioritario, modelos más avanzados, archivos más grandes |
| **Productividad (Reclaim, Notion AI)** | Funcionalidad core completa con límites de volumen | Más integraciones, automatizaciones avanzadas, equipos |
| **Aprendizaje (Perplexity, Khanmigo)** | Búsquedas ilimitadas, tutor básico | Modelos premium, búsquedas más profundas, carga de archivos |
| **Salud (Wysa)** | Herramientas de autoayuda, ejercicios de respiración, journaling | Sesiones con terapeutas humanos, programas estructurados |
| **Finanzas (Fintonic, Plum)** | Categorización de gastos, alertas, ahorro básico | Análisis avanzados, objetivos de ahorro, recomendaciones personalizadas |
| **Creación (Canva AI, CapCut)** | Plantillas, edición básica, generación limitada de imágenes y video | Sin marcas de agua, más generaciones de IA, funciones premium |

---

## Conclusión

No necesitas gastar dinero para empezar a usar IA en tu vida personal. Las versiones gratuitas de ChatGPT, Perplexity, Reclaim AI, Wysa y Fintonic cubren el 80% de lo que la mayoría de personas necesita. El mejor momento para probar es ahora: elige una herramienta de la tabla, instálala, y úsala durante una semana para resolver un problema real de tu día a día.

La IA no va a reemplazar tu criterio ni tus decisiones. Pero sí puede quitarte de encima las tareas repetitivas, ayudarte a aprender más rápido y darte mejor visibilidad sobre tu tiempo y tu dinero. Esas 3.6 horas semanales que puedes recuperar no son un número abstracto: son tiempo para tu familia, tus proyectos personales o simplemente para descansar.

---

## Fuentes

- Javadex. *Mejores herramientas de IA para productividad personal: ranking 2026*. [https://www.javadex.es/blog/mejores-herramientas-ia-productividad-personal-ranking-2026](https://www.javadex.es/blog/mejores-herramientas-ia-productividad-personal-ranking-2026)
- Guru. *Las 10 mejores herramientas de productividad con IA*. [https://www.getguru.com/es/reference/best-10-ai-productivity-tools](https://www.getguru.com/es/reference/best-10-ai-productivity-tools)
- Reclaim AI. *Smart Scheduling for Busy People*. [https://reclaim.ai/](https://reclaim.ai/)
- Motion. *The Intelligent Calendar*. [https://www.usemotion.com/](https://www.usemotion.com/)
- Khan Academy. *Khanmigo: AI Tutor*. [https://www.khanacademy.org/khan-labs](https://www.khanacademy.org/khan-labs)
- Perplexity AI. [https://www.perplexity.ai/](https://www.perplexity.ai/)
- Wysa. *Mental Health Support*. [https://www.wysa.com/](https://www.wysa.com/)
- Fintonic. *Control de gastos personal*. [https://www.fintonic.com/](https://www.fintonic.com/)$content$), 20);

INSERT INTO lecciones (id, modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
(109, 7, 2, '🚀 Reto: "Reconocimiento con Chispa IA"', 'ejercicio', jsonb_build_object('texto', $content$# 🚀 Reto: "Reconocimiento con Chispa IA"

En este módulo de **IA para la Vida**, el objetivo es convertir la tecnología en un puente para fortalecer nuestro equipo. Tu misión es elegir a un compañero de trabajo y crear una pieza digital única para reconocer su labor, su apoyo o su gran actitud.
---$content$, 'instrucciones', $content$### 🎯 El Objetivo
Selecciona a un compañero que admires o a quien quieras agradecer algo especial. Crea un detalle usando IA y compártelo para hacer su día más brillante. 



---

### 🛠️ Opciones Creativas y Herramientas

A continuación, elige **una** de las siguientes rutas creativas para tu reconocimiento:

#### **Opción 1: El Hit Musical Personalizado**
* **Qué hacer:** Compón una canción completa (letra y música) que hable de sus fortalezas o de un logro compartido.
* **Herramientas:** [Suno AI](https://suno.com/) o [Udio](https://www.udio.com/).
* **Sugerencia:** Prueba con géneros que sepas que le gustan (Rock, Jazz, Tropical o incluso un corrido).



#### **Opción 2: El Poster o Afiche de Reconocimiento**
* **Qué hacer:** Diseña un afiche de alta calidad. Puedes usar un estilo de "Película", "Superhéroe" o "Líder Inspirador".
* **Herramientas:** **Gemini**, [Microsoft Designer](https://designer.microsoft.com/), [Adobe Express](https://www.adobe.com/express/) o [Canva](https://www.canva.com/).
* **Sugerencia:** Pídele a Gemini que redacte el "copy" o eslogan perfecto para el poster.



#### **Opción 3: De Foto a Video (Cinematic)**
* **Qué hacer:** Toma una foto de tu compañero y conviértela en un video corto con movimiento. Acompaña el video con un mensaje potente de agradecimiento que aparezca en pantalla o como narración.
* **Herramientas:** **Sora**, [CapCut](https://www.capcut.com/) o [Luma Dream Machine](https://lumalabs.ai/dream-machine).
* **Estilo:** El video debe dar vida a la imagen estática (como un fondo que se mueve o un efecto de cámara lenta) y cerrar con tu mensaje de reconocimiento.



#### **Opción 4: El Avatar o Caricatura de Agradecimiento**
* **Qué hacer:** Genera una imagen estilizada (estilo Pixar, Arte Digital o Funko) que represente la esencia de tu compañero, junto a un mensaje potente redactado con IA.
* **Herramientas:** **Gemini**, [DALL-E 3](https://www.bing.com/images/create) o [Canva Magic Media](https://www.canva.com/).



---

### 📝 Instrucciones para completar el desafío

| Paso | Acción | Canal |
| :--- | :--- | :--- |
| **1. Crear** | Usa las herramientas mencionadas para generar tu pieza. Sé creativo con los *prompts*. | Herramientas de IA |
| **2. Sorprender** | Envía el archivo o link directamente a tu compañero con un mensaje personal. | Chat Interno / Teams |
| **3. Compartir** | Publica tu creación mencionando qué herramientas usaste y etiqueta a tu compañero. | Red Social Interna / LinkedIn |
| **4. Evidenciar** | Sube aquí el archivo o el enlace de lo que creaste para validar el módulo. | Plataforma de Aprendizaje |

---

### 💡 Nota importante

> No busques la perfección técnica, busca la **conexión**. El valor de este reto está en el tiempo que dedicas a reconocer el valor de otro ser humano usando las herramientas del futuro.

**¿Listo para crear algo increíble para tu equipo?**

`#MiVidaConIA` `#ReconocimientoIA` `#InnovacionHumana`$content$), 15);

INSERT INTO lecciones (id, modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
(110, 8, 1, 'Reto final: demuestra todo lo que aprendiste', 'texto', jsonb_build_object('texto', $content$# Reto final: demuestra todo lo que aprendiste

Has recorrido siete módulos donde aprendiste a comunicarte con la IA, proteger datos sensibles, estructurar instrucciones complejas, crear contenido profesional y automatizar tareas con agentes. Este es el momento de poner todo en práctica.

No es un examen. No hay respuestas correctas ni incorrectas. Es un reto integrador donde vas a diseñar una solución real combinando las técnicas que aprendiste a lo largo del taller.

---

## Lo que aprendiste en el camino

Antes de lanzarte al reto, repasemos las habilidades que construiste módulo a módulo:

| Módulo | Habilidad clave |
|--------|----------------|
| **Módulo 1** | Entender las capacidades y limitaciones de la IA en el entorno laboral |
| **Módulo 2** | Escribir prompts efectivos y aplicar protocolos de anonimización de datos |
| **Módulo 3** | Usar técnicas de Few-shot y Prompt Chaining para tareas complejas |
| **Módulo 4** | Estructurar instrucciones con XML/JSON y aplicar principios de seguridad |
| **Módulo 5** | Crear contenido profesional con Microsoft Copilot |
| **Módulo 6** | Diseñar agentes de IA y automatizar tareas en Excel |
| **Módulo 7** | Aplicar la IA como herramienta para la vida personal |

Cada una de estas habilidades es una pieza del rompecabezas. El reto que sigue te pide ensamblarlas todas.

---

## El escenario

> Tu departamento necesita crear un proceso completo de onboarding digital usando IA. Diseña el flujo completo: desde la recopilación de información (anonimizada), la generación de materiales de capacitación, la creación de un agente de preguntas frecuentes, hasta la evaluación del proceso.

Imagina que te asignan liderar este proyecto. Tienes acceso a Microsoft Copilot y a todo lo que aprendiste en el taller. Tu entregable es un documento que describa el proceso completo, con los prompts que usarías en cada etapa y los resultados esperados.

---

## Flujo esperado del entregable

```mermaid
flowchart TD
    A["Etapa 1\nRecopilación de información"] --> B["Etapa 2\nAnonimización de datos"]
    B --> C["Etapa 3\nGeneración de materiales\nde capacitación"]
    C --> D["Etapa 4\nCreación del agente\nde preguntas frecuentes"]
    D --> E["Etapa 5\nEvaluación del proceso"]
    E --> F["Entregable final\ndocumentado"]
    style A fill:#dbeafe,stroke:#3b82f6
    style B fill:#fce7f3,stroke:#ec4899
    style C fill:#e0e7ff,stroke:#6366f1
    style D fill:#d1fae5,stroke:#10b981
    style E fill:#fef3c7,stroke:#f59e0b
    style F fill:#bbf7d0,stroke:#22c55e
```

---

## Qué se espera en cada etapa

### Etapa 1: Recopilación de información

Define qué datos necesitas para diseñar el onboarding. Usa prompts para identificar las preguntas clave que le harías al área de Recursos Humanos, los requisitos del puesto y la información del nuevo colaborador.

### Etapa 2: Anonimización de datos

Aplica el protocolo de anonimización del Módulo 2 a toda la información personal recopilada. Demuestra que puedes trabajar con IA sin exponer datos sensibles de empleados ni de la organización.

### Etapa 3: Generación de materiales de capacitación

Usa técnicas de Prompt Chaining y estructuras XML o JSON para generar los materiales del onboarding: guías, presentaciones, correos de bienvenida o cualquier recurso que consideres necesario. Aplica al menos dos técnicas distintas de los módulos anteriores.

### Etapa 4: Creación del agente de preguntas frecuentes

Diseña un agente con Copilot que pueda responder las preguntas más comunes de un nuevo colaborador: beneficios, herramientas disponibles, contactos clave, políticas internas. Define su rol, sus instrucciones y sus límites.

### Etapa 5: Evaluación del proceso

Propone cómo medirías la efectividad del onboarding digital. Usa la IA para generar una encuesta de satisfacción, métricas de seguimiento o un dashboard de indicadores.

---

## Criterios de evaluación

Tu entregable será evaluado con base en cuatro criterios:

| Criterio | Qué se evalúa |
|----------|--------------|
| **Aplicación de técnicas** | Uso demostrable de al menos 4 técnicas de los módulos anteriores (Few-shot, Chaining, XML/JSON, anonimización, agentes, etc.) |
| **Protección de datos** | Ningún dato corporativo real queda expuesto en los prompts. Se aplica anonimización de forma consistente en todo el proceso |
| **Calidad del resultado** | Los materiales generados son profesionales, coherentes y listos para usar en un contexto corporativo real |
| **Documentación del proceso** | Cada etapa está explicada con claridad: qué prompt se usó, por qué se eligió esa técnica y qué resultado se obtuvo |

---

## Estructura sugerida del entregable

No es obligatorio seguir este formato, pero puede ayudarte a organizar tu trabajo:

1. **Introducción** - Breve descripción del problema y tu enfoque
2. **Etapa 1 a 5** - Para cada etapa incluir:
   - Prompt utilizado (completo)
   - Técnica aplicada y por qué la elegiste
   - Resultado obtenido de Copilot
   - Ajustes que hiciste al resultado (si aplica)
3. **Reflexión final** - Qué aprendiste del proceso y qué harías diferente

---

## Flujo de técnicas aplicadas por etapa

```mermaid
flowchart LR
    subgraph E1["Etapa 1"]
        T1["Prompt Engineering\nbásico"]
    end
    subgraph E2["Etapa 2"]
        T2["Protocolo de\nanonimización"]
    end
    subgraph E3["Etapa 3"]
        T3["Prompt Chaining\n+ XML/JSON"]
    end
    subgraph E4["Etapa 4"]
        T4["Diseño de\nagentes"]
    end
    subgraph E5["Etapa 5"]
        T5["Few-shot\n+ Copilot"]
    end
    E1 --> E2 --> E3 --> E4 --> E5
    style E1 fill:#dbeafe,stroke:#3b82f6
    style E2 fill:#fce7f3,stroke:#ec4899
    style E3 fill:#e0e7ff,stroke:#6366f1
    style E4 fill:#d1fae5,stroke:#10b981
    style E5 fill:#fef3c7,stroke:#f59e0b
```

---

## Antes de empezar

- Revisa tus notas de los módulos anteriores
- Ten Copilot abierto y listo para usar
- No intentes resolver todo de una vez: ve etapa por etapa
- Si un prompt no da el resultado esperado, itera y mejora. Eso también es parte de la habilidad

---

> La IA es un amplificador de tus capacidades. Tu criterio profesional es lo que marca la diferencia.$content$), 30);

-- === PRUEBAS (9 filas) ===
INSERT INTO pruebas (id, modulo_id, tipo, titulo, preguntas_por_intento, puntaje_aprobatorio, orden) VALUES
(1, NULL, 'diagnostico_pre', 'Diagnostico de entrada', 7, 0, 0);

INSERT INTO pruebas (id, modulo_id, tipo, titulo, preguntas_por_intento, puntaje_aprobatorio, orden) VALUES
(3, 1, 'modular', 'Prueba: Nuevos Horizontes', 5, 80, 1);

INSERT INTO pruebas (id, modulo_id, tipo, titulo, preguntas_por_intento, puntaje_aprobatorio, orden) VALUES
(12, 2, 'modular', 'Prueba: ADN Digital', 5, 80, 2);

INSERT INTO pruebas (id, modulo_id, tipo, titulo, preguntas_por_intento, puntaje_aprobatorio, orden) VALUES
(4, 3, 'modular', 'Prueba: Few-shot y Prompt Chaining', 5, 80, 3);

INSERT INTO pruebas (id, modulo_id, tipo, titulo, preguntas_por_intento, puntaje_aprobatorio, orden) VALUES
(5, 4, 'modular', 'Prueba: Prompting avanzado', 5, 80, 4);

INSERT INTO pruebas (id, modulo_id, tipo, titulo, preguntas_por_intento, puntaje_aprobatorio, orden) VALUES
(6, 5, 'modular', 'Prueba: Crea con Copilot', 5, 80, 5);

INSERT INTO pruebas (id, modulo_id, tipo, titulo, preguntas_por_intento, puntaje_aprobatorio, orden) VALUES
(7, 6, 'modular', 'Prueba: Agentes y Excel', 5, 80, 6);

INSERT INTO pruebas (id, modulo_id, tipo, titulo, preguntas_por_intento, puntaje_aprobatorio, orden) VALUES
(11, 7, 'modular', 'Prueba: IA para tu vida personal', 5, 80, 7);

INSERT INTO pruebas (id, modulo_id, tipo, titulo, preguntas_por_intento, puntaje_aprobatorio, orden) VALUES
(8, NULL, 'diagnostico_post', 'Diagnostico de salida', 7, 0, 8);

-- === PREGUNTAS (151 filas) ===
INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(189, 1, '¿Qué es la inteligencia artificial?', '[{"texto": "Un programa que imita capacidades humanas como razonar y aprender", "es_correcta": true}, {"texto": "Un tipo de hardware especializado", "es_correcta": false}, {"texto": "Una red social para científicos", "es_correcta": false}, {"texto": "Un sistema operativo avanzado", "es_correcta": false}]'::jsonb, 'La IA es un campo de la informática que busca crear sistemas capaces de realizar tareas que normalmente requieren inteligencia humana.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(190, 1, '¿Qué es un prompt?', '[{"texto": "Un tipo de archivo de texto", "es_correcta": false}, {"texto": "Una instrucción o pregunta que le das a una IA", "es_correcta": true}, {"texto": "Un programa de computador", "es_correcta": false}, {"texto": "Una base de datos", "es_correcta": false}]'::jsonb, 'Un prompt es la instrucción que el usuario le da a un sistema de IA para obtener una respuesta.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(191, 1, '¿Qué es Microsoft Copilot?', '[{"texto": "Un navegador web", "es_correcta": false}, {"texto": "Un asistente de IA integrado en Microsoft 365", "es_correcta": true}, {"texto": "Un antivirus", "es_correcta": false}, {"texto": "Una hoja de cálculo", "es_correcta": false}]'::jsonb, 'Microsoft Copilot es un asistente de IA que se integra en las aplicaciones de Microsoft 365.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(192, 1, '¿Qué es la IA generativa?', '[{"texto": "IA que genera contenido nuevo como texto, imágenes o código", "es_correcta": true}, {"texto": "IA que solo analiza datos existentes", "es_correcta": false}, {"texto": "IA que genera electricidad", "es_correcta": false}, {"texto": "IA que elimina archivos automáticamente", "es_correcta": false}]'::jsonb, 'La IA generativa crea contenido nuevo basándose en patrones aprendidos de grandes cantidades de datos.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(193, 1, '¿Cuál es un riesgo de usar IA en el trabajo?', '[{"texto": "Que la IA tome vacaciones", "es_correcta": false}, {"texto": "Compartir información confidencial sin darse cuenta", "es_correcta": true}, {"texto": "Que consuma mucha electricidad", "es_correcta": false}, {"texto": "Que hable con otros empleados", "es_correcta": false}]'::jsonb, 'Uno de los principales riesgos es compartir información confidencial de la empresa con herramientas de IA externas.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(194, 1, '¿Qué es una alucinación en IA?', '[{"texto": "Cuando la IA se apaga inesperadamente", "es_correcta": false}, {"texto": "Cuando genera información falsa presentándola como real", "es_correcta": true}, {"texto": "Cuando tarda mucho en responder", "es_correcta": false}, {"texto": "Cuando cambia de idioma sin motivo", "es_correcta": false}]'::jsonb, 'Una alucinación es cuando la IA genera contenido que parece real pero es incorrecto o inventado.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(195, 1, '¿Para qué sirve Copilot Chat en el trabajo diario?', '[{"texto": "Solo para enviar emails", "es_correcta": false}, {"texto": "Para resumir, redactar, analizar datos y automatizar tareas", "es_correcta": true}, {"texto": "Solo para hacer presentaciones", "es_correcta": false}, {"texto": "Solo para jugar", "es_correcta": false}]'::jsonb, 'Copilot sirve para múltiples tareas: resumir documentos, redactar textos, analizar datos y automatizar procesos.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(196, 1, '¿Qué debes hacer siempre después de recibir una respuesta de Copilot?', '[{"texto": "Publicarla inmediatamente", "es_correcta": false}, {"texto": "Verificar que la información sea precisa y veraz", "es_correcta": true}, {"texto": "Borrar el historial", "es_correcta": false}, {"texto": "Compartirla con todos los contactos", "es_correcta": false}]'::jsonb, 'Siempre debes verificar la información generada por IA antes de usarla, ya que puede contener errores.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(197, 1, '¿Qué es Machine Learning?', '[{"texto": "Un tipo de máquina física", "es_correcta": false}, {"texto": "Aprendizaje automático donde los sistemas aprenden de datos", "es_correcta": true}, {"texto": "Un lenguaje de programación", "es_correcta": false}, {"texto": "Una red social profesional", "es_correcta": false}]'::jsonb, 'Machine Learning es una rama de la IA donde los sistemas aprenden de datos sin ser programados explícitamente.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(198, 1, '¿Cuál de estas es una herramienta de IA generativa?', '[{"texto": "Microsoft Excel básico", "es_correcta": false}, {"texto": "ChatGPT", "es_correcta": true}, {"texto": "Windows 11", "es_correcta": false}, {"texto": "Microsoft Word sin Copilot", "es_correcta": false}]'::jsonb, 'ChatGPT es un modelo de lenguaje de OpenAI, una de las herramientas de IA generativa más conocidas.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(199, 1, '¿Qué significa IA responsable?', '[{"texto": "Usar IA solo en horario laboral", "es_correcta": false}, {"texto": "Principios y prácticas para usar la IA de forma ética y segura", "es_correcta": true}, {"texto": "Una marca comercial de software", "es_correcta": false}, {"texto": "Un tipo de licencia de software", "es_correcta": false}]'::jsonb, 'La IA responsable se refiere a principios para usar la inteligencia artificial de manera ética, transparente y segura.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(200, 1, '¿Qué puede hacer Copilot con tus archivos de Microsoft 365?', '[{"texto": "Borrarlos automáticamente", "es_correcta": false}, {"texto": "Acceder a ellos para dar respuestas contextualizadas", "es_correcta": true}, {"texto": "Compartirlos en redes sociales", "es_correcta": false}, {"texto": "Venderlos a terceros", "es_correcta": false}]'::jsonb, 'Copilot puede acceder a los archivos dentro de tu entorno de Microsoft 365 para proporcionar respuestas contextualizadas.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(201, 1, '¿Cuál es la mejor práctica al escribir un prompt?', '[{"texto": "Ser lo más vago posible", "es_correcta": false}, {"texto": "Ser específico y dar contexto claro", "es_correcta": true}, {"texto": "Usar solo una palabra", "es_correcta": false}, {"texto": "Escribir en mayúsculas", "es_correcta": false}]'::jsonb, 'La mejor práctica es dar instrucciones claras y específicas con contexto suficiente.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(202, 1, '¿Copilot puede reemplazar completamente el trabajo humano?', '[{"texto": "Sí, en todas las tareas", "es_correcta": false}, {"texto": "No, es un asistente que complementa el trabajo humano", "es_correcta": true}, {"texto": "Solo en matemáticas", "es_correcta": false}, {"texto": "Solo los fines de semana", "es_correcta": false}]'::jsonb, 'Copilot es un asistente que complementa el trabajo humano. Siempre requiere supervisión y juicio crítico.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(203, 1, '¿Qué es un chatbot?', '[{"texto": "Un robot físico de limpieza", "es_correcta": false}, {"texto": "Un programa que simula conversaciones con usuarios", "es_correcta": true}, {"texto": "Un tipo de virus informático", "es_correcta": false}, {"texto": "Una impresora inteligente", "es_correcta": false}]'::jsonb, 'Un chatbot es un programa diseñado para simular conversaciones con usuarios humanos a través de texto.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(204, 1, '¿Para qué puede servir la IA en Recursos Humanos?', '[{"texto": "Solo para despedir empleados", "es_correcta": false}, {"texto": "Para automatizar tareas repetitivas y mejorar procesos de talento", "es_correcta": true}, {"texto": "Para reemplazar a todos los empleados", "es_correcta": false}, {"texto": "No tiene uso en RRHH", "es_correcta": false}]'::jsonb, 'La IA en RRHH ayuda a automatizar procesos como selección, nómina y análisis de datos de talento.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(205, 1, '¿Qué pasa si le das información confidencial a una IA pública?', '[{"texto": "Nada, siempre es seguro", "es_correcta": false}, {"texto": "La información podría ser usada para entrenar el modelo o filtrarse", "es_correcta": true}, {"texto": "Se borra automáticamente después de 24 horas", "es_correcta": false}, {"texto": "Se encripta permanentemente", "es_correcta": false}]'::jsonb, 'Las herramientas de IA públicas pueden usar tus datos para entrenamiento. Siempre sigue las políticas de tu empresa.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(206, 1, '¿Qué es un LLM (Large Language Model)?', '[{"texto": "Un tipo de pantalla grande", "es_correcta": false}, {"texto": "Un modelo de IA entrenado con grandes cantidades de texto", "es_correcta": true}, {"texto": "Un lenguaje de programación", "es_correcta": false}, {"texto": "Un servidor de emails", "es_correcta": false}]'::jsonb, 'Un LLM es un modelo de IA entrenado con enormes cantidades de texto que puede generar y comprender lenguaje natural.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(207, 1, '¿Dónde se accede a Copilot Chat?', '[{"texto": "Solo en el Panel de Control de Windows", "es_correcta": false}, {"texto": "En Microsoft Teams, el navegador y otras apps de Microsoft 365", "es_correcta": true}, {"texto": "Solo en el Bloc de Notas", "es_correcta": false}, {"texto": "Solo en la calculadora", "es_correcta": false}]'::jsonb, 'Copilot Chat está disponible en Microsoft Teams, el navegador web y otras aplicaciones de Microsoft 365.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(208, 1, '¿Qué limitación tiene la IA actual?', '[{"texto": "No tiene ninguna limitación", "es_correcta": false}, {"texto": "Puede generar información incorrecta y no tiene sentido común real", "es_correcta": true}, {"texto": "Solo funciona en inglés", "es_correcta": false}, {"texto": "Solo puede procesar números", "es_correcta": false}]'::jsonb, 'La IA actual puede generar información incorrecta y carece de comprensión profunda o sentido común real.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(209, 1, '¿Qué es la tokenización en el contexto de IA?', '[{"texto": "Convertir texto en fichas de casino", "es_correcta": false}, {"texto": "El proceso de dividir texto en unidades que la IA puede procesar", "es_correcta": true}, {"texto": "Crear tokens de seguridad", "es_correcta": false}, {"texto": "Generar criptomonedas", "es_correcta": false}]'::jsonb, 'La tokenización es el proceso de dividir texto en tokens que el modelo de IA puede procesar.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(210, 1, '¿Cuál es una ventaja de usar Copilot corporativo vs una IA pública?', '[{"texto": "Es más barato", "es_correcta": false}, {"texto": "Los datos se mantienen dentro del entorno empresarial protegido", "es_correcta": true}, {"texto": "Genera respuestas más creativas", "es_correcta": false}, {"texto": "No necesita internet", "es_correcta": false}]'::jsonb, 'Copilot empresarial mantiene los datos dentro del tenant de Microsoft 365, protegiendo la información corporativa.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(211, 1, '¿Qué significa sesgo en inteligencia artificial?', '[{"texto": "Un error que hace lenta la IA", "es_correcta": false}, {"texto": "Tendencias injustas en los resultados causadas por datos desbalanceados", "es_correcta": true}, {"texto": "La preferencia de la IA por un idioma", "es_correcta": false}, {"texto": "La velocidad de respuesta de la IA", "es_correcta": false}]'::jsonb, 'El sesgo en IA son tendencias injustas que surgen de datos de entrenamiento desbalanceados.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(212, 3, '¿Cuál es la principal función de Microsoft Copilot en el entorno laboral?', '[{"texto": "Reemplazar al departamento de IT", "es_correcta": false}, {"texto": "Asistir en tareas como redacción, análisis y automatización dentro de Microsoft 365", "es_correcta": true}, {"texto": "Administrar las redes sociales de la empresa", "es_correcta": false}, {"texto": "Gestionar la nómina de empleados", "es_correcta": false}]'::jsonb, 'Copilot es un asistente de IA integrado en Microsoft 365 que ayuda con tareas de productividad.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(213, 3, '¿Qué debes verificar SIEMPRE después de que Copilot genera una respuesta?', '[{"texto": "Que el formato sea bonito", "es_correcta": false}, {"texto": "La precisión y veracidad de la información", "es_correcta": true}, {"texto": "Que no tenga emojis", "es_correcta": false}, {"texto": "El número de palabras", "es_correcta": false}]'::jsonb, 'La IA puede generar información incorrecta. Verificar la veracidad es responsabilidad del usuario.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(214, 3, '¿Qué es una alucinación en el contexto de Copilot?', '[{"texto": "Cuando Copilot muestra colores extraños", "es_correcta": false}, {"texto": "Cuando genera información que parece real pero es inventada", "es_correcta": true}, {"texto": "Cuando tarda demasiado en responder", "es_correcta": false}, {"texto": "Cuando se desconecta del servidor", "es_correcta": false}]'::jsonb, 'Una alucinación es cuando la IA genera contenido que suena convincente pero es factualmente incorrecto.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(215, 3, '¿En cuáles aplicaciones de Microsoft 365 está disponible Copilot?', '[{"texto": "Solo en Word", "es_correcta": false}, {"texto": "En Teams, Word, Excel, PowerPoint, Outlook y más", "es_correcta": true}, {"texto": "Solo en Excel", "es_correcta": false}, {"texto": "Solo en Teams", "es_correcta": false}]'::jsonb, 'Copilot se integra en múltiples aplicaciones de Microsoft 365.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(216, 3, '¿Cuál es el primer paso recomendado al empezar a usar Copilot?', '[{"texto": "Pedirle que escriba un libro completo", "es_correcta": false}, {"texto": "Hacer una pregunta simple y clara para familiarizarte", "es_correcta": true}, {"texto": "Compartir toda tu información personal", "es_correcta": false}, {"texto": "Desactivar todas las configuraciones de seguridad", "es_correcta": false}]'::jsonb, 'Es recomendable empezar con preguntas simples para entender cómo responde Copilot.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(217, 3, '¿Qué tipo de contenido puede generar Copilot?', '[{"texto": "Solo texto plano sin formato", "es_correcta": false}, {"texto": "Texto, resúmenes, código, análisis, presentaciones y más", "es_correcta": true}, {"texto": "Solo imágenes", "es_correcta": false}, {"texto": "Solo hojas de cálculo", "es_correcta": false}]'::jsonb, 'Copilot puede generar diversos tipos de contenido incluyendo texto, resúmenes, código y presentaciones.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(218, 3, '¿Por qué es importante dar contexto en un prompt?', '[{"texto": "Para hacer el prompt más largo", "es_correcta": false}, {"texto": "Para que la IA entienda mejor lo que necesitas y dé respuestas más relevantes", "es_correcta": true}, {"texto": "Para confundir a la IA", "es_correcta": false}, {"texto": "No es importante, la IA adivina todo", "es_correcta": false}]'::jsonb, 'El contexto ayuda a la IA a entender tu situación y necesidad específica.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(219, 3, '¿Qué aspecto de seguridad es más importante al usar Copilot corporativo?', '[{"texto": "Usar contraseñas cortas", "es_correcta": false}, {"texto": "No compartir información confidencial fuera del entorno protegido", "es_correcta": true}, {"texto": "Desactivar el firewall", "es_correcta": false}, {"texto": "Usar redes WiFi públicas", "es_correcta": false}]'::jsonb, 'Es fundamental no compartir datos confidenciales fuera del entorno empresarial protegido.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(220, 3, '¿Copilot puede acceder a tus archivos en OneDrive y SharePoint?', '[{"texto": "No, nunca accede a archivos", "es_correcta": false}, {"texto": "Sí, puede usar tus archivos para contextualizar sus respuestas", "es_correcta": true}, {"texto": "Solo si son archivos de imagen", "es_correcta": false}, {"texto": "Solo si pesan menos de 1MB", "es_correcta": false}]'::jsonb, 'Copilot puede acceder a los archivos de tu Microsoft 365 para dar respuestas contextualizadas.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(221, 3, '¿Qué sucede si Copilot no entiende tu solicitud?', '[{"texto": "Se apaga automáticamente", "es_correcta": false}, {"texto": "Puedes reformular tu prompt con más contexto o instrucciones más claras", "es_correcta": true}, {"texto": "Debes reiniciar el computador", "es_correcta": false}, {"texto": "No puedes volver a usarlo por 24 horas", "es_correcta": false}]'::jsonb, 'Si la respuesta no es lo que esperabas, reformula tu prompt con más contexto y detalles.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(222, 3, '¿Cuál es una buena práctica de seguridad al usar IA en la empresa?', '[{"texto": "Compartir las credenciales de Copilot con compañeros", "es_correcta": false}, {"texto": "Seguir las políticas de seguridad de la empresa sobre manejo de datos con IA", "es_correcta": true}, {"texto": "Usar la misma contraseña para todo", "es_correcta": false}, {"texto": "Desactivar la autenticación de dos factores", "es_correcta": false}]'::jsonb, 'Siempre debes seguir las políticas de seguridad de tu empresa respecto al uso de herramientas de IA.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(223, 3, '¿Qué es la extensión de capacidades que ofrece la IA?', '[{"texto": "Reemplazar las habilidades humanas", "es_correcta": false}, {"texto": "Amplificar y complementar las habilidades humanas con asistencia tecnológica", "es_correcta": true}, {"texto": "Agregar más RAM al computador", "es_correcta": false}, {"texto": "Instalar más programas", "es_correcta": false}]'::jsonb, 'La extensión de capacidades significa que la IA amplifica lo que los humanos ya saben hacer.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(224, 3, '¿En qué se diferencia Copilot Chat de un buscador como Google?', '[{"texto": "No hay diferencia", "es_correcta": false}, {"texto": "Copilot genera respuestas conversacionales y puede acceder a tus datos empresariales", "es_correcta": true}, {"texto": "Google es más inteligente", "es_correcta": false}, {"texto": "Copilot solo funciona offline", "es_correcta": false}]'::jsonb, 'Copilot genera respuestas contextualizadas y puede acceder a tu información empresarial de Microsoft 365.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(225, 3, '¿Qué es el control humano al usar herramientas de IA?', '[{"texto": "Dejar que la IA tome todas las decisiones", "es_correcta": false}, {"texto": "Mantener la supervisión y toma de decisiones final en las personas", "es_correcta": true}, {"texto": "Controlar la velocidad de internet", "es_correcta": false}, {"texto": "Programar la IA desde cero", "es_correcta": false}]'::jsonb, 'El control humano significa que las personas mantienen la supervisión y la decisión final.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(226, 3, '¿Qué ventaja tiene Copilot para resumir documentos largos?', '[{"texto": "Borra los documentos después de leerlos", "es_correcta": false}, {"texto": "Puede procesar grandes volúmenes de texto y extraer los puntos clave rápidamente", "es_correcta": true}, {"texto": "Solo resume documentos de una página", "es_correcta": false}, {"texto": "Traduce automáticamente todos los documentos", "es_correcta": false}]'::jsonb, 'Copilot puede procesar documentos extensos y generar resúmenes con los puntos clave rápidamente.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(242, 4, '¿Qué es un prompt zero-shot?', '[{"texto": "Un prompt que no funciona", "es_correcta": false}, {"texto": "Un prompt que da instrucciones sin proporcionar ejemplos previos", "es_correcta": true}, {"texto": "Un prompt que solo usa números", "es_correcta": false}, {"texto": "Un prompt de una sola palabra", "es_correcta": false}]'::jsonb, 'Zero-shot significa dar instrucciones sin incluir ejemplos previos.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(243, 4, '¿Qué es un prompt few-shot?', '[{"texto": "Un prompt muy corto", "es_correcta": false}, {"texto": "Un prompt que incluye ejemplos del resultado esperado para guiar a la IA", "es_correcta": true}, {"texto": "Un prompt que falla varias veces", "es_correcta": false}, {"texto": "Un prompt que solo sirve para fotos", "es_correcta": false}]'::jsonb, 'Few-shot incluye uno o más ejemplos del resultado deseado.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(244, 4, '¿Cuándo es más útil usar few-shot en lugar de zero-shot?', '[{"texto": "Cuando tienes prisa", "es_correcta": false}, {"texto": "Cuando necesitas que la IA siga un formato o patrón específico", "es_correcta": true}, {"texto": "Cuando el prompt es muy largo", "es_correcta": false}, {"texto": "Cuando la tarea es muy simple", "es_correcta": false}]'::jsonb, 'Few-shot es útil cuando necesitas que la IA replique un formato o estructura específica.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(245, 4, '¿Qué es Prompt Chaining?', '[{"texto": "Encadenar la computadora al escritorio", "es_correcta": false}, {"texto": "Conectar varios prompts donde la salida de uno alimenta al siguiente", "es_correcta": true}, {"texto": "Escribir un prompt muy largo sin parar", "es_correcta": false}, {"texto": "Copiar el mismo prompt en varias herramientas", "es_correcta": false}]'::jsonb, 'Prompt Chaining es encadenar prompts secuenciales donde el resultado de cada paso sirve como entrada del siguiente.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(246, 4, '¿Cuál es una ventaja principal del Prompt Chaining?', '[{"texto": "Es más rápido que un solo prompt", "es_correcta": false}, {"texto": "Permite descomponer tareas complejas en pasos más manejables", "es_correcta": true}, {"texto": "Usa menos tokens", "es_correcta": false}, {"texto": "No requiere verificar los resultados", "es_correcta": false}]'::jsonb, 'El chaining permite dividir una tarea compleja en subtareas más simples.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(247, 4, 'En una cadena de 3 prompts para generar un reporte, ¿cuál sería un primer paso lógico?', '[{"texto": "Formatear el reporte final", "es_correcta": false}, {"texto": "Extraer y organizar los datos clave del tema", "es_correcta": true}, {"texto": "Agregar la firma del gerente", "es_correcta": false}, {"texto": "Imprimir el documento", "es_correcta": false}]'::jsonb, 'El primer paso suele ser recopilar y estructurar la información base.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(248, 4, '¿Qué diferencia a few-shot de dar instrucciones detalladas sin ejemplos?', '[{"texto": "No hay diferencia", "es_correcta": false}, {"texto": "Few-shot muestra el patrón con ejemplos concretos", "es_correcta": true}, {"texto": "Few-shot es siempre más corto", "es_correcta": false}, {"texto": "Few-shot solo funciona en inglés", "es_correcta": false}]'::jsonb, 'Few-shot usa ejemplos concretos para demostrar el patrón deseado.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(249, 4, '¿Cuántos ejemplos son típicamente suficientes en un prompt few-shot?', '[{"texto": "Al menos 50", "es_correcta": false}, {"texto": "2 a 5 ejemplos suelen ser suficientes", "es_correcta": true}, {"texto": "Solo 1 siempre", "es_correcta": false}, {"texto": "Más de 100", "es_correcta": false}]'::jsonb, 'Generalmente 2 a 5 ejemplos son suficientes.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(250, 4, 'Si necesitas clasificar quejas de clientes, ¿qué técnica usarías?', '[{"texto": "Zero-shot sin contexto", "es_correcta": false}, {"texto": "Few-shot con ejemplos de quejas ya clasificadas", "es_correcta": true}, {"texto": "Un prompt de una sola palabra", "es_correcta": false}, {"texto": "No se puede hacer con IA", "es_correcta": false}]'::jsonb, 'Para clasificación con categorías específicas, dar ejemplos es la técnica más efectiva.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(251, 4, '¿Cuál es el riesgo principal de una cadena de prompts muy larga?', '[{"texto": "Que Copilot se canse", "es_correcta": false}, {"texto": "Que los errores se acumulen y amplifiquen en cada paso", "es_correcta": true}, {"texto": "Que la cadena se rompa físicamente", "es_correcta": false}, {"texto": "No tiene riesgos", "es_correcta": false}]'::jsonb, 'En cadenas largas, un error temprano se propaga y amplifica.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(252, 4, '¿Qué debes hacer entre cada paso de un Prompt Chain?', '[{"texto": "Esperar 24 horas", "es_correcta": false}, {"texto": "Verificar que el resultado intermedio sea correcto", "es_correcta": true}, {"texto": "Reiniciar Copilot", "es_correcta": false}, {"texto": "Cambiar de idioma", "es_correcta": false}]'::jsonb, 'Es crucial verificar cada resultado intermedio antes de pasarlo al siguiente paso.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(253, 4, '¿Cuál es un buen caso de uso para Prompt Chaining en RRHH?', '[{"texto": "Responder un saludo", "es_correcta": false}, {"texto": "Analizar hojas de vida, extraer requisitos clave y generar evaluación comparativa", "es_correcta": true}, {"texto": "Encender la computadora", "es_correcta": false}, {"texto": "Enviar un emoji por Teams", "es_correcta": false}]'::jsonb, 'Encadenar pasos como analizar CVs, extraer habilidades y comparar contra requisitos.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(254, 4, '¿Qué patrón de encadenamiento analiza un problema desde múltiples perspectivas?', '[{"texto": "Cadena lineal simple", "es_correcta": false}, {"texto": "Cadena con ramificación: mismo input con diferentes prompts especializados", "es_correcta": true}, {"texto": "Repetir el mismo prompt", "es_correcta": false}, {"texto": "No existe ese patrón", "es_correcta": false}]'::jsonb, 'La ramificación procesa la misma información con diferentes prompts especializados y luego consolida.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(255, 4, 'Si un prompt zero-shot da resultados inconsistentes, ¿cuál es el siguiente paso?', '[{"texto": "Abandonar la tarea", "es_correcta": false}, {"texto": "Convertirlo a few-shot agregando 2-3 ejemplos del resultado esperado", "es_correcta": true}, {"texto": "Usar letras mayúsculas", "es_correcta": false}, {"texto": "Escribir el prompt más corto", "es_correcta": false}]'::jsonb, 'Agregar ejemplos (few-shot) ayuda a la IA a entender exactamente el patrón deseado.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(256, 4, '¿Qué elementos debe incluir un buen ejemplo en un prompt few-shot?', '[{"texto": "Solo la respuesta correcta", "es_correcta": false}, {"texto": "La entrada de ejemplo Y la salida esperada en el formato deseado", "es_correcta": true}, {"texto": "Solo la pregunta", "es_correcta": false}, {"texto": "Solo emojis", "es_correcta": false}]'::jsonb, 'Un buen ejemplo few-shot incluye tanto la entrada como la salida esperada en el formato deseado.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(257, 5, '¿Para qué sirven las estructuras XML en un prompt?', '[{"texto": "Para decorar el texto", "es_correcta": false}, {"texto": "Para organizar la información del prompt en secciones claras y etiquetadas", "es_correcta": true}, {"texto": "Para crear páginas web", "es_correcta": false}, {"texto": "Para encriptar el prompt", "es_correcta": false}]'::jsonb, 'Las etiquetas XML organizan el prompt en secciones claras que la IA puede procesar mejor.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(258, 5, '¿Qué es un template reutilizable de prompt?', '[{"texto": "Un prompt que solo se puede usar una vez", "es_correcta": false}, {"texto": "Una plantilla con campos variables que se adapta a diferentes situaciones", "es_correcta": true}, {"texto": "Un documento de Word", "es_correcta": false}, {"texto": "Un archivo de Excel", "es_correcta": false}]'::jsonb, 'Un template es una plantilla con estructura fija y campos variables que se rellenan según la necesidad.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(259, 5, '¿Qué es Shadow AI?', '[{"texto": "Una IA que trabaja de noche", "es_correcta": false}, {"texto": "El uso no autorizado de herramientas de IA por empleados", "es_correcta": true}, {"texto": "Una versión oscura de Copilot", "es_correcta": false}, {"texto": "Un juego de inteligencia artificial", "es_correcta": false}]'::jsonb, 'Shadow AI es cuando empleados usan herramientas de IA no aprobadas por la empresa.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(260, 5, '¿Cuál es una ventaja de usar JSON en prompts?', '[{"texto": "Se ve más bonito", "es_correcta": false}, {"texto": "Define la estructura exacta de datos que esperas como respuesta", "es_correcta": true}, {"texto": "Es más rápido de escribir", "es_correcta": false}, {"texto": "Solo funciona en inglés", "es_correcta": false}]'::jsonb, 'JSON permite especificar la estructura exacta de los datos que necesitas.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(261, 5, '¿Por qué Shadow AI es un riesgo para las empresas?', '[{"texto": "Porque consume mucha electricidad", "es_correcta": false}, {"texto": "Porque datos confidenciales pueden filtrarse a herramientas no controladas", "es_correcta": true}, {"texto": "Porque hace más lenta la red", "es_correcta": false}, {"texto": "Porque es ilegal usar IA", "es_correcta": false}]'::jsonb, 'Shadow AI expone datos corporativos a herramientas sin controles de seguridad.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(262, 5, '¿Qué etiqueta XML usarías para definir el rol de la IA?', '[{"texto": "<footer>", "es_correcta": false}, {"texto": "<rol> o <role>", "es_correcta": true}, {"texto": "<html>", "es_correcta": false}, {"texto": "<body>", "es_correcta": false}]'::jsonb, 'La etiqueta <rol> se usa para definir el personaje o expertise que la IA debe asumir.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(263, 5, '¿Cuál es un ejemplo de campo variable en un template XML?', '[{"texto": "La fecha de hoy", "es_correcta": false}, {"texto": "[NOMBRE_PROCESO] o {{cargo}} que se reemplaza en cada uso", "es_correcta": true}, {"texto": "El nombre de Copilot", "es_correcta": false}, {"texto": "Un número fijo", "es_correcta": false}]'::jsonb, 'Los campos variables son placeholders que el usuario reemplaza con datos específicos.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(264, 5, '¿Cómo combatir Shadow AI en una organización?', '[{"texto": "Prohibir todo uso de IA", "es_correcta": false}, {"texto": "Ofrecer herramientas de IA aprobadas y capacitar sobre su uso seguro", "es_correcta": true}, {"texto": "Ignorar el problema", "es_correcta": false}, {"texto": "Desconectar el internet", "es_correcta": false}]'::jsonb, 'La mejor estrategia es proveer herramientas aprobadas junto con capacitación.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(265, 5, '¿Qué ventaja tiene un prompt con estructura XML vs texto plano?', '[{"texto": "No hay diferencia", "es_correcta": false}, {"texto": "La IA puede distinguir claramente entre instrucciones, contexto y restricciones", "es_correcta": true}, {"texto": "Es más corto", "es_correcta": false}, {"texto": "Solo funciona en Chrome", "es_correcta": false}]'::jsonb, 'Las etiquetas XML crean separaciones claras que ayudan a la IA.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(266, 5, 'Si necesitas datos en formato tabla, ¿qué estructura usarías?', '[{"texto": "Solo pedir dame una tabla", "es_correcta": false}, {"texto": "Especificar las columnas en un formato JSON o XML con la estructura deseada", "es_correcta": true}, {"texto": "Enviar un dibujo de la tabla", "es_correcta": false}, {"texto": "No es posible obtener tablas de Copilot", "es_correcta": false}]'::jsonb, 'Definir las columnas explícitamente asegura que la IA devuelva los datos como los necesitas.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(267, 5, '¿Qué riesgo implica usar ChatGPT público para documentos internos?', '[{"texto": "Ninguno, es completamente seguro", "es_correcta": false}, {"texto": "Los datos podrían usarse para entrenar el modelo y quedar expuestos", "es_correcta": true}, {"texto": "ChatGPT rechaza documentos empresariales", "es_correcta": false}, {"texto": "Solo es riesgoso con imágenes", "es_correcta": false}]'::jsonb, 'Las herramientas públicas pueden usar los datos enviados para entrenamiento.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(268, 5, '¿Cuál es la estructura correcta de un template XML para descripciones de cargo?', '[{"texto": "Solo el título del cargo", "es_correcta": false}, {"texto": "<prompt><rol>Experto RRHH</rol><instrucciones>Genera descripción</instrucciones><variables>[CARGO]</variables></prompt>", "es_correcta": true}, {"texto": "Un párrafo sin estructura", "es_correcta": false}, {"texto": "Solo una lista de requisitos", "es_correcta": false}]'::jsonb, 'Un template XML bien estructurado incluye rol, instrucciones, variables y formato de salida.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(269, 5, '¿Por qué es importante que un template sea comprensible para no técnicos?', '[{"texto": "No es importante", "es_correcta": false}, {"texto": "Para que cualquier miembro del equipo pueda usarlo sin conocimiento de programación", "es_correcta": true}, {"texto": "Porque las personas técnicas no usan Copilot", "es_correcta": false}, {"texto": "Solo por estética", "es_correcta": false}]'::jsonb, 'Un template accesible democratiza el uso de IA en el equipo.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(270, 5, '¿Qué señal indica que podría haber Shadow AI en tu equipo?', '[{"texto": "Los empleados piden más monitores", "es_correcta": false}, {"texto": "Empleados comparten resultados sospechosamente perfectos sin explicar cómo los generaron", "es_correcta": true}, {"texto": "La red es lenta", "es_correcta": false}, {"texto": "Hay más reuniones de lo normal", "es_correcta": false}]'::jsonb, 'Si los resultados son inusualmente buenos sin proceso visible, puede ser Shadow AI.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(271, 5, '¿Qué significa que JSON sea un formato estructurado?', '[{"texto": "Que es muy grande", "es_correcta": false}, {"texto": "Que organiza datos en pares clave-valor con jerarquía definida", "es_correcta": true}, {"texto": "Que solo puede tener texto", "es_correcta": false}, {"texto": "Que es un lenguaje de programación completo", "es_correcta": false}]'::jsonb, 'JSON organiza datos en pares clave-valor con jerarquía clara.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(272, 6, '¿Qué puede crear Copilot en Microsoft Designer?', '[{"texto": "Solo documentos de texto", "es_correcta": false}, {"texto": "Imágenes, logos, banners e infografías", "es_correcta": true}, {"texto": "Solo hojas de cálculo", "es_correcta": false}, {"texto": "Solo presentaciones", "es_correcta": false}]'::jsonb, 'Microsoft Designer con Copilot genera imágenes, logos, banners e infografías.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(273, 6, '¿Qué debe incluir un buen prompt para generar una imagen?', '[{"texto": "Solo una palabra como bonito", "es_correcta": false}, {"texto": "Descripción del contenido, estilo visual, colores y composición", "es_correcta": true}, {"texto": "Solo el tamaño en píxeles", "es_correcta": false}, {"texto": "El nombre del archivo de salida", "es_correcta": false}]'::jsonb, 'Un prompt de imagen describe qué mostrar, el estilo, colores y composición.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(274, 6, '¿Cómo puede Copilot ayudar a crear presentaciones en PowerPoint?', '[{"texto": "Solo puede agregar texto", "es_correcta": false}, {"texto": "Puede generar diapositivas completas con estructura, contenido y diseño", "es_correcta": true}, {"texto": "Solo cambia los colores", "es_correcta": false}, {"texto": "Solo agrega animaciones", "es_correcta": false}]'::jsonb, 'Copilot en PowerPoint genera diapositivas con estructura, contenido y diseño visual.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(275, 6, '¿Para qué sirve Copilot en Microsoft Forms?', '[{"texto": "Solo para ver formularios existentes", "es_correcta": false}, {"texto": "Para generar formularios y encuestas a partir de una descripción", "es_correcta": true}, {"texto": "Solo para borrar formularios", "es_correcta": false}, {"texto": "No funciona con Forms", "es_correcta": false}]'::jsonb, 'Copilot genera formularios completos incluyendo preguntas y opciones.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(276, 6, '¿Qué herramienta de Microsoft usarías con Copilot para crear videos?', '[{"texto": "Excel", "es_correcta": false}, {"texto": "Clipchamp o Microsoft 365 Video Editor", "es_correcta": true}, {"texto": "Bloc de notas", "es_correcta": false}, {"texto": "Calculadora", "es_correcta": false}]'::jsonb, 'Clipchamp es la herramienta de edición de video de Microsoft.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(277, 6, '¿Qué es importante al generar imágenes para uso corporativo?', '[{"texto": "Nada, cualquier imagen sirve", "es_correcta": false}, {"texto": "Verificar que sea apropiada, sin sesgos y cumpla con guías de marca", "es_correcta": true}, {"texto": "Solo el tamaño importa", "es_correcta": false}, {"texto": "Que tenga muchos colores", "es_correcta": false}]'::jsonb, 'Las imágenes deben revisarse para asegurar que sean apropiadas y alineadas con la marca.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(278, 6, '¿Cuántas diapositivas es razonable pedir a Copilot como punto de partida?', '[{"texto": "Mínimo 100", "es_correcta": false}, {"texto": "5-10 diapositivas que luego se refinan", "es_correcta": true}, {"texto": "Solo 1", "es_correcta": false}, {"texto": "Exactamente 50", "es_correcta": false}]'::jsonb, 'Es recomendable generar 5-10 diapositivas como borrador y refinarlas.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(279, 6, '¿Qué formato es más efectivo para una infografía con Copilot?', '[{"texto": "Un párrafo largo de texto", "es_correcta": false}, {"texto": "Datos clave en puntos breves con jerarquía visual clara", "es_correcta": true}, {"texto": "Solo una imagen sin texto", "es_correcta": false}, {"texto": "Solo números sin contexto", "es_correcta": false}]'::jsonb, 'Las infografías efectivas combinan datos breves, íconos, gráficos y jerarquía visual.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(280, 6, '¿Cuál es el flujo creativo recomendado con Copilot?', '[{"texto": "Generar y publicar sin revisar", "es_correcta": false}, {"texto": "Prompt, generar borrador, revisar, iterar, finalizar", "es_correcta": true}, {"texto": "Copiar de internet", "es_correcta": false}, {"texto": "Solo usar templates predefinidos", "es_correcta": false}]'::jsonb, 'El flujo creativo con IA es iterativo.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(281, 6, '¿Qué debes documentar al crear contenido visual con Copilot?', '[{"texto": "Nada, la IA lo recuerda todo", "es_correcta": false}, {"texto": "Los prompts usados para poder reproducir o iterar", "es_correcta": true}, {"texto": "Solo la fecha de creación", "es_correcta": false}, {"texto": "El nombre del computador usado", "es_correcta": false}]'::jsonb, 'Documentar los prompts permite reproducir resultados exitosos.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(282, 6, '¿Qué limitación tiene Copilot al generar imágenes?', '[{"texto": "No tiene ninguna limitación", "es_correcta": false}, {"texto": "Puede no capturar detalles muy específicos y requiere iteración", "es_correcta": true}, {"texto": "Solo genera en blanco y negro", "es_correcta": false}, {"texto": "Solo genera imágenes de animales", "es_correcta": false}]'::jsonb, 'La generación de imágenes tiene limitaciones en detalles finos y requiere iteración.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(283, 6, '¿Cómo puedes mejorar una presentación generada por Copilot?', '[{"texto": "No se puede mejorar", "es_correcta": false}, {"texto": "Revisar contenido, ajustar diseño, agregar datos específicos y refinar", "es_correcta": true}, {"texto": "Agregar más diapositivas sin revisar", "es_correcta": false}, {"texto": "Solo cambiar el fondo", "es_correcta": false}]'::jsonb, 'El borrador de Copilot siempre debe refinarse manualmente.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(284, 6, '¿Qué estilo de imagen es más apropiado para comunicación corporativa?', '[{"texto": "Memes de internet", "es_correcta": false}, {"texto": "Estilo profesional, limpio, alineado con la identidad visual de la empresa", "es_correcta": true}, {"texto": "Estilo anime", "es_correcta": false}, {"texto": "Imágenes pixeladas retro", "es_correcta": false}]'::jsonb, 'Para comunicación corporativa, las imágenes deben ser profesionales y coherentes con la marca.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(285, 6, '¿Qué es un kit de comunicación creado con Copilot?', '[{"texto": "Un teléfono corporativo", "es_correcta": false}, {"texto": "Un conjunto de piezas visuales (imágenes, presentación, infografía) sobre un mismo tema", "es_correcta": true}, {"texto": "Un manual de Copilot impreso", "es_correcta": false}, {"texto": "Una lista de emails", "es_correcta": false}]'::jsonb, 'Un kit de comunicación es un conjunto coordinado de materiales visuales sobre un tema.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(286, 6, '¿Cuál es la ventaja de crear formularios con Copilot vs manualmente?', '[{"texto": "Son más bonitos automáticamente", "es_correcta": false}, {"texto": "Copilot genera la estructura y preguntas iniciales rápidamente", "es_correcta": true}, {"texto": "Son gratis vs los manuales que son pagos", "es_correcta": false}, {"texto": "Los manuales no funcionan", "es_correcta": false}]'::jsonb, 'Copilot acelera la creación generando la estructura base que luego se refina.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(287, 7, '¿Qué es un agente de IA en el contexto de Copilot?', '[{"texto": "Un empleado que trabaja con IA", "es_correcta": false}, {"texto": "Un asistente automatizado especializado en una tarea con instrucciones predefinidas", "es_correcta": true}, {"texto": "Un programa antivirus", "es_correcta": false}, {"texto": "Un chatbot genérico sin configuración", "es_correcta": false}]'::jsonb, 'Un agente de IA es un asistente configurado con instrucciones específicas para tareas especializadas.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(288, 7, '¿Qué es una instrucción maestra al crear un agente?', '[{"texto": "Un título decorativo", "es_correcta": false}, {"texto": "La instrucción base que define el rol, comportamiento y límites del agente", "es_correcta": true}, {"texto": "Una contraseña", "es_correcta": false}, {"texto": "Un manual de usuario impreso", "es_correcta": false}]'::jsonb, 'La instrucción maestra define quién es el agente, qué sabe y cómo debe responder.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(289, 7, '¿Cuál es un caso de uso práctico de un agente de IA en RRHH?', '[{"texto": "Reemplazar al gerente de RRHH", "es_correcta": false}, {"texto": "Un asistente de onboarding que responde preguntas frecuentes de nuevos empleados", "es_correcta": true}, {"texto": "Un robot que entrega documentos físicos", "es_correcta": false}, {"texto": "Un sistema de vigilancia", "es_correcta": false}]'::jsonb, 'Un agente de onboarding puede responder preguntas y guiar a nuevos empleados 24/7.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(290, 7, '¿Cuántas instrucciones base debería tener un agente bien configurado?', '[{"texto": "Solo 1", "es_correcta": false}, {"texto": "Al menos 3 instrucciones que definan su comportamiento clave", "es_correcta": true}, {"texto": "Más de 100", "es_correcta": false}, {"texto": "No necesita instrucciones", "es_correcta": false}]'::jsonb, 'Al menos 3 instrucciones base que definan su rol, alcance y forma de responder.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(291, 7, '¿Cómo puede Copilot ayudar con Excel?', '[{"texto": "Solo puede abrir archivos", "es_correcta": false}, {"texto": "Puede analizar datos, crear fórmulas, generar gráficos y resumir tendencias", "es_correcta": true}, {"texto": "Solo puede cambiar colores", "es_correcta": false}, {"texto": "Solo funciona con tablas de una fila", "es_correcta": false}]'::jsonb, 'Copilot en Excel puede analizar datos, sugerir fórmulas y crear visualizaciones.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(292, 7, '¿Qué diferencia a un agente de un prompt individual?', '[{"texto": "Son lo mismo", "es_correcta": false}, {"texto": "El agente tiene contexto persistente, instrucciones base y especialización", "es_correcta": true}, {"texto": "El agente es más lento", "es_correcta": false}, {"texto": "El prompt es más inteligente", "es_correcta": false}]'::jsonb, 'Un agente mantiene instrucciones permanentes y contexto especializado.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(293, 7, '¿Qué tipo de tarea es ideal para automatizar con un agente?', '[{"texto": "Tareas que se hacen una sola vez", "es_correcta": false}, {"texto": "Tareas repetitivas con patrones predecibles", "es_correcta": true}, {"texto": "Tareas que requieren creatividad única", "es_correcta": false}, {"texto": "Decisiones legales críticas", "es_correcta": false}]'::jsonb, 'Los agentes son ideales para tareas repetitivas y predecibles.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(294, 7, '¿Qué sucede si un agente recibe una consulta fuera de su especialización?', '[{"texto": "Inventa una respuesta", "es_correcta": false}, {"texto": "Debería indicar que está fuera de su alcance y redirigir", "es_correcta": true}, {"texto": "Se apaga automáticamente", "es_correcta": false}, {"texto": "Borra la conversación", "es_correcta": false}]'::jsonb, 'Un agente bien configurado reconoce los límites de su especialización.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(295, 7, '¿Qué significa gobernanza de identidad en agentes de IA?', '[{"texto": "Crear tarjetas de identidad para robots", "es_correcta": false}, {"texto": "Definir y controlar quién puede crear, modificar y usar agentes", "es_correcta": true}, {"texto": "Verificar identidad de usuarios de internet", "es_correcta": false}, {"texto": "Un protocolo de passwords", "es_correcta": false}]'::jsonb, 'La gobernanza define quién puede crear, configurar y acceder a agentes.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(296, 7, '¿Qué pregunta debes hacerte antes de crear un agente?', '[{"texto": "¿Qué color le pongo?", "es_correcta": false}, {"texto": "¿Qué problema repetitivo resuelve y quién lo usará?", "es_correcta": true}, {"texto": "¿Cuántos agentes tienen otras empresas?", "es_correcta": false}, {"texto": "¿Cuánto cuesta?", "es_correcta": false}]'::jsonb, 'Define el problema específico y los usuarios para configurar apropiadamente.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(297, 7, '¿Cuál es un beneficio de usar Copilot para analizar datos en Excel?', '[{"texto": "Los datos se borran después", "es_correcta": false}, {"texto": "Puede identificar tendencias y patrones que tomarían horas encontrar manualmente", "es_correcta": true}, {"texto": "Solo funciona con datos de ventas", "es_correcta": false}, {"texto": "Hace los gráficos más coloridos", "es_correcta": false}]'::jsonb, 'Copilot puede identificar tendencias y patrones rápidamente.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(298, 7, '¿Qué incluye el catálogo de casos de uso para agentes en RRHH?', '[{"texto": "Una lista de precios", "es_correcta": false}, {"texto": "Escenarios específicos donde los agentes pueden automatizar procesos de Talento Humano", "es_correcta": true}, {"texto": "Un directorio de empleados", "es_correcta": false}, {"texto": "Las vacaciones del equipo", "es_correcta": false}]'::jsonb, 'El catálogo documenta escenarios como onboarding, FAQs, evaluaciones donde los agentes aportan valor.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(299, 7, '¿Cómo se prueba un agente antes de desplegarlo?', '[{"texto": "No es necesario probarlo", "es_correcta": false}, {"texto": "Hacerle consultas reales de prueba y verificar que las respuestas sean correctas", "es_correcta": true}, {"texto": "Solo revisar la instrucción maestra", "es_correcta": false}, {"texto": "Pedirle que se pruebe a sí mismo", "es_correcta": false}]'::jsonb, 'Probar implica hacerle consultas reales y verificar calidad de respuestas.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(300, 7, '¿Qué debe hacer un agente cuando no tiene suficiente información?', '[{"texto": "Inventar la información", "es_correcta": false}, {"texto": "Pedir al usuario la información adicional que necesita", "es_correcta": true}, {"texto": "Dar una respuesta genérica", "es_correcta": false}, {"texto": "Terminar la conversación", "es_correcta": false}]'::jsonb, 'Un agente bien diseñado solicita la información faltante.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(301, 7, '¿Qué pasa si la instrucción maestra es demasiado vaga?', '[{"texto": "Funciona mejor con más libertad", "es_correcta": false}, {"texto": "El agente da respuestas inconsistentes e impredecibles", "es_correcta": true}, {"texto": "El agente se apaga", "es_correcta": false}, {"texto": "No afecta su funcionamiento", "es_correcta": false}]'::jsonb, 'Una instrucción vaga produce respuestas inconsistentes.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(317, 8, '¿Qué framework aprendiste para estructurar prompts profesionales?', '[{"texto": "HTML", "es_correcta": false}, {"texto": "GOCE (Goal, Output, Context, Extras)", "es_correcta": true}, {"texto": "SCRUM", "es_correcta": false}, {"texto": "SQL", "es_correcta": false}]'::jsonb, 'GOCE es el framework para diseñar prompts con objetivo, formato, contexto y extras.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(318, 8, '¿Cuál es la diferencia principal entre zero-shot y few-shot?', '[{"texto": "Zero-shot es más lento", "es_correcta": false}, {"texto": "Few-shot incluye ejemplos del resultado esperado, zero-shot no", "es_correcta": true}, {"texto": "Zero-shot es más preciso", "es_correcta": false}, {"texto": "No hay diferencia", "es_correcta": false}]'::jsonb, 'Few-shot proporciona ejemplos concretos; zero-shot confía solo en instrucciones.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(319, 8, '¿Qué es el blindaje de datos en prompting?', '[{"texto": "Encriptar la computadora", "es_correcta": false}, {"texto": "Establecer restricciones explícitas sobre lo que la IA no debe incluir", "es_correcta": true}, {"texto": "Instalar un antivirus", "es_correcta": false}, {"texto": "Usar una VPN", "es_correcta": false}]'::jsonb, 'El blindaje son instrucciones que protegen información sensible.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(320, 8, '¿Para qué sirve Prompt Chaining?', '[{"texto": "Para hacer prompts más cortos", "es_correcta": false}, {"texto": "Para descomponer tareas complejas en pasos secuenciales conectados", "es_correcta": true}, {"texto": "Para encadenar computadoras", "es_correcta": false}, {"texto": "Para repetir el mismo prompt", "es_correcta": false}]'::jsonb, 'Prompt Chaining divide tareas complejas en pasos conectados.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(321, 8, '¿Qué es Shadow AI y por qué es un riesgo empresarial?', '[{"texto": "Un tipo de virus", "es_correcta": false}, {"texto": "El uso no autorizado de herramientas de IA que puede filtrar datos corporativos", "es_correcta": true}, {"texto": "Una marca de IA", "es_correcta": false}, {"texto": "Un método de programación", "es_correcta": false}]'::jsonb, 'Shadow AI expone datos corporativos a herramientas sin controles de seguridad.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(322, 8, '¿Cómo funcionan las estructuras XML en un prompt?', '[{"texto": "Son decorativas", "es_correcta": false}, {"texto": "Organizan el prompt en secciones etiquetadas que la IA identifica claramente", "es_correcta": true}, {"texto": "Solo sirven para páginas web", "es_correcta": false}, {"texto": "Encriptan el prompt", "es_correcta": false}]'::jsonb, 'Las etiquetas XML separan claramente cada componente del prompt.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(323, 8, '¿Qué puede crear Copilot en términos de contenido visual?', '[{"texto": "Solo texto plano", "es_correcta": false}, {"texto": "Imágenes, presentaciones, infografías, formularios y videos", "es_correcta": true}, {"texto": "Solo impresiones en papel", "es_correcta": false}, {"texto": "Solo códigos QR", "es_correcta": false}]'::jsonb, 'Copilot genera diversos tipos de contenido visual.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(324, 8, '¿Qué es un agente de IA y cómo se diferencia de un prompt individual?', '[{"texto": "Son lo mismo", "es_correcta": false}, {"texto": "Un agente tiene instrucciones permanentes y especialización; un prompt es puntual", "es_correcta": true}, {"texto": "Un agente es más lento", "es_correcta": false}, {"texto": "Un prompt es más inteligente", "es_correcta": false}]'::jsonb, 'Un agente mantiene instrucciones permanentes y contexto especializado.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(325, 8, '¿Cuál es el componente más importante al configurar un agente?', '[{"texto": "El nombre del agente", "es_correcta": false}, {"texto": "La instrucción maestra que define su rol, comportamiento y límites", "es_correcta": true}, {"texto": "El color de su interfaz", "es_correcta": false}, {"texto": "La velocidad de respuesta", "es_correcta": false}]'::jsonb, 'La instrucción maestra es fundamental para el comportamiento del agente.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(326, 8, '¿Qué debes hacer antes de anonimizar datos en un prompt?', '[{"texto": "Nada, la IA los anonimiza sola", "es_correcta": false}, {"texto": "Identificar todos los datos personales y sensibles presentes", "es_correcta": true}, {"texto": "Enviar los datos sin cambios", "es_correcta": false}, {"texto": "Pedir permiso a Copilot", "es_correcta": false}]'::jsonb, 'Identifica todos los datos personales antes de anonimizar.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(327, 8, '¿Cuántas pruebas modulares debes aprobar para obtener el certificado?', '[{"texto": "3", "es_correcta": false}, {"texto": "7", "es_correcta": true}, {"texto": "5", "es_correcta": false}, {"texto": "Solo el diagnóstico final", "es_correcta": false}]'::jsonb, 'Debes aprobar las 7 pruebas modulares.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(328, 8, '¿Qué es la iteración en el contexto de trabajo con IA?', '[{"texto": "Hacer todo de una sola vez", "es_correcta": false}, {"texto": "Refinar progresivamente los resultados basándose en evaluación", "es_correcta": true}, {"texto": "Copiar y pegar respuestas", "es_correcta": false}, {"texto": "Cambiar de herramienta cada vez", "es_correcta": false}]'::jsonb, 'La iteración es evaluar y refinar progresivamente.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(329, 8, '¿Cómo contribuye la IA a la extensión de capacidades laborales?', '[{"texto": "Reemplazando tus habilidades", "es_correcta": false}, {"texto": "Amplificando tus habilidades para que hagas más con menos tiempo", "es_correcta": true}, {"texto": "Solo automatizando tareas simples", "es_correcta": false}, {"texto": "No contribuye, es una moda", "es_correcta": false}]'::jsonb, 'La IA amplifica tus capacidades, permitiéndote ser más productivo.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(330, 8, '¿Qué tareas son más apropiadas para automatizar con agentes?', '[{"texto": "Decisiones estratégicas de alto nivel", "es_correcta": false}, {"texto": "Tareas repetitivas con patrones predecibles", "es_correcta": true}, {"texto": "Negociaciones con clientes", "es_correcta": false}, {"texto": "Entrevistas de trabajo", "es_correcta": false}]'::jsonb, 'Los agentes son ideales para tareas repetitivas y predecibles.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(331, 8, '¿Qué herramienta usarías para crear una presentación profesional rápidamente?', '[{"texto": "Excel", "es_correcta": false}, {"texto": "Copilot en PowerPoint", "es_correcta": true}, {"texto": "Bloc de notas", "es_correcta": false}, {"texto": "La calculadora", "es_correcta": false}]'::jsonb, 'Copilot en PowerPoint genera presentaciones completas.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(332, 8, '¿Cuál es la mejor estrategia cuando un prompt no da el resultado esperado?', '[{"texto": "Repetir el mismo prompt", "es_correcta": false}, {"texto": "Analizar qué faltó, agregar contexto o restricciones y reformular", "es_correcta": true}, {"texto": "Abandonar y hacerlo manualmente", "es_correcta": false}, {"texto": "Cambiar de herramienta", "es_correcta": false}]'::jsonb, 'La iteración efectiva implica analizar la brecha y ajustar el prompt.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(333, 8, '¿Qué significa que Copilot empresarial mantiene los datos dentro del tenant?', '[{"texto": "Se almacenan en nube pública", "es_correcta": false}, {"texto": "La información no sale del entorno protegido de Microsoft 365 de tu empresa", "es_correcta": true}, {"texto": "Se guardan en tu computador local", "es_correcta": false}, {"texto": "Se comparten con otras empresas", "es_correcta": false}]'::jsonb, 'Los datos procesados por Copilot empresarial no salen del tenant de tu empresa.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(334, 8, '¿Qué protocolo aprendiste para proteger datos sensibles al usar IA?', '[{"texto": "Protocolo HTTP", "es_correcta": false}, {"texto": "Protocolo de anonimización: reemplazar datos personales por genéricos", "es_correcta": true}, {"texto": "Protocolo TCP/IP", "es_correcta": false}, {"texto": "No existe ningún protocolo", "es_correcta": false}]'::jsonb, 'La anonimización consiste en reemplazar datos sensibles por genéricos.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(335, 8, '¿Cuál es una habilidad clave para el futuro profesional según lo aprendido?', '[{"texto": "Memorizar datos", "es_correcta": false}, {"texto": "Saber diseñar buenos prompts y evaluar críticamente los resultados de la IA", "es_correcta": true}, {"texto": "Programar en Python", "es_correcta": false}, {"texto": "Usar solo Microsoft Word", "es_correcta": false}]'::jsonb, 'El prompt engineering y el pensamiento crítico son habilidades fundamentales.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(336, 8, '¿Qué tipo de formato estructurado aprendiste para instrucciones complejas?', '[{"texto": "Formato PDF", "es_correcta": false}, {"texto": "Estructuras XML y JSON con etiquetas y pares clave-valor", "es_correcta": true}, {"texto": "Formato ZIP", "es_correcta": false}, {"texto": "Formato MP3", "es_correcta": false}]'::jsonb, 'XML y JSON permiten organizar instrucciones complejas para la IA.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(337, 8, '¿Cuántos retos deben completarse para obtener la certificación?', '[{"texto": "3", "es_correcta": false}, {"texto": "6 retos (uno por módulo 1-6)", "es_correcta": true}, {"texto": "Solo 1 reto final", "es_correcta": false}, {"texto": "No hay retos obligatorios", "es_correcta": false}]'::jsonb, 'Se deben completar los 6 retos de los módulos 1-6.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(338, 8, '¿Qué aprendiste sobre la IA para tu vida personal?', '[{"texto": "La IA solo sirve para el trabajo", "es_correcta": false}, {"texto": "La IA puede ayudar en aprendizaje, finanzas, salud, viajes y creatividad", "es_correcta": true}, {"texto": "Solo puede usarse con licencia empresarial", "es_correcta": false}, {"texto": "Es peligrosa para uso personal", "es_correcta": false}]'::jsonb, 'La IA tiene aplicaciones valiosas para la vida personal.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(339, 8, '¿Qué principio fundamental rige el uso responsable de IA?', '[{"texto": "Automatizar todo sin supervisión", "es_correcta": false}, {"texto": "El control humano: la IA asiste, pero las personas deciden y verifican", "es_correcta": true}, {"texto": "Confiar ciegamente en la IA", "es_correcta": false}, {"texto": "Usar IA solo cuando no haya alternativa humana", "es_correcta": false}]'::jsonb, 'El principio fundamental es el control humano: la IA es una herramienta, las decisiones son humanas.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(302, 11, '¿Cuál es una aplicación práctica de la IA para uso personal?', '[{"texto": "La IA solo sirve para el trabajo", "es_correcta": false}, {"texto": "Planificar viajes, aprender idiomas, organizar finanzas y gestionar salud", "es_correcta": true}, {"texto": "Solo para jugar videojuegos", "es_correcta": false}, {"texto": "Solo para redes sociales", "es_correcta": false}]'::jsonb, 'La IA tiene muchas aplicaciones personales.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(303, 11, '¿Cómo puede Copilot ayudarte a aprender un nuevo tema?', '[{"texto": "No puede ayudar con aprendizaje", "es_correcta": false}, {"texto": "Puede explicar conceptos, crear planes de estudio y responder dudas", "es_correcta": true}, {"texto": "Solo puede buscar en Wikipedia", "es_correcta": false}, {"texto": "Solo repite información sin explicar", "es_correcta": false}]'::jsonb, 'Copilot puede actuar como tutor personal.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(304, 11, '¿Qué tendencia define el futuro cercano de la IA?', '[{"texto": "La IA va a desaparecer pronto", "es_correcta": false}, {"texto": "Mayor integración en herramientas cotidianas y personalización", "es_correcta": true}, {"texto": "Será exclusiva para programadores", "es_correcta": false}, {"texto": "Los robots reemplazarán todos los trabajos en 2027", "es_correcta": false}]'::jsonb, 'La tendencia es mayor integración y personalización.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(305, 11, '¿Cuál es una herramienta de IA accesible para productividad personal?', '[{"texto": "Solo herramientas empresariales costosas", "es_correcta": false}, {"texto": "Copilot, ChatGPT, Gemini u otros asistentes accesibles", "es_correcta": true}, {"texto": "Solo calculadoras científicas", "es_correcta": false}, {"texto": "No existen herramientas accesibles", "es_correcta": false}]'::jsonb, 'Existen múltiples herramientas de IA accesibles.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(306, 11, '¿Cómo puede la IA ayudar con finanzas personales?', '[{"texto": "Gestionando tu cuenta bancaria directamente", "es_correcta": false}, {"texto": "Ayudando a crear presupuestos, analizar gastos y planificar ahorro", "es_correcta": true}, {"texto": "Invirtiendo dinero automáticamente", "es_correcta": false}, {"texto": "Generando dinero", "es_correcta": false}]'::jsonb, 'La IA puede asistir en presupuestos, categorizar gastos e identificar patrones.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(307, 11, '¿Qué precaución debes tener al usar IA para temas de salud?', '[{"texto": "Ninguna, la IA es 100% precisa en salud", "es_correcta": false}, {"texto": "Usarla como complemento informativo, nunca como reemplazo del médico", "es_correcta": true}, {"texto": "Solo usarla para emergencias", "es_correcta": false}, {"texto": "No puede ayudar con salud", "es_correcta": false}]'::jsonb, 'La IA nunca debe reemplazar el consejo de un profesional médico.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(308, 11, '¿Qué es la IA multimodal?', '[{"texto": "IA que solo funciona en un dispositivo", "es_correcta": false}, {"texto": "IA que puede procesar y generar texto, imágenes, audio y video", "es_correcta": true}, {"texto": "IA con múltiples passwords", "es_correcta": false}, {"texto": "IA exclusiva para multinacionales", "es_correcta": false}]'::jsonb, 'La IA multimodal procesa múltiples tipos de contenido de forma integrada.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(309, 11, '¿Cómo puede la IA ayudar en la planificación de un viaje?', '[{"texto": "Solo buscando vuelos baratos", "es_correcta": false}, {"texto": "Creando itinerarios personalizados, sugiriendo actividades y presupuesto", "es_correcta": true}, {"texto": "Solo traduciendo menús", "es_correcta": false}, {"texto": "Solo tomando fotos del viaje", "es_correcta": false}]'::jsonb, 'La IA puede crear itinerarios basados en preferencias, presupuesto y duración.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(310, 11, '¿Qué habilidad será más valiosa en un futuro con IA ubicua?', '[{"texto": "Memorizar grandes cantidades de datos", "es_correcta": false}, {"texto": "Saber formular buenas preguntas y evaluar críticamente las respuestas", "es_correcta": true}, {"texto": "Tipear rápido", "es_correcta": false}, {"texto": "Usar solo una herramienta específica", "es_correcta": false}]'::jsonb, 'El pensamiento crítico será la habilidad clave.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(311, 11, '¿Cuál es una tendencia emergente en IA para 2025-2026?', '[{"texto": "Las empresas abandonan la IA", "es_correcta": false}, {"texto": "Agentes autónomos que completan tareas complejas con mínima supervisión", "es_correcta": true}, {"texto": "Solo funcionará en computadores nuevos", "es_correcta": false}, {"texto": "Se prohibirá el uso de IA", "es_correcta": false}]'::jsonb, 'Los agentes autónomos son una de las tendencias más importantes.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(312, 11, '¿Cómo puede la IA ayudar con el aprendizaje de idiomas?', '[{"texto": "Solo traduciendo palabras", "es_correcta": false}, {"texto": "Practicando conversación, corrigiendo gramática y creando ejercicios", "es_correcta": true}, {"texto": "Solo repitiendo frases", "es_correcta": false}, {"texto": "No puede ayudar con idiomas", "es_correcta": false}]'::jsonb, 'La IA puede ser un tutor de idiomas versátil.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(313, 11, '¿Qué ventaja tiene usar IA para organizar tu agenda?', '[{"texto": "La IA decide por ti qué hacer", "es_correcta": false}, {"texto": "Puede priorizar tareas, sugerir bloques de tiempo y optimizar tu horario", "es_correcta": true}, {"texto": "Solo muestra la fecha y hora", "es_correcta": false}, {"texto": "Elimina todas tus reuniones", "es_correcta": false}]'::jsonb, 'La IA puede analizar compromisos y sugerir organización óptima.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(314, 11, '¿Qué es importante sobre la privacidad al usar IA personal?', '[{"texto": "La IA nunca almacena datos", "es_correcta": false}, {"texto": "Revisar políticas de privacidad y ser selectivo con la información", "es_correcta": true}, {"texto": "Compartir toda tu información mejora las respuestas", "es_correcta": false}, {"texto": "La privacidad no importa en herramientas gratuitas", "es_correcta": false}]'::jsonb, 'Debes revisar políticas de privacidad y ser selectivo con los datos que compartes.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(315, 11, '¿Cómo puede la IA ayudar en proyectos creativos personales?', '[{"texto": "No puede ayudar con creatividad", "es_correcta": false}, {"texto": "Generando ideas, borradores, diseños y contenido como punto de partida", "es_correcta": true}, {"texto": "Solo copiando contenido de internet", "es_correcta": false}, {"texto": "Solo con proyectos de texto", "es_correcta": false}]'::jsonb, 'La IA puede generar ideas y borradores como punto de partida que luego personalizas.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(316, 11, '¿Cuál es el mayor beneficio de dominar herramientas de IA para tu carrera?', '[{"texto": "Poder reemplazar a todos tus compañeros", "es_correcta": false}, {"texto": "Amplificar tu productividad y valor como profesional", "es_correcta": true}, {"texto": "No tener que aprender nada más", "es_correcta": false}, {"texto": "Poder trabajar menos horas", "es_correcta": false}]'::jsonb, 'Dominar la IA amplifica tu impacto profesional.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(227, 12, '¿Qué significa la G en el framework GOCE?', '[{"texto": "Generar", "es_correcta": false}, {"texto": "Goal (Objetivo)", "es_correcta": true}, {"texto": "Grupo", "es_correcta": false}, {"texto": "Gráfico", "es_correcta": false}]'::jsonb, 'En GOCE, la G representa Goal (Objetivo): lo que quieres lograr con tu prompt.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(228, 12, '¿Cuál es el propósito del blindaje en un prompt?', '[{"texto": "Hacer el prompt más largo", "es_correcta": false}, {"texto": "Establecer restricciones claras sobre lo que la IA NO debe hacer", "es_correcta": true}, {"texto": "Decorar el prompt con formato", "es_correcta": false}, {"texto": "Traducir el prompt a otro idioma", "es_correcta": false}]'::jsonb, 'El blindaje establece límites y restricciones claras para controlar la salida de la IA.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(229, 12, '¿Qué es el protocolo de anonimización al usar Copilot?', '[{"texto": "Crear una cuenta anónima", "es_correcta": false}, {"texto": "Reemplazar datos personales y sensibles antes de incluirlos en un prompt", "es_correcta": true}, {"texto": "Usar Copilot sin iniciar sesión", "es_correcta": false}, {"texto": "Borrar el historial de conversaciones", "es_correcta": false}]'::jsonb, 'La anonimización consiste en reemplazar nombres, cifras y datos sensibles por genéricos antes de enviarlos a la IA.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(230, 12, 'En el framework GOCE, ¿qué representa la C?', '[{"texto": "Código", "es_correcta": false}, {"texto": "Context (Contexto)", "es_correcta": true}, {"texto": "Copilot", "es_correcta": false}, {"texto": "Comunicación", "es_correcta": false}]'::jsonb, 'La C en GOCE representa Context (Contexto): la información de fondo que la IA necesita.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(231, 12, '¿Qué tipo de restricción es NO incluyas nombres reales de empleados?', '[{"texto": "Una restricción de formato", "es_correcta": false}, {"texto": "Una restricción de blindaje de datos", "es_correcta": true}, {"texto": "Una restricción de longitud", "es_correcta": false}, {"texto": "Una restricción de idioma", "es_correcta": false}]'::jsonb, 'Es una restricción de blindaje que protege datos sensibles.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(232, 12, '¿Qué es la iteración en el contexto de prompting?', '[{"texto": "Escribir el prompt más rápido", "es_correcta": false}, {"texto": "Refinar progresivamente el prompt basándose en las respuestas de la IA", "es_correcta": true}, {"texto": "Copiar el mismo prompt varias veces", "es_correcta": false}, {"texto": "Traducir el prompt a varios idiomas", "es_correcta": false}]'::jsonb, 'La iteración es mejorar progresivamente tu prompt según los resultados.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(233, 12, '¿Cuál es un ejemplo correcto de aplicar el framework GOCE?', '[{"texto": "Hazme algo bonito", "es_correcta": false}, {"texto": "Objetivo: resumen ejecutivo. Output: 5 bullets. Contexto: reporte Q1. Extra: tono formal.", "es_correcta": true}, {"texto": "Dame información", "es_correcta": false}, {"texto": "Copilot, trabaja", "es_correcta": false}]'::jsonb, 'Un prompt con GOCE incluye objetivo claro, formato de salida, contexto relevante y extras.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(234, 12, '¿Por qué es importante definir el formato de salida (Output) en GOCE?', '[{"texto": "Para hacer el prompt más largo", "es_correcta": false}, {"texto": "Para que la IA entregue la información en la estructura que necesitas", "es_correcta": true}, {"texto": "Porque Copilot no funciona sin formato", "es_correcta": false}, {"texto": "Para que la respuesta sea más corta", "es_correcta": false}]'::jsonb, 'Definir el output ayuda a que la IA entregue información en el formato más útil.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(235, 12, '¿Qué dato deberías anonimizar antes de enviarlo a Copilot?', '[{"texto": "El nombre de tu empresa (ya es público)", "es_correcta": false}, {"texto": "El número de cédula de un empleado", "es_correcta": true}, {"texto": "El nombre de un producto público", "es_correcta": false}, {"texto": "El horario de oficina", "es_correcta": false}]'::jsonb, 'Los datos personales identificables como cédulas deben anonimizarse.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(236, 12, '¿Qué es el ciclo de refinamiento en prompting?', '[{"texto": "Repetir el mismo prompt 10 veces", "es_correcta": false}, {"texto": "Evaluar la respuesta, identificar brechas y mejorar el prompt en cada iteración", "es_correcta": true}, {"texto": "Cambiar de herramienta de IA cada vez", "es_correcta": false}, {"texto": "Pedirle a un compañero que revise tu prompt", "es_correcta": false}]'::jsonb, 'El ciclo de refinamiento es evaluar, identificar lo que falta, ajustar el prompt y reevaluar.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(237, 12, '¿Qué componente de GOCE se refiere a los extras como tono y restricciones?', '[{"texto": "Goal", "es_correcta": false}, {"texto": "Output", "es_correcta": false}, {"texto": "Context", "es_correcta": false}, {"texto": "Extras", "es_correcta": true}]'::jsonb, 'La E en GOCE son los Extras: especificaciones adicionales como tono, longitud o restricciones.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(238, 12, '¿Cuál es un ejemplo de blindaje en un prompt?', '[{"texto": "Por favor sé amable", "es_correcta": false}, {"texto": "NO incluyas cifras reales de presupuesto ni nombres de proyectos internos", "es_correcta": true}, {"texto": "Escribe en español", "es_correcta": false}, {"texto": "Usa viñetas", "es_correcta": false}]'::jsonb, 'El blindaje son instrucciones explícitas de lo que la IA no debe incluir.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(239, 12, 'Si la primera respuesta de Copilot no es lo que necesitas, ¿qué debes hacer?', '[{"texto": "Rendirte y hacerlo manualmente", "es_correcta": false}, {"texto": "Iterar: ajustar el prompt con más contexto, restricciones o formato diferente", "es_correcta": true}, {"texto": "Reiniciar la computadora", "es_correcta": false}, {"texto": "Cambiar de herramienta de IA", "es_correcta": false}]'::jsonb, 'La iteración es clave: ajusta tu prompt basándote en lo que la IA te dio vs lo que necesitas.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(240, 12, '¿Por qué se le llama ADN Digital al proceso de clonación de patrones?', '[{"texto": "Porque usa biotecnología", "es_correcta": false}, {"texto": "Porque se replica la estructura y lógica de un prompt exitoso para nuevas situaciones", "es_correcta": true}, {"texto": "Porque cambia el ADN del usuario", "es_correcta": false}, {"texto": "Porque solo funciona con datos genéticos", "es_correcta": false}]'::jsonb, 'Se replican estructuras y lógicas exitosas para aplicarlas en nuevos contextos.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(241, 12, '¿Qué es un formato de alto impacto al dar instrucciones a la IA?', '[{"texto": "Un formato que usa muchos colores", "es_correcta": false}, {"texto": "Estructuras como tablas, comparativas o frameworks que maximizan la utilidad", "es_correcta": true}, {"texto": "Un formato que ocupa más espacio", "es_correcta": false}, {"texto": "Un formato exclusivo de Copilot", "es_correcta": false}]'::jsonb, 'Los formatos de alto impacto son estructuras de salida que maximizan la utilidad y claridad de la respuesta.');

-- === RETOS (6 filas) ===
INSERT INTO retos (id, titulo, escenario, criterios_evaluacion, modulo_id) VALUES
(1, 'Consultoría Estratégica con Copilot', 'Para completar este reto profesional debes abrir un nuevo chat en Copilot y redactar por tu cuenta una primera instrucción utilizando la estructura de Rol, Contexto y Tarea, donde le pidas a la IA que actúe como un consultor experto y te haga cinco preguntas clave sobre un tema real de tu trabajo para entender cómo estructurar un informe de alto impacto. Una vez respondas a esas preguntas en el mismo chat, deberás construir un segundo prompt indicándole a la IA que ahora asuma un Rol Gerencial para redactar un correo electrónico ejecutivo basado en la información anterior, asegurándote de solicitar un Formato que incluya asunto formal, saludo, los puntos principales del informe y los pasos a seguir. Para validar tu actividad, deberás entregar una captura de pantalla de toda la conversación donde se vea claramente cómo estructuraste tus propias instrucciones y el resultado final del correo profesional generado.', '["Calidad de los prompts", "Uso de los conceptos aprendidos. "]'::jsonb, 1);

INSERT INTO retos (id, titulo, escenario, criterios_evaluacion, modulo_id) VALUES
(10, 'Blindaje de prompts: reescribe y protege', 'Tu jefe te envía un email con datos sensibles de un proyecto confidencial y te pide que uses Copilot para generar un resumen ejecutivo. El email contiene nombres de empleados, cifras de presupuesto y estrategias internas. Debes: (1) Reescribir el prompt original aplicando el protocolo de anonimización que aprendiste, (2) Usar el framework GOCE para estructurar la instrucción, (3) Aplicar al menos una restricción de blindaje ("NO incluyas..."), (4) Mostrar el resultado de Copilot con tu prompt mejorado. Sube una captura de pantalla o documento con el prompt original, tu prompt mejorado y la respuesta de Copilot.', '["Aplicación correcta del protocolo de anonimización", "Uso del framework GOCE en la estructura del prompt", "Presencia de restricciones de blindaje", "Calidad del resultado obtenido con Copilot"]'::jsonb, 2);

INSERT INTO retos (id, titulo, escenario, criterios_evaluacion, modulo_id) VALUES
(11, 'Cadena de prompts para un proceso real', 'Identifica un proceso repetitivo de tu área de trabajo que puedas automatizar con Copilot (ejemplos: clasificar correos, generar reportes semanales, analizar feedback de clientes). Diseña una cadena de al menos 3 prompts donde la salida de cada uno alimenta al siguiente. Para cada prompt: usa la técnica apropiada (zero-shot o few-shot con ejemplos). Documenta el proceso completo en un documento y sube el enlace.', '["Identificación clara de un proceso real de su área", "Cadena de al menos 3 prompts conectados", "Uso apropiado de técnicas zero-shot y few-shot", "Resultado final útil y aplicable"]'::jsonb, 3);

INSERT INTO retos (id, titulo, escenario, criterios_evaluacion, modulo_id) VALUES
(12, 'Template XML reutilizable para tu equipo', 'Crea una plantilla XML reutilizable que tu equipo pueda usar para una tarea recurrente (ejemplo: generar descripciones de cargo, crear agendas de reunión, redactar comunicados internos). La plantilla debe incluir: (1) Estructura XML con campos variables claramente marcados, (2) Instrucciones de uso para que cualquier persona de tu equipo pueda utilizarla sin conocimiento técnico, (3) Un ejemplo de la plantilla completada y el resultado de Copilot. Incluye una reflexión breve sobre los riesgos de Shadow AI que identificaste en tu entorno laboral.', '["Estructura XML correcta y funcional", "Campos variables claramente identificados", "Instrucciones de uso comprensibles para no-técnicos", "Reflexión sobre Shadow AI relevante a su contexto"]'::jsonb, 4);

INSERT INTO retos (id, titulo, escenario, criterios_evaluacion, modulo_id) VALUES
(13, 'Kit creativo con Copilot: imagen + presentación + infografía', 'Elige un tema relevante para tu área de trabajo y crea un mini kit de comunicación usando Copilot que incluya: (1) Al menos 2 imágenes generadas con prompts específicos, (2) Un borrador de presentación de 3-5 diapositivas, (3) Una infografía o formulario diseñado con Copilot. Documenta los prompts exactos que usaste para cada pieza y sube los resultados en un enlace.', '["Mínimo 2 imágenes generadas con Copilot", "Presentación de 3-5 diapositivas coherente", "Infografía o formulario incluido", "Prompts documentados para cada pieza creativa"]'::jsonb, 5);

INSERT INTO retos (id, titulo, escenario, criterios_evaluacion, modulo_id) VALUES
(14, 'Construye tu primer agente especializado', 'Diseña y construye un agente de IA en Copilot especializado en una tarea repetitiva de tu área. El agente debe: (1) Tener un rol claro definido con una instrucción maestra, (2) Estar orientado a resolver un problema real de tu equipo (revisa el catálogo de casos de uso del módulo para inspirarte), (3) Incluir al menos 3 instrucciones base que definan su comportamiento. Documenta la configuración del agente, pruébalo con 2-3 consultas reales y sube las capturas del proceso y los resultados.', '["Instrucción maestra clara y específica", "Agente orientado a un caso de uso real del área", "Mínimo 3 instrucciones base configuradas", "Evidencia de pruebas con consultas reales"]'::jsonb, 6);

-- === RESET SECUENCIAS ===
SELECT setval('modulos_id_seq',   (SELECT MAX(id) FROM modulos));
SELECT setval('lecciones_id_seq', (SELECT MAX(id) FROM lecciones));
SELECT setval('pruebas_id_seq',   (SELECT MAX(id) FROM pruebas));
SELECT setval('preguntas_id_seq', (SELECT MAX(id) FROM preguntas));
SELECT setval('retos_id_seq',     (SELECT MAX(id) FROM retos));
