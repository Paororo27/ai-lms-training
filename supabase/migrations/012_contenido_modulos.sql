-- 012_contenido_modulos.sql
-- Actualizar modulos existentes (1-6), crear modulos 7-8, y poblar lecciones

BEGIN;

-- ============================================================
-- PART 1: Actualizar modulos existentes y crear nuevos
-- ============================================================

UPDATE modulos SET titulo = 'Nuevos Horizontes: el despertar digital', descripcion = 'Introducción a la extensión de capacidades laborales con IA. Qué es Copilot, cómo funciona y por qué cambia tu forma de trabajar.' WHERE orden = 1;

UPDATE modulos SET titulo = 'Ingeniería del Diálogo: cómo construir mejores prompts', descripcion = 'Framework GOCE de Microsoft, técnicas de prompting, anonimización de datos y protocolo de seguridad con IA.' WHERE orden = 2;

UPDATE modulos SET titulo = 'El arte de enseñarle a la IA: Few-shot y Prompt Chaining', descripcion = 'Técnicas avanzadas: cuándo dar ejemplos a la IA, cómo encadenar prompts y patrones de encadenamiento para tareas complejas.' WHERE orden = 3;

UPDATE modulos SET titulo = 'Prompting avanzado: estructuras y seguridad', descripcion = 'Estructuras XML y JSON para prompts, templates reutilizables, generación de contenido y protección contra Shadow AI.' WHERE orden = 4;

UPDATE modulos SET titulo = 'Crea con Copilot: imágenes, formularios y presentaciones', descripcion = 'Herramientas de creación de contenido: Designer para imágenes, Forms para formularios inteligentes y PowerPoint con IA.', duracion_minutos = 40 WHERE orden = 5;

UPDATE modulos SET titulo = 'Agentes y Excel con Copilot', descripcion = 'Crea agentes de IA para automatizar tareas repetitivas y domina Excel con Copilot para análisis de datos.', duracion_minutos = 40 WHERE orden = 6;

INSERT INTO modulos (orden, semana, titulo, descripcion, contenido, duracion_minutos) VALUES
(7, 4, 'IA para tu vida personal', 'Panorama de herramientas de IA para uso personal: productividad, aprendizaje, salud, finanzas y el futuro de la tecnología.', '{}', 35)
ON CONFLICT (orden) DO UPDATE SET semana = EXCLUDED.semana, titulo = EXCLUDED.titulo, descripcion = EXCLUDED.descripcion, duracion_minutos = EXCLUDED.duracion_minutos;

INSERT INTO modulos (orden, semana, titulo, descripcion, contenido, duracion_minutos) VALUES
(8, 4, 'Reto final: demuestra lo que aprendiste', 'El desafío integrador que pone a prueba todas las habilidades del taller. Sin prueba, solo un reto profesional.', '{}', 30)
ON CONFLICT (orden) DO UPDATE SET semana = EXCLUDED.semana, titulo = EXCLUDED.titulo, descripcion = EXCLUDED.descripcion, duracion_minutos = EXCLUDED.duracion_minutos;

-- ============================================================
-- PART 2: Eliminar lecciones existentes de modulos 2-6
-- ============================================================

DELETE FROM lecciones WHERE modulo_id IN (SELECT id FROM modulos WHERE orden IN (2, 3, 4, 5, 6, 7, 8));

-- ============================================================
-- PART 3: Insertar lecciones para cada modulo
-- ============================================================

-- ============================================================
-- MODULO 2: Ingeniería del Diálogo
-- ============================================================

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 2), 1, 'Qué es un prompt y por qué importa', 'video',
 '{"media_url": "ugQQ8Xa6hI0", "texto": "Video de Pablo Prompt: introducción a Copilot para principiantes. Créditos: canal Pablo Prompt en YouTube."}', 10);

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 2), 2, 'Anatomía de un buen prompt: framework GOCE', 'texto',
 jsonb_build_object('texto', $md$# Anatomía de un buen prompt: el framework GOCE

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
- Microsoft Copilot - Galería de prompts: [https://copilot.cloud.microsoft/prompts](https://copilot.cloud.microsoft/prompts)$md$), 15);

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 2), 3, 'El escudo de la confianza', 'texto',
 jsonb_build_object('texto', $md$# 🛡️ El Escudo de la Confianza

Protegiendo el corazón de Talento Humano en la era de la IA.

---

## ⚠️ La advertencia que sacudió a Silicon Valley

En abril de 2023, **Samsung** se convirtió en el centro de una noticia que nadie en Talento Humano debería ignorar. Tres empleados, buscando optimizar su tiempo, cometieron un error crítico al usar versiones gratuitas de IA:

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

> 💡 En Talento Humano, la tecnología pone la eficiencia, pero nosotros ponemos el escudo de la confianza.$md$), 10);

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 2), 4, 'Protocolo de anonimización', 'texto',
 jsonb_build_object('texto', $md$# Protocolo de anonimización: protege la información antes de usar IA

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
- [Microsoft Purview para IA](https://learn.microsoft.com/es-es/purview/ai-microsoft-purview) -- Herramientas de auditoría, cumplimiento y gobernanza de datos en entornos de IA.$md$), 15);

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 2), 5, 'Práctica: reescribe prompts inseguros', 'ejercicio',
 '{"instrucciones": "A continuación tienes 3 prompts con datos sensibles. Tu tarea es reescribirlos aplicando las técnicas de anonimización del módulo.\n\n1. \"Redacta un correo para María González de Nómina, cédula 52.345.678, informando que su aumento de $850.000 fue aprobado por su jefe Carlos Ruiz.\"\n\n2. \"Analiza por qué el cliente Pedro Martínez, tarjeta Visa terminada en 4523, hizo 3 reclamos el mes pasado por cobros incorrectos de $1.234.567.\"\n\n3. \"Genera un reporte del empleado Juan Díaz, diagnosticado con estrés laboral, incapacitado hasta el 20 de abril, del área de operaciones de El Dorado.\"\n\nRecuerda: usa placeholders, generaliza datos y elimina toda información que identifique personas.", "texto": "Aplica la prueba de la valla publicitaria a cada prompt antes de enviarlo."}', 15);

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 2), 6, 'Errores comunes y cómo evitarlos', 'video',
 '{"media_url": "p2PqfRte46k", "texto": "Video de Cyberclick Marketing Digital: La fórmula del prompt perfecto. Créditos: canal Cyberclick en YouTube."}', 10);

-- ============================================================
-- MODULO 3: El arte de enseñarle a la IA
-- ============================================================

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 3), 1, 'Introducción a técnicas avanzadas de prompting', 'video',
 '{"media_url": "x-iTco25VGI", "texto": "Video de HolaMundo: técnicas avanzadas de prompting explicadas de forma clara. Créditos: canal HolaMundo en YouTube."}', 10);

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 3), 2, 'Zero-shot vs Few-shot: cuándo dar ejemplos a la IA', 'texto',
 jsonb_build_object('texto', $md$# Zero-shot vs Few-shot: cuándo y por qué dar ejemplos a la IA

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
- [Prompt.org.es - Few-shot vs Zero-shot: comparativa](https://www.prompt.org.es/docs/vs-metods/few-shot-vs-zero-shot-prompting-comparativa)$md$), 15);

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 3), 3, 'Práctica: clasifica quejas con few-shot', 'ejercicio',
 '{"instrucciones": "Vas a practicar la técnica few-shot con 3 escenarios de una aerolínea. Para cada uno, escribe un prompt few-shot con al menos 3 ejemplos y luego presenta la tarea real.\n\nEscenario 1: Clasificar correos internos en categorías [Urgente], [Informativo], [Acción requerida].\nEscenario 2: Categorizar comentarios de pasajeros en [Elogio], [Queja], [Sugerencia], [Pregunta].\nEscenario 3: Etiquetar solicitudes de empleados en [Vacaciones], [Capacitación], [Soporte TI], [Otro].\n\nPara cada escenario:\n1. Escribe 3 a 5 ejemplos variados que cubran todas las categorías\n2. Mantené el formato idéntico en cada ejemplo\n3. Agrega la tarea real al final sin la respuesta\n4. Verifica que tus ejemplos no introduzcan sesgo hacia una categoría", "texto": "Recuerda las 4 reglas: variedad, formato consistente, representatividad y cantidad óptima (3-5 ejemplos)."}', 15);

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 3), 4, 'Prompt Chaining: divide y vencerás con la IA', 'texto',
 jsonb_build_object('texto', $md$# Prompt Chaining: divide y vencerás con la IA

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
- [DataStudios - Microsoft Copilot Prompting Techniques](https://www.datastudios.org/post/microsoft-copilot-prompting-techniques-structure-grounding-and-workflow-optimisation)$md$), 15);

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 3), 5, 'Práctica: diseña una cadena de 3 prompts', 'ejercicio',
 '{"instrucciones": "Elige un proceso de tu área de trabajo que tenga al menos 3 etapas lógicas. Diseña una cadena de 3 prompts donde la salida de cada uno alimente al siguiente.\n\nEstructura tu entregable así:\n\n1. **Descripción del proceso:** Qué tarea vas a resolver y por qué necesita encadenamiento.\n\n2. **Prompt 1 (Extracción/Preparación):** Escribe el primer prompt que recopile o estructure la información inicial. Indica el formato de salida esperado.\n\n3. **Prompt 2 (Análisis/Transformación):** Escribe el segundo prompt que tome el resultado del Paso 1 y lo analice o transforme. Referencia explícitamente los datos del paso anterior.\n\n4. **Prompt 3 (Acción/Entregable):** Escribe el tercer prompt que genere el resultado final: un correo, un reporte, una recomendación o una decisión.\n\n5. **Patrón utilizado:** Indica cuál de los 4 patrones de encadenamiento aplicaste (Secuencial, Paralelo con merge, Condicional o Loop de refinamiento) y por qué.\n\nRecuerda: cada prompt debe tener un solo objetivo, un formato de salida claro y referenciar explícitamente el resultado anterior.", "texto": "Tip: Si no se te ocurre un proceso, usa este ejemplo: analizar las 5 preguntas más frecuentes de tu área, categorizarlas por urgencia y generar respuestas estandarizadas."}', 15);

-- ============================================================
-- MODULO 4: Prompting avanzado: estructuras y seguridad
-- ============================================================

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 4), 1, 'Estructuras avanzadas para prompts efectivos', 'video',
 '{"media_url": "BRy7Z3ZoQZk", "texto": "Video de Xavier Mitjana: cómo estructurar prompts avanzados con XML y JSON. Créditos: canal Xavier Mitjana en YouTube."}', 10);

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 4), 2, 'Estructuras XML y JSON para prompts', 'texto',
 jsonb_build_object('texto', $md$# Estructuras XML y JSON para prompts: organiza tus instrucciones como un profesional

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
- VisualSP. *Comprehensive Guide to Effective Microsoft Copilot Prompts*. [https://www.visualsp.com/blog/comprehensive-guide-to-effective-microsoft-copilot-prompts/](https://www.visualsp.com/blog/comprehensive-guide-to-effective-microsoft-copilot-prompts/)$md$), 15);

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 4), 3, 'Práctica: crea una plantilla XML reutilizable', 'ejercicio',
 '{"instrucciones": "Crea una plantilla XML reutilizable para un caso de uso de tu área de trabajo. La plantilla debe incluir:\n\n1. **Etiqueta <rol>:** Define quién es la IA en este escenario.\n2. **Etiqueta <contexto>:** Incluye al menos 3 campos con placeholders [CAMPO] que se puedan reemplazar.\n3. **Etiqueta <tarea>:** Describe la acción específica que la IA debe realizar.\n4. **Etiqueta <formato>:** Especifica cómo quieres la respuesta (longitud, estructura, tono).\n5. **Etiqueta <restricciones>:** Al menos 2 restricciones claras.\n\nDespués de crear la plantilla:\n- Llena los placeholders con datos ficticios para un caso concreto\n- Prueba el prompt completo en Copilot\n- Evalúa si el resultado cumple con lo esperado\n\nEntregable: la plantilla vacía + un ejemplo de uso con datos ficticios + el resultado de Copilot.", "texto": "Tip: Las mejores plantillas son las que puedes reutilizar al menos 5 veces al mes. Piensa en tareas que haces repetidamente."}', 15);

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 4), 4, 'Shadow AI: el peligro oculto en tu empresa', 'texto',
 jsonb_build_object('texto', $md$# Shadow AI: el peligro oculto en tu empresa

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
- [7Experts — Riesgos de seguridad y privacidad de ChatGPT en empresas](https://www.7experts.com/riesgos-seguridad-privacidad-chatgpt-empresas/) — Análisis de riesgos corporativos$md$), 15);

-- ============================================================
-- MODULO 5: Crea con Copilot
-- ============================================================

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 5), 1, 'Crear imágenes con Copilot Designer', 'texto',
 jsonb_build_object('texto', $md$# Crear imágenes con Copilot Designer

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
- Microsoft Designer. *Herramienta de diseño con IA*. [https://designer.microsoft.com/](https://designer.microsoft.com/)$md$), 15);

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 5), 2, 'Práctica: genera 3 imágenes para una presentación', 'ejercicio',
 '{"instrucciones": "Usando Copilot Designer, genera 3 imágenes para una presentación profesional de tu área. Cada imagen debe tener un propósito diferente:\n\n1. **Imagen de portada:** Genera una imagen que funcione como portada de una presentación sobre un tema relevante de tu departamento. Usa el formato SUJETO + CONTEXTO + ESTILO VISUAL + PARÁMETROS.\n\n2. **Imagen de sección:** Genera una imagen que ilustre un concepto clave de tu área (por ejemplo: trabajo en equipo, innovación, servicio al cliente). Usa un estilo diferente al de la portada.\n\n3. **Imagen para redes sociales:** Genera una imagen en formato cuadrado (1:1) que podría usarse en LinkedIn para comunicar un logro del equipo.\n\nPara cada imagen documenta:\n- El prompt que usaste\n- Por qué elegiste ese estilo y formato\n- Si iteraste el prompt y qué cambios hiciste\n- Si la imagen cumple con las guías de marca (colores corporativos, diversidad, profesionalismo)", "texto": "Recuerda: nunca presentes imágenes generadas por IA como fotos reales de empleados."}', 10);

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 5), 3, 'Formularios y presentaciones inteligentes con Copilot', 'texto',
 jsonb_build_object('texto', $md$# Formularios y presentaciones inteligentes con Copilot

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

## PARTE 2: PowerPoint + Copilot

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
- Microsoft Support. *Copilot en PowerPoint*. [https://support.microsoft.com/en-us/copilot-powerpoint](https://support.microsoft.com/en-us/copilot-powerpoint)$md$), 15);

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 5), 4, 'Práctica: crea una infografía sobre un tema de tu área', 'ejercicio',
 '{"instrucciones": "Usando las herramientas de Copilot que aprendiste en este módulo, crea una infografía o material visual sobre un tema relevante de tu área de trabajo.\n\nEl entregable debe incluir:\n\n1. **Tema elegido:** Describe brevemente el tema y por qué es relevante para tu departamento.\n\n2. **Imagen principal:** Genera al menos 1 imagen con Copilot Designer que ilustre el concepto central. Documenta el prompt que usaste.\n\n3. **Presentación o formulario:** Elige una de estas opciones:\n   - **Opción A (PowerPoint):** Crea una presentación de 5 slides sobre el tema usando Copilot en PowerPoint. Incluye el prompt que usaste y ajustes que hiciste.\n   - **Opción B (Forms):** Crea un formulario de evaluación o encuesta relacionada con el tema usando Copilot en Forms. Incluye el prompt y las preguntas generadas.\n\n4. **Reflexión:** En 3-5 oraciones, describe qué funcionó bien, qué ajustaste manualmente y qué limitaciones encontraste.\n\nRecuerda aplicar las buenas prácticas: colores corporativos, diversidad en imágenes, y verificación de contenido generado.", "texto": "Tip: Si eliges PowerPoint, pide a Copilot que agregue notas del orador para cada diapositiva."}', 10);

-- ============================================================
-- MODULO 6: Agentes y Excel con Copilot
-- ============================================================

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 6), 1, 'Agentes de Copilot y Excel con IA', 'texto',
 jsonb_build_object('texto', $md$# Agentes de Copilot y Excel con IA: automatiza tareas y potencia tus datos

Microsoft 365 Copilot no es solo un asistente de chat. Dentro del ecosistema hay dos capacidades que transforman la forma de trabajar en una aerolínea: los **agentes de Copilot** que automatizan flujos de trabajo específicos, y la **integración con Excel** que convierte hojas de cálculo en herramientas de análisis inteligente.

En esta lección vas a aprender a crear agentes simples sin programar y a usar Copilot dentro de Excel para analizar datos, generar fórmulas y crear visualizaciones, todo desde tu entorno corporativo de Avianca.

---

## Parte 1: Agentes de Copilot

### Qué son los agentes

Un **agente de Copilot** es un asistente de IA especializado en una tarea concreta. A diferencia de Copilot Chat (que responde preguntas generales), un agente está configurado con instrucciones, contexto y fuentes de datos específicas para resolver un tipo de problema particular.

Piensa en la diferencia entre llamar a un call center general y hablar con un especialista de tu área: el especialista ya conoce el contexto, las reglas y los sistemas relevantes. Eso es un agente.

### Dos niveles de agentes

Microsoft ofrece dos caminos para crear agentes según la complejidad que necesites:

**Agentes simples (sin código):** se crean directamente desde Microsoft 365 usando una interfaz gráfica. No requieren conocimientos técnicos. Son ideales para tareas repetitivas que siguen un patrón claro, como responder preguntas frecuentes o generar borradores a partir de plantillas.

**Agentes avanzados (Copilot Studio):** se construyen en Microsoft Copilot Studio, una plataforma dedicada que permite conectar fuentes de datos externas, definir flujos de conversación complejos y agregar lógica condicional. Estos agentes requieren apoyo del equipo de TI o de un especialista en automatización.

Para esta lección nos enfocamos en los agentes simples, que cualquier colaborador puede crear.

---

### Cómo crear un agente simple en Microsoft 365

Crear un agente básico en M365 toma menos de 10 minutos. Estos son los pasos:

1. **Abrir Microsoft 365 Copilot Chat** desde el navegador o la aplicación de escritorio
2. **Seleccionar "Crear agente"** en el menú lateral o desde la opción de agentes en la barra superior
3. **Definir el nombre y la descripción** del agente. Ejemplo: "Asistente de políticas de equipaje"
4. **Escribir las instrucciones** que definen el comportamiento del agente. Aquí es donde aplicas todo lo que aprendiste sobre prompting estructurado: rol, contexto, tarea, formato y restricciones
5. **Agregar fuentes de conocimiento** subiendo documentos (Word, PDF, PowerPoint) o conectando sitios de SharePoint que el agente debe consultar para responder
6. **Probar el agente** en la vista previa para verificar que responde correctamente
7. **Publicar y compartir** con tu equipo o área

```mermaid
flowchart TD
    A["Abrir Copilot Chat\nen M365"] --> B["Seleccionar\nCrear agente"]
    B --> C["Definir nombre\ny descripción"]
    C --> D["Escribir instrucciones\n(rol, contexto, tarea)"]
    D --> E["Agregar fuentes\nde conocimiento"]
    E --> F["Probar en\nvista previa"]
    F --> G{"¿Respuestas\ncorrectas?"}
    G -->|"Sí"| H["Publicar y\ncompartir"]
    G -->|"No"| D
    style A fill:#e0e7ff,stroke:#6366f1
    style B fill:#dbeafe,stroke:#3b82f6
    style C fill:#dbeafe,stroke:#3b82f6
    style D fill:#c7d2fe,stroke:#818cf8
    style E fill:#dbeafe,stroke:#3b82f6
    style F fill:#fef3c7,stroke:#f59e0b
    style G fill:#fef3c7,stroke:#f59e0b
    style H fill:#bbf7d0,stroke:#22c55e
```

---

### Casos de uso por departamento

| Departamento | Agente | Qué hace | Fuente de conocimiento |
|---|---|---|---|
| **Recursos Humanos** | Bot de preguntas frecuentes | Responde consultas sobre políticas internas, beneficios, vacaciones y procesos de nómina | Manual del colaborador, políticas de RRHH en SharePoint |
| **Ventas** | Asistente de propuestas | Genera borradores de propuestas comerciales basados en plantillas aprobadas y datos del cliente | Plantillas de ventas, catálogo de tarifas corporativas |
| **Finanzas** | Generador de reportes | Crea resúmenes financieros periódicos a partir de datos estructurados y plantillas estándar | Reportes históricos, plantillas de informes |
| **Servicio al Cliente** | Clasificador de tickets | Categoriza solicitudes de pasajeros por tipo (equipaje, reembolso, cambio de vuelo) y sugiere respuestas iniciales | Base de conocimiento de servicio, guías de respuesta |

Cada uno de estos agentes se puede crear con el flujo de 7 pasos descrito arriba. La clave está en las instrucciones: entre más específicas y estructuradas, mejores resultados.

---

### Limitaciones de los agentes

Es importante entender que los agentes de Copilot **no son sistemas autónomos**. Tienen límites claros que debes conocer antes de implementarlos:

- **No acceden a sistemas externos sin conectores:** un agente simple no puede consultar SAP, Salesforce ni bases de datos externas a Microsoft 365. Para eso se necesitan agentes avanzados con conectores configurados por TI
- **No toman decisiones autónomas:** el agente sugiere, redacta y clasifica, pero no ejecuta acciones por su cuenta. No aprueba solicitudes, no envía correos automáticamente ni modifica registros sin intervención humana
- **No reemplazan el juicio humano:** un agente puede generar un borrador de respuesta a un pasajero, pero un agente de servicio al cliente debe revisarlo antes de enviarlo. La IA asiste, no reemplaza
- **No aprenden de interacciones pasadas:** los agentes simples no mejoran automáticamente con el uso. Si necesitas ajustar su comportamiento, debes modificar las instrucciones manualmente
- **No garantizan precisión absoluta:** como cualquier herramienta de IA generativa, pueden producir respuestas incorrectas o inventar información. Siempre verifica datos críticos

---

## Parte 2: Excel con Copilot

### Qué puede hacer Copilot en Excel

Copilot integrado en Excel transforma la forma de trabajar con datos. En lugar de memorizar funciones o navegar menús complejos, puedes describir lo que necesitas en lenguaje natural y Copilot lo ejecuta.

Estas son las capacidades principales:

- **Generar fórmulas:** describe el cálculo que necesitas y Copilot escribe la fórmula correcta, incluyendo funciones anidadas como BUSCARV, SI.CONJUNTO o SUMAR.SI
- **Crear tablas dinámicas:** pide un resumen de datos por categoría, período o cualquier dimensión y Copilot genera la tabla dinámica automáticamente
- **Generar gráficos:** solicita una visualización y Copilot selecciona el tipo de gráfico más apropiado y lo crea con los datos seleccionados
- **Analizar tendencias:** Copilot puede identificar patrones, valores atípicos y tendencias en los datos sin que tengas que hacer el análisis manual
- **Obtener insights:** pide un resumen de los datos y Copilot resalta los hallazgos más relevantes: máximos, mínimos, promedios, distribuciones y anomalías

---

### 5 prompts de ejemplo para Excel

Estos prompts están diseñados para contextos típicos de trabajo en una aerolínea. Puedes usarlos directamente o adaptarlos a tus datos.

**1. Tabla dinámica de ventas**
> "Crea una tabla dinámica que muestre el total de boletos vendidos por ruta y por mes para el último trimestre. Incluye una columna con el porcentaje de variación mes a mes."

**2. Gráfico de ocupación**
> "Genera un gráfico de barras que compare el porcentaje de ocupación de las rutas nacionales vs internacionales durante los últimos 6 meses. Usa colores diferentes para cada categoría."

**3. Análisis de tendencias**
> "Analiza las tendencias de puntualidad de los vuelos del hub de Bogotá en los últimos 12 meses. Identifica los meses con mayor cantidad de retrasos y sugiere posibles patrones."

**4. Fórmula de cálculo**
> "Sugiere una fórmula para calcular el costo promedio por pasajero en cada ruta, considerando la columna de costos operativos totales y la columna de pasajeros transportados."

**5. Resumen ejecutivo de datos**
> "Resume los datos de esta hoja en 5 puntos clave. Incluye el total de ingresos, la ruta más rentable, la ruta con menor ocupación, el promedio de tarifa y cualquier anomalía que detectes."

---

### Limitaciones de Copilot en Excel

Copilot en Excel es poderoso pero no infalible. Ten en cuenta estas limitaciones:

- **Funciona mejor con datos limpios y estructurados:** si tu hoja tiene celdas combinadas, encabezados ambiguos, filas vacías intercaladas o formatos mixtos, Copilot tendrá dificultades para interpretar los datos correctamente
- **Puede generar fórmulas incorrectas:** la IA a veces "alucina" funciones que no existen o aplica lógica incorrecta. Siempre revisa que la fórmula haga lo que esperas antes de confiar en el resultado
- **No reemplaza la validación humana:** los cálculos críticos (financieros, de seguridad, regulatorios) deben ser verificados manualmente. Copilot es un acelerador, no un auditor
- **Tiene límites de tamaño:** hojas con cientos de miles de filas pueden generar respuestas lentas o incompletas. Para volumen masivo de datos, herramientas como Power BI son más apropiadas

---

### Tips para mejores resultados en Excel

- **Formatea tus datos como Tabla** (Insertar > Tabla o Ctrl+T) antes de usar Copilot. Las tablas con formato permiten que Copilot identifique correctamente las columnas, filas y relaciones entre datos
- **Usa encabezados claros y descriptivos** en cada columna. "Ingresos_USD_2024" es mucho mejor que "Col1" o "Datos"
- **Una hoja, un tema:** evita mezclar datasets no relacionados en la misma hoja. Si tienes datos de ventas y datos de RRHH, sepáralos en hojas distintas
- **Sé específico en tus prompts:** en lugar de "analiza estos datos", pide "analiza la variación porcentual de ingresos por ruta entre enero y marzo de 2025"

> **Tip importante:** Antes de presentar cualquier resultado generado por Copilot en Excel, verifica los cálculos manualmente con una muestra. Selecciona 3 a 5 filas al azar y confirma que la fórmula o el análisis produzca los valores correctos. Esta práctica toma menos de 2 minutos y puede evitar errores costosos en reportes ejecutivos o decisiones basadas en datos incorrectos.

---

## Fuentes

- Microsoft Learn. *Microsoft Copilot Studio - Documentación oficial*. [https://learn.microsoft.com/en-us/microsoft-copilot-studio/](https://learn.microsoft.com/en-us/microsoft-copilot-studio/)
- Microsoft Support. *Copilot en Excel - Guía de uso*. [https://support.microsoft.com/en-us/copilot-excel](https://support.microsoft.com/en-us/copilot-excel)
- Microsoft Learn. *Información general de Microsoft 365 Copilot*. [https://learn.microsoft.com/es-es/copilot/microsoft-365/microsoft-365-copilot-overview](https://learn.microsoft.com/es-es/copilot/microsoft-365/microsoft-365-copilot-overview)$md$), 20);

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 6), 2, 'Práctica: crea un agente de preguntas frecuentes', 'ejercicio',
 '{"instrucciones": "Diseña un agente de Copilot para responder las preguntas más frecuentes de tu área de trabajo. Sigue estos pasos:\n\n1. **Identifica el caso de uso:** Elige un tema donde tu equipo reciba preguntas repetitivas (políticas internas, procesos, herramientas, beneficios, etc.).\n\n2. **Define las instrucciones del agente** usando el formato estructurado:\n   - **Rol:** Quién es el agente y qué especialidad tiene\n   - **Contexto:** En qué área opera y qué información maneja\n   - **Tarea:** Qué tipo de preguntas debe responder\n   - **Formato:** Cómo debe estructurar sus respuestas\n   - **Restricciones:** Qué no debe hacer (inventar datos, dar opiniones personales, etc.)\n\n3. **Crea una lista de 10 preguntas frecuentes** que el agente debería poder responder.\n\n4. **Prueba el agente** (si tienes acceso a Copilot) o simula las respuestas esperadas para 3 de las 10 preguntas.\n\n5. **Evalúa y ajusta:** Para cada respuesta, indica si es correcta, si necesita ajustes y qué cambiarías en las instrucciones.\n\nEntregable: las instrucciones completas del agente + las 10 preguntas + las 3 respuestas evaluadas.", "texto": "Recuerda: un buen agente tiene instrucciones específicas, fuentes de conocimiento confiables y restricciones claras sobre lo que NO debe hacer."}', 20);

-- ============================================================
-- MODULO 7: IA para tu vida personal
-- ============================================================

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 7), 1, 'IA para tu vida personal: herramientas que ya puedes usar', 'texto',
 jsonb_build_object('texto', $md$# IA para tu vida personal: herramientas que ya puedes usar

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
- Fintonic. *Control de gastos personal*. [https://www.fintonic.com/](https://www.fintonic.com/)$md$), 20);

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 7), 2, 'El futuro de la IA: tendencias que definirán los próximos años', 'texto',
 jsonb_build_object('texto', $md$# El futuro de la IA: 7 tendencias que definirán los próximos años

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
- IT Masters Mag. *Más allá del hype: 10 predicciones para la AI empresarial en 2026*. [https://www.itmastersmag.com/inteligencia-artificial/mas-alla-del-hype-10-predicciones-para-la-ai-empresarial-en-2026/](https://www.itmastersmag.com/inteligencia-artificial/mas-alla-del-hype-10-predicciones-para-la-ai-empresarial-en-2026/)$md$), 15);

-- ============================================================
-- MODULO 8: Reto final
-- ============================================================

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 8), 1, 'Reto final: demuestra todo lo que aprendiste', 'texto',
 jsonb_build_object('texto', $md$# Reto final: demuestra todo lo que aprendiste

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

> La IA es un amplificador de tus capacidades. Tu criterio profesional es lo que marca la diferencia.$md$), 30);

COMMIT;
