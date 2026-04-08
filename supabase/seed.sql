-- ============================================================
-- Seed: Snapshot de contenido desde produccion (2026-04-07)
-- Tablas: modulos, lecciones, pruebas, preguntas, retos
-- Solo se ejecuta con `supabase db reset` (entorno local).
-- ============================================================

-- Limpiar contenido previo
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

-- === LECCIONES (34 filas) ===
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
(91, 2, 4, 'Práctica: reescribe prompts inseguros', 'ejercicio', '{"texto": "Aplica la prueba de la valla publicitaria a cada prompt antes de enviarlo.", "instrucciones": "A continuación tienes 3 prompts con datos sensibles. Tu tarea es reescribirlos aplicando las técnicas de anonimización del módulo.\n\n1. \"Redacta un correo para María González de Nómina, cédula 52.345.678, informando que su aumento de $850.000 fue aprobado por su jefe Carlos Ruiz.\"\n\n2. \"Analiza por qué el cliente Pedro Martínez, tarjeta Visa terminada en 4523, hizo 3 reclamos el mes pasado por cobros incorrectos de $1.234.567.\"\n\n3. \"Genera un reporte del empleado Juan Díaz, diagnosticado con estrés laboral, incapacitado hasta el 20 de abril, del área de operaciones de El Dorado.\"\n\nRecuerda: usa placeholders, generaliza datos y elimina toda información que identifique personas."}'::jsonb, 15);

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
(95, 3, 4, 'Práctica: clasifica quejas con few-shot', 'ejercicio', '{"texto": "Recuerda las 4 reglas: variedad, formato consistente, representatividad y cantidad óptima (3-5 ejemplos).", "instrucciones": "Vas a practicar la técnica few-shot con 3 escenarios de una aerolínea. Para cada uno, escribe un prompt few-shot con al menos 3 ejemplos y luego presenta la tarea real.\n\nEscenario 1: Clasificar correos internos en categorías [Urgente], [Informativo], [Acción requerida].\nEscenario 2: Categorizar comentarios de pasajeros en [Elogio], [Queja], [Sugerencia], [Pregunta].\nEscenario 3: Etiquetar solicitudes de empleados en [Vacaciones], [Capacitación], [Soporte TI], [Otro].\n\nPara cada escenario:\n1. Escribe 3 a 5 ejemplos variados que cubran todas las categorías\n2. Mantené el formato idéntico en cada ejemplo\n3. Agrega la tarea real al final sin la respuesta\n4. Verifica que tus ejemplos no introduzcan sesgo hacia una categoría"}'::jsonb, 15);

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
(97, 3, 6, 'Práctica: diseña una cadena de 3 prompts', 'ejercicio', '{"texto": "Tip: Si no se te ocurre un proceso, usa este ejemplo: analizar las 5 preguntas más frecuentes de tu área, categorizarlas por urgencia y generar respuestas estandarizadas.", "instrucciones": "Elige un proceso de tu área de trabajo que tenga al menos 3 etapas lógicas. Diseña una cadena de 3 prompts donde la salida de cada uno alimente al siguiente.\n\nEstructura tu entregable así:\n\n1. **Descripción del proceso:** Qué tarea vas a resolver y por qué necesita encadenamiento.\n\n2. **Prompt 1 (Extracción/Preparación):** Escribe el primer prompt que recopile o estructure la información inicial. Indica el formato de salida esperado.\n\n3. **Prompt 2 (Análisis/Transformación):** Escribe el segundo prompt que tome el resultado del Paso 1 y lo analice o transforme. Referencia explícitamente los datos del paso anterior.\n\n4. **Prompt 3 (Acción/Entregable):** Escribe el tercer prompt que genere el resultado final: un correo, un reporte, una recomendación o una decisión.\n\n5. **Patrón utilizado:** Indica cuál de los 4 patrones de encadenamiento aplicaste (Secuencial, Paralelo con merge, Condicional o Loop de refinamiento) y por qué.\n\nRecuerda: cada prompt debe tener un solo objetivo, un formato de salida claro y referenciar explícitamente el resultado anterior."}'::jsonb, 15);

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
(100, 4, 4, 'Práctica: crea una plantilla XML reutilizable', 'ejercicio', '{"texto": "Tip: Las mejores plantillas son las que puedes reutilizar al menos 5 veces al mes. Piensa en tareas que haces repetidamente.", "instrucciones": "Crea una plantilla XML reutilizable para un caso de uso de tu área de trabajo. La plantilla debe incluir:\n\n1. **Etiqueta <rol>:** Define quién es la IA en este escenario.\n2. **Etiqueta <contexto>:** Incluye al menos 3 campos con placeholders [CAMPO] que se puedan reemplazar.\n3. **Etiqueta <tarea>:** Describe la acción específica que la IA debe realizar.\n4. **Etiqueta <formato>:** Especifica cómo quieres la respuesta (longitud, estructura, tono).\n5. **Etiqueta <restricciones>:** Al menos 2 restricciones claras.\n\nDespués de crear la plantilla:\n- Llena los placeholders con datos ficticios para un caso concreto\n- Prueba el prompt completo en Copilot\n- Evalúa si el resultado cumple con lo esperado\n\nEntregable: la plantilla vacía + un ejemplo de uso con datos ficticios + el resultado de Copilot."}'::jsonb, 15);

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
(103, 5, 6, 'Práctica: genera 3 imágenes para una presentación', 'ejercicio', '{"texto": "Recuerda: nunca presentes imágenes generadas por IA como fotos reales de empleados.", "instrucciones": "Usando Copilot Designer, genera 3 imágenes para una presentación profesional de tu área. Cada imagen debe tener un propósito diferente:\n\n1. **Imagen de portada:** Genera una imagen que funcione como portada de una presentación sobre un tema relevante de tu departamento. Usa el formato SUJETO + CONTEXTO + ESTILO VISUAL + PARÁMETROS.\n\n2. **Imagen de sección:** Genera una imagen que ilustre un concepto clave de tu área (por ejemplo: trabajo en equipo, innovación, servicio al cliente). Usa un estilo diferente al de la portada.\n\n3. **Imagen para redes sociales:** Genera una imagen en formato cuadrado (1:1) que podría usarse en LinkedIn para comunicar un logro del equipo.\n\nPara cada imagen documenta:\n- El prompt que usaste\n- Por qué elegiste ese estilo y formato\n- Si iteraste el prompt y qué cambios hiciste\n- Si la imagen cumple con las guías de marca (colores corporativos, diversidad, profesionalismo)"}'::jsonb, 10);

INSERT INTO lecciones (id, modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
(105, 5, 7, 'Práctica: crea una infografía sobre un tema de tu área', 'ejercicio', '{"texto": "Tip: Si eliges PowerPoint, pide a Copilot que agregue notas del orador para cada diapositiva.", "instrucciones": "Usando las herramientas de Copilot que aprendiste en este módulo, crea una infografía o material visual sobre un tema relevante de tu área de trabajo.\n\nEl entregable debe incluir:\n\n1. **Tema elegido:** Describe brevemente el tema y por qué es relevante para tu departamento.\n\n2. **Imagen principal:** Genera al menos 1 imagen con Copilot Designer que ilustre el concepto central. Documenta el prompt que usaste.\n\n3. **Presentación o formulario:** Elige una de estas opciones:\n   - **Opción A (PowerPoint):** Crea una presentación de 5 slides sobre el tema usando Copilot en PowerPoint. Incluye el prompt que usaste y ajustes que hiciste.\n   - **Opción B (Forms):** Crea un formulario de evaluación o encuesta relacionada con el tema usando Copilot en Forms. Incluye el prompt y las preguntas generadas.\n\n4. **Reflexión:** En 3-5 oraciones, describe qué funcionó bien, qué ajustaste manualmente y qué limitaciones encontraste.\n\nRecuerda aplicar las buenas prácticas: colores corporativos, diversidad en imágenes, y verificación de contenido generado."}'::jsonb, 10);

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
    style E fill:#d1fae5,stroke:#10b981$content$, 'media_url', ''), 20);

INSERT INTO lecciones (id, modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
(107, 6, 3, '🏆 Reto: Construye tu Primer Especialista Digital (Agente IA)', 'ejercicio', jsonb_build_object('texto', $content$# 🏆 Reto: Construye tu Primer Especialista Digital (Agente IA)

Ha llegado el momento de dejar de ser un espectador y convertirte en un **Arquitecto de Soluciones**. El objetivo de este reto es que identifiques una tarea que hoy te quita energía y crees un Agente en Copilot que asuma el **80% de ese esfuerzo operativo**.

---$content$, 'instrucciones', $content$
## 🧐 Paso 1: El Diagnóstico (Identifica tu oportunidad)

No todas las tareas deben ser un agente. Para encontrar la tarea perfecta, responde con total honestidad estas **4 preguntas clave**:

1.  **Frecuencia:** ¿Es una tarea que realizas al menos 2 o 3 veces por semana o que te quita más de 2 horas de trabajo mecánico?
2.  **Lógica:** ¿Existe un manual, un paso a paso o una serie de reglas claras que siempre sigues para completarla?
3.  **Esfuerzo:** ¿Sientes que el trabajo es más "operativo" (redactar, buscar, organizar, resumir) que "estratégico" (decidir, negociar, liderar)?
4.  **Insumos:** ¿Tienes documentos, plantillas o ejemplos de cómo se hace bien esa tarea que puedas darle a la IA como referencia?

> **Si respondiste "SÍ" a la mayoría, ¡tienes al candidato ideal para tu primer Agente!**

---

## 🛠️ Paso 2: Manos a la obra (Creación en Copilot)

Sigue estos pasos técnicos para dar vida a tu asistente:

1.  **Entra a Copilot:** Ve a la sección de **"Agentes"** o **"Copilot GPTs"** y haz clic en **"Crear nuevo agente"**.
2.  **Define el ADN (Instrucción Maestra):** Ve a la pestaña de **"Configurar"** y redacta las instrucciones siguiendo esta estructura:
    * **Rol:** ¿Quién es el agente? (Ej: "Eres un experto en Relaciones Laborales...").
    * **Contexto:** ¿Para qué empresa trabaja y qué valores debe cuidar?
    * **Tarea:** ¿Qué debe hacer exactamente cuando le entregues información?
    * **Reglas:** ¿Qué cosas tiene prohibido hacer o decir?
3.  **Carga el Conocimiento:** Sube los archivos (PDF, Word, Excel) que el agente debe usar como fuente de verdad.
4.  **Prueba el prototipo:** Hazle una pregunta difícil en el panel de vista previa y ajusta las instrucciones si es necesario.

---

## 📝 Paso 3: Comparte tu Logro

Para completar el reto, envíanos los resultados de tu ejercicio con la siguiente estructura:

1.  **La Tarea Elegida:** (Ej: Redacción de actas de descargos).
2.  **Tus respuestas al Diagnóstico:** (Un resumen breve de por qué elegiste esta tarea).
3.  **La Instrucción Maestra:** Pega aquí el texto que usaste para configurar el "cerebro" de tu agente.
4.  **El Resultado:** Cuéntanos qué tal fue la primera prueba. ¿Qué lograste automatizar?

---

## 💡 Tip de Experto
No intentes que el agente haga todo el proceso de principio a fin. Enfócate en que el agente te entregue un **borrador avanzado al 80%**. Tu éxito en este reto depende de que recuperes tiempo para dedicarlo al 20% donde tu talento humano es irreemplazable.

**¡Estamos ansiosos por ver a tus nuevos especialistas digitales en acción!**$content$), 20);

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
(109, 7, 2, 'El futuro de la IA: tendencias que definirán los próximos años', 'texto', jsonb_build_object('texto', $content$# El futuro de la IA: 7 tendencias que definirán los próximos años

La Inteligencia Artificial dejó de ser una promesa futurista. En 2026, ya es una herramienta cotidiana en las empresas, incluyendo la nuestra. Pero el panorama sigue cambiando a velocidad de despegue. Conocer las tendencias que vienen no es curiosidad académica: es **preparación estratégica**.

Este módulo te presenta las 7 tendencias clave que definirán los próximos años, con datos concretos y lo que significan para tu trabajo en Avianca. El objetivo no es que te conviertas en experto en tecnología, sino que puedas **tomar mejores decisiones** sabiendo hacia dónde se mueve el ecosistema.

---

## 1. Agentes autónomos: la IA pasa de responder a ejecutar

Hasta ahora, la IA funcionaba como un asistente reactivo: tú preguntas, ella responde. Los **agentes autónomos** cambian esa dinámica. Son sistemas de IA capaces de recibir un objetivo y ejecutar una secuencia completa de pasos para lograrlo, tomando decisiones intermedias sin intervención humana.

Según Gartner, el **40% de las aplicaciones empresariales integrarán agentes de IA para finales de 2026**. Microsoft ya está incorporando agentes en su ecosistema Copilot que pueden gestionar flujos de trabajo completos: desde agendar reuniones hasta procesar solicitudes internas.

**Qué significa para Avianca:** Imagina un agente que recibe una queja de un pasajero, clasifica la urgencia, consulta el historial del cliente, genera una respuesta personalizada y escala al área correspondiente si es necesario. Todo automático, pero supervisado por humanos.

> La clave no es reemplazar personas, sino liberar tiempo de tareas repetitivas para que los equipos se enfoquen en decisiones que requieren criterio humano.

---

## 2. Edge AI: inteligencia que corre en el dispositivo

Hoy, la mayoría de las herramientas de IA dependen de la nube: tu pregunta viaja a un servidor remoto, se procesa y la respuesta regresa. **Edge AI** cambia eso: la inteligencia corre directamente en tu dispositivo (laptop, teléfono, tablet), sin necesidad de conexión permanente.

Las ventajas son tres: **más privacidad** (los datos no salen del dispositivo), **más velocidad** (no hay latencia de red) y **mayor disponibilidad** (funciona sin internet).

Microsoft, Google y Apple ya están integrando modelos de IA directamente en sus sistemas operativos y dispositivos. Los procesadores NPU (Neural Processing Unit) vienen integrados en las laptops de última generación.

**Qué significa para Avianca:** Equipos de tierra y tripulación podrían usar herramientas de IA que funcionan sin conexión a internet, procesando información sensible de pasajeros localmente sin enviarla a servidores externos.

---

## 3. Modelos especializados: pequeños pero expertos

La tendencia inicial fue construir modelos gigantes que "saben de todo". Ahora el mercado está virando hacia **modelos más pequeños y especializados**, entrenados para tareas o industrias específicas. Son más rápidos, más baratos y frecuentemente más precisos en su área de dominio.

Se proyecta que para 2027, **más del 50% de los modelos empresariales serán adaptados al sector** en el que operan, en lugar de usar modelos generales.

| Modelo general | Modelo especializado |
|---|---|
| Sabe un poco de todo | Domina un área específica |
| Respuestas genéricas | Respuestas con terminología del sector |
| Alto costo computacional | Más ligero y eficiente |
| Requiere más contexto en el prompt | Entiende el contexto del negocio |

**Qué significa para Avianca:** Un modelo especializado en aviación comercial entendería automáticamente que "ETD" es Estimated Time of Departure, que "code share" implica acuerdos interlínea, o que "IROPS" se refiere a operaciones irregulares, sin necesidad de explicárselo cada vez.

---

## 4. Computación cuántica + IA: el punto de inflexión

IBM declaró 2026 como el **punto de inflexión para la computación cuántica aplicada a IA**. Mientras las computadoras clásicas procesan información en bits (0 o 1), las computadoras cuánticas usan qubits que pueden ser ambos a la vez, permitiendo resolver problemas exponencialmente más complejos.

La convergencia de computación cuántica e IA promete avances en optimización de rutas, simulaciones complejas y análisis de riesgo a una escala que hoy es inviable.

**Qué significa para Avianca:** La optimización de rutas aéreas, la predicción de mantenimiento de flota y el modelado de demanda podrían alcanzar niveles de precisión que hoy son matemáticamente imposibles con computación tradicional. No es algo para mañana, pero ya está en el horizonte.

> Es una tendencia a mediano plazo. No necesitas entender la física cuántica, pero sí saber que existe y que va a transformar la capacidad de procesamiento de la IA.

---

## 5. Regulación y confianza: el marco legal se consolida

El **EU AI Act** (Ley Europea de Inteligencia Artificial) ya está vigente y establece reglas claras sobre cómo se puede y no se puede usar IA según su nivel de riesgo. Otros países están siguiendo la misma ruta regulatoria.

Esto no es un freno para la IA, es una **condición para su adopción masiva**. Las empresas que operan internacionalmente, como Avianca, necesitan garantizar que su uso de IA cumple con los marcos regulatorios de cada región.

Las áreas clave de regulación incluyen:

- **Transparencia:** los usuarios deben saber cuándo interactúan con IA
- **No discriminación:** los modelos no pueden generar sesgos sistemáticos
- **Privacidad:** cumplimiento de normativas como GDPR y leyes locales de protección de datos
- **Responsabilidad:** debe haber un humano responsable de las decisiones asistidas por IA

**Qué significa para Avianca:** Cada vez que uses IA para generar comunicaciones, analizar datos de pasajeros o tomar decisiones operativas, debes asegurarte de que el resultado sea revisado por un humano y cumpla con las políticas internas. El criterio humano no es opcional, es un requerimiento legal.

---

## 6. Fatiga del hype: de la cantidad a la calidad

Después del boom de 2023-2024, el mercado está experimentando **saturación de contenido generado por IA**. Los consumidores y profesionales ya identifican textos genéricos producidos por modelos de lenguaje. La prioridad está cambiando de "generar mucho" a "generar bien".

Las empresas que simplemente automatizaron producción de contenido sin supervisión están viendo resultados negativos: contenido repetitivo, errores factuales y pérdida de voz de marca.

La respuesta no es dejar de usar IA, sino usarla con **criterio editorial**:

- La IA genera el primer borrador
- El humano aporta contexto, datos verificados y voz auténtica
- El resultado final tiene calidad y autenticidad que la IA sola no logra

**Qué significa para Avianca:** Si usas Copilot para generar un correo, un reporte o una presentación, tu trabajo no termina cuando la IA entrega el texto. Empieza ahí. Tu conocimiento del negocio, del cliente y del contexto es lo que transforma un borrador genérico en un documento de valor.

---

## 7. IA como commodity: el diferenciador eres tú

Las herramientas de IA se están **comoditizando**. GPT, Claude, Gemini, Copilot y decenas de modelos ofrecen capacidades similares a precios cada vez más accesibles. La tecnología en sí deja de ser ventaja competitiva.

Lo que marca la diferencia es **quién la usa y cómo la usa**. Dos personas con la misma herramienta pueden obtener resultados radicalmente diferentes dependiendo de la calidad de sus instrucciones, su conocimiento del problema y su capacidad de evaluar críticamente las respuestas.

```mermaid
flowchart LR
    A["Herramienta de IA\n(commodity)"] --> B["Usuario sin\ncapacitación"]
    A --> C["Usuario\ncapacitado"]
    B --> D["Resultado\ngenérico"]
    C --> E["Resultado de\nalto valor"]
    style A fill:#e2e8f0,stroke:#94a3b8
    style B fill:#fecaca,stroke:#ef4444
    style C fill:#bfdbfe,stroke:#3b82f6
    style D fill:#fef3c7,stroke:#f59e0b
    style E fill:#bbf7d0,stroke:#22c55e
```

**Qué significa para Avianca:** La inversión en esta capacitación no es sobre aprender a usar un botón. Es sobre desarrollar la habilidad de **pensar junto con la IA**, de saber qué pedirle, cuándo confiar en su respuesta y cuándo cuestionarla.

---

## Línea de tiempo: evolución de las tendencias

```mermaid
timeline
    title Horizonte de tendencias en IA empresarial
    2025 : Adopción masiva de Copilot
         : Primeros agentes en producción
         : EU AI Act entra en vigor
    2026 : 40% apps con agentes integrados
         : Edge AI en dispositivos comerciales
         : Punto de inflexión cuántica según IBM
    2027 : 50%+ modelos especializados por sector
         : Regulación consolidada en Latam
         : IA como commodity generalizado
    2028+ : Agentes autónomos multi-sistema
          : Cuántica + IA en producción
          : Diferenciador puro en habilidad humana
```

---

## Reflexión final: tu ventaja competitiva es tu criterio, no la herramienta

Las 7 tendencias que revisamos tienen un hilo común: **la tecnología avanza, pero el valor lo aporta la persona que la usa con criterio**.

Los agentes autónomos necesitan supervisores humanos. Los modelos especializados necesitan quien sepa formular la pregunta correcta. La regulación exige responsabilidad humana. Y cuando todas las herramientas sean iguales, el diferenciador será quien sepa extraer el máximo valor de ellas.

Tú no compites contra la IA. Compites contra otros profesionales que también la usan. Tu ventaja no está en tener acceso a Copilot, porque eso lo tienen todos. Tu ventaja está en **tu conocimiento del negocio, tu criterio para evaluar respuestas y tu capacidad de hacer las preguntas correctas**.

Eso es exactamente lo que esta capacitación te está ayudando a construir.

> Lo que te hace valioso no es la herramienta que usas, sino lo que sabes hacer con ella. La IA amplifica tu criterio, pero no lo reemplaza.

---

## Fuentes

- Microsoft News Latam. *Qué viene en IA: 7 tendencias a seguir en 2026*. [https://news.microsoft.com/source/latam/features/ia/que-viene-en-ia-7-tendencias-a-seguir-en-2026/](https://news.microsoft.com/source/latam/features/ia/que-viene-en-ia-7-tendencias-a-seguir-en-2026/)
- IBM Think. *AI tech trends predictions 2026*. [https://www.ibm.com/think/news/ai-tech-trends-predictions-2026](https://www.ibm.com/think/news/ai-tech-trends-predictions-2026)
- UOC. *Seis tendencias clave de la IA en 2026*. [https://www.uoc.edu/es/news/2025/seis-tendencias-clave-de-la-ia-en-2026](https://www.uoc.edu/es/news/2025/seis-tendencias-clave-de-la-ia-en-2026)
- IT Masters Mag. *Más allá del hype: 10 predicciones para la AI empresarial en 2026*. [https://www.itmastersmag.com/inteligencia-artificial/mas-alla-del-hype-10-predicciones-para-la-ai-empresarial-en-2026/](https://www.itmastersmag.com/inteligencia-artificial/mas-alla-del-hype-10-predicciones-para-la-ai-empresarial-en-2026/)$content$), 15);

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

-- === PRUEBAS (8 filas) ===
INSERT INTO pruebas (id, modulo_id, tipo, titulo, preguntas_por_intento, puntaje_aprobatorio, orden) VALUES
(1, NULL, 'diagnostico_pre', 'Diagnostico de entrada', 7, 0, 0);

INSERT INTO pruebas (id, modulo_id, tipo, titulo, preguntas_por_intento, puntaje_aprobatorio, orden) VALUES
(3, 1, 'modular', 'Prueba: Prompt Engineering', 5, 80, 2);

INSERT INTO pruebas (id, modulo_id, tipo, titulo, preguntas_por_intento, puntaje_aprobatorio, orden) VALUES
(4, 3, 'modular', 'Prueba: Productividad Real', 5, 80, 3);

INSERT INTO pruebas (id, modulo_id, tipo, titulo, preguntas_por_intento, puntaje_aprobatorio, orden) VALUES
(5, 4, 'modular', 'Prueba: Inteligencia de Datos', 5, 80, 4);

INSERT INTO pruebas (id, modulo_id, tipo, titulo, preguntas_por_intento, puntaje_aprobatorio, orden) VALUES
(6, 5, 'modular', 'Prueba: Etica y Seguridad', 5, 80, 5);

INSERT INTO pruebas (id, modulo_id, tipo, titulo, preguntas_por_intento, puntaje_aprobatorio, orden) VALUES
(7, 6, 'modular', 'Prueba: IA para RR.HH.', 5, 80, 6);

INSERT INTO pruebas (id, modulo_id, tipo, titulo, preguntas_por_intento, puntaje_aprobatorio, orden) VALUES
(11, 7, 'modular', 'Prueba: IA para tu vida personal', 5, 80, 8);

INSERT INTO pruebas (id, modulo_id, tipo, titulo, preguntas_por_intento, puntaje_aprobatorio, orden) VALUES
(8, NULL, 'diagnostico_post', 'Diagnostico de salida', 7, 0, 9);

-- === PREGUNTAS (136 filas) ===
INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(53, 1, 'Tu jefe te pide urgentemente un resumen ejecutivo de un informe de 40 paginas para una reunion en 30 minutos. Tienes acceso a Copilot. Cual es la MEJOR estrategia?', '[{"texto": "Copiar y pegar todo el informe en Copilot y pedir el resumen", "es_correcta": false}, {"texto": "Verificar que el informe no contenga datos confidenciales, luego usar Copilot para resumir seccion por seccion", "es_correcta": true}, {"texto": "No usar IA porque el informe puede tener datos sensibles, y hacer el resumen manualmente", "es_correcta": false}, {"texto": "Usar Copilot para resumir y enviar directamente sin revisar", "es_correcta": false}]'::jsonb, 'La urgencia no justifica saltarse la seguridad (elimina A y D), pero negarse a usar la herramienta cuando se puede hacer de forma segura tampoco es optimo (elimina C).');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(54, 1, 'Un companero te dice: ''Le pedi a ChatGPT gratuito que revisara el contrato con nuestro nuevo cliente y me dio sugerencias excelentes.'' Cual es el problema PRINCIPAL?', '[{"texto": "ChatGPT no es bueno para revision legal", "es_correcta": false}, {"texto": "La version gratuita puede usar esas conversaciones para entrenamiento, exponiendo datos contractuales confidenciales", "es_correcta": true}, {"texto": "No hay problema si el contrato ya esta firmado", "es_correcta": false}, {"texto": "El problema es que no uso Copilot", "es_correcta": false}]'::jsonb, 'El 34.8% de los datos que empleados pegan en ChatGPT son sensibles. La version gratuita usa conversaciones para entrenamiento.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(55, 1, 'Le pediste a una IA los 5 estudios mas relevantes sobre liderazgo remoto de 2025. Te dio una lista profesional. Cual deberia ser tu SIGUIENTE paso?', '[{"texto": "Incluirlos en tu presentacion", "es_correcta": false}, {"texto": "Verificar que cada estudio realmente exista en Google Scholar", "es_correcta": true}, {"texto": "Confiar en los de universidades reconocidas", "es_correcta": false}, {"texto": "Pedir a la IA que confirme que son reales", "es_correcta": false}]'::jsonb, 'Los modelos alucinan referencias academicas con frecuencia. La IA confirmara sus propias alucinaciones.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(56, 1, 'Usas IA para analizar ventas. La IA dice que cayeron 15% por estacionalidad. Tu sabes que hubo cambio de precio y competidor nuevo. Que haces?', '[{"texto": "Aceptar el analisis porque la IA proceso todos los datos", "es_correcta": false}, {"texto": "Rechazar completamente y hacerlo manualmente", "es_correcta": false}, {"texto": "Cuestionar la conclusion, pedir que considere las variables adicionales, y validar contra tu experiencia", "es_correcta": true}, {"texto": "Agregar nota ''segun IA''", "es_correcta": false}]'::jsonb, 'La IA no tiene contexto empresarial que tu si tienes. Combina su procesamiento con tu conocimiento.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(57, 1, 'En cuales de estas tareas la IA es MENOS confiable?', '[{"texto": "Resumir un documento largo", "es_correcta": false}, {"texto": "Hacer calculos matematicos complejos", "es_correcta": false}, {"texto": "Generar ideas para lluvia de ideas", "es_correcta": false}, {"texto": "Proporcionar datos estadisticos especificos y actualizados", "es_correcta": true}]'::jsonb, 'Para datos estadisticos especificos la IA tiene fecha de corte, no accede a bases de datos en tiempo real, y tiende a inventar cifras.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(58, 1, 'Trabajas en RRHH y necesitas redactar un correo de retroalimentacion para un empleado con bajo desempeno. Cual es la forma CORRECTA de usar IA?', '[{"texto": "Incluir nombre, departamento y datos del empleado en el prompt", "es_correcta": false}, {"texto": "Anonimizar: ''correo de retroalimentacion para un analista que no alcanzo metas trimestrales en un 20%''", "es_correcta": true}, {"texto": "No usar IA en temas de RRHH", "es_correcta": false}, {"texto": "Usar IA pero borrar el historial despues", "es_correcta": false}]'::jsonb, 'Anonimiza sin nombre ni departamento. Borrar historial no protege nada.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(59, 1, 'Tu companero afirma: ''ChatGPT tiene acceso a internet y siempre da informacion actualizada.'' Esta afirmacion es:', '[{"texto": "Correcta, todos los modelos tienen acceso", "es_correcta": false}, {"texto": "Parcialmente correcta: algunos modelos buscan en internet, pero tienen fecha de corte y los resultados deben verificarse", "es_correcta": true}, {"texto": "Incorrecta, ningun modelo tiene acceso a internet", "es_correcta": false}, {"texto": "Correcta solo con version de pago", "es_correcta": false}]'::jsonb, 'Algunos modelos pueden buscar, pero no garantiza precision. Siguen teniendo fecha de corte.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(60, 1, 'La IA escribe un correo de disculpa perfecto pero con frases como ''lamentamos profundamente las molestias''. Que problema tiene?', '[{"texto": "Ninguno, es profesional", "es_correcta": false}, {"texto": "El tono es generico y suena a IA; el cliente podria percibirlo como insincero", "es_correcta": true}, {"texto": "Es demasiado formal", "es_correcta": false}, {"texto": "Deberia incluir emojis", "es_correcta": false}]'::jsonb, 'La IA genera texto correcto pero generico. En disculpas, el toque humano es critico.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(61, 1, 'Se venden credenciales de ChatGPT con historial en la dark web (225,000+ en 2025). Que implica?', '[{"texto": "No importa con version empresarial", "es_correcta": false}, {"texto": "NUNCA ingresar info confidencial en herramientas personales, usar cuentas corporativas con MFA", "es_correcta": true}, {"texto": "Dejar de usar IA", "es_correcta": false}, {"texto": "Solo afecta a contrasenas debiles", "es_correcta": false}]'::jsonb, 'El robo expone todo el historial. Refuerza usar cuentas corporativas con SSO y MFA.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(62, 1, 'Usas IA para filtrar CVs. Notas que califica mas alto a ciertas universidades y mas bajo a ciertos nombres etnicos. Esto es:', '[{"texto": "Normal, identifica mejores candidatos", "es_correcta": false}, {"texto": "Reflejo de sesgos en datos de entrenamiento que la IA replica y amplifica", "es_correcta": true}, {"texto": "Error tecnico que se corrige con mas datos", "es_correcta": false}, {"texto": "Imposible, la IA es objetiva", "es_correcta": false}]'::jsonb, 'Los modelos replican sesgos. Amazon tuvo que descartar su herramienta de reclutamiento por discriminacion.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(63, 1, 'Para cual tarea seria MAS INAPROPIADO usar IA sin supervision experta?', '[{"texto": "Plan de marketing", "es_correcta": false}, {"texto": "Diagnostico medico basado en sintomas", "es_correcta": true}, {"texto": "Agenda para reunion", "es_correcta": false}, {"texto": "Temas para newsletter", "es_correcta": false}]'::jsonb, 'Tareas con consecuencias graves (medicina, legal) requieren supervision experta obligatoria.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(64, 1, 'La IA genera un logo profesional para tu proyecto. Puedes usarlo sin restricciones?', '[{"texto": "Si, es completamente tuyo", "es_correcta": false}, {"texto": "Depende: las leyes de propiedad intelectual sobre contenido de IA varian y estan evolucionando", "es_correcta": true}, {"texto": "No, pertenece a la empresa del modelo", "es_correcta": false}, {"texto": "Si, porque tu prompt es original", "es_correcta": false}]'::jsonb, 'El marco legal esta en evolucion. No hay proteccion de copyright clara para obras sin autor humano.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(65, 1, 'Un equipo usa IA para TODAS sus comunicaciones. Cual es el riesgo principal?', '[{"texto": "Que la IA no sea suficientemente buena", "es_correcta": false}, {"texto": "Perdida de voz autentica, dependencia y atrofia de capacidad de comunicacion", "es_correcta": true}, {"texto": "Que sea demasiado caro", "es_correcta": false}, {"texto": "Ningun riesgo", "es_correcta": false}]'::jsonb, 'Sobredependencia genera homogeneidad y perdida de habilidades.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(66, 1, 'La IA dice: ''segun McKinsey 2025, el 73% de empresas latinoamericanas ya implementaron IA.'' Que nivel de confianza?', '[{"texto": "Alto, McKinsey es confiable", "es_correcta": false}, {"texto": "Bajo hasta verificar: la IA pudo inventar la cifra, la fuente, o ambas", "es_correcta": true}, {"texto": "Medio, probablemente redondeo", "es_correcta": false}, {"texto": "Alto si pregunto dos veces y da lo mismo", "es_correcta": false}]'::jsonb, 'Las alucinaciones frecuentemente involucran fuentes respetadas con datos inventados.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(67, 1, 'Un colega dice: ''Con Copilot vamos a reducir el equipo de analistas.'' Cual es la mejor respuesta?', '[{"texto": "Tiene razon, la IA analiza mejor", "es_correcta": false}, {"texto": "La IA aumenta la capacidad pero no reemplaza juicio experto ni conocimiento del negocio", "es_correcta": true}, {"texto": "Esperar a ver resultados", "es_correcta": false}, {"texto": "Depende del costo licencias vs salarios", "es_correcta": false}]'::jsonb, 'La IA es amplificador, no reemplazo. Los analistas contextualizan y cuestionan.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(143, 1, 'Tu equipo de marketing quiere usar IA para personalizar correos masivos a 50,000 clientes usando su historial de compras, preferencias y ubicacion. El proyecto promete +35% de conversion. Cual es el riesgo que el equipo probablemente NO esta considerando?', '[{"texto": "Que la IA escriba correos con errores gramaticales", "es_correcta": false}, {"texto": "Que la personalizacion a ese nivel revele que la empresa tiene mas datos del cliente de lo que el cree, generando desconfianza", "es_correcta": true}, {"texto": "Que el costo de la herramienta sea alto", "es_correcta": false}, {"texto": "Que los correos lleguen a spam", "es_correcta": false}]'::jsonb, 'La hiperpersonalizacion puede cruzar la linea entre ''util'' y ''invasivo''. Los clientes que perciben vigilancia reaccionan negativamente, el efecto contrario al esperado.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(144, 1, 'Un gerente propone usar IA para transcribir y resumir automaticamente TODAS las reuniones del equipo, guardando las transcripciones en un repositorio compartido. La intencion es mejorar la documentacion. Por que podria ser contraproducente?', '[{"texto": "Porque la IA no transcribe bien", "es_correcta": false}, {"texto": "Porque la gente dejara de hablar con franqueza sabiendo que todo queda grabado y procesado por IA", "es_correcta": true}, {"texto": "Porque consume muchos tokens", "es_correcta": false}, {"texto": "Porque no todos hablan claro", "es_correcta": false}]'::jsonb, 'El efecto ''chilling'': cuando las personas saben que una IA procesa sus palabras, se autocensuran. La calidad de las discusiones baja y las conversaciones dificiles se evitan.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(145, 1, 'Una startup te ofrece una herramienta de IA que analiza el tono de voz en llamadas de servicio al cliente para detectar emociones y evaluar agentes. En que escenario seria MEJOR no implementarla, a pesar de los beneficios prometidos?', '[{"texto": "Cuando es cara", "es_correcta": false}, {"texto": "Cuando la legislacion local requiere consentimiento para monitoreo biometrico y los empleados no han sido informados", "es_correcta": true}, {"texto": "Cuando los agentes tienen buen desempeno", "es_correcta": false}, {"texto": "Cuando ya tienes encuestas de satisfaccion", "es_correcta": false}]'::jsonb, 'El analisis de voz es dato biometrico en muchas jurisdicciones. Implementar sin cumplir normativa legal expone a la empresa a demandas, independientemente de los beneficios operativos.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(146, 1, 'Tu jefe quiere que uses IA para redactar las respuestas a una auditoria de cumplimiento regulatorio. Cual es la razon MAS fuerte para no hacerlo sin supervision experta?', '[{"texto": "La IA no entiende regulaciones", "es_correcta": false}, {"texto": "La IA puede generar respuestas que suenan correctas pero malinterpretan requisitos especificos, creando evidencia escrita de incumplimiento", "es_correcta": true}, {"texto": "Los auditores lo notaran", "es_correcta": false}, {"texto": "No es etico", "es_correcta": false}]'::jsonb, 'En auditorias, una respuesta incorrecta documentada es peor que no responder. La IA puede generar lenguaje regulatorio convincente pero impreciso, creando problemas legales.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(147, 1, 'Un colega automatizo con IA la generacion de reportes semanales que antes le tomaban 4 horas. Ahora los genera en 10 minutos pero dedica el tiempo ahorrado a otras tareas sin revisar los reportes. Que problema se esta gestando?', '[{"texto": "Ninguno, es mas eficiente", "es_correcta": false}, {"texto": "Deuda de calidad: errores no detectados se acumulan hasta que un reporte incorrecto causa una mala decision de negocio", "es_correcta": true}, {"texto": "Los reportes son demasiado genericos", "es_correcta": false}, {"texto": "Sus colegas se sentiran reemplazados", "es_correcta": false}]'::jsonb, 'La automatizacion sin verificacion crea una falsa sensacion de productividad. El riesgo se acumula silenciosamente hasta que un error tiene consecuencias reales.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(148, 1, 'En una reunion, alguien propone: ''Dejemos que la IA decida a que clientes darles credito, asi eliminamos el sesgo humano.'' Cual es la falla en este razonamiento?', '[{"texto": "La IA no puede analizar datos financieros", "es_correcta": false}, {"texto": "La IA hereda sesgos de los datos historicos con los que fue entrenada, potencialmente discriminando contra los mismos grupos que el sesgo humano afectaba", "es_correcta": true}, {"texto": "Es ilegal usar IA para credito", "es_correcta": false}, {"texto": "La IA es mas sesgada que los humanos", "es_correcta": false}]'::jsonb, 'Los modelos entrenados con datos historicos replican patrones discriminatorios del pasado. Eliminar sesgo humano no elimina sesgo sistematico en los datos.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(149, 1, 'Tienes dos opciones para un analisis urgente: (A) usar una herramienta de IA gratuita que da resultados en 2 minutos, o (B) esperar 2 horas a que el analista del equipo lo haga manualmente. Los datos contienen nombres de clientes y montos de facturacion. Cual es la decision CORRECTA?', '[{"texto": "Opcion A, la urgencia lo justifica", "es_correcta": false}, {"texto": "Opcion B, porque los datos contienen informacion sensible de clientes que no debe procesarse en herramientas no autorizadas", "es_correcta": false}, {"texto": "Opcion A pero anonimizando los datos antes de enviarlos", "es_correcta": false}, {"texto": "Depende: si existe herramienta corporativa autorizada, anonimizar y usarla; si no, opcion B", "es_correcta": true}]'::jsonb, 'No es binario. La respuesta correcta evalua si hay una herramienta autorizada disponible. Ni la urgencia justifica exponer datos, ni hay que rechazar toda IA por precaucion.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(150, 1, 'Una IA genera un analisis que contradice tu experiencia de 10 anos en el sector. El analisis esta bien redactado y cita tendencias de mercado. Cual es la actitud MAS profesional?', '[{"texto": "Confiar en la IA porque procesa mas datos que tu", "es_correcta": false}, {"texto": "Descartar el analisis porque tu experiencia es mas valiosa", "es_correcta": false}, {"texto": "Investigar la discrepancia: verificar los datos de la IA, cuestionar tus supuestos, y llegar a una conclusion informada que combine ambas perspectivas", "es_correcta": true}, {"texto": "Pedir una segunda opinion a otra IA", "es_correcta": false}]'::jsonb, 'Ni aceptar ciegamente ni rechazar por orgullo. La discrepancia es una oportunidad para descubrir algo nuevo o confirmar que la IA se equivoca, pero requiere investigacion.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(83, 3, 'Tu companera escribe este prompt: ''Hazme un analisis de ventas.'' El resultado es vago e inutil. Usando el framework GOCE, que componente falta PRINCIPALMENTE?', '[{"texto": "Goal (objetivo claro)", "es_correcta": false}, {"texto": "Orientacion (contexto de quien eres y para que)", "es_correcta": true}, {"texto": "Constraint (restricciones)", "es_correcta": false}, {"texto": "Ejemplo (formato esperado)", "es_correcta": false}]'::jsonb, 'Sin contexto de rol, audiencia o proposito, la IA no puede orientar su respuesta. La Orientacion da el marco necesario.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(84, 3, 'Necesitas que la IA redacte un correo para un cliente molesto. Cual prompt aplica MEJOR el componente de Constraint del framework GOCE?', '[{"texto": "''Escribe un correo profesional para un cliente''", "es_correcta": false}, {"texto": "''Redacta un correo de maximo 150 palabras, tono empatico pero firme, sin prometer reembolso, en formato parrafo corto''", "es_correcta": true}, {"texto": "''Escribe el mejor correo posible para calmar a un cliente''", "es_correcta": false}, {"texto": "''Genera 3 versiones de correo para cliente molesto''", "es_correcta": false}]'::jsonb, 'Las restricciones (longitud, tono, prohibiciones, formato) acotan la respuesta y evitan resultados genericos.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(85, 3, 'Un analista escribe: ''Analiza las quejas del cliente Juan Perez, cuenta #4521, sobre el producto Premium que compro el 15 de marzo por $2,500.'' Cual es el problema de seguridad?', '[{"texto": "El prompt es demasiado largo", "es_correcta": false}, {"texto": "Incluye datos personales identificables (nombre, cuenta, producto, fecha, monto) que no deberian enviarse a la IA", "es_correcta": true}, {"texto": "Deberia usar Copilot en vez de ChatGPT", "es_correcta": false}, {"texto": "No hay problema si es herramienta corporativa", "es_correcta": false}]'::jsonb, 'Incluso en herramientas corporativas, el principio de minimizacion de datos aplica: solo enviar lo necesario, anonimizado.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(86, 3, 'Quieres que la IA genere un reporte financiero trimestral. Cual es la forma CORRECTA de anonimizar los datos antes de enviarlos?', '[{"texto": "Cambiar solo los nombres de personas", "es_correcta": false}, {"texto": "Reemplazar nombres, cuentas, montos exactos y fechas especificas por identificadores genericos manteniendo la estructura", "es_correcta": true}, {"texto": "Pedirle a la IA que ignore los datos personales", "es_correcta": false}, {"texto": "Enviar todo y borrar el chat despues", "es_correcta": false}]'::jsonb, 'La anonimizacion efectiva cubre todos los campos identificables. La IA no puede ''ignorar'' lo que ya leyo.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(87, 3, 'Estas construyendo un prompt para analizar encuestas de satisfaccion. Cual orden de componentes GOCE produce mejores resultados?', '[{"texto": "Ejemplo -> Goal -> Constraint -> Orientacion", "es_correcta": false}, {"texto": "Goal -> Orientacion -> Constraint -> Ejemplo", "es_correcta": true}, {"texto": "Constraint -> Ejemplo -> Goal -> Orientacion", "es_correcta": false}, {"texto": "El orden no importa", "es_correcta": false}]'::jsonb, 'GOCE sigue un flujo logico: primero que quieres, luego contexto, despues limites, y finalmente un ejemplo de formato.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(88, 3, 'Tu jefe te pide usar IA para resumir las actas de la junta directiva que incluyen discusiones sobre despidos y reestructuracion. Mejor enfoque?', '[{"texto": "Resumir directamente en Copilot ya que es herramienta corporativa", "es_correcta": false}, {"texto": "Reemplazar nombres por roles genericos, omitir montos de liquidacion, y resumir temas sin detalles identificables", "es_correcta": true}, {"texto": "Hacer el resumen manualmente sin usar IA", "es_correcta": false}, {"texto": "Usar IA pero agregar disclaimer de confidencialidad al prompt", "es_correcta": false}]'::jsonb, 'Las actas de junta directiva contienen informacion altamente sensible. Anonimizar es obligatorio incluso en herramientas corporativas.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(89, 3, 'Escribes: ''Eres un experto en marketing digital. Crea una estrategia para redes sociales.'' La IA da algo generico. Que componente GOCE mejorar primero?', '[{"texto": "Orientacion - ya la tienes", "es_correcta": false}, {"texto": "Goal - necesitas especificar objetivo medible y audiencia concreta", "es_correcta": true}, {"texto": "Ejemplo - falta un ejemplo", "es_correcta": false}, {"texto": "Constraint - faltan restricciones", "es_correcta": false}]'::jsonb, 'El Goal es vago (''crea una estrategia''). Especificar objetivo (ej: aumentar engagement 20%), plataforma, audiencia y plazo hace la diferencia.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(90, 3, 'Un companero dice: ''Si uso Copilot de Microsoft, no necesito preocuparme por seguridad porque Microsoft protege todo.'' Esta afirmacion es:', '[{"texto": "Correcta, Copilot tiene todas las protecciones necesarias", "es_correcta": false}, {"texto": "Incorrecta: la herramienta corporativa reduce riesgos pero el usuario sigue siendo responsable de que datos comparte y como los usa", "es_correcta": true}, {"texto": "Correcta si tienes licencia empresarial", "es_correcta": false}, {"texto": "Correcta para documentos internos, incorrecta para datos de clientes", "es_correcta": false}]'::jsonb, 'La herramienta segura no elimina la responsabilidad del usuario. El principio de minimizacion siempre aplica.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(91, 3, 'Necesitas que la IA genere un template de propuesta comercial. El componente Ejemplo de GOCE seria:', '[{"texto": "Decirle ''haz algo profesional''", "es_correcta": false}, {"texto": "Mostrarle una propuesta anterior exitosa (anonimizada) como referencia de estructura y tono", "es_correcta": true}, {"texto": "Pedirle que busque ejemplos en internet", "es_correcta": false}, {"texto": "Darle el nombre de un competidor para que copie su estilo", "es_correcta": false}]'::jsonb, 'El Ejemplo muestra a la IA exactamente que formato y estilo esperas. Un ejemplo real anonimizado es la mejor referencia.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(92, 3, 'Descubres que un equipo de tu empresa comparte un login de ChatGPT Plus entre 5 personas para ''ahorrar licencias.'' Cual es el riesgo PRINCIPAL?', '[{"texto": "Violacion de terminos de servicio", "es_correcta": false}, {"texto": "Todos ven el historial de prompts de todos, incluyendo datos confidenciales que cada uno ingreso", "es_correcta": true}, {"texto": "La cuenta podria ser bloqueada", "es_correcta": false}, {"texto": "No hay riesgo si todos son del mismo equipo", "es_correcta": false}]'::jsonb, 'Compartir cuenta expone historiales cruzados. Un usuario podria ver datos sensibles de RRHH, finanzas o clientes que otro ingreso.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(159, 3, 'Un analista escribe este prompt: ''Actua como analista financiero senior. El area de tesoreria necesita un informe del flujo de caja de marzo para el comite directivo. Usa formato ejecutivo con 3 parrafos.'' Al aplicar el framework de 5 componentes expandido, que componente CRITICO falta que podria causar un resultado inapropiado?', '[{"texto": "Rol, ya que ''analista financiero'' es muy generico", "es_correcta": false}, {"texto": "Restricciones: sin limites sobre que NO incluir, la IA podria agregar proyecciones especulativas, datos sensibles o recomendaciones fuera de su alcance", "es_correcta": true}, {"texto": "Contexto, porque no especifica el mes exacto", "es_correcta": false}, {"texto": "Formato, porque ''3 parrafos'' no es suficiente", "es_correcta": false}]'::jsonb, 'El framework de 5 componentes agrega Restricciones como quinto elemento. Sin restricciones, la IA puede incluir contenido inapropiado para la audiencia o el nivel de confidencialidad.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(160, 3, 'Necesitas anonimizar esta frase para un prompt: ''La gerente de operaciones Maria Lopez reporto que el vuelo AV204 del 15 de marzo tuvo 3 horas de retraso por falla en el motor #2, afectando a 180 pasajeros del programa LifeMiles Gold.'' Cual anonimizacion es INSUFICIENTE?', '[{"texto": "Reemplazar ''Maria Lopez'' por [GERENTE_AREA] y ''AV204'' por [VUELO]", "es_correcta": true}, {"texto": "Reemplazar nombre, vuelo, fecha exacta, detalle tecnico del motor y categoria de pasajeros", "es_correcta": false}, {"texto": "Generalizar todo: ''Una gerente reporto retraso significativo en un vuelo por problema tecnico, afectando pasajeros frecuentes''", "es_correcta": false}, {"texto": "Usar seudonimizacion: ''Empleada A reporto que el vuelo X tuvo retraso por falla en sistema Y''", "es_correcta": false}]'::jsonb, 'Solo cambiar nombre y vuelo es insuficiente. La fecha exacta, el detalle tecnico (motor #2) y la categoria especifica (Gold) permiten identificar el incidente y las personas. La anonimizacion debe cubrir TODOS los campos identificables.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(161, 3, 'Tu prompt genera un resultado mediocre. Iteraste 3 veces pero sigue sin mejorar. El prompt actual tiene Goal claro, Context detallado, Expectations de formato, y Source definida. Segun el proceso de construccion de prompts, cual es la estrategia de iteracion MAS efectiva en este punto?', '[{"texto": "Agregar mas contexto al prompt", "es_correcta": false}, {"texto": "Cambiar de herramienta de IA", "es_correcta": false}, {"texto": "Replantear el Goal: quizas el objetivo esta mal definido o es demasiado amplio, y todo el prompt esta optimizando para la pregunta equivocada", "es_correcta": true}, {"texto": "Agregar un ejemplo de formato esperado", "es_correcta": false}]'::jsonb, 'Segun el proceso de construccion de prompts, cuando la iteracion no mejora resultados, hay que volver al inicio del ciclo: replantear si el objetivo mismo es correcto. Los demas componentes no compensan un Goal mal definido.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(162, 3, 'Tu colega aplica la ''prueba de la valla publicitaria'' a un prompt y concluye que es seguro porque no tiene nombres de personas. Sin embargo, el prompt dice: ''Analiza el desempeno del unico piloto que vuela la ruta Bogota-Toronto los martes y jueves.'' Pasa la prueba?', '[{"texto": "Si, porque no hay nombres ni documentos de identidad", "es_correcta": false}, {"texto": "No, porque la combinacion de ruta unica + dias especificos + rol de piloto identifica a una persona sin necesidad de nombrarla", "es_correcta": true}, {"texto": "Si, porque la ruta y los dias no son datos personales", "es_correcta": false}, {"texto": "Depende de si el piloto es conocido publicamente", "es_correcta": false}]'::jsonb, 'La prueba de la valla publicitaria evalua si alguien podria identificar personas, no solo si hay nombres. La combinacion de atributos unicos puede ser tan identificable como un nombre completo.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(163, 3, 'Copilot empresarial opera dentro del tenant de Microsoft 365 y no entrena con tus datos. Un colega argumenta: ''Entonces no hay diferencia entre pegar un contrato completo o solo las clausulas relevantes.'' Por que esta equivocado?', '[{"texto": "Porque Copilot podria fallar con documentos largos", "es_correcta": false}, {"texto": "Porque el principio de minimo privilegio aplica independientemente de la seguridad de la herramienta: no compartir mas datos de los necesarios reduce riesgo ante errores de canal, auditorias y exposicion accidental", "es_correcta": true}, {"texto": "Porque Copilot si entrena con algunos datos", "es_correcta": false}, {"texto": "Porque los contratos son confidenciales incluso para herramientas corporativas", "es_correcta": false}]'::jsonb, 'El protocolo de anonimizacion ensena que la seguridad de la herramienta y la higiene del dato son capas complementarias, no sustitutas. El principio de minimo privilegio aplica siempre.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(93, 4, 'Necesitas clasificar 50 correos de clientes como ''queja'', ''consulta'' o ''felicitacion''. Nunca has hecho esto con IA. Mejor approach?', '[{"texto": "Zero-shot: ''Clasifica este correo''", "es_correcta": false}, {"texto": "Few-shot: dar 2-3 ejemplos de cada categoria antes de pedir la clasificacion", "es_correcta": true}, {"texto": "Pedirle que invente sus propias categorias", "es_correcta": false}, {"texto": "Clasificar manualmente los primeros 10 y dejar el resto a la IA", "es_correcta": false}]'::jsonb, 'Few-shot con ejemplos por categoria le muestra a la IA exactamente tu criterio de clasificacion, reduciendo ambiguedad.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(94, 4, 'Quieres que la IA escriba descripciones de producto en tu estilo especifico. Tus ejemplos few-shot deben:', '[{"texto": "Ser los mejores textos que encuentres en internet", "es_correcta": false}, {"texto": "Ser textos reales de TU marca que representen el tono y estructura deseada", "es_correcta": true}, {"texto": "Ser lo mas variados posible en estilo", "es_correcta": false}, {"texto": "Incluir al menos 10 ejemplos para precision", "es_correcta": false}]'::jsonb, 'Los ejemplos few-shot deben reflejar TU estilo deseado. 2-3 ejemplos consistentes son mas efectivos que 10 variados.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(95, 4, 'Estas usando chaining para crear una propuesta: Paso 1 analiza necesidades, Paso 2 busca soluciones, Paso 3 redacta. El Paso 2 da resultados irrelevantes. Que haces?', '[{"texto": "Repetir todo el chain desde el inicio", "es_correcta": false}, {"texto": "Revisar y corregir solo el Paso 2, verificando que recibio bien el output del Paso 1", "es_correcta": true}, {"texto": "Agregar un Paso 2.5 para filtrar", "es_correcta": false}, {"texto": "Saltar al Paso 3 con lo que hay", "es_correcta": false}]'::jsonb, 'La ventaja del chaining es que puedes depurar cada paso independientemente sin repetir todo.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(96, 4, 'Tu equipo necesita estandarizar respuestas a preguntas frecuentes de clientes. Zero-shot o few-shot?', '[{"texto": "Zero-shot, porque las preguntas son simples", "es_correcta": false}, {"texto": "Few-shot con ejemplos de respuestas aprobadas, para garantizar consistencia de tono y precision", "es_correcta": true}, {"texto": "Da igual, el resultado sera similar", "es_correcta": false}, {"texto": "Zero-shot con instrucciones muy detalladas", "es_correcta": false}]'::jsonb, 'Cuando necesitas consistencia y un estilo especifico, few-shot con ejemplos aprobados es superior a instrucciones detalladas.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(97, 4, 'Diseñas un chain de 6 pasos para generar un informe completo. Al ejecutarlo, el resultado final es incoherente. Cual es la causa MAS probable?', '[{"texto": "La IA no puede manejar 6 pasos", "es_correcta": false}, {"texto": "Un paso intermedio genero output incorrecto que contamino los pasos siguientes (error en cascada)", "es_correcta": true}, {"texto": "Necesitas un modelo mas potente", "es_correcta": false}, {"texto": "El chain es demasiado largo, maximo 3 pasos", "es_correcta": false}]'::jsonb, 'El error en cascada es el riesgo principal del chaining. Validar outputs intermedios es esencial.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(98, 4, 'Quieres que la IA extraiga datos especificos de contratos (fechas, montos, partes). Tu ejemplo few-shot muestra: Input: contrato completo -> Output: tabla con campos. Que falta?', '[{"texto": "Mas ejemplos", "es_correcta": false}, {"texto": "Un ejemplo donde el dato NO existe en el contrato, para que la IA aprenda a decir ''no encontrado'' en vez de inventar", "es_correcta": true}, {"texto": "Instrucciones mas largas", "es_correcta": false}, {"texto": "Nada, el ejemplo es suficiente", "es_correcta": false}]'::jsonb, 'Los ejemplos few-shot deben incluir casos negativos. Sin ellos, la IA inventara datos faltantes en vez de indicar ausencia.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(99, 4, 'Para un proceso de onboarding, diseñas este chain: 1) Generar temario -> 2) Crear contenido por tema -> 3) Disenar evaluacion. Cual es la MEJOR mejora?', '[{"texto": "Hacerlo todo en un solo prompt", "es_correcta": false}, {"texto": "Agregar paso de validacion humana entre cada paso antes de continuar al siguiente", "es_correcta": true}, {"texto": "Agregar mas pasos para mayor detalle", "es_correcta": false}, {"texto": "Usar modelos diferentes para cada paso", "es_correcta": false}]'::jsonb, 'La validacion humana entre pasos previene error en cascada y asegura que cada etapa cumple el objetivo antes de avanzar.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(100, 4, 'Tu jefe te pide analizar sentimiento en 100 resenas de producto. Tienes 3 resenas ya clasificadas por el equipo. Mejor estrategia?', '[{"texto": "Zero-shot con instrucciones de que es positivo/negativo", "es_correcta": false}, {"texto": "Usar las 3 resenas clasificadas como few-shot examples y luego procesar en lotes con chaining", "es_correcta": true}, {"texto": "Pedir a la IA que clasifique sin contexto", "es_correcta": false}, {"texto": "Clasificar las 100 manualmente", "es_correcta": false}]'::jsonb, 'Combinacion optima: few-shot para calibrar criterio con ejemplos reales + chaining para procesar en lotes manejables.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(101, 4, 'Estas encadenando prompts y el Paso 3 necesita informacion del Paso 1 que el Paso 2 no paso. Solucion?', '[{"texto": "Repetir la informacion del Paso 1 en el Paso 3", "es_correcta": false}, {"texto": "Redisenar el chain para que cada paso pase explicitamente toda la informacion necesaria al siguiente", "es_correcta": true}, {"texto": "Hacer los 3 pasos en un solo prompt", "es_correcta": false}, {"texto": "Crear un Paso 2.5 que recupere la informacion", "es_correcta": false}]'::jsonb, 'En chaining, cada paso debe recibir todo el contexto necesario. Perder informacion entre pasos es un error de diseno del chain.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(102, 4, 'Cuando es MEJOR usar zero-shot en vez de few-shot?', '[{"texto": "Siempre, es mas rapido", "es_correcta": false}, {"texto": "Cuando la tarea es estandar y no requiere formato o criterio especifico de tu organizacion", "es_correcta": true}, {"texto": "Cuando tienes muchos ejemplos disponibles", "es_correcta": false}, {"texto": "Cuando el resultado debe ser preciso", "es_correcta": false}]'::jsonb, 'Zero-shot funciona bien para tareas genericas. Few-shot es necesario cuando necesitas un estilo, formato o criterio organizacional especifico.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(164, 4, 'Creas un prompt few-shot para clasificar quejas en 4 categorias: [Equipaje], [Retraso], [Servicio], [Reservas]. Tus 5 ejemplos son: 3 de [Equipaje], 1 de [Retraso], 1 de [Servicio], y ninguno de [Reservas]. Al clasificar una queja real sobre cobro duplicado en la app, la IA dice [Equipaje]. Que regla few-shot violaste?', '[{"texto": "Cantidad optima: deberian ser solo 3 ejemplos", "es_correcta": false}, {"texto": "Variedad: los ejemplos deben cubrir todas las categorias. Sin ejemplo de [Reservas] y con sesgo hacia [Equipaje], la IA no puede clasificar correctamente fuera de la clase dominante", "es_correcta": true}, {"texto": "Representatividad: los ejemplos no son reales", "es_correcta": false}, {"texto": "Formato consistente: falta estandarizar la estructura", "es_correcta": false}]'::jsonb, 'La regla de variedad dice que los ejemplos deben cubrir todas o la mayoria de las categorias. 3 de 5 ejemplos de la misma categoria sesga las respuestas hacia ella.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(165, 4, 'Tu chain de 3 pasos procesa encuestas de satisfaccion: Paso 1 extrae datos -> Paso 2 clasifica sentimiento -> Paso 3 genera reporte. La instruccion del Paso 2 dice ''clasifica como positivo o negativo'' pero tus ejemplos few-shot incluyen clasificaciones de ''positivo'', ''negativo'' y ''mixto''. Que va a hacer la IA?', '[{"texto": "Seguir la instruccion e ignorar la categoria ''mixto''", "es_correcta": false}, {"texto": "Imitar los ejemplos y usar tres categorias incluyendo ''mixto'', porque los ejemplos siempre ganan sobre las instrucciones cuando hay contradiccion", "es_correcta": true}, {"texto": "Dar un error por la contradiccion", "es_correcta": false}, {"texto": "Alternar entre 2 y 3 categorias al azar", "es_correcta": false}]'::jsonb, 'Una de las trampas del few-shot: cuando los ejemplos contradicen la instruccion, el modelo imita los ejemplos. Es un error comun documentado en las reglas de few-shot.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(166, 4, 'Necesitas generar un informe mensual que combina datos de ventas (Excel) con feedback de clientes (correos). Diseñas un chain: Paso A analiza ventas, Paso B analiza feedback. Ambos deben alimentar el Paso C que genera el informe unificado. Que patron de chaining estas usando?', '[{"texto": "Secuencial: A -> B -> C", "es_correcta": false}, {"texto": "Paralelo con merge: A + B -> C, donde dos ramas independientes alimentan un paso final de sintesis", "es_correcta": true}, {"texto": "Condicional: si ventas bajan, incluir feedback", "es_correcta": false}, {"texto": "Loop de refinamiento: borrador -> revision -> final", "es_correcta": false}]'::jsonb, 'El patron paralelo con merge ejecuta ramas independientes que luego convergen. Es el patron correcto cuando dos fuentes de datos distintas deben combinarse en un resultado final.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(167, 4, 'Tu jefe quiere que clasifiques 500 correos de proveedores como ''urgente'', ''informativo'' o ''accion requerida''. Te pide hacerlo zero-shot para ahorrar tiempo. Tu sabes que la clasificacion tiene criterios especificos de tu empresa (ej: cualquier mencion de SLA vencido es ''urgente''). Cual es tu MEJOR argumento?', '[{"texto": "Zero-shot es mas rapido y el resultado sera similar", "es_correcta": false}, {"texto": "Few-shot con 3-5 ejemplos que reflejen los criterios internos tomara 10 minutos extra de preparacion pero mejorara dramaticamente la consistencia, porque sin ejemplos la IA no conoce las reglas especificas de la empresa", "es_correcta": true}, {"texto": "Mejor hacerlo manualmente para garantizar calidad", "es_correcta": false}, {"texto": "Usar zero-shot con instrucciones muy detalladas del criterio", "es_correcta": false}]'::jsonb, 'La regla practica: cuando el criterio tiene una interpretacion especifica de la organizacion, few-shot supera a zero-shot con instrucciones detalladas, porque los ejemplos anclan el comportamiento.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(168, 4, 'Diseñas un chain para generar un plan de capacitacion: Paso 1 define temas, Paso 2 crea contenido por tema, Paso 3 diseña evaluacion. Segun el tip ''valida antes de avanzar'', decides revisar el output del Paso 1 antes de continuar. Encuentras que uno de los 5 temas propuestos es irrelevante. En vez de regenerar todo el Paso 1, que es lo MAS eficiente?', '[{"texto": "Ignorar el tema irrelevante y continuar con los 4 buenos", "es_correcta": false}, {"texto": "Editar manualmente el output del Paso 1 eliminando el tema irrelevante y agregando uno correcto, y luego pasar ese output corregido al Paso 2", "es_correcta": true}, {"texto": "Agregar una instruccion al Paso 2 para que ignore ese tema", "es_correcta": false}, {"texto": "Regenerar el Paso 1 completo con un prompt mejor", "es_correcta": false}]'::jsonb, 'La ventaja del chaining es que puedes intervenir entre pasos. Editar el output intermedio es mas eficiente que regenerar o propagar un error con workarounds en pasos posteriores.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(103, 5, 'Necesitas que la IA procese datos de encuestas con campos anidados (preguntas con sub-preguntas y opciones multiples). Mejor formato de prompt?', '[{"texto": "Texto plano con guiones", "es_correcta": false}, {"texto": "JSON para datos estructurados con niveles de anidacion claros", "es_correcta": true}, {"texto": "Tabla markdown", "es_correcta": false}, {"texto": "XML siempre es mejor para datos", "es_correcta": false}]'::jsonb, 'JSON es ideal para datos con estructura jerarquica y campos multiples. XML es mejor para documentos con mezcla de texto y metadatos.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(104, 5, 'Tu empresa no tiene politica de IA. Descubres que 8 equipos usan ChatGPT personal, 3 usan herramientas de IA no autorizadas, y nadie sabe que datos han compartido. Esto se llama:', '[{"texto": "Innovacion organica", "es_correcta": false}, {"texto": "Shadow AI: uso no autorizado de herramientas de IA sin gobernanza que genera riesgos invisibles", "es_correcta": true}, {"texto": "Adopcion temprana", "es_correcta": false}, {"texto": "Problema de TI", "es_correcta": false}]'::jsonb, 'Shadow AI es el uso de herramientas de IA fuera del control organizacional. El riesgo principal es que nadie sabe que datos ya fueron expuestos.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(105, 5, 'Creas un template para que tu equipo analice reportes mensuales con IA. El template debe incluir:', '[{"texto": "Solo el prompt", "es_correcta": false}, {"texto": "Instrucciones de anonimizacion, prompt con marcadores de posicion, formato de salida esperado, y checklist de verificacion", "es_correcta": true}, {"texto": "Ejemplo de reporte completo", "es_correcta": false}, {"texto": "Link a la herramienta de IA preferida", "es_correcta": false}]'::jsonb, 'Un template reutilizable completo incluye seguridad (anonimizacion), estructura (prompt), expectativa (formato) y calidad (verificacion).');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(106, 5, 'Un proveedor ofrece un plugin de IA para tu CRM que ''automatiza analisis de clientes.'' Antes de instalarlo, que debes verificar?', '[{"texto": "Que tenga buenas resenas", "es_correcta": false}, {"texto": "Que datos accede, donde los procesa, si los usa para entrenar modelos, y que pasa si el proveedor cierra", "es_correcta": true}, {"texto": "Que sea compatible con tu version de CRM", "es_correcta": false}, {"texto": "Que el precio sea razonable", "es_correcta": false}]'::jsonb, 'Herramientas externas de IA pueden acceder a datos sensibles del CRM. Evaluar flujo de datos, politicas de uso y riesgo de dependencia.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(107, 5, 'Necesitas estructurar un prompt largo con secciones de contexto, instrucciones y restricciones claramente separadas. Mejor formato?', '[{"texto": "Todo en un parrafo", "es_correcta": false}, {"texto": "XML con tags semanticos como <contexto>, <instrucciones>, <restricciones> para separacion clara", "es_correcta": true}, {"texto": "JSON con campos", "es_correcta": false}, {"texto": "Bullet points simples", "es_correcta": false}]'::jsonb, 'XML con tags semanticos organiza prompts largos de forma clara. El modelo identifica cada seccion por su tag.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(108, 5, 'Diseñas un template para generar reportes de ventas. El template tiene [PERIODO], [REGION], [PRODUCTO]. Un usuario pone datos de clientes reales en [REGION]. Que fallo?', '[{"texto": "El template esta mal diseñado", "es_correcta": false}, {"texto": "El template necesita instrucciones claras sobre que datos son permitidos en cada campo y cuales requieren anonimizacion", "es_correcta": true}, {"texto": "El usuario no siguio instrucciones", "es_correcta": false}, {"texto": "No deberia tener campo REGION", "es_correcta": false}]'::jsonb, 'Los templates deben incluir guia de seguridad por campo. Sin ella, los usuarios ingresaran datos sensibles por conveniencia.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(109, 5, 'Tu equipo usa 5 herramientas de IA diferentes (ChatGPT, Copilot, Midjourney, Jasper, Notion AI). Para reducir riesgo de Shadow AI, la PRIMERA accion debe ser:', '[{"texto": "Prohibir todas excepto una", "es_correcta": false}, {"texto": "Inventariar todas las herramientas en uso, clasificar riesgo por tipo de dato que manejan, y establecer politica de uso aprobado", "es_correcta": true}, {"texto": "Esperar a que TI se encargue", "es_correcta": false}, {"texto": "Capacitar al equipo en la que el lider prefiera", "es_correcta": false}]'::jsonb, 'No puedes gobernar lo que no conoces. El inventario es el primer paso para pasar de Shadow AI a IA gobernada.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(110, 5, 'Quieres que la IA analice feedback de clientes y devuelva resultados estructurados. Que formato de salida pedirle?', '[{"texto": "Texto libre para que sea natural", "es_correcta": false}, {"texto": "JSON con campos predefinidos (sentimiento, categoria, urgencia, resumen) para procesamiento automatizado posterior", "es_correcta": true}, {"texto": "Una tabla simple", "es_correcta": false}, {"texto": "XML porque es mas seguro", "es_correcta": false}]'::jsonb, 'Si los resultados alimentan otro sistema o proceso, JSON con esquema predefinido permite automatizacion confiable.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(111, 5, 'Un companero copia un template de prompts de un blog para analizar datos financieros de la empresa. Cual es el riesgo que NO esta considerando?', '[{"texto": "Que el prompt no funcione bien", "es_correcta": false}, {"texto": "El template podria contener instrucciones ocultas (prompt injection) que exfiltren datos o modifiquen el comportamiento del modelo", "es_correcta": true}, {"texto": "Que el blog tenga informacion desactualizada", "es_correcta": false}, {"texto": "Que el formato no sea compatible", "es_correcta": false}]'::jsonb, 'Los templates externos pueden contener instrucciones maliciosas no visibles que manipulan al modelo para filtrar datos.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(112, 5, 'Para una tarea compleja necesitas mezclar texto narrativo con datos estructurados en el prompt. Mejor combinacion de formatos?', '[{"texto": "Todo en JSON", "es_correcta": false}, {"texto": "XML para la estructura general con secciones narrativas en texto y datos en JSON embebido", "es_correcta": true}, {"texto": "Todo en texto plano", "es_correcta": false}, {"texto": "Markdown con tablas", "es_correcta": false}]'::jsonb, 'XML permite mezclar contenido narrativo con datos estructurados en JSON embebido, aprovechando lo mejor de ambos formatos.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(169, 5, 'Tu colega creo este template XML reutilizable para el equipo: <contexto>Datos del cliente: [NOMBRE_CLIENTE], contrato #[NUMERO_CONTRATO], monto: [MONTO_USD]</contexto>. Lo comparte en un canal de Teams para que todos lo usen con ChatGPT gratuito en casa. Cuantos riesgos de seguridad hay?', '[{"texto": "Uno: los datos no estan anonimizados", "es_correcta": false}, {"texto": "Dos: datos sin anonimizar y uso de herramienta no autorizada", "es_correcta": false}, {"texto": "Tres: los placeholders invitan a pegar datos reales, la herramienta destino es gratuita (entrena con datos), y se distribuye sin instrucciones de anonimizacion ni advertencias", "es_correcta": true}, {"texto": "Ninguno, los placeholders protegen los datos", "es_correcta": false}]'::jsonb, 'El template tiene un diseno de seguridad defectuoso: los placeholders invitan a insertar datos reales, la herramienta sugerida es gratuita (Shadow AI), y no incluye protocolo de anonimizacion. Combina problemas de M4 y M2.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(170, 5, 'Segun las estadisticas de Shadow AI, el 77% de empleados comparten datos corporativos en herramientas no autorizadas y el costo promedio de una brecha es $670,000 USD. Tu jefe dice: ''Pero nosotros usamos Copilot, asi que eso no nos aplica.'' Cual es la falla en su razonamiento?', '[{"texto": "Copilot no es tan seguro como cree", "es_correcta": false}, {"texto": "El 77% incluye a SUS empleados: tener Copilot no impide que personas del equipo usen herramientas gratuitas en paralelo, especialmente para tareas que perciben como rapidas o personales", "es_correcta": true}, {"texto": "Las estadisticas estan desactualizadas", "es_correcta": false}, {"texto": "Solo aplica a empresas sin politica de IA", "es_correcta": false}]'::jsonb, 'Tener herramienta corporativa no elimina Shadow AI. El caso Samsung demostro que incluso empresas tecnologicas enfrentan este problema. La cultura de uso seguro es tan importante como la herramienta.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(171, 5, 'Necesitas crear un prompt estructurado para generar reportes de incidentes que incluyen: datos del evento (fecha, tipo, severidad), personas involucradas, acciones tomadas, y lecciones aprendidas. XML o JSON seria mejor, y por que?', '[{"texto": "JSON, porque tiene mejor rendimiento", "es_correcta": false}, {"texto": "XML, porque el reporte mezcla secciones narrativas (acciones tomadas, lecciones) con datos estructurados (fecha, tipo), y las etiquetas XML manejan mejor esa combinacion que JSON", "es_correcta": true}, {"texto": "Da igual, ambos producen el mismo resultado", "es_correcta": false}, {"texto": "JSON, porque es mas moderno", "es_correcta": false}]'::jsonb, 'La comparacion del curso dice: XML es mejor para prompts largos con secciones narrativas, JSON es mejor para datos, listas y parametros numericos. Un reporte de incidentes mezcla ambos, pero el componente narrativo domina.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(172, 5, 'El caso Samsung involucro a 3 ingenieros que: pegaron codigo fuente, notas de reunion estrategica, y un reporte tecnico en ChatGPT gratuito. Si estos ingenieros hubieran aplicado una SOLA de las 6 reglas de oro, cual habria prevenido los 3 incidentes?', '[{"texto": "No usar cuentas personales para IA laboral", "es_correcta": false}, {"texto": "Usar unicamente las herramientas aprobadas por TI: si ChatGPT gratuito no estaba autorizado, ninguno de los 3 habria tenido donde pegar los datos", "es_correcta": true}, {"texto": "Nunca confiar ciegamente en la IA", "es_correcta": false}, {"texto": "Consultar con TI antes de probar nuevas aplicaciones", "es_correcta": false}]'::jsonb, 'La regla #1 (usar solo herramientas aprobadas) es el control mas efectivo porque actua como puerta de entrada. Las demas reglas son capas adicionales, pero si la herramienta no autorizada nunca se usa, el riesgo se elimina de raiz.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(173, 5, 'Creas una plantilla JSON con placeholders para que tu equipo genere agendas de capacitacion con IA. La plantilla incluye: tema, duracion, audiencia, nivel, formato_entrega, y restricciones. Un miembro del equipo la usa pero cambia "audiencia": "[NOMBRE_AREA]" por "audiencia": "Los 12 coordinadores de la regional de Bogota que reportan a Patricia Vega". Que regla del protocolo violo?', '[{"texto": "Uso de herramienta no autorizada", "es_correcta": false}, {"texto": "Principio de minimizacion y anonimizacion: incluyo cantidad exacta de personas, ubicacion, cargo, nombre de jefe directo, datos que combinados identifican al grupo y su lider", "es_correcta": true}, {"texto": "Formato incorrecto del JSON", "es_correcta": false}, {"texto": "No violo ninguna regla, son datos internos", "es_correcta": false}]'::jsonb, 'El placeholder invitaba a generalizar (ej: "equipo regional de area operativa"), pero el usuario especifico datos que identifican personas. La combinacion de detalles es tan identificable como poner nombres.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(113, 6, 'Necesitas crear una presentacion de 15 slides para el comite directivo. Copilot genera un borrador en PowerPoint. Tu siguiente paso?', '[{"texto": "Enviarla directamente, Copilot la hizo bien", "es_correcta": false}, {"texto": "Revisar narrativa, verificar datos, ajustar diseño a la marca, y validar que cada slide tenga un mensaje clave claro", "es_correcta": true}, {"texto": "Regenerar hasta que quede perfecta", "es_correcta": false}, {"texto": "Agregar mas slides por si faltan temas", "es_correcta": false}]'::jsonb, 'Copilot genera borradores utiles pero requiere revision de contenido, datos, marca y claridad de mensaje.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(114, 6, 'Quieres usar Designer de Copilot para crear un banner. Le pides ''un banner corporativo azul con logo.'' El resultado no tiene tu logo. Por que?', '[{"texto": "Designer no puede generar logos de marca", "es_correcta": false}, {"texto": "Designer genera imagenes desde cero basandose en texto; no accede a tus assets de marca ni puede reproducir logos existentes", "es_correcta": true}, {"texto": "Necesitas subir el logo primero", "es_correcta": false}, {"texto": "Debes describir el logo con mas detalle", "es_correcta": false}]'::jsonb, 'Designer es IA generativa de imagenes, no un editor. No accede a archivos de marca ni reproduce elementos visuales especificos.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(115, 6, 'Tu equipo necesita una encuesta de satisfaccion para un evento. Quieres usar Copilot en Forms. Cual es la MEJOR instruccion?', '[{"texto": "''Crea una encuesta de satisfaccion''", "es_correcta": false}, {"texto": "''Crea encuesta de 10 preguntas para evento corporativo: 3 de logistica (escala 1-5), 3 de contenido (opcion multiple), 2 abiertas de mejora, 2 de NPS''", "es_correcta": true}, {"texto": "''Encuesta profesional con preguntas variadas''", "es_correcta": false}, {"texto": "''Encuesta rapida de 5 preguntas''", "es_correcta": false}]'::jsonb, 'Especificar cantidad, tipo de preguntas, escalas y categorias da a Copilot suficiente contexto para generar algo util.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(116, 6, 'Necesitas crear contenido visual para redes sociales, un formulario de feedback, y un deck de ventas. Que herramienta de Copilot para cada uno?', '[{"texto": "PowerPoint para todo", "es_correcta": false}, {"texto": "Designer para visual de redes, Forms para feedback, PowerPoint para deck de ventas", "es_correcta": true}, {"texto": "Designer para todo lo visual, Word para lo demas", "es_correcta": false}, {"texto": "ChatGPT para generar todo y copiar a cada herramienta", "es_correcta": false}]'::jsonb, 'Cada herramienta de Copilot tiene su fortaleza: Designer para imagenes, Forms para encuestas/formularios, PowerPoint para presentaciones.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(117, 6, 'Copilot en PowerPoint genera slides con datos estadisticos impresionantes sobre tu industria. Cual es el riesgo PRINCIPAL?', '[{"texto": "Que los datos esten desactualizados", "es_correcta": false}, {"texto": "Los datos pueden ser completamente inventados (alucinaciones) y al estar en formato profesional parecen mas creibles", "es_correcta": true}, {"texto": "Que no sean relevantes para tu audiencia", "es_correcta": false}, {"texto": "Que la fuente no sea reconocida", "es_correcta": false}]'::jsonb, 'El formato profesional de las slides hace que datos alucinados parezcan mas creibles. Verificar cada dato contra fuentes reales.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(118, 6, 'Quieres que Copilot en Forms cree un quiz de capacitacion para tu equipo. Mejor estrategia?', '[{"texto": "''Crea un quiz de capacitacion''", "es_correcta": false}, {"texto": "Dar el tema especifico, nivel de dificultad, tipos de pregunta deseados, y pedir respuestas correctas para luego verificarlas tu", "es_correcta": true}, {"texto": "Crear las preguntas manualmente y solo usar Copilot para el formato", "es_correcta": false}, {"texto": "Generar multiples quizzes y elegir el mejor", "es_correcta": false}]'::jsonb, 'Copilot puede generar quizzes utiles pero las respuestas correctas DEBEN verificarse por un experto en el tema.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(119, 6, 'Designer de Copilot es MAS util para:', '[{"texto": "Editar fotos existentes con precision", "es_correcta": false}, {"texto": "Generar imagenes conceptuales rapidas para brainstorming, mockups iniciales o inspiracion visual", "es_correcta": true}, {"texto": "Crear material de marca final listo para publicar", "es_correcta": false}, {"texto": "Reemplazar al equipo de diseño grafico", "es_correcta": false}]'::jsonb, 'Designer es ideal para exploracion visual rapida, no para produccion final de marca. Siempre necesita refinamiento profesional.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(120, 6, 'Tu presentacion de PowerPoint generada por Copilot tiene 20 slides pero el comite solo tiene 10 minutos. Que haces?', '[{"texto": "Pedir a Copilot que la resuma", "es_correcta": false}, {"texto": "Identificar los 3-5 mensajes clave, reducir a slides esenciales, y usar notas del presentador para detalles adicionales", "es_correcta": true}, {"texto": "Hablar mas rapido", "es_correcta": false}, {"texto": "Enviar las 20 slides por correo antes de la reunion", "es_correcta": false}]'::jsonb, 'La edicion humana para adaptar al contexto (tiempo, audiencia, objetivo) es donde el profesional agrega valor sobre el borrador de IA.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(121, 6, 'Un companero dice: ''Copilot en Forms puede crear formularios de evaluacion 360 completos automaticamente.'' La realidad es:', '[{"texto": "Correcto, Forms es muy avanzado", "es_correcta": false}, {"texto": "Copilot genera un borrador util pero las preguntas de evaluacion 360 requieren revision de RRHH para alinearse con competencias organizacionales", "es_correcta": true}, {"texto": "Incorrecto, Forms no puede crear evaluaciones", "es_correcta": false}, {"texto": "Correcto solo con licencia E5", "es_correcta": false}]'::jsonb, 'Copilot acelera la creacion pero evaluaciones de desempeno requieren alineacion con el modelo de competencias de la organizacion.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(122, 6, 'Para una campana de marketing necesitas: 5 variantes de imagen, encuesta de preferencia, y deck de resultados. Cual es el flujo OPTIMO?', '[{"texto": "Crear todo en paralelo con diferentes herramientas", "es_correcta": false}, {"texto": "Designer para variantes visuales -> Forms para encuesta comparativa con las imagenes -> PowerPoint para deck con resultados y ganadora", "es_correcta": true}, {"texto": "PowerPoint para todo incluyendo las imagenes", "es_correcta": false}, {"texto": "Pedir a ChatGPT que diseñe todo el flujo", "es_correcta": false}]'::jsonb, 'El flujo secuencial aprovecha cada herramienta para su fortaleza y el output de una alimenta la siguiente.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(174, 6, 'Necesitas preparar 3 entregables para una reunion: (1) encuesta previa para recopilar expectativas de los asistentes, (2) presentacion de 10 slides con datos del trimestre, (3) imagen personalizada para la portada. Cual es la secuencia CORRECTA de herramientas y por que importa el orden?', '[{"texto": "Crear todo en paralelo con Copilot Chat", "es_correcta": false}, {"texto": "Primero Forms para la encuesta (recopila datos), luego Excel para analizar respuestas, despues PowerPoint con los datos verificados, y finalmente Designer para la portada que refleje el contenido", "es_correcta": true}, {"texto": "PowerPoint primero, luego Forms, luego Designer", "es_correcta": false}, {"texto": "Designer primero para definir el estilo visual, luego lo demas", "es_correcta": false}]'::jsonb, 'El orden importa porque cada paso alimenta al siguiente: Forms recopila datos, Excel los analiza, PowerPoint los presenta, y Designer crea la imagen sabiendo el contenido. Invertir el orden genera retrabajo.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(175, 6, 'Tu jefe pide que la presentacion de PowerPoint incluya el logo de la empresa generado por IA ''para que se vea mas moderno''. Por que deberias rechazar esta solicitud especifica?', '[{"texto": "Porque Copilot no puede crear presentaciones", "es_correcta": false}, {"texto": "Porque DALL-E no puede reproducir logotipos ni marcas registradas con precision; los logos generados tendran errores, y ademas se deben usar los archivos oficiales del manual de marca", "es_correcta": true}, {"texto": "Porque es ilegal generar logos con IA", "es_correcta": false}, {"texto": "Porque los logos generados no tienen suficiente resolucion", "es_correcta": false}]'::jsonb, 'Es una limitacion documentada de DALL-E/Designer: no genera texto legible ni marcas registradas con precision. Los logos siempre deben ser los archivos oficiales.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(176, 6, 'Quieres crear un formulario en Forms para evaluar el conocimiento de tu equipo sobre seguridad de datos. Le pides a Copilot que genere las preguntas. El resultado tiene 15 preguntas, todas de opcion multiple con 3 opciones. Que deberia ajustarse segun las mejores practicas?', '[{"texto": "Agregar mas preguntas", "es_correcta": false}, {"texto": "Pedir que incluya variedad de tipos de pregunta (escala Likert, texto abierto, seleccion multiple), agregar opcion ''No se/No aplica'', y revisar que la redaccion sea clara para tu audiencia especifica", "es_correcta": true}, {"texto": "Las 15 preguntas de opcion multiple estan bien", "es_correcta": false}, {"texto": "Reducir a 5 preguntas", "es_correcta": false}]'::jsonb, 'Los tips de Forms con Copilot recomiendan: especificar tipos de pregunta variados, incluir opciones de ''Otro'' o ''N/A'', y adaptar el lenguaje a la audiencia. Copilot genera un borrador funcional, no un producto terminado.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(177, 6, 'Generas una imagen en Copilot Designer con este prompt: ''Foto de nuestro equipo de ventas celebrando los resultados del trimestre en la oficina de Bogota.'' La imagen sale bien. Quieres usarla en el newsletter interno. Cual es el problema que probablemente NO estás considerando?', '[{"texto": "La imagen no tiene suficiente resolucion", "es_correcta": false}, {"texto": "Los empleados reales podrian sentirse incomodos al ver personas ficticias presentadas como su equipo, y se debe incluir nota de que la imagen fue generada con IA", "es_correcta": true}, {"texto": "La imagen podria tener errores de ortografia", "es_correcta": false}, {"texto": "El fondo no coincidira con la oficina real", "es_correcta": false}]'::jsonb, 'La leccion de Designer advierte: nunca usar imagenes generadas como fotos de empleados reales. En comunicaciones internas debe indicarse que es generada con IA. Presentar personas ficticias como reales viola principios de transparencia.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(178, 6, 'Tu equipo discute dos metodos para crear una presentacion sobre resultados trimestrales: Metodo A (generar desde PowerPoint con prompt) vs Metodo B (usar Copilot Chat para crear el archivo). Ambos producen resultados similares. En que situacion concreta es Metodo A claramente superior?', '[{"texto": "Cuando tienes prisa", "es_correcta": false}, {"texto": "Cuando necesitas iterar rapidamente sobre el diseno y contenido, porque trabajar directamente en PowerPoint da acceso inmediato a herramientas de edicion sin tener que descargar y abrir un archivo generado externamente", "es_correcta": true}, {"texto": "Cuando la presentacion es corta", "es_correcta": false}, {"texto": "No hay diferencia practica", "es_correcta": false}]'::jsonb, 'La leccion documenta que ambos metodos producen resultados similares, pero PowerPoint directo da acceso inmediato a edicion y diseno. Para iteracion rapida, el flujo sin descarga es superior.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(123, 7, 'Tu jefe quiere un agente de Copilot que apruebe gastos automaticamente segun politicas internas. Cual es el riesgo PRINCIPAL?', '[{"texto": "Que apruebe demasiado rapido", "es_correcta": false}, {"texto": "Un agente puede malinterpretar casos ambiguos en politicas y aprobar gastos fuera de politica sin juicio contextual humano", "es_correcta": true}, {"texto": "Que los empleados no confien en el agente", "es_correcta": false}, {"texto": "Que sea mas lento que un humano", "es_correcta": false}]'::jsonb, 'Los agentes ejecutan segun reglas pero carecen de juicio para casos grises. Aprobaciones financieras necesitan supervision humana para excepciones.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(124, 7, 'Tienes un Excel con 10,000 filas de transacciones. Copilot en Excel puede ayudarte a:', '[{"texto": "Solo crear graficas basicas", "es_correcta": false}, {"texto": "Analizar patrones, crear tablas dinamicas, generar formulas complejas, identificar anomalias y visualizar tendencias", "es_correcta": true}, {"texto": "Solo ordenar y filtrar", "es_correcta": false}, {"texto": "Reemplazar todo analisis manual", "es_correcta": false}]'::jsonb, 'Copilot en Excel es potente para analisis pero los resultados deben validarse, especialmente formulas y conclusiones.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(125, 7, 'Un agente de Copilot busca informacion en SharePoint y responde preguntas de empleados. Un empleado recibe respuesta incorrecta sobre politica de vacaciones. Que fallo?', '[{"texto": "SharePoint tiene info desactualizada", "es_correcta": false}, {"texto": "Puede ser ambas: el agente pudo interpretar mal un documento correcto, O el documento en SharePoint esta desactualizado; ambos riesgos deben gestionarse", "es_correcta": true}, {"texto": "El empleado hizo la pregunta mal", "es_correcta": false}, {"texto": "El agente necesita mas entrenamiento", "es_correcta": false}]'::jsonb, 'Dos puntos de falla: calidad de la fuente Y capacidad de interpretacion del agente. Hay que gestionar ambos.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(126, 7, 'Le pides a Copilot en Excel: ''Calcula el ROI de cada campana de marketing.'' Los resultados parecen razonables. Que debes hacer ANTES de presentarlos?', '[{"texto": "Nada, Copilot calcula bien", "es_correcta": false}, {"texto": "Verificar la formula que Copilot genero, validar con 2-3 calculos manuales, y confirmar que la definicion de ROI usada es la de tu empresa", "es_correcta": true}, {"texto": "Pedir que recalcule para confirmar", "es_correcta": false}, {"texto": "Agregar nota de que fue calculado por IA", "es_correcta": false}]'::jsonb, 'Copilot puede usar una formula de ROI diferente a la de tu empresa. Siempre verifica la formula, no solo el resultado.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(127, 7, 'Quieres crear un agente que resuma correos del dia y priorice los urgentes. Para que esto funcione, el agente necesita:', '[{"texto": "Acceso a todos los correos de la empresa", "es_correcta": false}, {"texto": "Acceso solo a TUS correos, criterios claros de urgencia definidos por ti, y limite de acciones (solo leer y resumir, no responder)", "es_correcta": true}, {"texto": "Integracion con calendario tambien", "es_correcta": false}, {"texto": "Entrenamiento con correos historicos", "es_correcta": false}]'::jsonb, 'Principio de minimo privilegio: el agente solo accede a lo necesario y solo ejecuta acciones permitidas.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(128, 7, 'Tu Excel tiene datos de ventas con celdas vacias, formatos inconsistentes de fecha, y duplicados. Le pides analisis a Copilot. Que pasara?', '[{"texto": "Copilot limpiara los datos automaticamente", "es_correcta": false}, {"texto": "Los resultados seran poco confiables: basura entra, basura sale. Debes limpiar datos ANTES de analizar", "es_correcta": true}, {"texto": "Copilot te advertira de los problemas", "es_correcta": false}, {"texto": "Solo los duplicados afectaran el resultado", "es_correcta": false}]'::jsonb, 'Garbage in, garbage out. La calidad del analisis depende de la calidad de los datos. Limpiar primero es fundamental.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(129, 7, 'Un agente de IA tiene acceso a tu CRM y calendario. Un dia, envia correos a clientes cancelando reuniones ''para optimizar tu agenda.'' Que principio se violo?', '[{"texto": "El agente tomo demasiado tiempo", "es_correcta": false}, {"texto": "El agente actuo autonomamente sin autorizacion explicita: los agentes deben tener limites claros de accion y requerir aprobacion para decisiones con impacto externo", "es_correcta": true}, {"texto": "El CRM no deberia conectarse al calendario", "es_correcta": false}, {"texto": "Los clientes deberian haber sido notificados", "es_correcta": false}]'::jsonb, 'Agentes con demasiada autonomia pueden tomar acciones daninas. Las acciones con impacto externo siempre requieren aprobacion humana.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(130, 7, 'Copilot en Excel te sugiere una formula LAMBDA compleja para tu analisis. Tu no entiendes LAMBDA. Que haces?', '[{"texto": "Usarla, Copilot sabe lo que hace", "es_correcta": false}, {"texto": "Pedir a Copilot que explique paso a paso que hace la formula, probarla con datos conocidos, y asegurarte de entenderla antes de usarla en produccion", "es_correcta": true}, {"texto": "Rechazarla y pedir algo mas simple", "es_correcta": false}, {"texto": "Buscar LAMBDA en Google", "es_correcta": false}]'::jsonb, 'Nunca uses formulas que no entiendas. Pedir explicacion a Copilot y validar con datos conocidos es el camino correcto.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(131, 7, 'Para cual escenario un agente de IA es MAS apropiado?', '[{"texto": "Decidir a quien promover en el equipo", "es_correcta": false}, {"texto": "Monitorear inventario y alertar cuando un producto baja del minimo, sugiriendo orden de reposicion para aprobacion humana", "es_correcta": true}, {"texto": "Negociar precios con proveedores", "es_correcta": false}, {"texto": "Evaluar desempeno de empleados", "es_correcta": false}]'::jsonb, 'Los agentes son ideales para monitoreo y alerta con reglas claras. Decisiones sobre personas requieren juicio humano.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(132, 7, 'Tu equipo quiere conectar un agente de Copilot a la base de datos de clientes, sistema de facturacion, y correo corporativo. Cual es la regla de oro?', '[{"texto": "Conectar todo para maximo valor", "es_correcta": false}, {"texto": "Cada conexion es un vector de riesgo: conectar solo lo necesario, con permisos minimos, acciones limitadas, y auditoria de cada interaccion", "es_correcta": true}, {"texto": "Conectar solo la base de clientes", "es_correcta": false}, {"texto": "Esperar a que TI lo configure", "es_correcta": false}]'::jsonb, 'Principio de minimo privilegio aplicado a agentes: cada conexion amplia la superficie de ataque. Solo lo estrictamente necesario.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(179, 7, 'Creaste un agente simple en M365 para responder preguntas sobre politicas de viaje de la empresa. Le subiste el manual como fuente de conocimiento. Un empleado pregunta: ''Cual es el presupuesto maximo para hotel en Nueva York?'' y el agente responde con un monto que era correcto el ano pasado pero fue actualizado hace 2 meses. Que fallo arquitectonico explica esto?', '[{"texto": "El agente no tiene acceso a internet", "es_correcta": false}, {"texto": "Los agentes simples no aprenden de interacciones pasadas ni actualizan automaticamente sus fuentes: el documento de SharePoint que tiene como fuente esta desactualizado y nadie lo ha reemplazado", "es_correcta": true}, {"texto": "El modelo tiene fecha de corte", "es_correcta": false}, {"texto": "El empleado formulo mal la pregunta", "es_correcta": false}]'::jsonb, 'Los agentes simples NO mejoran automaticamente con el uso y dependen de las fuentes que les subiste. Si el documento esta desactualizado, el agente da informacion obsoleta con total confianza.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(180, 7, 'Tu equipo quiere un agente que: reciba solicitudes de vacaciones, consulte el saldo en SAP, verifique con el calendario del equipo en Outlook, y envie la aprobacion al gerente. Cual de estas acciones NO puede hacer un agente simple (sin codigo)?', '[{"texto": "Recibir solicitudes en lenguaje natural", "es_correcta": false}, {"texto": "Consultar SAP, porque los agentes simples no acceden a sistemas externos sin conectores configurados por TI", "es_correcta": true}, {"texto": "Verificar el calendario de Outlook", "es_correcta": false}, {"texto": "Redactar un correo de respuesta", "es_correcta": false}]'::jsonb, 'Limitacion clave de agentes simples: no acceden a sistemas externos a Microsoft 365. SAP requiere agentes avanzados con conectores configurados por TI (Copilot Studio).');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(181, 7, 'Copilot en Excel genera una formula BUSCARV para cruzar datos de ventas con datos de costos por ruta. La formula funciona para las primeras 10 filas pero da #N/A en las siguientes. Cual es la causa MAS probable segun las limitaciones documentadas?', '[{"texto": "BUSCARV tiene un limite de filas", "es_correcta": false}, {"texto": "Los datos no estan formateados como Tabla, o hay inconsistencias de formato entre las hojas (espacios extra, formatos de texto vs numero) que confunden tanto a la formula como a Copilot", "es_correcta": true}, {"texto": "Copilot genero una formula incorrecta", "es_correcta": false}, {"texto": "Excel tiene un bug con BUSCARV", "es_correcta": false}]'::jsonb, 'La primera recomendacion para Copilot en Excel es formatear datos como Tabla con encabezados claros. Inconsistencias de formato son la causa mas comun de errores parciales en formulas.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(182, 7, 'Copilot en Excel analiza tu dataset de 50,000 filas y genera un insight: ''La ruta BOG-MDE tiene el margen mas alto con 23.5%.'' Tu verificacion manual de 5 filas al azar muestra margenes negativos para esa ruta. Antes de reportar el error, que debes revisar?', '[{"texto": "Si el modelo de Copilot esta actualizado", "es_correcta": false}, {"texto": "Si hay celdas vacias, formatos mixtos en las columnas de costos e ingresos, o si la hoja mezcla datasets no relacionados que Copilot pudo confundir en el calculo", "es_correcta": true}, {"texto": "Si Copilot uso la formula correcta", "es_correcta": false}, {"texto": "Ejecutar el analisis en otra herramienta de IA", "es_correcta": false}]'::jsonb, 'El tip de verificacion dice: revisar datos limpios primero (celdas vacias, formatos mixtos, datasets mezclados). Copilot procesa lo que ve. Si los datos estan sucios, el output sera incorrecto.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(183, 7, 'Un gerente crea un agente de Copilot para su equipo de finanzas y le sube 15 documentos de SharePoint como fuente de conocimiento. El agente responde preguntas sobre presupuestos citando secciones de documentos. Un dia, responde una pregunta sobre politica de gastos mezclando informacion de dos documentos diferentes que se contradicen (uno de 2024 y otro de 2025). Cual es el error de diseno?', '[{"texto": "El agente necesita un modelo mas potente", "es_correcta": false}, {"texto": "Las fuentes de conocimiento incluyen versiones contradictorias del mismo documento y no hay instrucciones que le digan al agente priorizar el mas reciente o senalar cuando detecte conflictos", "es_correcta": true}, {"texto": "15 documentos son demasiados para un agente", "es_correcta": false}, {"texto": "El agente deberia tener acceso a internet para verificar", "es_correcta": false}]'::jsonb, 'Los agentes no toman decisiones autonomas ni priorizan fuentes por fecha automaticamente. Las instrucciones del agente deben incluir reglas de prioridad y el creador debe curar las fuentes eliminando versiones obsoletas.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(68, 8, 'Tienes Excel con 500 registros de quejas (nombre, monto, tipo, resolucion). Mejor approach?', '[{"texto": "Subir a ChatGPT y pedir analisis", "es_correcta": false}, {"texto": "Anonimizar, estructurar prompt con contexto y formato, procesar en herramienta corporativa", "es_correcta": true}, {"texto": "Solo analizar campo ''tipo de queja''", "es_correcta": false}, {"texto": "Analizar y borrar historial", "es_correcta": false}]'::jsonb, 'Combina anonimizacion + prompt estructurado + herramienta corporativa.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(69, 8, 'Necesitas 5 correos de follow-up con tono progresivo (informativo a urgente). Mejor estrategia?', '[{"texto": "Pedir los 5 en un solo prompt", "es_correcta": false}, {"texto": "Prompt chaining: definir tonos, generar con few-shot, evaluar, encadenar ajustando", "es_correcta": true}, {"texto": "Generar uno y pedir variaciones", "es_correcta": false}, {"texto": "Escribirlos manualmente", "es_correcta": false}]'::jsonb, 'Aplica chaining + few-shot para control de tono progresivo.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(70, 8, 'Tu jefa pide que uses IA para redactar evaluaciones de desempeno de 8 personas. Respuesta MAS profesional?', '[{"texto": "Hacerlo tal cual", "es_correcta": false}, {"texto": "Negarse rotundamente", "es_correcta": false}, {"texto": "Proponer enfoque intermedio: IA para estructura y guia, jefa escribe con conocimiento directo, IA pule redaccion sin datos identificables", "es_correcta": true}, {"texto": "Hacerlo pero no decir a empleados", "es_correcta": false}]'::jsonb, 'Enfoque intermedio respeta autoridad, protege integridad y usa IA donde agrega valor.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(71, 8, 'Proveedor te envia agente de IA que pide acceso a tu base de clientes. Que riesgos?', '[{"texto": "Podria extraer datos al proveedor", "es_correcta": false}, {"texto": "Datos para entrenar modelos de competidores", "es_correcta": false}, {"texto": "Sin auditoria de que hace con los datos", "es_correcta": false}, {"texto": "Todas las anteriores", "es_correcta": true}]'::jsonb, 'Multiples vectores: fuga, uso no autorizado, falta de transparencia.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(72, 8, 'Chatbot con 95% precision pero 5% error en politicas de devolucion. El equipo dice ''excelente, lancemoslo.'' Tu analisis?', '[{"texto": "Estan en lo correcto", "es_correcta": false}, {"texto": "El 5% de error en politicas genera riesgo legal y reputacional desproporcionado; se necesita escalado humano", "es_correcta": true}, {"texto": "Mejorar hasta 99%", "es_correcta": false}, {"texto": "No lanzar hasta 100%", "es_correcta": false}]'::jsonb, 'El impacto del error importa mas que su frecuencia.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(73, 8, 'Necesitas analizar 200 comentarios de clima laboral, algunos mencionan gerentes por nombre. Secuencia correcta?', '[{"texto": "Subir archivo y pedir analisis", "es_correcta": false}, {"texto": "Anonimizar nombres, estructurar prompt con rol+contexto+formato, herramienta corporativa, validar con RRHH", "es_correcta": true}, {"texto": "Solo extraer palabras clave", "es_correcta": false}, {"texto": "Pedir al LLM que anonimice automaticamente", "es_correcta": false}]'::jsonb, 'Flujo completo del curso. Para anonimizar, la IA tiene que LEER los nombres primero (D es riesgoso).');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(74, 8, 'Marketing creo campana completa con IA. Director pregunta: ''Lo hizo nuestro equipo creativo?'' Respuesta correcta?', '[{"texto": "Si, el equipo lo creo", "es_correcta": false}, {"texto": "El equipo creo estrategia y direccion, uso IA generativa para producir assets, revisando y ajustando", "es_correcta": true}, {"texto": "Lo hizo la IA, nosotros revisamos", "es_correcta": false}, {"texto": "No es necesario mencionarlo", "es_correcta": false}]'::jsonb, 'Transparencia sobre uso de IA es principio etico fundamental.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(75, 8, 'RRHH ofrece sistema de IA que monitorea pulsaciones, tiempo en apps, navegacion. Promete +25% productividad. Mejor analisis?', '[{"texto": "Si el ROI justifica inversion", "es_correcta": false}, {"texto": "Privacidad, impacto en confianza y moral, legalidad, si metricas miden productividad real o actividad, riesgo de gaming", "es_correcta": true}, {"texto": "Si empleados estan de acuerdo", "es_correcta": false}, {"texto": "Probarlo con piloto", "es_correcta": false}]'::jsonb, 'Analisis multi-dimensional: etica, psicologia, legalidad, validez de metricas, efectos secundarios.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(76, 8, 'Creaste informe con IA para CEO: 8 estadisticas, 3 graficas, 5 fuentes. Tu checklist?', '[{"texto": "Revisar ortografia", "es_correcta": false}, {"texto": "Verificar cada estadistica contra fuente original, confirmar fuentes existen, validar graficas, agregar nota de metodologia", "es_correcta": true}, {"texto": "Pedirle a la IA que revise su propio informe", "es_correcta": false}, {"texto": "Enviar con nota ''datos sujetos a verificacion''", "es_correcta": false}]'::jsonb, 'Verificar CADA dato. La IA confirma sus propios errores.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(77, 8, 'Agente de Copilot para politicas internas. Empleado pregunta sobre dia libre por emergencia, agente dice ''si puedes''. La politica real dice siempre notificar. Que implica?', '[{"texto": "Necesita mas entrenamiento", "es_correcta": false}, {"texto": "Agentes deben: citar seccion exacta, incluir disclaimer ''verifica con RRHH'', revision periodica, nunca respuestas definitivas sobre derechos laborales", "es_correcta": true}, {"texto": "Desactivar inmediatamente", "es_correcta": false}, {"texto": "Caso aislado, 95% correcto", "es_correcta": false}]'::jsonb, 'Error en politicas laborales puede crear precedentes legales. Disenar con salvaguardas.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(78, 8, 'Automatizar propuestas comerciales (analizar necesidades, consultar catalogo, calcular presupuesto, redactar). Mejor diseno?', '[{"texto": "Un solo prompt largo", "es_correcta": false}, {"texto": "Pipeline encadenado: analisis estructurado -> matching con catalogo -> calculo verificado por humano -> redaccion con template, revision al final", "es_correcta": true}, {"texto": "IA genera todo, humano revisa", "es_correcta": false}, {"texto": "Solo IA para redaccion final", "es_correcta": false}]'::jsonb, 'Chaining con herramienta correcta para cada paso y supervision humana.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(79, 8, 'Puedes generar resenas positivas falsas indistinguibles de reales. Jefe dice ''la competencia lo hace.'' Tu posicion?', '[{"texto": "Si la competencia lo hace, debemos", "es_correcta": false}, {"texto": "Es deshonesta, puede tener consecuencias legales, dano reputacional devastador si se descubre; proponer alternativas eticas", "es_correcta": true}, {"texto": "Hacerlo moderadamente", "es_correcta": false}, {"texto": "Consultar legal", "es_correcta": false}]'::jsonb, '''La competencia lo hace'' nunca es justificacion etica. En muchas jurisdicciones es ilegal.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(80, 8, 'IA empresarial: empleado junior pregunta salario del CEO y la herramienta responde. Que fallo?', '[{"texto": "No deberia tener acceso a datos salariales", "es_correcta": false}, {"texto": "No implementa control de acceso basado en roles: responde basandose en lo que SABE, no en lo que el usuario esta AUTORIZADO a saber", "es_correcta": true}, {"texto": "El empleado no deberia preguntar", "es_correcta": false}, {"texto": "Bug de filtrado de palabras clave", "es_correcta": false}]'::jsonb, 'Problema de arquitectura de seguridad (RBAC), no de filtrado.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(81, 8, 'Articulo 1: ''IA reemplazara 40% empleos.'' Articulo 2: ''IA creara mas empleos.'' Posicion MAS informada?', '[{"texto": "El primero, automatizacion elimina empleos", "es_correcta": false}, {"texto": "El segundo, tecnologia crea empleos", "es_correcta": false}, {"texto": "Ambas probablemente extremas; IA transformara roles y el impacto depende del sector, velocidad de adopcion, politicas y reskilling", "es_correcta": true}, {"texto": "Imposible predecir", "es_correcta": false}]'::jsonb, 'Pensamiento critico requiere resistir narrativas simplistas.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(82, 8, 'Cual afirmacion refleja MEJOR la relacion ideal profesional-IA?', '[{"texto": "IA eventualmente hara la mayoria de nuestro trabajo", "es_correcta": false}, {"texto": "IA es amplificador que funciona mejor con criterio humano, pensamiento critico y conciencia de limitaciones", "es_correcta": true}, {"texto": "IA es util pero sobrevalorada", "es_correcta": false}, {"texto": "IA es peligrosa y debemos limitar su uso", "es_correcta": false}]'::jsonb, 'Resume la filosofia del curso: IA como amplificador con criterio profesional.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(151, 8, 'Tu empresa lanza un agente de Copilot para responder consultas de pasajeros sobre politicas de equipaje. El agente usa documentos de SharePoint como fuente. Un pasajero pregunta: ''Mi vuelo fue cancelado, tengo derecho a compensacion?'' El agente responde ''Si, tienes derecho a USD 250.'' Pero la politica real tiene condiciones (causa de cancelacion, antelacion, ruta). Que combinacion de fallas explica este error?', '[{"texto": "El modelo alucinó el monto y las condiciones", "es_correcta": false}, {"texto": "El agente no tiene acceso a los documentos correctos", "es_correcta": false}, {"texto": "Falla de diseno: las instrucciones del agente no incluyen restriccion de dar respuestas condicionales como definitivas, no cita la seccion de la politica, y no escala a humano en temas legales/compensatorios", "es_correcta": true}, {"texto": "El documento de SharePoint esta desactualizado", "es_correcta": false}]'::jsonb, 'Combina: limitaciones de agentes (M6), restricciones en prompts (M4/GOCE), y principio de que la IA no reemplaza juicio humano. Es un problema de arquitectura del agente, no del modelo.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(152, 8, 'Disenaste un pipeline con chaining de 4 pasos para procesar encuestas de clima laboral: 1) Anonimizar, 2) Clasificar sentimiento con few-shot, 3) Agrupar por tema, 4) Generar recomendaciones. Al revisar los resultados, las recomendaciones no tienen relacion con los datos originales. Aplicas depuracion: el Paso 1 funciona bien, el Paso 2 funciona bien, el Paso 3 agrupa correctamente. Donde esta el error?', '[{"texto": "El Paso 4 necesita mas contexto en el prompt", "es_correcta": false}, {"texto": "El Paso 3 paso las agrupaciones al Paso 4 sin incluir los comentarios originales anonimizados, y el Paso 4 genero recomendaciones solo a partir de etiquetas de categoria sin datos de respaldo", "es_correcta": true}, {"texto": "El modelo alucinó en el Paso 4", "es_correcta": false}, {"texto": "Necesitas agregar un Paso 5 de validacion", "es_correcta": false}]'::jsonb, 'Combina: error de diseno de chaining (M3) donde se pierde contexto entre pasos, anonimizacion (M2), y validacion de outputs. El chain debe pasar toda la informacion necesaria a cada paso.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(153, 8, 'La VP de Operaciones te pide crear una presentacion en PowerPoint con Copilot sobre la baja de puntualidad del trimestre, usando datos de un Excel con informacion de 200 vuelos (ruta, hora, causa de retraso, minutos de demora). Los datos incluyen nombres de pilotos y numeros de vuelo activos. Cual es la secuencia CORRECTA?', '[{"texto": "Subir el Excel a Copilot en PowerPoint y pedir la presentacion", "es_correcta": false}, {"texto": "Anonimizar el Excel (quitar nombres de pilotos, generalizar numeros de vuelo), analizar primero en Excel con Copilot para extraer insights, luego crear la presentacion en PowerPoint con los hallazgos verificados, y revisar que las graficas reflejen datos reales", "es_correcta": true}, {"texto": "Crear la presentacion manualmente y usar Copilot solo para mejorar el diseno", "es_correcta": false}, {"texto": "Usar Copilot Chat para generar la presentacion directamente desde el prompt", "es_correcta": false}]'::jsonb, 'Combina: anonimizacion (M2), Excel con Copilot (M6), PowerPoint con Copilot (M5), y verificacion de datos. Cada herramienta cumple un rol en la secuencia correcta.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(154, 8, 'Un equipo de 3 personas usa diferentes estrategias de IA: Ana usa prompts zero-shot largos con mucho contexto. Carlos usa few-shot con 8 ejemplos por tarea. Maria usa chaining de 2 pasos con prompts XML estructurados. Los tres trabajan sobre las mismas tareas de clasificacion de tickets con 4 categorias. Quien probablemente obtiene los resultados MAS consistentes y por que?', '[{"texto": "Ana, porque mas contexto siempre es mejor", "es_correcta": false}, {"texto": "Carlos, porque mas ejemplos eliminan toda ambiguedad", "es_correcta": false}, {"texto": "Maria, porque la estructura XML separa instrucciones claramente y el chaining permite verificar la clasificacion antes de actuar sobre ella", "es_correcta": true}, {"texto": "Los tres obtendran resultados similares", "es_correcta": false}]'::jsonb, 'Ana pierde consistencia por falta de patron (M3). Carlos excede los 3-5 ejemplos optimos y puede introducir sesgo (M3). Maria combina estructura (M4) con verificacion intermedia (M3), maximizando consistencia.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(155, 8, 'Tu empresa adopta un modelo de IA especializado en aviacion (tendencia de modelos especializados) que corre localmente en las laptops del equipo (Edge AI). Un gerente dice: ''Perfecto, ahora no necesitamos anonimizar porque los datos no salen del dispositivo.'' Es correcto?', '[{"texto": "Si, Edge AI elimina riesgos de privacidad", "es_correcta": false}, {"texto": "No: el modelo local puede guardar logs, la laptop puede ser robada, otros usuarios del equipo pueden acceder al historial, y el principio de minimizacion de datos aplica independientemente de donde corra el modelo", "es_correcta": true}, {"texto": "Parcialmente: solo hay que anonimizar datos de clientes, no internos", "es_correcta": false}, {"texto": "Depende de si la laptop tiene cifrado de disco", "es_correcta": false}]'::jsonb, 'Combina: Edge AI (M7), anonimizacion (M2), y 6 reglas de oro de Shadow AI (M4). La ubicacion del procesamiento no elimina la disciplina de proteccion de datos.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(156, 8, 'Diseñas un formulario en Forms con Copilot para evaluar la satisfaccion de 500 empleados. Quieres analizar los resultados en Excel con Copilot y luego crear una presentacion para el comite. Al analizar en Excel, Copilot genera una formula que dice que la satisfaccion promedio es 4.2/5. Tu revisas manualmente 5 registros al azar y calculas 3.6/5. Que deberias hacer ANTES de investigar la discrepancia?', '[{"texto": "Confiar en Copilot porque proceso todos los datos", "es_correcta": false}, {"texto": "Confiar en tu muestra manual", "es_correcta": false}, {"texto": "Verificar que los datos en Excel estan formateados como Tabla, que los encabezados son claros, y que no hay celdas vacias o formatos mixtos que puedan confundir a Copilot", "es_correcta": true}, {"texto": "Pedir a Copilot que recalcule", "es_correcta": false}]'::jsonb, 'Combina: Forms (M5), Excel con Copilot (M6), y principio de verificacion. La causa mas probable es que los datos no estan limpios, que es la primera limitacion documentada de Copilot en Excel.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(157, 8, 'Tu colega creo una imagen con Copilot Designer para una publicacion de LinkedIn de la empresa. La imagen muestra ''empleados diversos en una oficina moderna''. El texto del post, generado por Copilot Chat, dice que la empresa fue reconocida por su cultura inclusiva. Ni la foto ni el reconocimiento son reales. Cuantos problemas eticos y practicos hay en esta situacion?', '[{"texto": "Uno: la foto es generada por IA", "es_correcta": false}, {"texto": "Dos: foto falsa y dato inventado", "es_correcta": false}, {"texto": "Al menos cuatro: personas ficticias presentadas como empleados reales, dato de reconocimiento posiblemente alucinado por la IA, falta de transparencia sobre uso de IA en comunicacion publica, y riesgo reputacional si se descubre", "es_correcta": true}, {"texto": "Tres: foto falsa, dato falso, y falta de disclosure", "es_correcta": false}]'::jsonb, 'Combina: limitaciones de Designer/DALL-E (M5), alucinaciones (diagnostico), etica y transparencia (M4/M7), y regulacion que exige indicar cuando se usa IA. Cada capa agrega un riesgo.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(158, 8, 'Un directivo propone reemplazar el proceso de creacion de propuestas comerciales (que toma 3 dias) con un pipeline de IA que lo haga en 2 horas. El pipeline usaria: agente de Copilot para recopilar info del cliente desde SharePoint, chaining para analizar necesidades y generar la propuesta, template XML para formato estandar, y Designer para imagenes. Tu evaluacion profesional MAS completa es:', '[{"texto": "Excelente idea, la IA puede hacer todo eso", "es_correcta": false}, {"texto": "El pipeline es viable pero necesita: revision humana entre cada paso del chaining, verificacion de que el agente no invente datos del cliente, anonimizacion si se usan datos de propuestas anteriores como few-shot, y que las imagenes de Designer se marquen como generadas por IA", "es_correcta": true}, {"texto": "Demasiado complejo, mejor usar IA solo para la redaccion final", "es_correcta": false}, {"texto": "Viable si se entrena al equipo primero", "es_correcta": false}]'::jsonb, 'Integra: agentes y sus limitaciones (M6), chaining con validacion (M3), XML/templates (M4), anonimizacion (M2), Designer y transparencia (M5). La respuesta correcta no rechaza la idea sino que agrega las salvaguardas que el curso ensena.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(133, 11, 'Quieres usar IA para planificar un viaje familiar a Europa. Cual es la MEJOR forma de empezar?', '[{"texto": "''Planifica un viaje a Europa''", "es_correcta": false}, {"texto": "Dar contexto especifico: fechas, presupuesto, edades del grupo, intereses, restricciones alimentarias, y pedir itinerario dia por dia para validar", "es_correcta": true}, {"texto": "Pedir a la IA que elija el mejor destino", "es_correcta": false}, {"texto": "Buscar paquetes turisticos y luego pedir opinion a la IA", "es_correcta": false}]'::jsonb, 'El mismo principio del curso aplica: contexto especifico genera resultados utiles. Sin datos, la IA da recomendaciones genericas.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(134, 11, 'Usas la version gratuita de ChatGPT para pedir consejo medico sobre un sintoma persistente. La IA te da un diagnostico detallado. Que debes considerar?', '[{"texto": "Si el diagnostico suena logico, seguirlo", "es_correcta": false}, {"texto": "La IA no es profesional medico, puede dar informacion incorrecta o incompleta, y la version gratuita puede usar tus datos de salud para entrenamiento", "es_correcta": true}, {"texto": "Pedir segunda opinion a otra IA", "es_correcta": false}, {"texto": "Confiar si cita fuentes medicas", "es_correcta": false}]'::jsonb, 'Doble riesgo: precision cuestionable en temas medicos + datos de salud expuestos en version gratuita. Consultar profesional siempre.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(135, 11, 'Tu hijo de 14 anos usa ChatGPT para hacer toda su tarea escolar. Cual es tu preocupacion PRINCIPAL como padre?', '[{"texto": "Que lo descubran en la escuela", "es_correcta": false}, {"texto": "No esta desarrollando pensamiento critico, capacidad de escritura ni aprendizaje real; la IA esta reemplazando el proceso educativo, no complementandolo", "es_correcta": true}, {"texto": "Que use la version de pago sin permiso", "es_correcta": false}, {"texto": "Que la tarea tenga errores", "es_correcta": false}]'::jsonb, 'El objetivo de la tarea es aprender, no entregarla. Usar IA para reemplazar el proceso atrofia habilidades criticas en desarrollo.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(136, 11, 'Quieres usar IA para gestionar tus finanzas personales. Cual es el enfoque MAS seguro?', '[{"texto": "Compartir estados de cuenta con la IA para que analice tus gastos", "es_correcta": false}, {"texto": "Crear categorias de gasto anonimizadas (sin numeros de cuenta ni montos exactos) y pedir estrategias de ahorro generales adaptadas a tu perfil", "es_correcta": true}, {"texto": "Usar apps de finanzas con IA integrada sin revisar politicas de privacidad", "es_correcta": false}, {"texto": "No usar IA para finanzas personales", "es_correcta": false}]'::jsonb, 'Los principios de seguridad del curso aplican a lo personal: anonimizar datos financieros y nunca compartir numeros de cuenta.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(137, 11, 'La version gratuita de ChatGPT vs la version de pago (Plus/Pro). Cual es la diferencia MAS importante para un usuario personal?', '[{"texto": "La de pago es mas rapida", "es_correcta": false}, {"texto": "La de pago tiene mejores politicas de privacidad (no usa conversaciones para entrenamiento), acceso a modelos mas capaces, y funciones avanzadas como vision y analisis de archivos", "es_correcta": true}, {"texto": "La de pago no tiene limites de uso", "es_correcta": false}, {"texto": "No hay diferencia real, solo marketing", "es_correcta": false}]'::jsonb, 'La diferencia clave es privacidad: la version gratuita puede usar tus datos para entrenamiento. Para datos sensibles, esto importa.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(138, 11, 'Un amigo te dice: ''Use IA para escribir mi CV y carta de presentacion. Las envie a 50 empresas identicas.'' Cual es el problema?', '[{"texto": "Que las 50 empresas reciban lo mismo", "es_correcta": false}, {"texto": "CVs genericos de IA son detectables, no reflejan voz autentica, y sin personalizacion por empresa demuestran falta de interes genuino", "es_correcta": true}, {"texto": "Que la IA no tenga datos actualizados del mercado laboral", "es_correcta": false}, {"texto": "Ningun problema, es eficiente", "es_correcta": false}]'::jsonb, 'La IA es herramienta para personalizar y mejorar, no para reemplazar autenticidad. Reclutadores detectan contenido generico de IA.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(139, 11, 'Quieres usar IA para aprender un nuevo idioma. Cual es la estrategia MAS efectiva?', '[{"texto": "Pedirle que traduzca todo lo que necesites", "es_correcta": false}, {"texto": "Usarla como tutor conversacional: practicar dialogos, pedir correccion con explicaciones, y crear ejercicios personalizados a tu nivel", "es_correcta": true}, {"texto": "Solo usar apps dedicadas de idiomas", "es_correcta": false}, {"texto": "Memorizar vocabulario que la IA genere", "es_correcta": false}]'::jsonb, 'La IA como tutor interactivo permite practica personalizada ilimitada. Traducir todo no desarrolla la habilidad.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(140, 11, 'Ves un anuncio de una ''IA que predice tu futuro financiero con 95% de precision.'' Tu reaccion deberia ser:', '[{"texto": "Probarlo, 95% es muy alto", "es_correcta": false}, {"texto": "Escepticismo: ninguna IA predice el futuro con esa precision, probablemente es marketing enganoso o estafa para obtener datos financieros", "es_correcta": true}, {"texto": "Investigar la empresa detras", "es_correcta": false}, {"texto": "Probarlo con datos falsos primero", "es_correcta": false}]'::jsonb, 'El pensamiento critico del curso aplica a la vida personal: afirmaciones extraordinarias requieren evidencia extraordinaria.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(141, 11, 'Con la evolucion de la IA, cual habilidad personal sera MAS valiosa en los proximos anos?', '[{"texto": "Aprender a programar IA", "es_correcta": false}, {"texto": "Pensamiento critico, capacidad de hacer las preguntas correctas, y saber cuando confiar o cuestionar resultados de IA", "es_correcta": true}, {"texto": "Usar la mayor cantidad de herramientas de IA posible", "es_correcta": false}, {"texto": "Especializarse en un area que la IA no pueda hacer", "es_correcta": false}]'::jsonb, 'La habilidad meta es saber trabajar CON la IA: criterio para evaluar, creatividad para dirigir, y etica para decidir.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(142, 11, 'Usas IA para generar un plan de ejercicios personalizado. Le diste tu edad, peso, condiciones medicas y objetivos. Que riesgo acabas de crear?', '[{"texto": "Ningun riesgo, es informacion basica", "es_correcta": false}, {"texto": "Compartiste datos de salud sensibles que quedan en el historial del proveedor; ademas, el plan podria ser inadecuado para tus condiciones medicas sin supervision profesional", "es_correcta": true}, {"texto": "Solo el riesgo de que el plan no funcione", "es_correcta": false}, {"texto": "Riesgo de que te cobren mas por tus datos", "es_correcta": false}]'::jsonb, 'Doble riesgo: datos de salud expuestos al proveedor + recomendaciones de ejercicio que podrian ser daninas para tus condiciones.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(184, 11, 'Un amigo te recomienda una app de IA para ''gestionar tus finanzas automaticamente'' que pide acceso a tus cuentas bancarias. Segun los principios del curso, que deberias verificar ANTES de darle acceso?', '[{"texto": "Que tenga buenas calificaciones en la tienda de apps", "es_correcta": false}, {"texto": "Que datos accede la app, como los procesa, si los usa para entrenar modelos, que pasa si la empresa cierra, y si tiene respaldo de supervision clinica o financiera profesional", "es_correcta": true}, {"texto": "Que sea gratuita", "es_correcta": false}, {"texto": "Que funcione en tu telefono", "es_correcta": false}]'::jsonb, 'La leccion de IA para vida personal advierte: nunca ingresar datos financieros sensibles en herramientas no verificadas. Evaluar flujo de datos, politicas de uso, y respaldo profesional.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(185, 11, 'Segun las 7 tendencias, Gartner predice que el 40% de las aplicaciones empresariales integraran agentes de IA para finales de 2026. Tu director pregunta: ''Entonces debemos reemplazar a nuestros analistas con agentes?'' Cual es la respuesta MAS alineada con la tendencia real?', '[{"texto": "Si, los agentes son mas eficientes", "es_correcta": false}, {"texto": "No, los agentes son una moda pasajera", "es_correcta": false}, {"texto": "Los agentes autonomos necesitan supervisores humanos y liberan tiempo de tareas repetitivas para que los analistas se enfoquen en decisiones que requieren criterio; el diferenciador es la habilidad humana, no la herramienta", "es_correcta": true}, {"texto": "Depende del costo de licencias", "es_correcta": false}]'::jsonb, 'La tendencia #1 (agentes autonomos) y la #7 (IA como commodity) convergen: los agentes automatizan lo repetitivo, pero el valor diferencial esta en el criterio humano que los supervisa.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(186, 11, 'Usas ChatGPT como ''profesor personal'' para aprender Excel avanzado siguiendo la tecnica de 4 pasos. Completaste los pasos 1 (definir tema y nivel) y 2 (explicacion adaptada). En el paso 3, la IA te da 3 ejercicios pero los 3 son triviales. Que deberia decirle?', '[{"texto": "Gracias, ya entendi todo", "es_correcta": false}, {"texto": "Pedir que aumente la dificultad progresivamente: ''El ejercicio 1 esta bien como basico, pero necesito que el 2 sea intermedio y el 3 requiera combinar multiples funciones. No me des las respuestas.''", "es_correcta": true}, {"texto": "Buscar ejercicios en YouTube", "es_correcta": false}, {"texto": "Pasar directamente al paso 4 de evaluacion", "es_correcta": false}]'::jsonb, 'La tecnica de profesor personal dice: solicitar ejercicios con dificultad progresiva. Si los 3 son faciles, el paso correcto es iterar la solicitud, no aceptar ni abandonar.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(187, 11, 'La tendencia de ''fatiga del hype'' describe empresas que automatizaron produccion de contenido con IA sin supervision y vieron resultados negativos. Tu equipo genera newsletters semanales completamente con Copilot sin revision humana. Segun esta tendencia, que problemas se estan acumulando?', '[{"texto": "Los newsletters llegan tarde", "es_correcta": false}, {"texto": "Contenido repetitivo, posibles errores factuales no detectados, perdida de voz de marca autentica, y audiencia que eventualmente identifica el patron generico y deja de leer", "es_correcta": true}, {"texto": "El costo de Copilot se vuelve insostenible", "es_correcta": false}, {"texto": "No hay problema si el contenido es correcto", "es_correcta": false}]'::jsonb, 'La tendencia #6 (fatiga del hype) documenta: contenido generado sin supervision es repetitivo, pierde voz autentica y genera desconfianza. La IA genera el borrador, el humano aporta criterio editorial.');

INSERT INTO preguntas (id, prueba_id, texto, opciones, explicacion) VALUES
(188, 11, 'Edge AI permite que modelos corran en el dispositivo sin enviar datos a la nube. Tu colega dice: ''Perfecto, ahora puedo usar IA para todo sin preocuparme por nada.'' Ademas de los riesgos de privacidad que ya discutimos, que limitacion PRACTICA de Edge AI esta ignorando?', '[{"texto": "Edge AI es muy cara", "es_correcta": false}, {"texto": "Los modelos que corren localmente son mas pequenos y especializados, lo que significa que pueden ser menos capaces que los modelos completos en la nube para tareas complejas o generales", "es_correcta": true}, {"texto": "Edge AI no existe todavia", "es_correcta": false}, {"texto": "Solo funciona con Microsoft", "es_correcta": false}]'::jsonb, 'La tendencia #2 (Edge AI) y #3 (modelos especializados) se conectan: los modelos locales son mas pequenos por necesidad. Ganas privacidad y velocidad, pero pierdes capacidad general. No es un reemplazo universal de la nube.');

-- === RETOS (5 filas) ===
INSERT INTO retos (id, titulo, escenario, criterios_evaluacion, modulo_id) VALUES
(1, 'Automatizacion de proceso de seleccion', 'Tu equipo de seleccion recibe 50 hojas de vida por semana para una posicion. Actualmente, un analista dedica 3 horas revisando cada lote. Describe paso a paso como usarias Copilot Chat para optimizar este proceso. Incluye los prompts exactos que usarias y explica como verificarias los resultados.', '["Claridad del proceso propuesto", "Calidad de los prompts", "Consideracion de riesgos y verificacion", "Ahorro de tiempo estimado"]'::jsonb, 1);

INSERT INTO retos (id, titulo, escenario, criterios_evaluacion, modulo_id) VALUES
(2, 'Reporte de clima organizacional', 'Tienes los resultados de una encuesta de clima organizacional con 500 respuestas abiertas. Tu jefe necesita un resumen ejecutivo para manana. Describe como usarias Copilot y otras herramientas de IA para analizar las respuestas, identificar patrones y generar el reporte. Incluye prompts y pasos de verificacion.', '["Proceso de analisis propuesto", "Uso efectivo de Copilot", "Verificacion de resultados", "Presentacion del reporte"]'::jsonb, NULL);

INSERT INTO retos (id, titulo, escenario, criterios_evaluacion, modulo_id) VALUES
(3, 'Capacitacion con IA para el equipo', 'Te piden disenar un plan de capacitacion de 2 horas sobre uso basico de IA para un equipo de 20 personas de nomina que nunca han usado herramientas de IA. Describe como usarias Copilot para crear el contenido, las actividades practicas que incluirias, y como mediras el aprendizaje.', '["Estructura del plan de capacitacion", "Uso de Copilot en la creacion de contenido", "Actividades practicas relevantes", "Metricas de aprendizaje"]'::jsonb, NULL);

INSERT INTO retos (id, titulo, escenario, criterios_evaluacion, modulo_id) VALUES
(4, 'Optimizacion de comunicaciones internas', 'Tu area envia 15 comunicados al mes a diferentes publicos (operaciones, administrativos, tripulaciones). Cada uno toma 2 horas de redaccion y revision. Propone un flujo de trabajo con Copilot para reducir este tiempo a la mitad. Incluye prompts, plantillas y controles de calidad.', '["Flujo de trabajo propuesto", "Prompts y plantillas", "Controles de calidad", "Estimacion de ahorro de tiempo"]'::jsonb, NULL);

INSERT INTO retos (id, titulo, escenario, criterios_evaluacion, modulo_id) VALUES
(5, 'Analisis de rotacion de personal', 'Los ultimos 6 meses has notado un aumento del 15% en la rotacion de personal en areas operativas. Tienes acceso a datos de salida, encuestas de clima y metricas de desempeno. Describe como usarias Copilot y herramientas de IA para analizar la situacion, identificar causas raiz y proponer acciones. Detalla los prompts y la estrategia de analisis.', '["Enfoque analitico", "Uso de datos disponibles", "Prompts para analisis", "Propuestas de accion basadas en hallazgos"]'::jsonb, NULL);

-- === RESET SECUENCIAS ===
SELECT setval('modulos_id_seq',   (SELECT MAX(id) FROM modulos));
SELECT setval('lecciones_id_seq', (SELECT MAX(id) FROM lecciones));
SELECT setval('pruebas_id_seq',   (SELECT MAX(id) FROM pruebas));
SELECT setval('preguntas_id_seq', (SELECT MAX(id) FROM preguntas));
SELECT setval('retos_id_seq',     (SELECT MAX(id) FROM retos));
