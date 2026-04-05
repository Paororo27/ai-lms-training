-- 012_contenido_modulos.sql
-- Actualizar modulos existentes (1-6), crear modulos 7-8, y poblar lecciones

BEGIN;

-- ============================================================
-- PART 1: Actualizar modulos existentes y crear nuevos
-- ============================================================

UPDATE modulos SET titulo = 'Nuevos Horizontes: el despertar digital', descripcion = 'Introduccion a la extension de capacidades laborales con IA. Que es Copilot, como funciona y por que cambia tu forma de trabajar.' WHERE orden = 1;

UPDATE modulos SET titulo = 'Ingenieria del Dialogo: como construir mejores prompts', descripcion = 'Framework GOCE de Microsoft, tecnicas de prompting, anonimizacion de datos y protocolo de seguridad con IA.' WHERE orden = 2;

UPDATE modulos SET titulo = 'El arte de ensenarle a la IA: Few-shot y Prompt Chaining', descripcion = 'Tecnicas avanzadas: cuando dar ejemplos a la IA, como encadenar prompts y patrones de encadenamiento para tareas complejas.' WHERE orden = 3;

UPDATE modulos SET titulo = 'Prompting avanzado: estructuras y seguridad', descripcion = 'Estructuras XML y JSON para prompts, templates reutilizables, generacion de contenido y proteccion contra Shadow AI.' WHERE orden = 4;

UPDATE modulos SET titulo = 'Crea con Copilot: imagenes, formularios y presentaciones', descripcion = 'Herramientas de creacion de contenido: Designer para imagenes, Forms para formularios inteligentes y PowerPoint con IA.', duracion_minutos = 40 WHERE orden = 5;

UPDATE modulos SET titulo = 'Agentes y Excel con Copilot', descripcion = 'Crea agentes de IA para automatizar tareas repetitivas y domina Excel con Copilot para analisis de datos.', duracion_minutos = 40 WHERE orden = 6;

INSERT INTO modulos (orden, semana, titulo, descripcion, contenido, duracion_minutos) VALUES
(7, 4, 'IA para tu vida personal', 'Panorama de herramientas de IA para uso personal: productividad, aprendizaje, salud, finanzas y el futuro de la tecnologia.', '{}', 35)
ON CONFLICT (orden) DO UPDATE SET semana = EXCLUDED.semana, titulo = EXCLUDED.titulo, descripcion = EXCLUDED.descripcion, duracion_minutos = EXCLUDED.duracion_minutos;

INSERT INTO modulos (orden, semana, titulo, descripcion, contenido, duracion_minutos) VALUES
(8, 4, 'Reto final: demuestra lo que aprendiste', 'El desafio integrador que pone a prueba todas las habilidades del taller. Sin prueba, solo un reto profesional.', '{}', 30)
ON CONFLICT (orden) DO UPDATE SET semana = EXCLUDED.semana, titulo = EXCLUDED.titulo, descripcion = EXCLUDED.descripcion, duracion_minutos = EXCLUDED.duracion_minutos;

-- ============================================================
-- PART 2: Eliminar lecciones existentes de modulos 2-6
-- ============================================================

DELETE FROM lecciones WHERE modulo_id IN (SELECT id FROM modulos WHERE orden IN (2, 3, 4, 5, 6));

-- ============================================================
-- PART 3: Insertar lecciones para cada modulo
-- ============================================================

-- ============================================================
-- MODULO 2: Ingenieria del Dialogo
-- ============================================================

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 2), 1, 'Que es un prompt y por que importa', 'video',
 '{"media_url": "ugQQ8Xa6hI0", "texto": "Video de Pablo Prompt: introduccion a Copilot para principiantes. Creditos: canal Pablo Prompt en YouTube."}', 10);

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 2), 2, 'Anatomia de un buen prompt: framework GOCE', 'texto',
 jsonb_build_object('texto', $md$# Anatomia de un buen prompt: el framework GOCE

Un prompt no es solo una pregunta. Es una **instruccion estructurada** que determina la calidad de la respuesta que obtienes de Copilot. La diferencia entre un resultado mediocre y uno extraordinario esta en como construyes esa instruccion.

Microsoft propone un framework oficial para escribir prompts efectivos en Copilot: **GOCE**. Dominar este framework es la habilidad mas importante que puedes desarrollar como usuario de IA en tu dia a dia laboral.

---

## El framework GOCE

GOCE es un acronimo que representa los **cuatro componentes fundamentales** de un prompt efectivo, segun la documentacion oficial de Microsoft para Copilot:

| Componente | Significado | Descripcion | Ejemplo en Avianca |
|---|---|---|---|
| **G** - Goal | Objetivo | Que quieres lograr. La accion concreta que Copilot debe ejecutar. | "Redacta un correo para informar a la tripulacion sobre el cambio de itinerario" |
| **O** - Context | Contexto | Informacion de fondo que Copilot necesita para entender la situacion. | "El vuelo AV204 Bogota-Miami fue reprogramado de 6:00 AM a 9:30 AM por mantenimiento preventivo" |
| **C** - Expectations | Expectativas | El formato, tono o estilo que esperas en la respuesta. | "Usa un tono formal pero empatico, en maximo 150 palabras" |
| **E** - Source | Fuente | Documentos, datos o referencias que Copilot debe consultar. | "Basate en el protocolo de comunicacion de cambios operacionales del manual de Avianca" |

> Tip: No necesitas incluir los cuatro componentes en cada prompt, pero mientras mas componentes uses, mejor sera la respuesta. Empieza con Goal y Context como minimo.

---

## Prompt malo vs. prompt bueno

### Prompt malo

```
Hazme un resumen del informe de puntualidad
```

Este prompt falla porque no tiene contexto, no especifica periodo, no define formato y no indica la fuente de datos. Copilot tendra que adivinar todo y probablemente entregara algo generico e inutil.

### Prompt bueno (aplicando GOCE)

```
[Goal] Genera un resumen ejecutivo del desempeno de puntualidad operacional
[Context] para la ruta Bogota-Cancun durante marzo 2026, considerando que
el objetivo corporativo de OTP es 85% y el resultado fue 78.3%
[Expectations] en formato de 3 parrafos: situacion actual, causas principales
y recomendaciones. Usa tono profesional para presentar ante el Comite de
Operaciones.
[Source] Basate en los datos del reporte mensual de operaciones /OTP-marzo-2026.xlsx
```

La diferencia es evidente: el segundo prompt le da a Copilot toda la informacion que necesita para generar una respuesta precisa y accionable.

---

## Framework expandido de 5 componentes

Para situaciones mas complejas, puedes usar un framework ampliado de **cinco componentes** que agrega mayor control sobre la respuesta:

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

Define **quien es** Copilot en este escenario. Esto calibra el vocabulario, la profundidad tecnica y el enfoque de la respuesta.

*Ejemplo: "Actua como un analista senior de operaciones aereas con 10 anos de experiencia en aerolineas latinoamericanas."*

### 2. Contexto

Proporciona la **informacion de fondo** necesaria. Incluye datos, fechas, areas involucradas y cualquier detalle relevante.

*Ejemplo: "Avianca esta evaluando abrir una nueva ruta directa Bogota-Toronto para el segundo semestre de 2026."*

### 3. Tarea

Indica la **accion especifica** que debe realizar. Se claro y usa verbos de accion: analiza, compara, redacta, resume, genera.

*Ejemplo: "Elabora un analisis comparativo de demanda y rentabilidad proyectada."*

### 4. Formato

Especifica **como quieres recibir** la respuesta: tabla, lista, parrafos, bullet points, cantidad de palabras, idioma.

*Ejemplo: "Presentalo en una tabla con columnas: criterio, dato, fuente, y un parrafo de conclusion de maximo 100 palabras."*

### 5. Restricciones

Establece los **limites y condiciones** que la respuesta debe respetar: que no debe incluir, que tono usar, que evitar.

*Ejemplo: "No incluyas proyecciones financieras especificas. Mantente en un analisis cualitativo de mercado."*

---

## El proceso de construccion de un prompt

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

> Tip: Un prompt rara vez es perfecto a la primera. Trata la conversacion con Copilot como un dialogo iterativo: envia un prompt, evalua la respuesta, y refina tu instruccion. Cada iteracion te acerca mas al resultado que necesitas. La clave no es escribir el prompt perfecto, sino mejorar progresivamente.

---

## Errores comunes y como corregirlos

| Error | Ejemplo malo | Correccion | Ejemplo bueno |
|---|---|---|---|
| Prompt vago sin objetivo | "Dime algo sobre la puntualidad" | Definir un objetivo concreto | "Resume las 3 principales causas de retraso en la ruta BOG-MDE en febrero 2026" |
| Sin contexto ni datos | "Haz un informe de ventas" | Agregar periodo, area y metricas | "Genera un informe de ventas del canal digital para el Q1 2026, enfocado en la ruta BOG-CUN" |
| No especificar formato | "Analiza estos datos" | Indicar como quieres la respuesta | "Analiza estos datos y presentalos en una tabla con columnas: metrica, valor actual, meta, brecha" |
| Pedir demasiado en un solo prompt | "Haz el informe completo, la presentacion, el correo y el dashboard" | Dividir en tareas individuales | "Primero, genera el resumen ejecutivo del informe de OTP de marzo 2026" |
| No iterar ante una mala respuesta | Aceptar la primera respuesta sin cuestionar | Refinar con instrucciones adicionales | "Buen inicio, pero necesito que te enfoques mas en las causas operacionales y menos en las meteorologicas" |
| Olvidar el tono y la audiencia | "Explica por que hubo retrasos" | Especificar para quien es | "Explica las causas de retraso en terminos ejecutivos para presentar al VP de Operaciones" |

---

## Fuentes

- Microsoft Learn - Crear indicaciones eficaces para Microsoft 365 Copilot: [https://learn.microsoft.com/es-es/training/paths/craft-effective-prompts-copilot-microsoft-365/](https://learn.microsoft.com/es-es/training/paths/craft-effective-prompts-copilot-microsoft-365/)
- Microsoft Support - Cooking up a great prompt: [https://support.microsoft.com/en-us/topic/cooking-up-a-great-prompt-getting-the-most-from-copilot-7b614306-d5aa-4b62-8509-e46674a29165](https://support.microsoft.com/en-us/topic/cooking-up-a-great-prompt-getting-the-most-from-copilot-7b614306-d5aa-4b62-8509-e46674a29165)
- Microsoft Copilot - Galeria de prompts: [https://copilot.cloud.microsoft/prompts](https://copilot.cloud.microsoft/prompts)$md$), 15);

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 2), 3, 'El escudo de la confianza', 'texto',
 jsonb_build_object('texto', $md$# El Escudo de la Confianza

Protegiendo el corazon de Talento Humano en la era de la IA.

---

## La advertencia que sacudio a Silicon Valley

En abril de 2023, **Samsung** se convirtio en el centro de una noticia que nadie en Talento Humano deberia ignorar. Tres empleados, buscando optimizar su tiempo, cometieron un error critico al usar versiones gratuitas de IA:

1. Subieron **codigo fuente confidencial** para buscar errores
2. Compartieron **notas de una reunion interna** estrategica
3. Pidieron un resumen de un **reporte tecnico** de hardware

> Esos datos pasaron a formar parte del entrenamiento del modelo publico. La informacion dejo de pertenecer a la empresa y quedo disponible para que la herramienta la revelara en respuestas a otros usuarios.

```mermaid
flowchart LR
    E["Empleado"] -->|Pega datos confidenciales| IA["IA Publica"]
    IA -->|Entrena el modelo| M["Modelo Global"]
    M -->|Responde a otros usuarios| U["Cualquier Persona"]
    style IA fill:#FF0000,color:white
    style U fill:#FF0000,color:white
```

[Fuente: Forbes Colombia — Samsung prohibe ChatGPT entre empleados](https://forbes.co/tecnologia/samsung-prohibe-a-chatgpt-entre-empleados)

Este evento fue un quiebre en la confianza organizacional. En Talento Humano, donde manejamos el "ADN" de las personas (salarios, historias clinicas, evaluaciones), un error de este tipo cuesta la reputacion y la seguridad de nuestra gente.

---

## Conceptos criticos: Donde estamos parados?

Para navegar con seguridad, debemos entender la diferencia fundamental entre las herramientas:

| Herramienta | Analogia | Privacidad de Datos |
|-------------|----------|---------------------|
| IA Publica (Version Abierta) | Hablar en una plaza llena de gente | Riesgo alto. Todo lo que escribas entrena al modelo |
| IA Corporativa (Copilot) | Hablar en una sala de juntas blindada | Seguro. Los datos no salen de la organizacion |
| PII (Informacion Personal) | Tu "ADN" digital (Cedula, correo, fotos) | Maxima proteccion. Nunca debe compartirse sin filtrar |

```mermaid
flowchart TD
    subgraph RIESGO["IA Publica"]
        A[Tu Prompt] --> B[Modelo Global]
        B --> C[Entrenamiento con tus datos]
        C --> D[Exposicion a terceros]
    end
    subgraph SEGURO["Copilot Empresarial"]
        E[Tu Prompt] --> F[Modelo Aislado]
        F --> G[Respuesta privada]
        G --> H[Datos protegidos]
    end
    style RIESGO fill:#FF000015,stroke:#FF0000
    style SEGURO fill:#23C84715,stroke:#23C847
```

---

## Copilot Chat: Nuestra Fortaleza Digital

La eleccion de la herramienta es una salvaguarda etica. **Copilot Chat es la unica herramienta de IA autorizada por Avianca.**

![Diagrama de arquitectura de Microsoft 365 Copilot mostrando como los datos del usuario permanecen dentro del limite de servicio](https://learn.microsoft.com/en-us/copilot/microsoft-365/media/microsoft-365-copilot-architecture/copilot-tenant-architecture.png)

Al utilizar Copilot, activamos un ecosistema donde la privacidad es una **garantia contractual** que impide que la informacion sensible sea utilizada para entrenar modelos fuera de nuestro control.

> Usar una IA no oficial es abrir una grieta en la privacidad de nuestra gente. Usar Copilot es honrar el compromiso de custodia que Avianca tiene con cada uno de sus miembros.

![Diagrama de acceso de usuario en Microsoft 365 Copilot mostrando que solo accede a datos que el usuario tiene permiso de ver](https://learn.microsoft.com/en-us/copilot/microsoft-365/media/microsoft-365-copilot-architecture/copilot-user-access.png)

---

## El Protocolo de Anonimizacion

No significa que no podamos pedirle ayuda a la IA. Significa que debemos **"limpiar" la informacion** antes de compartirla.

### La tecnica del "Reemplazo de Identidad"

| Incorrecto | Correcto |
|------------|----------|
| "IA, ayudame a redactar un correo para **Carlos Rodriguez** de Nomina. Ha fallado en los cierres de mes y su jefe, **Juan**, esta muy molesto." | "IA, ayudame a redactar un correo de retroalimentacion constructiva para un **analista financiero**. El colaborador ha presentado retrasos en la entrega de reportes mensuales." |

```mermaid
flowchart LR
    A["Texto con PII"] --> B["Reemplazar nombres"]
    B --> C["Generalizar cargos"]
    C --> D["Remover datos unicos"]
    D --> E["Texto anonimizado"]
    style A fill:#FF0000,color:white
    style E fill:#23C847,color:white
```

> **La Prueba de la Valla Publicitaria:** Antes de dar clic en "enviar", preguntate: Me sentiria comodo si este texto apareciera manana en una valla publicitaria en la entrada de la empresa? Si la respuesta es no, limpia el texto.

---

## Recomendaciones de Oro para Talento Humano

1. **La Prueba de la Valla Publicitaria** — Antes de enviar, preguntate si te sentirias comodo viendo ese texto en publico. Si la respuesta es no, limpia el texto.

2. **Usa los Canales Oficiales** — Privilegia siempre Microsoft Copilot dentro de nuestro entorno corporativo. Es la unica forma de garantizar respaldo de seguridad empresarial.

3. **Criterio sobre Automatizacion** — La IA puede redactar la estructura, pero tu eres quien debe revisar el contenido final, corregir sesgos y asegurar que el trato sea humano y digno.

---

## Conclusion: Innovacion con Responsabilidad

La Inteligencia Artificial no es un reemplazo de nuestra etica, es un **amplificador de nuestra capacidad**. Al proteger la informacion, estamos honrando la promesa de cuidado que le hicimos a cada colaborador.

> En Talento Humano, la tecnologia pone la eficiencia, pero nosotros ponemos el escudo de la confianza.$md$), 10);

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 2), 4, 'Protocolo de anonimizacion', 'texto',
 jsonb_build_object('texto', $md$# Protocolo de anonimizacion: protege la informacion antes de usar IA

Cada vez que escribes un prompt, estas compartiendo informacion con un sistema de inteligencia artificial. Incluso dentro de un entorno corporativo como Microsoft Copilot, aplicar un protocolo de anonimizacion es una practica esencial que reduce riesgos y protege a las personas detras de los datos.

---

## Por que anonimizar, incluso con Copilot empresarial

Microsoft Copilot para Microsoft 365 opera dentro del limite de confianza de tu organizacion. Tus datos no entrenan el modelo publico y permanecen aislados en el tenant de Avianca. Sin embargo, hay razones concretas para anonimizar antes de enviar un prompt:

- **Principio de minimo privilegio:** No compartas mas datos de los necesarios para obtener la respuesta que buscas. Si la IA puede ayudarte sin conocer el nombre real de una persona, no lo incluyas.
- **Errores de canal:** Un prompt pensado para Copilot puede terminar pegado por accidente en una herramienta publica. Si el texto ya esta anonimizado, el dano es nulo.
- **Auditoria y cumplimiento:** Los registros de uso pueden ser revisados. Un historial limpio de PII demuestra buenas practicas ante auditorias internas y regulatorias.
- **Cultura de proteccion:** Anonimizar por defecto crea un habito que protege a la organizacion sin depender de que cada persona recuerde que herramienta esta usando.

> La anonimizacion no es desconfianza hacia la herramienta. Es disciplina profesional.

---

## Cuatro tecnicas de anonimizacion

| Tecnica | Descripcion | Antes | Despues |
|---------|-------------|-------|---------|
| Reemplazo por placeholders | Sustituir datos reales por etiquetas genericas entre corchetes | "Envia el reporte a Carlos Mendez, cedula 1.023.456.789" | "Envia el reporte a [NOMBRE_EMPLEADO], cedula [ID_DOCUMENTO]" |
| Generalizacion | Reemplazar valores especificos por rangos o categorias | "La colaboradora de 34 anos gana $8.500.000 mensuales" | "La colaboradora esta en el rango de 30-40 anos con salario en banda salarial media" |
| Seudonimizacion | Sustituir identificadores reales por codigos ficticios consistentes | "Maria Lopez del area de Finanzas reporto a Juan Perez" | "Empleada A del area X reporto a Empleado B" |
| Datos sinteticos | Crear ejemplos ficticios que conservan la estructura del dato real | "Tarjeta corporativa 4532-XXXX-XXXX-7821 con cupo de USD 15.000" | "Tarjeta corporativa 0000-0000-0000-0000 con cupo de USD [MONTO]" |

> La tecnica mas simple y efectiva para el dia a dia es el reemplazo por placeholders. Las demas son utiles cuando necesitas que la IA trabaje con la estructura del dato.

---

## Datos que nunca deben ir en un prompt

Independientemente de la herramienta que uses, estos tipos de informacion requieren anonimizacion obligatoria:

- **Identificacion personal:** Nombres completos, numeros de cedula, pasaportes, fechas de nacimiento exactas
- **Datos financieros:** Numeros de tarjetas de credito, cuentas bancarias, salarios especificos, extractos
- **Informacion medica:** Diagnosticos, historias clinicas, resultados de examenes, incapacidades con detalles
- **Credenciales de acceso:** Contrasenas, tokens de API, claves de cifrado, URLs internas con parametros de autenticacion
- **Acuerdos confidenciales:** Terminos de contratos con proveedores, clausulas de no divulgacion, condiciones comerciales exclusivas
- **Datos de contacto directo:** Numeros de celular personal, direcciones de domicilio, correos personales

---

## Copilot empresarial vs. herramientas gratuitas

| Caracteristica | Microsoft Copilot (empresarial) | ChatGPT / Gemini (version gratuita) |
|---|---|---|
| Uso de datos para entrenamiento | No. Los datos no entrenan el modelo | Si. Los datos pueden usarse para mejorar el modelo |
| Aislamiento de datos | Dentro del tenant de Microsoft 365 de Avianca | Sin aislamiento. Los datos circulan por infraestructura compartida |
| Cumplimiento GDPR / Ley 1581 | Si. Contratos de procesamiento de datos (DPA) con la organizacion | Limitado. El usuario acepta terminos individuales sin respaldo corporativo |
| Capacidad de auditoria | Si. Registros disponibles en Microsoft Purview | No. Sin visibilidad para la organizacion sobre que se compartio |
| Control de acceso | Respeta los permisos de Microsoft 365. Solo ves lo que tu rol permite | Sin integracion con permisos corporativos |
| Retencion y eliminacion | Politicas configurables por la organizacion | Sujeta a las politicas del proveedor, fuera del control de Avianca |

> Que Copilot sea seguro no elimina la necesidad de anonimizar. La seguridad de la herramienta y la higiene del dato son capas complementarias, no sustitutas.

---

## Flujo de anonimizacion

Antes de enviar cualquier prompt, sigue este proceso mental:

```mermaid
flowchart LR
    A["Texto original"] --> B["Identificar PII"]
    B --> C["Reemplazar con placeholders"]
    C --> D["Generalizar valores especificos"]
    D --> E["Texto seguro"]
    style A fill:#fecaca,stroke:#b91c1c
    style B fill:#fed7aa,stroke:#c2410c
    style C fill:#fef08a,stroke:#a16207
    style D fill:#bbf7d0,stroke:#15803d
    style E fill:#a7f3d0,stroke:#059669
```

Cada paso actua como un filtro. No todos los textos requieren los cuatro pasos; a veces basta con reemplazar nombres. Lo importante es que el proceso se vuelva automatico.

---

## Ejercicio practico: antes y despues

### Prompt 1 -- Solicitud de retroalimentacion

**Antes (con PII):**

"Ayudame a escribir un correo de retroalimentacion para Andrea Gomez, analista de Revenue Management. Su jefe directo es Roberto Castillo. Andrea ha tenido tres llegadas tarde esta semana y su evaluacion de desempeno fue 2.3/5."

**Despues (anonimizado):**

"Ayudame a escribir un correo de retroalimentacion para un analista del area comercial. El colaborador ha tenido tres llegadas tarde esta semana y su evaluacion de desempeno fue inferior al promedio esperado."

---

### Prompt 2 -- Analisis de datos de nomina

**Antes (con PII):**

"Revisa esta tabla de nomina: Juan Perez - CC 80.123.456 - $12.300.000; Laura Diaz - CC 52.789.012 - $9.800.000; Miguel Torres - CC 1.098.765.432 - $7.500.000."

**Despues (anonimizado):**

"Revisa esta estructura de nomina con datos de ejemplo: Empleado A - [ID_1] - Banda salarial alta; Empleado B - [ID_2] - Banda salarial media; Empleado C - [ID_3] - Banda salarial base."

---

### Prompt 3 -- Consulta sobre beneficios medicos

**Antes (con PII):**

"La colaboradora Sofia Ramirez, cedula 1.045.678.901, fue diagnosticada con sindrome de burnout. Su EPS es Sura y tiene una incapacidad hasta el 15 de abril. Ayudame a redactar la comunicacion al area de bienestar."

**Despues (anonimizado):**

"Una colaboradora del area operativa presenta una incapacidad medica por estres laboral con vigencia de dos semanas. Ayudame a redactar la comunicacion al area de bienestar siguiendo el protocolo interno."

---

## La prueba de la valla publicitaria

Antes de enviar cualquier prompt, aplica esta regla:

> **Imagina que el texto que vas a enviar aparece manana en una valla publicitaria en la entrada de la sede principal de Avianca.** Si eso te generaria incomodidad, preocupacion o un problema legal, entonces el texto necesita ser anonimizado antes de enviarlo.

Esta prueba funciona porque obliga a evaluar el riesgo desde la perspectiva mas expuesta posible. No importa si la herramienta es segura; lo que importa es que el contenido del prompt sea seguro por si mismo, independientemente de donde termine.

La valla publicitaria no es un escenario probable, pero es el estandar correcto. Un texto que pasa esta prueba esta listo para cualquier herramienta, cualquier auditoria y cualquier eventualidad.

---

## Fuentes

- [Privacidad de Microsoft 365 Copilot](https://learn.microsoft.com/es-es/copilot/microsoft-365/microsoft-365-copilot-privacy) -- Como Microsoft gestiona los datos dentro de Copilot.
- [Proteccion de datos empresariales en Copilot](https://learn.microsoft.com/es-es/copilot/microsoft-365/enterprise-data-protection) -- Controles de seguridad y aislamiento del tenant.
- [Microsoft Purview para IA](https://learn.microsoft.com/es-es/purview/ai-microsoft-purview) -- Herramientas de auditoria, cumplimiento y gobernanza de datos en entornos de IA.$md$), 15);

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 2), 5, 'Practica: reescribe prompts inseguros', 'ejercicio',
 '{"instrucciones": "A continuacion tienes 3 prompts con datos sensibles. Tu tarea es reescribirlos aplicando las tecnicas de anonimizacion del modulo.\n\n1. \"Redacta un correo para Maria Gonzalez de Nomina, cedula 52.345.678, informando que su aumento de $850.000 fue aprobado por su jefe Carlos Ruiz.\"\n\n2. \"Analiza por que el cliente Pedro Martinez, tarjeta Visa terminada en 4523, hizo 3 reclamos el mes pasado por cobros incorrectos de $1.234.567.\"\n\n3. \"Genera un reporte del empleado Juan Diaz, diagnosticado con estres laboral, incapacitado hasta el 20 de abril, del area de operaciones de El Dorado.\"\n\nRecuerda: usa placeholders, generaliza datos y elimina toda informacion que identifique personas.", "texto": "Aplica la prueba de la valla publicitaria a cada prompt antes de enviarlo."}', 15);

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 2), 6, 'Errores comunes y como evitarlos', 'video',
 '{"media_url": "p2PqfRte46k", "texto": "Video de Cyberclick Marketing Digital: La formula del prompt perfecto. Creditos: canal Cyberclick en YouTube."}', 10);

-- ============================================================
-- MODULO 3: El arte de ensenarle a la IA
-- ============================================================

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 3), 1, 'Introduccion a tecnicas avanzadas de prompting', 'video',
 '{"media_url": "x-iTco25VGI", "texto": "Video de HolaMundo: tecnicas avanzadas de prompting explicadas de forma clara. Creditos: canal HolaMundo en YouTube."}', 10);

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 3), 2, 'Zero-shot vs Few-shot: cuando dar ejemplos a la IA', 'texto',
 jsonb_build_object('texto', $md$# Zero-shot vs Few-shot: cuando y por que dar ejemplos a la IA

Cuando le pides algo a la IA, tienes dos caminos fundamentales: darle solo la instruccion o acompanarla con ejemplos. Esta decision impacta directamente la calidad y consistencia de la respuesta.

---

## Que es Zero-shot

Zero-shot significa darle a la IA **unicamente la instruccion**, sin ningun ejemplo previo. Confias en que el modelo ya "sabe" como resolver la tarea gracias a su entrenamiento.

```
Clasifica el siguiente texto como positivo, negativo o neutro:

"El vuelo llego a tiempo y el servicio fue excelente."
```

La IA interpreta la tarea y responde directamente. Funciona bien cuando la tarea es clara y no hay ambiguedad en el formato o los criterios esperados.

---

## Que es Few-shot

Few-shot significa incluir **entre 2 y 5 ejemplos resueltos** antes de presentar la tarea real. Le estas mostrando al modelo exactamente que formato y criterio esperas.

```
Clasifica el sentimiento del texto.

Texto: "Me encanto la comida del vuelo."
Sentimiento: Positivo

Texto: "Perdieron mi maleta y nadie me ayudo."
Sentimiento: Negativo

Texto: "El vuelo duro 3 horas."
Sentimiento: Neutro

Texto: "El vuelo llego a tiempo y el servicio fue excelente."
Sentimiento:
```

Los ejemplos actuan como una **guia implicita**: el modelo detecta el patron y lo replica.

---

## Comparacion directa

| Aspecto | Zero-shot | Few-shot |
|---------|-----------|----------|
| Ejemplos necesarios | Ninguno | 2 a 5 |
| Consumo de tokens | Bajo | Moderado |
| Velocidad de escritura | Rapida | Requiere preparacion |
| Consistencia de formato | Variable | Alta |
| Ideal para | Tareas genericas y claras | Clasificacion, formatos especificos |
| Riesgo principal | Formato impredecible | Sesgo si los ejemplos son malos |
| Complejidad del prompt | Baja | Media |

---

## Regla practica

La decision se reduce a una pregunta: **La tarea tiene una unica interpretacion posible?**

- **Tarea univoca** (resumir, traducir, corregir ortografia): usa **zero-shot**. La IA ya entiende que hacer.
- **Formato o clasificacion especifica** (categorizar quejas, generar tablas con estructura definida, etiquetar datos): usa **few-shot**. Los ejemplos eliminan la ambiguedad.

> Si al leer tu instruccion alguien podria responder de tres formas distintas y todas serian "correctas", necesitas few-shot para anclar la respuesta al formato que esperas.

---

## Flujo de decision

```mermaid
flowchart TD
    A[Tienes una tarea para la IA] --> B{La tarea tiene una sola<br/>interpretacion posible?}
    B -- Si --> C[Zero-shot:<br/>solo instruccion]
    B -- No --> D{Necesitas un formato<br/>o clasificacion especifica?}
    D -- Si --> E[Few-shot:<br/>incluir 3 a 5 ejemplos]
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

## Comparacion de flujos: Zero-shot vs Few-shot

```mermaid
flowchart LR
    subgraph ZS["Zero-shot"]
        direction TB
        Z1[Instruccion] --> Z2[Modelo procesa] --> Z3[Respuesta]
    end
    subgraph FS["Few-shot"]
        direction TB
        F1[Ejemplos resueltos] --> F2[Instruccion + tarea real] --> F3[Modelo detecta patron] --> F4[Respuesta consistente]
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

## Ejemplo completo: clasificacion de quejas de pasajeros

Supongamos que necesitas clasificar quejas de pasajeros en cuatro categorias: **[Equipaje]**, **[Retraso]**, **[Servicio a bordo]** y **[Reservas]**.

### Prompt few-shot con 5 ejemplos

```
Clasifica la queja del pasajero en una de estas categorias: [Equipaje], [Retraso], [Servicio a bordo], [Reservas].
Responde unicamente con la categoria entre corchetes.

Queja: "Mi maleta llego con una rueda rota y el cierre danado."
Categoria: [Equipaje]

Queja: "El vuelo BOG-MDE salio con 4 horas de retraso y no nos dieron informacion."
Categoria: [Retraso]

Queja: "La comida estaba fria y el auxiliar de vuelo fue grosero cuando lo mencione."
Categoria: [Servicio a bordo]

Queja: "Compre un tiquete por la app y me cobraron dos veces sin generar confirmacion."
Categoria: [Reservas]

Queja: "Llevamos 2 horas esperando en la puerta de embarque sin ninguna actualizacion."
Categoria: [Retraso]

Queja: "En el vuelo AV204 el sistema de entretenimiento no funcionaba y los asientos estaban sucios."
Categoria:
```

La respuesta esperada es `[Servicio a bordo]`. Observa como los 5 ejemplos:

- Cubren las **4 categorias** (no se repite siempre la misma).
- Mantienen un **formato identico**: "Queja: ... / Categoria: [...]".
- Son **representativos** de quejas reales en una aerolinea.
- La tarea real sigue el mismo formato exacto.

---

## Las 4 reglas para construir buenos ejemplos few-shot

### 1. Variedad

Los ejemplos deben cubrir **todas o la mayoria de las categorias posibles**. Si tienes 4 categorias, no pongas 5 ejemplos de la misma; distribuyelos.

### 2. Formato consistente

Cada ejemplo debe seguir **exactamente la misma estructura**. Si el primero usa "Queja: ... / Categoria: [...]", todos deben hacerlo igual. Una inconsistencia confunde al modelo.

### 3. Representatividad

Los ejemplos deben parecerse a los **casos reales** que la IA va a encontrar. No uses ejemplos triviales o artificiales; usa lenguaje y situaciones que reflejen la realidad.

### 4. Cantidad optima: 3 a 5 ejemplos

Menos de 3 no establece un patron claro. Mas de 5 consume tokens sin mejorar significativamente la calidad. El punto optimo esta entre **3 y 5 ejemplos**.

| Regla | Que hacer | Que evitar |
|-------|-----------|------------|
| Variedad | Cubrir todas las categorias | 5 ejemplos de la misma clase |
| Formato consistente | Misma estructura en cada ejemplo | Mezclar formatos o estilos |
| Representatividad | Casos reales y tipicos | Ejemplos inventados o extremos |
| Cantidad optima | 3 a 5 ejemplos | 1 solo ejemplo o mas de 7 |

---

## Errores comunes

### Muy pocos ejemplos

Dar solo 1 ejemplo no es few-shot, es un caso aislado. El modelo no tiene suficiente informacion para detectar un patron. Usa al menos 3.

### Todos los ejemplos de la misma categoria

Si tus 5 ejemplos son de `[Equipaje]`, el modelo va a sesgar sus respuestas hacia esa categoria. Distribuye los ejemplos entre todas las opciones.

### Formato inconsistente entre ejemplos

Si un ejemplo usa "Categoria:" y otro usa "Tipo:", el modelo no sabe cual formato seguir. Manten la estructura identica en cada ejemplo y en la tarea real.

### Ejemplos que contradicen la instruccion

Si la instruccion dice "responde solo con la categoria" pero en los ejemplos agregas explicaciones, el modelo va a imitar los ejemplos, no la instruccion. Los ejemplos siempre ganan.

---

## Fuentes

- [Prompting Guide - Few-shot Prompting](https://www.promptingguide.ai/es/techniques/fewshot)
- [Prompting Guide - Zero-shot Prompting](https://www.promptingguide.ai/es/techniques/zeroshot)
- [Microsoft Learn - Aprendizaje Zero-shot](https://learn.microsoft.com/es-es/dotnet/ai/conceptual/zero-shot-learning)
- [Prompt.org.es - Few-shot vs Zero-shot: comparativa](https://www.prompt.org.es/docs/vs-metods/few-shot-vs-zero-shot-prompting-comparativa)$md$), 15);

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 3), 3, 'Practica: clasifica quejas con few-shot', 'ejercicio',
 '{"instrucciones": "Vas a practicar la tecnica few-shot con 3 escenarios de una aerolinea. Para cada uno, escribe un prompt few-shot con al menos 3 ejemplos y luego presenta la tarea real.\n\nEscenario 1: Clasificar correos internos en categorias [Urgente], [Informativo], [Accion requerida].\nEscenario 2: Categorizar comentarios de pasajeros en [Elogio], [Queja], [Sugerencia], [Pregunta].\nEscenario 3: Etiquetar solicitudes de empleados en [Vacaciones], [Capacitacion], [Soporte TI], [Otro].\n\nPara cada escenario:\n1. Escribe 3 a 5 ejemplos variados que cubran todas las categorias\n2. Mantene el formato identico en cada ejemplo\n3. Agrega la tarea real al final sin la respuesta\n4. Verifica que tus ejemplos no introduzcan sesgo hacia una categoria", "texto": "Recuerda las 4 reglas: variedad, formato consistente, representatividad y cantidad optima (3-5 ejemplos)."}', 15);

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 3), 4, 'Prompt Chaining: divide y venceras con la IA', 'texto',
 jsonb_build_object('texto', $md$# Prompt Chaining: divide y venceras con la IA

Cuando un problema es complejo, la mejor estrategia no es pedirle todo a la IA de una sola vez. La tecnica de **Prompt Chaining** consiste en dividir una tarea grande en pasos mas pequenos, donde **la salida de un prompt se convierte en la entrada del siguiente**.

Es como una linea de ensamblaje: cada estacion hace una cosa bien hecha, y el resultado final es superior a intentar hacerlo todo en un solo paso.

> Segun estudios presentados en ACL 2024, dividir tareas complejas en pasos encadenados mejora la precision de las respuestas entre un 20% y un 50% comparado con un unico prompt monolitico.

---

## Por que funciona mejor

Cuando le pides a la IA que haga todo en un solo mensaje, esta repartiendo su "atencion" entre multiples objetivos. Al encadenar prompts:

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

Existen cuatro patrones principales que puedes aplicar segun el tipo de tarea:

| Patron | Flujo | Ejemplo en aerolinea |
|--------|-------|---------------------|
| **Secuencial** | A -> B -> C | Extraer datos de quejas -> Analizar tendencias -> Recomendar acciones |
| **Paralelo con merge** | A + B -> C | Analizar quejas de pasajeros + Analizar metricas de puntualidad -> Generar reporte unificado |
| **Condicional** | Si X entonces Y, si no Z | Si la queja es por equipaje -> Proceso de reclamo; si es por retraso -> Calcular compensacion |
| **Loop de refinamiento** | A -> Revisar -> Ajustar -> Final | Borrador de respuesta -> Revisar tono corporativo -> Ajustar lenguaje -> Version final para el pasajero |

---

## Ejemplo completo: Analisis de quejas de pasajeros

Veamos como aplicar el patron **Secuencial** (Resumen -> Analisis -> Accion) para procesar una queja real.

### Paso 1: Resumir y extraer datos clave

```
Tengo la siguiente queja de un pasajero de Avianca:

"Viaje el 15 de marzo en el vuelo AV204 de Bogota a Lima. Mi maleta
no llego. Llevo 3 dias esperando y nadie me da respuesta. Llame 4
veces al call center y cada vez me dicen algo diferente. Soy viajero
frecuente LifeMiles Gold desde hace 6 anos y nunca me habia pasado
algo asi. Estoy considerando cambiarme de aerolinea."

Extrae la siguiente informacion en formato estructurado:
- Numero de vuelo
- Ruta
- Fecha
- Tipo de problema
- Nivel de urgencia (alto/medio/bajo)
- Categoria de pasajero
- Sentimiento general
```

### Paso 2: Analizar con el contexto extraido

```
Con base en los datos extraidos del paso anterior:

- Vuelo: AV204
- Ruta: Bogota - Lima
- Fecha: 15 de marzo
- Problema: Equipaje perdido, 3 dias sin respuesta
- Urgencia: Alta
- Pasajero: LifeMiles Gold, 6 anos de antiguedad
- Sentimiento: Frustracion alta, riesgo de desercion

Analiza:
1. Cual es el riesgo real de perder a este cliente
2. Que politicas de compensacion aplican para un Gold con este tipo de incidente
3. Que fallo en el proceso si llamo 4 veces sin respuesta consistente
```

### Paso 3: Generar plan de accion

```
Segun el analisis anterior, el pasajero es Gold con alto riesgo de
desercion, tiene un equipaje perdido hace 3 dias y ha recibido
informacion inconsistente en 4 llamadas.

Genera un plan de accion concreto que incluya:
1. Respuesta inmediata al pasajero (tono empatico y profesional)
2. Compensacion recomendada segun su categoria
3. Acciones internas para evitar que se repita la inconsistencia en
   call center
4. Seguimiento a 7 dias

Formato: lista numerada con responsable y plazo para cada accion.
```

### Flujo completo del ejemplo

```mermaid
flowchart TD
    Q["Queja del pasajero (texto libre)"]
    Q --> P1["Prompt 1: Extraer datos clave"]
    P1 --> R1["Vuelo, ruta, problema, urgencia, categoria"]
    R1 --> P2["Prompt 2: Analizar riesgo y contexto"]
    P2 --> R2["Riesgo de desercion, politicas aplicables, fallas"]
    R2 --> P3["Prompt 3: Plan de accion"]
    P3 --> R3["Respuesta + Compensacion + Acciones internas"]
    style Q fill:#f8b4b4
    style R1 fill:#93c5fd
    style R2 fill:#93c5fd
    style R3 fill:#86efac
    style P1 fill:#e2e8f0
    style P2 fill:#e2e8f0
    style P3 fill:#e2e8f0
```

---

## Cuando NO encadenar

No toda tarea necesita una cadena. Usar chaining para algo simple agrega complejidad innecesaria.

**Usa un solo prompt cuando:**

- La tarea es directa: "Resume este correo en 3 puntos"
- No necesitas verificar pasos intermedios
- La respuesta esperada es corta y concreta

**Usa chaining cuando:**

- La tarea tiene multiples etapas logicas
- Necesitas diferentes "roles" o perspectivas en cada paso
- El resultado final depende de analisis previos
- Quieres poder corregir el rumbo entre pasos

---

## Tips para encadenar de forma efectiva

### 1. Se especifico con el formato en cada paso

Indicar el formato de salida esperado facilita que el siguiente prompt lo consuma correctamente.

```
Responde SOLO en formato de tabla con columnas:
| Campo | Valor |
```

### 2. Referencia explicitamente el resultado anterior

No asumas que la IA "recuerda" el contexto. Copia o resume la salida del paso anterior al inicio del siguiente prompt.

```
Con base en los datos extraidos en el paso anterior:
[pegar aqui el resultado del Prompt 1]

Ahora analiza...
```

### 3. Valida antes de avanzar

Revisa el resultado de cada paso antes de pasarlo al siguiente. Si el Paso 1 extrajo mal un dato, todo lo demas se construye sobre una base erronea.

### 4. Mantene cada prompt enfocado en una sola tarea

Si un prompt intenta hacer dos cosas a la vez, dividilo en dos. Mejor tres prompts simples que uno confuso.

---

## Fuentes

- [Prompting Guide - Chain of Thought](https://www.promptingguide.ai/techniques/cot)
- [FindSkill - Prompt Chaining: como encadenar prompts para tareas complejas](https://findskill.ai/es/blog/prompt-chaining-como-encadenar-prompts-para-tareas-complejas/)
- [DataStudios - Microsoft Copilot Prompting Techniques](https://www.datastudios.org/post/microsoft-copilot-prompting-techniques-structure-grounding-and-workflow-optimisation)$md$), 15);

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 3), 5, 'Practica: disena una cadena de 3 prompts', 'ejercicio',
 '{"instrucciones": "Elige un proceso de tu area de trabajo que tenga al menos 3 etapas logicas. Disena una cadena de 3 prompts donde la salida de cada uno alimente al siguiente.\n\nEstructura tu entregable asi:\n\n1. **Descripcion del proceso:** Que tarea vas a resolver y por que necesita encadenamiento.\n\n2. **Prompt 1 (Extraccion/Preparacion):** Escribe el primer prompt que recopile o estructure la informacion inicial. Indica el formato de salida esperado.\n\n3. **Prompt 2 (Analisis/Transformacion):** Escribe el segundo prompt que tome el resultado del Paso 1 y lo analice o transforme. Referencia explicitamente los datos del paso anterior.\n\n4. **Prompt 3 (Accion/Entregable):** Escribe el tercer prompt que genere el resultado final: un correo, un reporte, una recomendacion o una decision.\n\n5. **Patron utilizado:** Indica cual de los 4 patrones de encadenamiento aplicaste (Secuencial, Paralelo con merge, Condicional o Loop de refinamiento) y por que.\n\nRecuerda: cada prompt debe tener un solo objetivo, un formato de salida claro y referenciar explicitamente el resultado anterior.", "texto": "Tip: Si no se te ocurre un proceso, usa este ejemplo: analizar las 5 preguntas mas frecuentes de tu area, categorizarlas por urgencia y generar respuestas estandarizadas."}', 15);

-- ============================================================
-- MODULO 4: Prompting avanzado: estructuras y seguridad
-- ============================================================

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 4), 1, 'Estructuras avanzadas para prompts efectivos', 'video',
 '{"media_url": "BRy7Z3ZoQZk", "texto": "Video de Xavier Mitjana: como estructurar prompts avanzados con XML y JSON. Creditos: canal Xavier Mitjana en YouTube."}', 10);

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 4), 2, 'Estructuras XML y JSON para prompts', 'texto',
 jsonb_build_object('texto', $md$# Estructuras XML y JSON para prompts: organiza tus instrucciones como un profesional

Cuando le pides algo a una IA escribiendo texto libre, es como darle instrucciones verbales a alguien en medio de un aeropuerto ruidoso: la idea general llega, pero los detalles se pierden. Las **estructuras XML y JSON** son formas de organizar tus instrucciones para que la IA entienda exactamente que necesitas, sin ambiguedad.

En este modulo vas a aprender a usar estas estructuras sin necesidad de saber programar. Piensa en ellas como **formularios inteligentes** que le dicen a Copilot que rol asumir, que contexto considerar y que formato debe tener la respuesta.

---

## Que son XML y JSON (explicacion sin tecnicismos)

### XML: etiquetas que envuelven instrucciones

XML usa **etiquetas** (palabras entre signos `< >`) para separar y nombrar cada parte de tu instruccion. Funciona como un formulario donde cada campo tiene un nombre claro.

Imagina que llenas una solicitud interna: hay un campo para "Nombre", otro para "Area", otro para "Descripcion". XML hace exactamente lo mismo, pero para la IA.

### JSON: listas organizadas con llaves y corchetes

JSON usa **llaves `{ }`** para agrupar informacion y **dos puntos `:`** para asignar valores a cada campo. Es como una lista de datos estructurada donde cada elemento tiene un nombre y un valor.

Piensa en una hoja de calculo donde la columna A tiene los nombres de los campos y la columna B tiene los valores. JSON organiza la informacion de esa forma.

---

## Por que las estructuras mejoran los resultados de la IA

Investigaciones en tecnicas de prompting estructurado muestran que organizar las instrucciones en formato XML o JSON reduce los errores de interpretacion de la IA en aproximadamente un **60%** comparado con texto libre.

La razon es simple: cuando la IA recibe un prompt estructurado, no tiene que "adivinar" donde empieza el contexto y donde termina la tarea. Cada seccion esta claramente delimitada.

```mermaid
flowchart LR
    A["Texto libre\n(ambiguo)"] --> B["Prompt\nestructurado"]
    B --> C["Respuesta precisa\ny completa"]
    A -.->|"Sin estructura"| D["Respuesta generica\no incompleta"]
    style A fill:#fecaca,stroke:#ef4444
    style B fill:#bfdbfe,stroke:#3b82f6
    style C fill:#bbf7d0,stroke:#22c55e
    style D fill:#fef3c7,stroke:#f59e0b
```

---

## Ejemplo XML: prompt de comunicacion de crisis para una aerolinea

Este es un prompt estructurado con etiquetas XML para generar una comunicacion de crisis. Cada etiqueta delimita una seccion con un proposito especifico.

```xml
<rol>
Eres un experto en comunicaciones corporativas de crisis
para la industria de aviacion comercial.
</rol>

<contexto>
Avianca ha experimentado una demora masiva en el hub de Bogota
debido a condiciones meteorologicas severas. Hay 2,500 pasajeros
afectados en 15 vuelos. Las redes sociales estan activas con quejas.
</contexto>

<tarea>
Redacta un comunicado oficial para publicar en redes sociales
y enviar por correo a los pasajeros afectados.
</tarea>

<formato>
- Longitud: maximo 200 palabras
- Tono: empatico, profesional y proactivo
- Incluir: disculpa, causa, acciones tomadas, siguiente paso
- Idioma: espanol formal
</formato>

<restricciones>
- No prometer compensaciones especificas sin autorizacion
- No mencionar montos economicos
- No culpar a terceros ni entidades gubernamentales
- Mantener coherencia con la voz de marca de Avianca
</restricciones>
```

Observa como cada etiqueta actua como un "cajon" con nombre propio. La IA sabe exactamente que informacion corresponde a cada parte del problema.

---

## Ejemplo JSON: creacion de agenda de capacitacion

JSON permite crear estructuras con datos anidados, lo que es util cuando necesitas organizar informacion con multiples niveles de detalle.

```json
{
  "solicitud": "Crear agenda de capacitacion",
  "parametros": {
    "tema": "Uso de Microsoft Copilot para equipos de servicio al cliente",
    "duracion": "4 horas",
    "audiencia": "Agentes de servicio al cliente de Avianca",
    "nivel": "Basico",
    "formato_entrega": "Virtual con ejercicios practicos"
  },
  "estructura_requerida": {
    "modulos": 4,
    "por_cada_modulo": [
      "Titulo del modulo",
      "Objetivo de aprendizaje",
      "Duracion estimada",
      "Actividad practica",
      "Recurso de apoyo"
    ]
  },
  "restricciones": {
    "herramienta_principal": "Microsoft Copilot Chat",
    "idioma": "Espanol",
    "incluir_pausas": true,
    "tiempo_maximo_teoria": "30% del total"
  }
}
```

La ventaja de JSON es que permite agrupar parametros relacionados dentro de un mismo bloque. Por ejemplo, todas las restricciones quedan juntas en su propia seccion.

---

## Comparacion: XML vs JSON vs Texto libre

| Criterio | XML | JSON | Texto libre |
|---|---|---|---|
| **Legibilidad para no tecnicos** | Alta. Las etiquetas se leen como titulos | Media. Requiere familiaridad con llaves y comillas | Alta. Es lenguaje natural |
| **Precision de resultados** | Muy alta | Muy alta | Variable |
| **Cuando usarlo** | Prompts largos con secciones narrativas | Prompts con datos, listas y parametros numericos | Preguntas simples y directas |
| **Complejidad de escritura** | Baja. Solo requiere abrir y cerrar etiquetas | Media. Hay que respetar comas, comillas y llaves | Ninguna |
| **Mejor para** | Comunicaciones, reportes, documentos | Agendas, formularios, configuraciones | Consultas rapidas del dia a dia |

**Conclusion practica:** XML es generalmente mas intuitivo para usuarios no tecnicos porque las etiquetas se leen como titulos de seccion. JSON es mas eficiente cuando trabajas con datos numericos o listas. Ambos funcionan perfectamente con Copilot. Para preguntas simples, el texto libre sigue siendo valido.

---

## Plantillas maestras: el concepto de "formulario reutilizable"

Una **plantilla maestra** es un prompt estructurado donde ciertos valores se reemplazan con marcadores de posicion (placeholders). Esto permite reutilizar la misma estructura una y otra vez, cambiando solo los datos especificos de cada situacion.

Los marcadores siguen el formato `[NOMBRE_DEL_CAMPO]` en mayusculas para que sean faciles de identificar y reemplazar.

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

Esta plantilla esta disenada para generar comunicados rapidos ante situaciones operacionales. Solo necesitas llenar los campos entre corchetes.

```xml
<rol>
Eres un especialista en comunicaciones de crisis
para [NOMBRE_AEROLINEA].
</rol>

<contexto>
Situacion: [DESCRIPCION_SITUACION]
Pasajeros afectados: [NUMERO_PASAJEROS]
Vuelos involucrados: [LISTA_VUELOS]
Canal de comunicacion: [CANAL]
Hora del incidente: [HORA]
</contexto>

<tarea>
[TIPO_COMUNICADO]: redacta un mensaje [TONO] que informe
a los pasajeros sobre la situacion y las acciones tomadas.
</tarea>

<formato>
- Longitud maxima: [MAX_PALABRAS] palabras
- Estructura: disculpa, explicacion, acciones, siguiente paso
- Idioma: [IDIOMA]
</formato>

<restricciones>
- No prometer compensaciones sin autorizacion de [AREA_RESPONSABLE]
- No revelar informacion tecnica interna
- Mantener coherencia con la guia de estilo corporativa
- [RESTRICCION_ADICIONAL]
</restricciones>
```

**Ejemplo de uso:** para un retraso por mantenimiento en Cartagena, simplemente reemplaza `[DESCRIPCION_SITUACION]` por "Retraso de 3 horas en vuelo AV204 Bogota-Cartagena por revision tecnica programada", `[NUMERO_PASAJEROS]` por "180" y asi sucesivamente.

---

## Plantilla 2: Reporte semanal de area

Esta plantilla genera reportes semanales estandarizados. Util para cualquier area que necesite entregar informes periodicos.

```xml
<rol>
Eres un analista de gestion que redacta reportes ejecutivos
claros y orientados a resultados.
</rol>

<contexto>
Area: [NOMBRE_AREA]
Periodo: Semana del [FECHA_INICIO] al [FECHA_FIN]
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

Plan para la proxima semana:
- [PLAN_1]
- [PLAN_2]
</tarea>

<formato>
- Formato: tabla resumen + parrafos breves
- Tono: profesional, directo, sin adjetivos innecesarios
- Longitud: maximo [MAX_PALABRAS] palabras
- Incluir: semaforo de estado (verde/amarillo/rojo) por cada KPI
</formato>

<restricciones>
- No inventar datos que no se proporcionaron
- Si falta informacion, indicar "Dato pendiente" en lugar de suponer
- Usar terminologia estandar de [NOMBRE_AEROLINEA]
</restricciones>
```

---

> **Advertencia sobre seguridad de datos:** Cuando utilices plantillas con herramientas de IA externas (fuera de Copilot empresarial), nunca incluyas datos reales de pasajeros, empleados, numeros de vuelo activos ni informacion financiera en los placeholders. Copilot Chat de Microsoft dentro del entorno corporativo de Avianca protege tus datos, pero cualquier herramienta externa podria almacenarlos o usarlos para entrenamiento. Ante la duda, usa datos ficticios o consultalo con tu lider.

---

## Fuentes

- CodeConductor. *Structured Prompting Techniques: XML & JSON*. [https://codeconductor.ai/blog/structured-prompting-techniques-xml-json/](https://codeconductor.ai/blog/structured-prompting-techniques-xml-json/)
- Microsoft Learn. *Prompt Library - Microsoft Copilot Studio*. [https://learn.microsoft.com/en-us/microsoft-copilot-studio/prompt-library](https://learn.microsoft.com/en-us/microsoft-copilot-studio/prompt-library)
- VisualSP. *Comprehensive Guide to Effective Microsoft Copilot Prompts*. [https://www.visualsp.com/blog/comprehensive-guide-to-effective-microsoft-copilot-prompts/](https://www.visualsp.com/blog/comprehensive-guide-to-effective-microsoft-copilot-prompts/)$md$), 15);

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 4), 3, 'Practica: crea una plantilla XML reutilizable', 'ejercicio',
 '{"instrucciones": "Crea una plantilla XML reutilizable para un caso de uso de tu area de trabajo. La plantilla debe incluir:\n\n1. **Etiqueta <rol>:** Define quien es la IA en este escenario.\n2. **Etiqueta <contexto>:** Incluye al menos 3 campos con placeholders [CAMPO] que se puedan reemplazar.\n3. **Etiqueta <tarea>:** Describe la accion especifica que la IA debe realizar.\n4. **Etiqueta <formato>:** Especifica como quieres la respuesta (longitud, estructura, tono).\n5. **Etiqueta <restricciones>:** Al menos 2 restricciones claras.\n\nDespues de crear la plantilla:\n- Llena los placeholders con datos ficticios para un caso concreto\n- Prueba el prompt completo en Copilot\n- Evalua si el resultado cumple con lo esperado\n\nEntregable: la plantilla vacia + un ejemplo de uso con datos ficticios + el resultado de Copilot.", "texto": "Tip: Las mejores plantillas son las que puedes reutilizar al menos 5 veces al mes. Piensa en tareas que haces repetidamente."}', 15);

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 4), 4, 'Shadow AI: el peligro oculto en tu empresa', 'texto',
 jsonb_build_object('texto', $md$# Shadow AI: el peligro oculto en tu empresa

Cada dia, miles de empleados usan herramientas de IA gratuitas para resolver tareas laborales sin que el area de TI lo sepa. Esta practica tiene nombre: **Shadow AI**, y representa uno de los riesgos de ciberseguridad mas criticos de la era actual.

---

## Que es Shadow AI

Shadow AI es el uso de **cualquier herramienta de inteligencia artificial que no ha sido autorizada ni supervisada por el area de Tecnologia** de la organizacion. Esto incluye:

- ChatGPT en su version gratuita o con cuenta personal
- Google Gemini sin licencia corporativa
- Aplicaciones moviles que integran IA (editores de texto, resumidores, traductores)
- Extensiones de navegador con funciones de IA
- Bots de terceros en Telegram, WhatsApp u otras plataformas

El problema no es la IA en si misma, sino que estas herramientas operan **fuera del perimetro de seguridad** de la empresa, sin controles de acceso, sin cifrado corporativo y sin politicas de retencion de datos.

---

## Las cifras que deberian preocuparnos

La magnitud del problema no es teorica. Estos son datos respaldados por investigaciones recientes:

| Indicador | Dato | Fuente |
|-----------|------|--------|
| Empleados que comparten datos corporativos en herramientas de IA no autorizadas | **77%** | eSecurity Planet, 2024 |
| Empleados que usan cuentas personales para IA laboral | **82%** | eSecurity Planet, 2024 |
| Costo promedio de una brecha originada por Shadow AI | **$670,000 USD** | IBM Cost of a Data Breach, 2025 |
| Tiempo adicional para identificar filtraciones via IA vs. ciberataques tradicionales | **26% mas lento** | IBM, 2025 |
| Porcentaje de datos pegados en ChatGPT que son sensibles | **34.8%** | Stanford, 2025 |

> Casi 8 de cada 10 empleados ya estan exponiendo informacion corporativa en herramientas de IA sin autorizacion. La pregunta no es si va a pasar una filtracion, sino cuando.

---

## Caso real: Samsung y la filtracion que cambio las reglas

En abril de 2023, tres ingenieros de **Samsung Semiconductor** usaron ChatGPT en su version gratuita para tareas laborales cotidianas:

1. Un ingeniero pego **codigo fuente confidencial** para buscar errores
2. Otro compartio **notas de una reunion estrategica interna** para generar un resumen
3. Un tercero subio un **reporte tecnico de hardware** para optimizarlo

El resultado fue devastador: toda esa informacion paso a formar parte de los datos de entrenamiento del modelo publico. Samsung perdio el control sobre propiedad intelectual critica, y la informacion quedo potencialmente disponible para cualquier usuario de ChatGPT en el mundo.

La consecuencia inmediata fue la **prohibicion total de herramientas de IA generativa** en Samsung, afectando a mas de 100,000 empleados. El dano reputacional y la perdida de ventaja competitiva fueron incalculables.

Este caso demuestra que el riesgo no proviene de hackers externos, sino de **empleados bien intencionados** que buscan ser mas productivos sin comprender las implicaciones de seguridad.

---

## Como funciona la filtracion

El mecanismo de exposicion es mas simple de lo que parece:

```mermaid
flowchart TD
    A["Empleado pega datos\nen IA no autorizada"] --> B["Los datos viajan\na servidores externos"]
    B --> C["La herramienta usa los datos\npara entrenar su modelo"]
    C --> D["La informacion queda\nen el modelo global"]
    D --> E["Terceros pueden acceder\na esa informacion"]
    style A fill:#e0f2fe,stroke:#0284c7
    style B fill:#fef3c7,stroke:#d97706
    style C fill:#fecaca,stroke:#dc2626
    style D fill:#fecaca,stroke:#dc2626
    style E fill:#fecaca,stroke:#dc2626
```

Cada vez que un empleado pega informacion en una herramienta gratuita, esos datos salen del control de la empresa. No hay forma de recuperarlos, eliminarlos ni rastrear quien mas pudo acceder a ellos.

---

## Copilot Empresarial vs. herramientas gratuitas

No todas las herramientas de IA son iguales. La diferencia entre una solucion corporativa y una gratuita es la diferencia entre una caja fuerte y una plaza publica.

| Caracteristica | Copilot Empresarial | ChatGPT Gratuito | Gemini Free |
|---------------|-------------------|-----------------|-------------|
| **Datos usados para entrenamiento** | No. Contractualmente prohibido | Si. Los datos alimentan el modelo | Si. Google puede usar los datos |
| **Aislamiento de inquilino (tenant)** | Si. Datos aislados por organizacion | No. Modelo compartido globalmente | No. Sin aislamiento corporativo |
| **Cumplimiento GDPR / regulatorio** | Si. Certificaciones SOC 2, ISO 27001 | Limitado. Sin garantias corporativas | Limitado. Depende de la cuenta |
| **Registros de auditoria** | Si. Logs completos para TI | No disponible | No disponible |
| **Soporte corporativo y SLA** | Si. Soporte dedicado con SLA | No. Solo soporte comunitario | No. Solo soporte estandar de Google |
| **Control de acceso y permisos** | Si. Integrado con Microsoft Entra ID | No. Cuenta personal del empleado | No. Cuenta personal de Google |
| **Cifrado de datos en transito y reposo** | Si. Cifrado empresarial | Basico | Basico |

> Cuando usas Copilot dentro del entorno corporativo de Avianca, tus datos permanecen dentro del perimetro de seguridad de la empresa. Cuando usas ChatGPT gratuito, tus datos dejan de pertenecerte en el momento en que presionas "Enviar".

---

## 6 reglas de oro para empleados de Avianca

Estas son las practicas obligatorias para proteger la informacion de la empresa y de nuestros pasajeros:

### 1. Usa unicamente las herramientas aprobadas por TI

Microsoft Copilot es la herramienta de IA autorizada por Avianca. Si no esta en la lista de herramientas aprobadas, no la uses para trabajo.

### 2. Nunca pegues datos de pasajeros en ninguna IA

Nombres, numeros de documento, itinerarios, datos de pago, historiales de vuelo: nada de esto debe ingresarse en herramientas de IA, ni siquiera en Copilot, sin verificar que el caso de uso esta permitido.

### 3. No uses cuentas personales para IA laboral

Tu cuenta personal de ChatGPT, Gemini o cualquier otra herramienta no tiene las protecciones del entorno corporativo. Usarla para trabajo es una brecha de seguridad automatica.

### 4. Si la herramienta pide datos para "mejorar", probablemente entrena con ellos

Muchas herramientas gratuitas incluyen clausulas donde los datos ingresados se usan para entrenamiento del modelo. Si ves opciones como "ayudanos a mejorar" o "compartir datos de uso", asume que tu informacion esta siendo recopilada.

### 5. Consulta con TI antes de probar nuevas aplicaciones de IA

Antes de instalar una extension, registrarte en un servicio nuevo o usar una app que promete funciones de IA, verifica con el area de Tecnologia si esta autorizada. Una consulta de 5 minutos puede evitar un incidente de seguridad.

### 6. Nunca confies ciegamente en la IA para datos regulatorios o de aviacion

La IA puede generar informacion incorrecta con total confianza. Para datos criticos de aviacion, regulaciones aeronauticas, normativas de seguridad o procedimientos operativos, siempre valida con fuentes oficiales.

---

## Flujo de decision: herramienta de IA segura o no

```mermaid
flowchart TD
    A["Necesito usar IA\npara una tarea laboral"] --> B{"La herramienta esta\naprobada por TI?"}
    B -->|Si| C{"Los datos que voy\na ingresar son sensibles?"}
    B -->|No| D["No la uses.\nConsulta con TI"]
    C -->|No| E["Procede con\nprecaucion"]
    C -->|Si| F{"He anonimizado\nla informacion?"}
    F -->|Si| E
    F -->|No| G["Anonimiza primero.\nElimina nombres, documentos\ny datos identificables"]
    G --> F
    style A fill:#e0f2fe,stroke:#0284c7
    style D fill:#fecaca,stroke:#dc2626
    style E fill:#dcfce7,stroke:#16a34a
    style G fill:#fef3c7,stroke:#d97706
```

---

## Fuentes

- [eSecurity Planet — Shadow AI: ChatGPT & DLP](https://www.esecurityplanet.com/news/shadow-ai-chatgpt-dlp/) — Estadisticas de 77% de empleados compartiendo datos y 82% usando cuentas personales
- [IBM — Cost of a Data Breach Report 2025](https://www.ibm.com/reports/data-breach) — Costo promedio de $670,000 USD y 26% mas lento en deteccion
- [Stanford HAI — AI Index Report 2025](https://aiindex.stanford.edu/report/) — 34.8% de datos sensibles pegados en ChatGPT
- [Forbes Colombia — Samsung prohibe ChatGPT entre empleados](https://forbes.co/tecnologia/samsung-prohibe-a-chatgpt-entre-empleados) — Caso de filtracion de codigo fuente
- [Microsoft — Seguridad en Microsoft 365 Copilot](https://learn.microsoft.com/es-es/copilot/microsoft-365/microsoft-365-copilot-ai-security) — Arquitectura de seguridad empresarial
- [Microsoft — Privacidad y protecciones de Copilot](https://learn.microsoft.com/es-es/copilot/privacy-and-protections) — Politicas de privacidad y no entrenamiento
- [7Experts — Riesgos de seguridad y privacidad de ChatGPT en empresas](https://www.7experts.com/riesgos-seguridad-privacidad-chatgpt-empresas/) — Analisis de riesgos corporativos$md$), 15);

-- ============================================================
-- MODULO 5: Crea con Copilot
-- ============================================================

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 5), 1, 'Crear imagenes con Copilot Designer', 'texto',
 jsonb_build_object('texto', $md$# Crear imagenes con Copilot Designer

Microsoft Copilot integra un generador de imagenes basado en **DALL-E 3**, el modelo de OpenAI especializado en crear imagenes a partir de descripciones textuales. Esto significa que puedes generar ilustraciones, fotografias conceptuales y graficos directamente desde la interfaz de Copilot, sin necesidad de herramientas externas de diseno.

Para el entorno corporativo, esta capacidad resuelve un problema concreto: obtener imagenes personalizadas para presentaciones, comunicaciones internas y publicaciones en redes sociales sin depender de bancos de imagenes genericas ni del equipo de diseno para cada solicitud.

---

## Como funciona la generacion de imagenes

Cuando describes una imagen en Copilot, el texto pasa por el modelo DALL-E 3, que interpreta la descripcion y genera una imagen original. El proceso interno funciona asi:

1. Copilot recibe tu descripcion en lenguaje natural
2. El modelo analiza los elementos descritos: sujeto, contexto, estilo y parametros tecnicos
3. DALL-E 3 genera varias opciones de imagen basadas en tu descripcion
4. Copilot te presenta las opciones para que selecciones o ajustes

La calidad del resultado depende directamente de la calidad de tu descripcion. Un prompt vago produce imagenes genericas; un prompt estructurado produce imagenes utiles para el contexto corporativo.

---

## Estructura de un prompt efectivo para imagenes

Un buen prompt de imagen sigue cuatro componentes que, combinados, le dan a DALL-E la informacion necesaria para generar exactamente lo que necesitas.

```mermaid
flowchart LR
    A["SUJETO\nQue aparece"] --> B["CONTEXTO\nDonde y cuando"]
    B --> C["ESTILO VISUAL\nComo se ve"]
    C --> D["PARAMETROS\nDetalles tecnicos"]
    D --> E["Imagen\ngenerada"]
    style A fill:#dbeafe,stroke:#3b82f6
    style B fill:#e0e7ff,stroke:#6366f1
    style C fill:#ede9fe,stroke:#8b5cf6
    style D fill:#fae8ff,stroke:#c084fc
    style E fill:#d1fae5,stroke:#10b981
```

| Componente | Que describe | Ejemplo |
|---|---|---|
| **Sujeto** | El elemento principal de la imagen | "Un equipo diverso de profesionales en una sala de reuniones" |
| **Contexto** | El escenario, ambiente o situacion | "En una oficina moderna con ventanales grandes y luz natural" |
| **Estilo visual** | La estetica y tipo de imagen | "Fotografia profesional corporativa, iluminacion calida" |
| **Parametros** | Detalles tecnicos y restricciones | "Formato horizontal 16:9, colores predominantes rojo y blanco" |

La formula general es:

**[SUJETO]** + **[CONTEXTO]** + **[ESTILO VISUAL]** + **[PARAMETROS]**

No es necesario incluir los cuatro componentes en cada prompt, pero mientras mas informacion relevante incluyas, mas preciso sera el resultado.

---

## Ejemplo 1: Imagen para diapositiva de presentacion

**Escenario:** Necesitas una imagen para la portada de una presentacion sobre transformacion digital en Avianca.

**Prompt:**

```
Crea una imagen de un equipo diverso de profesionales de aerolinea
colaborando frente a pantallas digitales con graficos de datos y
dashboards. Oficina corporativa moderna con ventanales panoramicos
y vista a una pista de aterrizaje al fondo. Fotografia profesional
corporativa con iluminacion suave y tonos calidos. Formato horizontal
16:9, paleta de colores que incluya rojo corporativo y blanco.
```

**Por que funciona:** El prompt especifica el sujeto (equipo diverso), el contexto (oficina con vista a pista), el estilo (fotografia profesional) y los parametros (formato, colores). DALL-E tiene suficiente informacion para generar algo alineado con la identidad visual de la empresa.

---

## Ejemplo 2: Imagen para publicacion en redes sociales

**Escenario:** El equipo de comunicaciones necesita una imagen para una publicacion de LinkedIn sobre la cultura de innovacion.

**Prompt:**

```
Crea una imagen de una mujer profesional de mediana edad usando una
tablet en el lobby de un aeropuerto moderno, con aviones visibles a
traves de los ventanales. La persona tiene una expresion de confianza
y concentracion. Estilo de fotografia editorial para revista de
negocios, iluminacion natural. Formato cuadrado 1:1, tonos limpios
con acentos en rojo.
```

**Por que funciona:** Para redes sociales, la imagen necesita un sujeto con el que la audiencia se identifique, un contexto reconocible y un formato adecuado al canal (cuadrado para feed de LinkedIn).

---

## Ejemplo 3: Imagen para comunicacion interna

**Escenario:** Recursos Humanos necesita una imagen para un correo interno sobre el programa de bienestar laboral.

**Prompt:**

```
Crea una imagen de un grupo pequeno de empleados de diferentes
edades y origenes etnicos en un espacio de descanso corporativo,
conversando de manera relajada con tazas de cafe. El ambiente es
luminoso y acogedor, con plantas y mobiliario moderno. Ilustracion
digital con estilo flat design, lineas limpias y colores pastel
con acentos en rojo y azul claro. Formato horizontal.
```

**Por que funciona:** Para comunicacion interna se puede usar un estilo mas informal como ilustracion en lugar de fotografia. El flat design es amigable y no genera confusion sobre si las personas son empleados reales.

---

## Tips para imagenes corporativas

### Especifica "fotografia profesional" cuando necesites realismo

Si no indicas el estilo, DALL-E puede generar una mezcla de ilustracion y fotografia. Usar la frase "fotografia profesional corporativa" o "fotografia editorial" orienta el modelo hacia resultados mas adecuados para el contexto empresarial.

### Describe la diversidad de forma explicita

Para que la imagen refleje la diversidad real de la organizacion, describela en el prompt: "equipo diverso en edad, genero y origen etnico". Si no lo especificas, el modelo puede generar resultados homogeneos que no representan al equipo.

### Incluye los colores de marca

Mencionar los colores corporativos en el prompt ayuda a que la imagen se integre visualmente con las presentaciones y materiales de la empresa. Usa frases como "paleta de colores con rojo corporativo y blanco" o "acentos en los colores institucionales".

### Evita prompts excesivamente detallados

DALL-E funciona mejor con descripciones claras y concretas que con listas exhaustivas de detalles. Si agregas demasiados elementos, el modelo intenta incluirlos todos y el resultado pierde coherencia. Prioriza los 3 o 4 elementos mas importantes.

### Itera en lugar de intentar el prompt perfecto

Es mas efectivo generar una primera version y luego ajustar el prompt que intentar escribir la descripcion perfecta de entrada. Usa frases como "Igual que la imagen anterior pero con..." para refinar el resultado.

---

## Limitaciones que debes conocer

Antes de usar Copilot Designer para generar imagenes corporativas, ten en cuenta estas restricciones tecnicas y legales:

| Limitacion | Detalle |
|---|---|
| **Texto en imagenes** | DALL-E no genera texto legible de forma confiable. Los logotipos, titulos o etiquetas dentro de la imagen pueden salir distorsionados o con errores ortograficos. Si necesitas texto, agregalo despues en PowerPoint o Canva. |
| **Marcas registradas** | El modelo no puede reproducir logotipos ni marcas registradas con precision. No intentes generar el logo de Avianca ni de ninguna otra empresa. Usa los archivos oficiales del manual de marca. |
| **Personas ficticias** | Todas las personas generadas por DALL-E son ficticias. No puedes solicitar que genere imagenes de personas reales, celebridades o empleados especificos. |
| **Consistencia entre imagenes** | Cada generacion es independiente. Si necesitas varias imagenes con el mismo estilo, incluye la misma descripcion de estilo en cada prompt, pero los resultados no seran identicos. |
| **Derechos de uso** | Las imagenes generadas con Copilot en el entorno empresarial de Microsoft 365 pueden usarse para fines comerciales segun los terminos de servicio de Microsoft. Verifica con tu area legal ante cualquier duda. |

> **Importante:** Nunca utilices imagenes generadas por IA como fotografias de empleados reales. En comunicaciones internas o externas, si usas una imagen generada, indicalo con una nota como "Imagen generada con IA con fines ilustrativos". Presentar personas ficticias como empleados reales viola principios de transparencia y puede generar problemas legales y de confianza.

---

## Como acceder a Copilot Designer

Copilot Designer esta disponible en varios puntos de acceso dentro del ecosistema Microsoft. La funcionalidad es la misma, pero el punto de entrada varia segun donde estes trabajando.

### Desde Copilot en la web

1. Ingresa a [copilot.microsoft.com](https://copilot.microsoft.com) con tu cuenta corporativa
2. En el campo de chat, escribe tu descripcion de imagen
3. Copilot detecta automaticamente que quieres una imagen y activa Designer
4. Selecciona la imagen que prefieras de las opciones generadas

### Desde Microsoft Edge

1. Abre el navegador Microsoft Edge
2. Haz clic en el icono de Copilot en la barra lateral derecha
3. Escribe tu prompt de imagen directamente en el chat
4. Las imagenes se generan en el panel lateral sin salir de tu pagina actual

### Desde Microsoft Designer

1. Ingresa a [designer.microsoft.com](https://designer.microsoft.com)
2. Selecciona "Crear con IA" o usa el campo de descripcion
3. Designer ofrece opciones adicionales de edicion posterior: recortar, agregar texto, aplicar filtros
4. Puedes descargar la imagen en varios formatos y resoluciones

### Desde Microsoft Teams

1. En una conversacion o canal de Teams, abre el panel de Copilot
2. Describe la imagen que necesitas
3. Copilot genera las opciones dentro de la misma interfaz de Teams
4. Puedes compartir la imagen directamente en la conversacion

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
- Microsoft Designer. *Herramienta de diseno con IA*. [https://designer.microsoft.com/](https://designer.microsoft.com/)$md$), 15);

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 5), 2, 'Practica: genera 3 imagenes para una presentacion', 'ejercicio',
 '{"instrucciones": "Usando Copilot Designer, genera 3 imagenes para una presentacion profesional de tu area. Cada imagen debe tener un proposito diferente:\n\n1. **Imagen de portada:** Genera una imagen que funcione como portada de una presentacion sobre un tema relevante de tu departamento. Usa el formato SUJETO + CONTEXTO + ESTILO VISUAL + PARAMETROS.\n\n2. **Imagen de seccion:** Genera una imagen que ilustre un concepto clave de tu area (por ejemplo: trabajo en equipo, innovacion, servicio al cliente). Usa un estilo diferente al de la portada.\n\n3. **Imagen para redes sociales:** Genera una imagen en formato cuadrado (1:1) que podria usarse en LinkedIn para comunicar un logro del equipo.\n\nPara cada imagen documenta:\n- El prompt que usaste\n- Por que elegiste ese estilo y formato\n- Si iteraste el prompt y que cambios hiciste\n- Si la imagen cumple con las guias de marca (colores corporativos, diversidad, profesionalismo)", "texto": "Recuerda: nunca presentes imagenes generadas por IA como fotos reales de empleados."}', 10);

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 5), 3, 'Formularios y presentaciones inteligentes con Copilot', 'texto',
 jsonb_build_object('texto', $md$# Formularios y presentaciones inteligentes con Copilot

Microsoft Copilot no solo sirve para redactar textos o analizar datos. Tambien puede ayudarte a crear **formularios profesionales** en Microsoft Forms y **presentaciones ejecutivas** en PowerPoint, reduciendo drasticamente el tiempo de preparacion. En esta leccion vas a aprender a usar Copilot como asistente en estas dos herramientas, con flujos paso a paso y ejemplos aplicados a Avianca.

---

## PARTE 1: Microsoft Forms + Copilot

### Que puede hacer Copilot en Forms

Copilot en Microsoft Forms funciona como un asistente de diseno de encuestas. En lugar de crear cada pregunta manualmente, **le describes lo que necesitas en lenguaje natural** y Copilot genera el formulario completo: preguntas, tipos de respuesta, opciones y estructura logica.

Esto es especialmente util cuando necesitas crear encuestas de satisfaccion, formularios de registro, evaluaciones internas o solicitudes estandarizadas, y no quieres partir desde cero.

### Flujo de trabajo: 7 pasos para crear un formulario con Copilot

```mermaid
flowchart TD
    A["1. Describir\nQue necesitas y para quien"] --> B["2. Generar\nCopilot crea el borrador"]
    B --> C["3. Revisar\nVerificar preguntas y opciones"]
    C --> D["4. Personalizar\nAjustar redaccion y diseno"]
    D --> E["5. Agregar logica\nRamificacion condicional"]
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

**1. Describir:** Abre Microsoft Forms y selecciona la opcion de Copilot. Escribe una descripcion clara de lo que necesitas. Mientras mas especifico seas, mejor sera el resultado. Incluye el proposito del formulario, la audiencia objetivo y los tipos de preguntas que esperas.

**2. Generar:** Copilot analiza tu descripcion y genera un borrador completo del formulario con preguntas, tipos de respuesta (opcion multiple, escala, texto abierto) y opciones predefinidas.

**3. Revisar:** Lee cada pregunta generada. Verifica que las opciones de respuesta cubran todos los casos relevantes y que la redaccion sea clara para tu audiencia.

**4. Personalizar:** Ajusta la redaccion para que coincida con el tono corporativo de Avianca. Modifica opciones de respuesta, agrega instrucciones adicionales o elimina preguntas que no apliquen.

**5. Agregar logica:** Configura ramificacion condicional cuando sea necesario. Por ejemplo, si un empleado responde "No" a una pregunta de satisfaccion, puedes dirigirlo a una pregunta abierta para que explique su respuesta.

**6. Distribuir:** Comparte el formulario mediante un enlace directo, por correo electronico o integrado en un canal de Microsoft Teams.

**7. Analizar resultados:** Una vez recopiladas las respuestas, Copilot puede generar resumenes automaticos, identificar tendencias y destacar los puntos que requieren atencion.

### Ejemplo practico: encuesta de satisfaccion para empleados de una aerolinea

Supongamos que Recursos Humanos necesita medir la satisfaccion de los empleados de operaciones en tierra. Este seria el prompt para Copilot en Forms:

> Crea una encuesta de satisfaccion laboral para empleados de operaciones en tierra de una aerolinea. Incluye preguntas sobre ambiente laboral, relacion con supervisores, carga de trabajo, oportunidades de crecimiento y bienestar general. Usa una combinacion de preguntas de escala del 1 al 5, opcion multiple y al menos 2 preguntas abiertas. La encuesta debe poder completarse en menos de 5 minutos.

Copilot generaria un formulario con preguntas como:

| Pregunta | Tipo | Opciones |
|----------|------|----------|
| En una escala del 1 al 5, que tan satisfecho estas con tu ambiente laboral? | Escala | 1 (Muy insatisfecho) a 5 (Muy satisfecho) |
| Cual es el aspecto que mas valoras de tu trabajo? | Opcion multiple | Estabilidad, Equipo de trabajo, Beneficios, Oportunidades de crecimiento, Otro |
| Con que frecuencia recibes retroalimentacion de tu supervisor? | Opcion multiple | Semanalmente, Quincenalmente, Mensualmente, Rara vez, Nunca |
| Consideras que tu carga de trabajo es adecuada? | Escala | 1 (Excesiva) a 5 (Muy adecuada) |
| Que sugieres para mejorar tu experiencia laboral? | Texto abierto | -- |
| Hay algo adicional que quieras compartir con el equipo de RR.HH.? | Texto abierto | -- |

### Tips para obtener mejores formularios con Copilot

- **Se especifico con los tipos de pregunta:** Indicale a Copilot si quieres escala de Likert (1-5 o 1-10), opcion multiple con seleccion unica o multiple, o preguntas abiertas. Si no lo especificas, Copilot elegira por defecto y puede no coincidir con lo que necesitas.
- **Define la audiencia:** No es lo mismo una encuesta para pilotos que para agentes de servicio al cliente. El lenguaje, los temas y la profundidad cambian segun el publico.
- **Indica el tiempo estimado:** Pedirle que la encuesta "se complete en 5 minutos" limita la cantidad de preguntas y evita formularios excesivamente largos.
- **Solicita opciones de "Otro" o "N/A":** Esto evita que los encuestados se sientan forzados a elegir una opcion que no los representa.

---

## PARTE 2: PowerPoint + Copilot

### Que puede hacer Copilot en PowerPoint

Copilot en PowerPoint actua como un asistente de creacion de presentaciones. Puede **generar una presentacion completa a partir de una descripcion textual**, estructurar diapositivas, sugerir contenido y agregar imagenes relevantes. Tambien puede tomar un documento de Word existente y convertirlo en una presentacion con estructura logica.

### Dos metodos para crear presentaciones

**Metodo 1: Desde PowerPoint directamente.** Abres PowerPoint, seleccionas Copilot y escribes un prompt describiendo la presentacion que necesitas. Copilot genera las diapositivas con contenido, estructura y diseno inicial.

**Metodo 2: Desde Copilot Chat.** Usas Copilot Chat (en el navegador o en Teams) para pedirle que cree una presentacion. Copilot genera un archivo de PowerPoint descargable que puedes abrir y editar.

Ambos metodos producen resultados similares, pero trabajar directamente en PowerPoint te da acceso inmediato a las herramientas de edicion y diseno.

### Capacidades de Copilot en PowerPoint

| Funcion | Descripcion |
|---------|-------------|
| **Generar desde un prompt** | Describe el tema, la audiencia y la cantidad de slides, y Copilot crea la presentacion completa |
| **Crear desde un documento Word** | Sube o referencia un documento de Word y Copilot lo transforma en diapositivas estructuradas |
| **Agregar imagenes** | Copilot sugiere e inserta imagenes de stock relevantes para cada diapositiva |
| **Reestructurar contenido** | Puede reorganizar el orden de las diapositivas, dividir slides con demasiada informacion o fusionar slides relacionados |
| **Resumir presentaciones** | Genera un resumen ejecutivo de una presentacion existente |
| **Agregar notas del orador** | Crea notas de apoyo para cada diapositiva con puntos clave para el presentador |

### Ejemplo de prompt para una presentacion

> Crea una presentacion de 10 slides sobre el programa de fidelizacion para la reunion del comite. Incluye una diapositiva de portada, los objetivos del programa, las metricas clave del ultimo trimestre, los beneficios para los miembros, una comparativa con programas de otras aerolineas, las mejoras propuestas para el proximo semestre y una diapositiva de cierre con proximos pasos. El tono debe ser ejecutivo y orientado a datos.

Copilot generaria una estructura como esta:

1. **Portada:** Programa de Fidelizacion - Informe para el Comite
2. **Agenda:** Temas a cubrir en la reunion
3. **Objetivos del programa:** Metas estrategicas y alineacion con la vision corporativa
4. **Metricas clave Q4:** Miembros activos, tasa de redencion, ingresos por programa
5. **Beneficios para miembros:** Niveles de membresia y propuesta de valor
6. **Satisfaccion del cliente:** Resultados de encuestas de miembros del programa
7. **Benchmarking:** Comparativa con programas de LATAM, Copa y Delta
8. **Mejoras propuestas:** Iniciativas para el proximo semestre con timeline
9. **Impacto financiero esperado:** Proyecciones y retorno de inversion
10. **Proximos pasos:** Acciones inmediatas, responsables y fechas clave

### Flujo de trabajo con Copilot en PowerPoint

```mermaid
flowchart LR
    A["Definir objetivo\ny audiencia"] --> B["Escribir prompt\ndetallado"]
    B --> C{"Metodo"}
    C -->|"PowerPoint"| D["Copilot genera\nslides directamente"]
    C -->|"Copilot Chat"| E["Copilot genera\narchivo descargable"]
    D --> F["Revisar estructura\ny contenido"]
    E --> F
    F --> G["Ajustar diseno\nmanualmente"]
    G --> H["Presentacion\nlista"]
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

- **Diseno visual:** Copilot genera un diseno funcional, pero no siempre coincide con la guia de marca corporativa de Avianca. Es probable que necesites ajustar colores, tipografias y logos manualmente despues de la generacion.
- **Imagenes genericas:** Las imagenes insertadas provienen de bibliotecas de stock y pueden no ser especificas para el contexto de aviacion. Revisa y reemplaza las que no aporten valor.
- **Contenido aproximado:** Copilot genera texto basado en su conocimiento general. Los datos especificos (metricas, cifras, KPIs) deben ser verificados y reemplazados con informacion real de la empresa.
- **Formato de graficos:** Copilot no siempre genera graficos o tablas complejas dentro de las diapositivas. Para visualizaciones de datos avanzadas, es mejor crearlas en Excel y pegarlas en la presentacion.
- **Consistencia entre slides:** En presentaciones largas, el estilo visual puede variar entre diapositivas. Una revision final de uniformidad es siempre recomendable.

> Copilot en PowerPoint es un excelente punto de partida, no un producto terminado. Usalo para generar el 70-80% de la estructura y el contenido, y dedica tu tiempo a pulir el diseno, verificar los datos y agregar el toque profesional que diferencia una presentacion buena de una excelente.

---

## Fuentes

- Microsoft Support. *Copilot en Microsoft Forms*. [https://support.microsoft.com/en-us/copilot-in-forms](https://support.microsoft.com/en-us/copilot-in-forms)
- Microsoft Support. *Copilot en PowerPoint*. [https://support.microsoft.com/en-us/copilot-powerpoint](https://support.microsoft.com/en-us/copilot-powerpoint)$md$), 15);

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 5), 4, 'Practica: crea una infografia sobre un tema de tu area', 'ejercicio',
 '{"instrucciones": "Usando las herramientas de Copilot que aprendiste en este modulo, crea una infografia o material visual sobre un tema relevante de tu area de trabajo.\n\nEl entregable debe incluir:\n\n1. **Tema elegido:** Describe brevemente el tema y por que es relevante para tu departamento.\n\n2. **Imagen principal:** Genera al menos 1 imagen con Copilot Designer que ilustre el concepto central. Documenta el prompt que usaste.\n\n3. **Presentacion o formulario:** Elige una de estas opciones:\n   - **Opcion A (PowerPoint):** Crea una presentacion de 5 slides sobre el tema usando Copilot en PowerPoint. Incluye el prompt que usaste y ajustes que hiciste.\n   - **Opcion B (Forms):** Crea un formulario de evaluacion o encuesta relacionada con el tema usando Copilot en Forms. Incluye el prompt y las preguntas generadas.\n\n4. **Reflexion:** En 3-5 oraciones, describe que funciono bien, que ajustaste manualmente y que limitaciones encontraste.\n\nRecuerda aplicar las buenas practicas: colores corporativos, diversidad en imagenes, y verificacion de contenido generado.", "texto": "Tip: Si eliges PowerPoint, pide a Copilot que agregue notas del orador para cada diapositiva."}', 10);

-- ============================================================
-- MODULO 6: Agentes y Excel con Copilot
-- ============================================================

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 6), 1, 'Agentes de Copilot y Excel con IA', 'texto',
 jsonb_build_object('texto', $md$# Agentes de Copilot y Excel con IA: automatiza tareas y potencia tus datos

Microsoft 365 Copilot no es solo un asistente de chat. Dentro del ecosistema hay dos capacidades que transforman la forma de trabajar en una aerolinea: los **agentes de Copilot** que automatizan flujos de trabajo especificos, y la **integracion con Excel** que convierte hojas de calculo en herramientas de analisis inteligente.

En esta leccion vas a aprender a crear agentes simples sin programar y a usar Copilot dentro de Excel para analizar datos, generar formulas y crear visualizaciones, todo desde tu entorno corporativo de Avianca.

---

## Parte 1: Agentes de Copilot

### Que son los agentes

Un **agente de Copilot** es un asistente de IA especializado en una tarea concreta. A diferencia de Copilot Chat (que responde preguntas generales), un agente esta configurado con instrucciones, contexto y fuentes de datos especificas para resolver un tipo de problema particular.

Piensa en la diferencia entre llamar a un call center general y hablar con un especialista de tu area: el especialista ya conoce el contexto, las reglas y los sistemas relevantes. Eso es un agente.

### Dos niveles de agentes

Microsoft ofrece dos caminos para crear agentes segun la complejidad que necesites:

**Agentes simples (sin codigo):** se crean directamente desde Microsoft 365 usando una interfaz grafica. No requieren conocimientos tecnicos. Son ideales para tareas repetitivas que siguen un patron claro, como responder preguntas frecuentes o generar borradores a partir de plantillas.

**Agentes avanzados (Copilot Studio):** se construyen en Microsoft Copilot Studio, una plataforma dedicada que permite conectar fuentes de datos externas, definir flujos de conversacion complejos y agregar logica condicional. Estos agentes requieren apoyo del equipo de TI o de un especialista en automatizacion.

Para esta leccion nos enfocamos en los agentes simples, que cualquier colaborador puede crear.

---

### Como crear un agente simple en Microsoft 365

Crear un agente basico en M365 toma menos de 10 minutos. Estos son los pasos:

1. **Abrir Microsoft 365 Copilot Chat** desde el navegador o la aplicacion de escritorio
2. **Seleccionar "Crear agente"** en el menu lateral o desde la opcion de agentes en la barra superior
3. **Definir el nombre y la descripcion** del agente. Ejemplo: "Asistente de politicas de equipaje"
4. **Escribir las instrucciones** que definen el comportamiento del agente. Aqui es donde aplicas todo lo que aprendiste sobre prompting estructurado: rol, contexto, tarea, formato y restricciones
5. **Agregar fuentes de conocimiento** subiendo documentos (Word, PDF, PowerPoint) o conectando sitios de SharePoint que el agente debe consultar para responder
6. **Probar el agente** en la vista previa para verificar que responde correctamente
7. **Publicar y compartir** con tu equipo o area

```mermaid
flowchart TD
    A["Abrir Copilot Chat\nen M365"] --> B["Seleccionar\nCrear agente"]
    B --> C["Definir nombre\ny descripcion"]
    C --> D["Escribir instrucciones\n(rol, contexto, tarea)"]
    D --> E["Agregar fuentes\nde conocimiento"]
    E --> F["Probar en\nvista previa"]
    F --> G{"Respuestas\ncorrectas?"}
    G -->|"Si"| H["Publicar y\ncompartir"]
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

| Departamento | Agente | Que hace | Fuente de conocimiento |
|---|---|---|---|
| **Recursos Humanos** | Bot de preguntas frecuentes | Responde consultas sobre politicas internas, beneficios, vacaciones y procesos de nomina | Manual del colaborador, politicas de RRHH en SharePoint |
| **Ventas** | Asistente de propuestas | Genera borradores de propuestas comerciales basados en plantillas aprobadas y datos del cliente | Plantillas de ventas, catalogo de tarifas corporativas |
| **Finanzas** | Generador de reportes | Crea resumenes financieros periodicos a partir de datos estructurados y plantillas estandar | Reportes historicos, plantillas de informes |
| **Servicio al Cliente** | Clasificador de tickets | Categoriza solicitudes de pasajeros por tipo (equipaje, reembolso, cambio de vuelo) y sugiere respuestas iniciales | Base de conocimiento de servicio, guias de respuesta |

Cada uno de estos agentes se puede crear con el flujo de 7 pasos descrito arriba. La clave esta en las instrucciones: entre mas especificas y estructuradas, mejores resultados.

---

### Limitaciones de los agentes

Es importante entender que los agentes de Copilot **no son sistemas autonomos**. Tienen limites claros que debes conocer antes de implementarlos:

- **No acceden a sistemas externos sin conectores:** un agente simple no puede consultar SAP, Salesforce ni bases de datos externas a Microsoft 365. Para eso se necesitan agentes avanzados con conectores configurados por TI
- **No toman decisiones autonomas:** el agente sugiere, redacta y clasifica, pero no ejecuta acciones por su cuenta. No aprueba solicitudes, no envia correos automaticamente ni modifica registros sin intervencion humana
- **No reemplazan el juicio humano:** un agente puede generar un borrador de respuesta a un pasajero, pero un agente de servicio al cliente debe revisarlo antes de enviarlo. La IA asiste, no reemplaza
- **No aprenden de interacciones pasadas:** los agentes simples no mejoran automaticamente con el uso. Si necesitas ajustar su comportamiento, debes modificar las instrucciones manualmente
- **No garantizan precision absoluta:** como cualquier herramienta de IA generativa, pueden producir respuestas incorrectas o inventar informacion. Siempre verifica datos criticos

---

## Parte 2: Excel con Copilot

### Que puede hacer Copilot en Excel

Copilot integrado en Excel transforma la forma de trabajar con datos. En lugar de memorizar funciones o navegar menus complejos, puedes describir lo que necesitas en lenguaje natural y Copilot lo ejecuta.

Estas son las capacidades principales:

- **Generar formulas:** describe el calculo que necesitas y Copilot escribe la formula correcta, incluyendo funciones anidadas como BUSCARV, SI.CONJUNTO o SUMAR.SI
- **Crear tablas dinamicas:** pide un resumen de datos por categoria, periodo o cualquier dimension y Copilot genera la tabla dinamica automaticamente
- **Generar graficos:** solicita una visualizacion y Copilot selecciona el tipo de grafico mas apropiado y lo crea con los datos seleccionados
- **Analizar tendencias:** Copilot puede identificar patrones, valores atipicos y tendencias en los datos sin que tengas que hacer el analisis manual
- **Obtener insights:** pide un resumen de los datos y Copilot resalta los hallazgos mas relevantes: maximos, minimos, promedios, distribuciones y anomalias

---

### 5 prompts de ejemplo para Excel

Estos prompts estan disenados para contextos tipicos de trabajo en una aerolinea. Puedes usarlos directamente o adaptarlos a tus datos.

**1. Tabla dinamica de ventas**
> "Crea una tabla dinamica que muestre el total de boletos vendidos por ruta y por mes para el ultimo trimestre. Incluye una columna con el porcentaje de variacion mes a mes."

**2. Grafico de ocupacion**
> "Genera un grafico de barras que compare el porcentaje de ocupacion de las rutas nacionales vs internacionales durante los ultimos 6 meses. Usa colores diferentes para cada categoria."

**3. Analisis de tendencias**
> "Analiza las tendencias de puntualidad de los vuelos del hub de Bogota en los ultimos 12 meses. Identifica los meses con mayor cantidad de retrasos y sugiere posibles patrones."

**4. Formula de calculo**
> "Sugiere una formula para calcular el costo promedio por pasajero en cada ruta, considerando la columna de costos operativos totales y la columna de pasajeros transportados."

**5. Resumen ejecutivo de datos**
> "Resume los datos de esta hoja en 5 puntos clave. Incluye el total de ingresos, la ruta mas rentable, la ruta con menor ocupacion, el promedio de tarifa y cualquier anomalia que detectes."

---

### Limitaciones de Copilot en Excel

Copilot en Excel es poderoso pero no infalible. Ten en cuenta estas limitaciones:

- **Funciona mejor con datos limpios y estructurados:** si tu hoja tiene celdas combinadas, encabezados ambiguos, filas vacias intercaladas o formatos mixtos, Copilot tendra dificultades para interpretar los datos correctamente
- **Puede generar formulas incorrectas:** la IA a veces "alucina" funciones que no existen o aplica logica incorrecta. Siempre revisa que la formula haga lo que esperas antes de confiar en el resultado
- **No reemplaza la validacion humana:** los calculos criticos (financieros, de seguridad, regulatorios) deben ser verificados manualmente. Copilot es un acelerador, no un auditor
- **Tiene limites de tamano:** hojas con cientos de miles de filas pueden generar respuestas lentas o incompletas. Para volumen masivo de datos, herramientas como Power BI son mas apropiadas

---

### Tips para mejores resultados en Excel

- **Formatea tus datos como Tabla** (Insertar > Tabla o Ctrl+T) antes de usar Copilot. Las tablas con formato permiten que Copilot identifique correctamente las columnas, filas y relaciones entre datos
- **Usa encabezados claros y descriptivos** en cada columna. "Ingresos_USD_2024" es mucho mejor que "Col1" o "Datos"
- **Una hoja, un tema:** evita mezclar datasets no relacionados en la misma hoja. Si tienes datos de ventas y datos de RRHH, separalos en hojas distintas
- **Se especifico en tus prompts:** en lugar de "analiza estos datos", pide "analiza la variacion porcentual de ingresos por ruta entre enero y marzo de 2025"

> **Tip importante:** Antes de presentar cualquier resultado generado por Copilot en Excel, verifica los calculos manualmente con una muestra. Selecciona 3 a 5 filas al azar y confirma que la formula o el analisis produzca los valores correctos. Esta practica toma menos de 2 minutos y puede evitar errores costosos en reportes ejecutivos o decisiones basadas en datos incorrectos.

---

## Fuentes

- Microsoft Learn. *Microsoft Copilot Studio - Documentacion oficial*. [https://learn.microsoft.com/en-us/microsoft-copilot-studio/](https://learn.microsoft.com/en-us/microsoft-copilot-studio/)
- Microsoft Support. *Copilot en Excel - Guia de uso*. [https://support.microsoft.com/en-us/copilot-excel](https://support.microsoft.com/en-us/copilot-excel)
- Microsoft Learn. *Informacion general de Microsoft 365 Copilot*. [https://learn.microsoft.com/es-es/copilot/microsoft-365/microsoft-365-copilot-overview](https://learn.microsoft.com/es-es/copilot/microsoft-365/microsoft-365-copilot-overview)$md$), 20);

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 6), 2, 'Practica: crea un agente de preguntas frecuentes', 'ejercicio',
 '{"instrucciones": "Disena un agente de Copilot para responder las preguntas mas frecuentes de tu area de trabajo. Sigue estos pasos:\n\n1. **Identifica el caso de uso:** Elige un tema donde tu equipo reciba preguntas repetitivas (politicas internas, procesos, herramientas, beneficios, etc.).\n\n2. **Define las instrucciones del agente** usando el formato estructurado:\n   - **Rol:** Quien es el agente y que especialidad tiene\n   - **Contexto:** En que area opera y que informacion maneja\n   - **Tarea:** Que tipo de preguntas debe responder\n   - **Formato:** Como debe estructurar sus respuestas\n   - **Restricciones:** Que no debe hacer (inventar datos, dar opiniones personales, etc.)\n\n3. **Crea una lista de 10 preguntas frecuentes** que el agente deberia poder responder.\n\n4. **Prueba el agente** (si tienes acceso a Copilot) o simula las respuestas esperadas para 3 de las 10 preguntas.\n\n5. **Evalua y ajusta:** Para cada respuesta, indica si es correcta, si necesita ajustes y que cambiarias en las instrucciones.\n\nEntregable: las instrucciones completas del agente + las 10 preguntas + las 3 respuestas evaluadas.", "texto": "Recuerda: un buen agente tiene instrucciones especificas, fuentes de conocimiento confiables y restricciones claras sobre lo que NO debe hacer."}', 20);

-- ============================================================
-- MODULO 7: IA para tu vida personal
-- ============================================================

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 7), 1, 'IA para tu vida personal: herramientas que ya puedes usar', 'texto',
 jsonb_build_object('texto', $md$# IA para tu vida personal: herramientas que ya puedes usar

La inteligencia artificial no es solo una herramienta de trabajo. Fuera de la oficina, existen decenas de aplicaciones que pueden ayudarte a organizar tu tiempo, aprender mas rapido, cuidar tu bienestar y administrar mejor tus finanzas. Segun datos recientes de productividad laboral y personal, los profesionales que integran herramientas de IA en su rutina diaria **ahorran en promedio 3.6 horas por semana**, tiempo que pueden dedicar a lo que realmente importa.

Este modulo es un recorrido practico por las mejores herramientas de IA disponibles hoy para tu vida personal, organizadas por categoria, con recomendaciones claras sobre cuales son gratuitas y cuales vale la pena pagar.

---

## Panorama de herramientas de IA para uso personal

| Categoria | Herramienta | Plan gratuito | Plan de pago | Mejor para |
|---|---|---|---|---|
| **Chatbots** | ChatGPT (OpenAI) | Si, GPT-4o limitado | Plus USD 20/mes | Preguntas complejas, redaccion, analisis |
| **Chatbots** | Gemini (Google) | Si, completo | Advanced USD 20/mes | Integracion con Google Workspace |
| **Chatbots** | Claude (Anthropic) | Si, limitado | Pro USD 20/mes | Textos largos, razonamiento detallado |
| **Chatbots** | Copilot (Microsoft) | Si, integrado en Bing | Pro USD 20/mes | Busqueda web con respuestas conversacionales |
| **Productividad** | Reclaim AI | Si, hasta 3 calendarios | Starter USD 8/mes | Organizacion automatica del calendario |
| **Productividad** | Notion AI | Requiere Notion (freemium) | Add-on USD 10/mes | Notas inteligentes, resumen de documentos |
| **Productividad** | Otter.ai | Si, 300 min/mes | Pro USD 17/mes | Transcripcion de reuniones en tiempo real |
| **Aprendizaje** | Khanmigo (Khan Academy) | Si, para estudiantes | Donacion sugerida | Tutor personalizado de matematicas y ciencias |
| **Aprendizaje** | Duolingo Max | No, solo version basica gratis | Super USD 7/mes | Practica de idiomas con IA conversacional |
| **Aprendizaje** | Perplexity AI | Si, busquedas ilimitadas | Pro USD 20/mes | Investigacion con fuentes verificadas |
| **Salud** | Wysa | Si, herramientas basicas | Premium USD 100/ano | Apoyo emocional y bienestar mental |
| **Finanzas** | Fintonic | Si, completo | Premium con funciones extra | Control de gastos y presupuesto automatico |
| **Creacion de contenido** | Canva AI | Si, funciones limitadas | Pro USD 13/mes | Diseno grafico con generacion de imagenes |
| **Creacion de contenido** | CapCut | Si, funciones basicas | Pro USD 10/mes | Edicion de video con IA |

---

## Productividad personal: organiza tu tiempo sin esfuerzo

La productividad personal es donde la IA tiene el impacto mas inmediato. Tres herramientas destacan por su utilidad practica.

### Reclaim AI: tu calendario en piloto automatico

Reclaim AI analiza tu calendario, tus habitos y tus prioridades para **bloquear tiempo automaticamente** para tareas importantes. No se trata solo de agendar reuniones: la herramienta protege bloques para trabajo profundo, pausas, ejercicio o tiempo personal.

```mermaid
flowchart LR
    A["Tus tareas\ny prioridades"] --> B["Reclaim AI\nanaliza patrones"]
    B --> C["Bloquea tiempo\nautomaticamente"]
    C --> D["Calendario\noptimizado"]
    D --> E["Mas tiempo para\nlo que importa"]
    style A fill:#dbeafe,stroke:#3b82f6
    style B fill:#e0e7ff,stroke:#6366f1
    style C fill:#ede9fe,stroke:#8b5cf6
    style D fill:#d1fae5,stroke:#10b981
    style E fill:#bbf7d0,stroke:#22c55e
```

Lo que la hace diferente de un calendario normal es que se **adapta en tiempo real**: si una reunion se mueve, Reclaim reorganiza automaticamente el resto de tu dia. El plan gratuito permite conectar hasta 3 calendarios, lo cual es suficiente para la mayoria de personas.

### Notion AI: notas que trabajan por ti

Si ya usas Notion (o cualquier herramienta de notas), Notion AI le agrega una capa de inteligencia: resume documentos largos, genera listas de accion a partir de notas desordenadas, y responde preguntas sobre tu propio contenido.

Caso de uso practico: pegas las notas de una reunion de padres de familia del colegio y le pides que extraiga las tareas pendientes con fechas. En segundos tienes una lista limpia y accionable.

### Otter.ai: transcripcion inteligente de reuniones

Otter.ai transcribe reuniones en tiempo real (presenciales o virtuales) y genera resumenes automaticos con los puntos clave y acciones a seguir. Funciona con Zoom, Google Meet y Microsoft Teams.

El plan gratuito incluye 300 minutos mensuales de transcripcion. Para uso personal (reuniones de condominio, citas medicas, clases), es mas que suficiente.

---

## Aprendizaje: la IA como tutor personal

### Khanmigo: tutor de Khan Academy con IA

Khanmigo no te da respuestas directas. En cambio, te hace **preguntas guiadas** para que llegues a la respuesta por tu cuenta. Es el enfoque socratico aplicado a matematicas, ciencias, programacion y mas.

Es especialmente util para padres que ayudan a sus hijos con tareas escolares: Khanmigo explica conceptos paso a paso, adaptandose al nivel del estudiante.

### Perplexity AI: investigacion con fuentes reales

A diferencia de los chatbots generales, Perplexity AI esta disenado como un **motor de investigacion**. Cada respuesta incluye citas con enlaces a las fuentes originales, lo que te permite verificar la informacion.

Ideal para: investigar temas de salud, comparar productos antes de comprar, entender temas complejos de actualidad, o preparar presentaciones con datos respaldados.

### Tecnica: "Profesor personal con ChatGPT" en 4 pasos

No necesitas una herramienta especializada para aprender. Cualquier chatbot de IA puede convertirse en un tutor personal si le das las instrucciones correctas.

```mermaid
flowchart TD
    P1["Paso 1\nDefine el tema y tu nivel actual"]
    P2["Paso 2\nPide una explicacion adaptada a tu nivel"]
    P3["Paso 3\nSolicita ejercicios practicos con dificultad progresiva"]
    P4["Paso 4\nPide que evalue tus respuestas y explique los errores"]
    P1 --> P2 --> P3 --> P4
    style P1 fill:#dbeafe,stroke:#3b82f6
    style P2 fill:#e0e7ff,stroke:#6366f1
    style P3 fill:#ede9fe,stroke:#8b5cf6
    style P4 fill:#fae8ff,stroke:#d946ef
```

**Ejemplo de prompt para el Paso 1:**

```
Quiero aprender sobre finanzas personales. Mi nivel actual es
basico: se lo que es un presupuesto pero no entiendo conceptos
como interes compuesto, fondos de inversion o diversificacion.
Explicame como si fuera la primera vez que escucho estos terminos.
```

**Para el Paso 3:**

```
Ahora dame 3 ejercicios practicos de dificultad progresiva sobre
interes compuesto. El primero muy basico, el segundo intermedio,
y el tercero que requiera pensar un poco mas. No me des las
respuestas todavia.
```

La clave es mantener la conversacion abierta: preguntale tus dudas, pide que reformule lo que no entiendas, y solicita mas ejercicios cuando te sientas listo.

---

## Salud y finanzas: IA con precaucion

> **Advertencia importante:** Nunca ingreses datos medicos reales, diagnosticos, numeros de cuenta bancaria ni informacion financiera sensible en herramientas de IA que no hayan sido verificadas por profesionales. Estas herramientas son un complemento, no un reemplazo de medicos ni asesores financieros.

### Wysa: apoyo emocional con IA

Wysa es un chatbot de salud mental basado en tecnicas de **terapia cognitivo-conductual (TCC)**. No reemplaza a un psicologo, pero ofrece ejercicios de respiracion, manejo de ansiedad, journaling guiado y tecnicas de relajacion disponibles las 24 horas.

Lo que distingue a Wysa de un chatbot general es que fue disenada con supervision clinica y no almacena conversaciones con identificadores personales. El plan gratuito incluye las herramientas de autoayuda; el premium agrega sesiones con terapeutas humanos.

### Fintonic: control de gastos automatico

Fintonic se conecta a tus cuentas bancarias (con tu autorizacion) y **categoriza automaticamente** tus gastos: alimentacion, transporte, entretenimiento, suscripciones. Te muestra graficos claros de a donde va tu dinero y te alerta cuando un gasto es inusual.

Es gratuito y disponible en Latinoamerica. La IA detecta patrones como suscripciones olvidadas o cobros duplicados.

### Plum: ahorro automatico inteligente

Plum analiza tus ingresos y gastos para **apartar pequenas cantidades automaticamente** en los momentos en que tu cuenta puede permitirselo. No sientes el ahorro porque las cantidades son pequenas, pero se acumulan con el tiempo.

Funciona como un "ahorro hormiga" potenciado por IA que se adapta a tu situacion financiera real.

```mermaid
flowchart LR
    subgraph "Herramientas de bienestar"
        W["Wysa\nSalud mental"]
        F["Fintonic\nControl de gastos"]
        P["Plum\nAhorro automatico"]
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

## Gratuito vs de pago: que ganas realmente al pagar

Una de las preguntas mas frecuentes es si vale la pena pagar por estas herramientas. La respuesta corta: **las versiones gratuitas son mas que suficientes para empezar**.

| Categoria | Lo que obtienes gratis | Lo que agrega el plan de pago |
|---|---|---|
| **Chatbots (ChatGPT, Gemini, Claude)** | Acceso al modelo principal con limites de uso diario, historial de conversaciones, funcionalidades basicas | Mas capacidad de uso, acceso prioritario, modelos mas avanzados, archivos mas grandes |
| **Productividad (Reclaim, Notion AI)** | Funcionalidad core completa con limites de volumen | Mas integraciones, automatizaciones avanzadas, equipos |
| **Aprendizaje (Perplexity, Khanmigo)** | Busquedas ilimitadas, tutor basico | Modelos premium, busquedas mas profundas, carga de archivos |
| **Salud (Wysa)** | Herramientas de autoayuda, ejercicios de respiracion, journaling | Sesiones con terapeutas humanos, programas estructurados |
| **Finanzas (Fintonic, Plum)** | Categorizacion de gastos, alertas, ahorro basico | Analisis avanzados, objetivos de ahorro, recomendaciones personalizadas |
| **Creacion (Canva AI, CapCut)** | Plantillas, edicion basica, generacion limitada de imagenes y video | Sin marcas de agua, mas generaciones de IA, funciones premium |

---

## Conclusion

No necesitas gastar dinero para empezar a usar IA en tu vida personal. Las versiones gratuitas de ChatGPT, Perplexity, Reclaim AI, Wysa y Fintonic cubren el 80% de lo que la mayoria de personas necesita. El mejor momento para probar es ahora: elige una herramienta de la tabla, instalala, y usala durante una semana para resolver un problema real de tu dia a dia.

La IA no va a reemplazar tu criterio ni tus decisiones. Pero si puede quitarte de encima las tareas repetitivas, ayudarte a aprender mas rapido y darte mejor visibilidad sobre tu tiempo y tu dinero. Esas 3.6 horas semanales que puedes recuperar no son un numero abstracto: son tiempo para tu familia, tus proyectos personales o simplemente para descansar.

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
((SELECT id FROM modulos WHERE orden = 7), 2, 'El futuro de la IA: tendencias que definiran los proximos anos', 'texto',
 jsonb_build_object('texto', $md$# El futuro de la IA: 7 tendencias que definiran los proximos anos

La Inteligencia Artificial dejo de ser una promesa futurista. En 2026, ya es una herramienta cotidiana en las empresas, incluyendo la nuestra. Pero el panorama sigue cambiando a velocidad de despegue. Conocer las tendencias que vienen no es curiosidad academica: es **preparacion estrategica**.

Este modulo te presenta las 7 tendencias clave que definiran los proximos anos, con datos concretos y lo que significan para tu trabajo en Avianca. El objetivo no es que te conviertas en experto en tecnologia, sino que puedas **tomar mejores decisiones** sabiendo hacia donde se mueve el ecosistema.

---

## 1. Agentes autonomos: la IA pasa de responder a ejecutar

Hasta ahora, la IA funcionaba como un asistente reactivo: tu preguntas, ella responde. Los **agentes autonomos** cambian esa dinamica. Son sistemas de IA capaces de recibir un objetivo y ejecutar una secuencia completa de pasos para lograrlo, tomando decisiones intermedias sin intervencion humana.

Segun Gartner, el **40% de las aplicaciones empresariales integraran agentes de IA para finales de 2026**. Microsoft ya esta incorporando agentes en su ecosistema Copilot que pueden gestionar flujos de trabajo completos: desde agendar reuniones hasta procesar solicitudes internas.

**Que significa para Avianca:** Imagina un agente que recibe una queja de un pasajero, clasifica la urgencia, consulta el historial del cliente, genera una respuesta personalizada y escala al area correspondiente si es necesario. Todo automatico, pero supervisado por humanos.

> La clave no es reemplazar personas, sino liberar tiempo de tareas repetitivas para que los equipos se enfoquen en decisiones que requieren criterio humano.

---

## 2. Edge AI: inteligencia que corre en el dispositivo

Hoy, la mayoria de las herramientas de IA dependen de la nube: tu pregunta viaja a un servidor remoto, se procesa y la respuesta regresa. **Edge AI** cambia eso: la inteligencia corre directamente en tu dispositivo (laptop, telefono, tablet), sin necesidad de conexion permanente.

Las ventajas son tres: **mas privacidad** (los datos no salen del dispositivo), **mas velocidad** (no hay latencia de red) y **mayor disponibilidad** (funciona sin internet).

Microsoft, Google y Apple ya estan integrando modelos de IA directamente en sus sistemas operativos y dispositivos. Los procesadores NPU (Neural Processing Unit) vienen integrados en las laptops de ultima generacion.

**Que significa para Avianca:** Equipos de tierra y tripulacion podrian usar herramientas de IA que funcionan sin conexion a internet, procesando informacion sensible de pasajeros localmente sin enviarla a servidores externos.

---

## 3. Modelos especializados: pequenos pero expertos

La tendencia inicial fue construir modelos gigantes que "saben de todo". Ahora el mercado esta virando hacia **modelos mas pequenos y especializados**, entrenados para tareas o industrias especificas. Son mas rapidos, mas baratos y frecuentemente mas precisos en su area de dominio.

Se proyecta que para 2027, **mas del 50% de los modelos empresariales seran adaptados al sector** en el que operan, en lugar de usar modelos generales.

| Modelo general | Modelo especializado |
|---|---|
| Sabe un poco de todo | Domina un area especifica |
| Respuestas genericas | Respuestas con terminologia del sector |
| Alto costo computacional | Mas ligero y eficiente |
| Requiere mas contexto en el prompt | Entiende el contexto del negocio |

**Que significa para Avianca:** Un modelo especializado en aviacion comercial entenderia automaticamente que "ETD" es Estimated Time of Departure, que "code share" implica acuerdos interlinea, o que "IROPS" se refiere a operaciones irregulares, sin necesidad de explicarselo cada vez.

---

## 4. Computacion cuantica + IA: el punto de inflexion

IBM declaro 2026 como el **punto de inflexion para la computacion cuantica aplicada a IA**. Mientras las computadoras clasicas procesan informacion en bits (0 o 1), las computadoras cuanticas usan qubits que pueden ser ambos a la vez, permitiendo resolver problemas exponencialmente mas complejos.

La convergencia de computacion cuantica e IA promete avances en optimizacion de rutas, simulaciones complejas y analisis de riesgo a una escala que hoy es inviable.

**Que significa para Avianca:** La optimizacion de rutas aereas, la prediccion de mantenimiento de flota y el modelado de demanda podrian alcanzar niveles de precision que hoy son matematicamente imposibles con computacion tradicional. No es algo para manana, pero ya esta en el horizonte.

> Es una tendencia a mediano plazo. No necesitas entender la fisica cuantica, pero si saber que existe y que va a transformar la capacidad de procesamiento de la IA.

---

## 5. Regulacion y confianza: el marco legal se consolida

El **EU AI Act** (Ley Europea de Inteligencia Artificial) ya esta vigente y establece reglas claras sobre como se puede y no se puede usar IA segun su nivel de riesgo. Otros paises estan siguiendo la misma ruta regulatoria.

Esto no es un freno para la IA, es una **condicion para su adopcion masiva**. Las empresas que operan internacionalmente, como Avianca, necesitan garantizar que su uso de IA cumple con los marcos regulatorios de cada region.

Las areas clave de regulacion incluyen:

- **Transparencia:** los usuarios deben saber cuando interactuan con IA
- **No discriminacion:** los modelos no pueden generar sesgos sistematicos
- **Privacidad:** cumplimiento de normativas como GDPR y leyes locales de proteccion de datos
- **Responsabilidad:** debe haber un humano responsable de las decisiones asistidas por IA

**Que significa para Avianca:** Cada vez que uses IA para generar comunicaciones, analizar datos de pasajeros o tomar decisiones operativas, debes asegurarte de que el resultado sea revisado por un humano y cumpla con las politicas internas. El criterio humano no es opcional, es un requerimiento legal.

---

## 6. Fatiga del hype: de la cantidad a la calidad

Despues del boom de 2023-2024, el mercado esta experimentando **saturacion de contenido generado por IA**. Los consumidores y profesionales ya identifican textos genericos producidos por modelos de lenguaje. La prioridad esta cambiando de "generar mucho" a "generar bien".

Las empresas que simplemente automatizaron produccion de contenido sin supervision estan viendo resultados negativos: contenido repetitivo, errores factuales y perdida de voz de marca.

La respuesta no es dejar de usar IA, sino usarla con **criterio editorial**:

- La IA genera el primer borrador
- El humano aporta contexto, datos verificados y voz autentica
- El resultado final tiene calidad y autenticidad que la IA sola no logra

**Que significa para Avianca:** Si usas Copilot para generar un correo, un reporte o una presentacion, tu trabajo no termina cuando la IA entrega el texto. Empieza ahi. Tu conocimiento del negocio, del cliente y del contexto es lo que transforma un borrador generico en un documento de valor.

---

## 7. IA como commodity: el diferenciador eres tu

Las herramientas de IA se estan **comoditizando**. GPT, Claude, Gemini, Copilot y decenas de modelos ofrecen capacidades similares a precios cada vez mas accesibles. La tecnologia en si deja de ser ventaja competitiva.

Lo que marca la diferencia es **quien la usa y como la usa**. Dos personas con la misma herramienta pueden obtener resultados radicalmente diferentes dependiendo de la calidad de sus instrucciones, su conocimiento del problema y su capacidad de evaluar criticamente las respuestas.

```mermaid
flowchart LR
    A["Herramienta de IA\n(commodity)"] --> B["Usuario sin\ncapacitacion"]
    A --> C["Usuario\ncapacitado"]
    B --> D["Resultado\ngenerico"]
    C --> E["Resultado de\nalto valor"]
    style A fill:#e2e8f0,stroke:#94a3b8
    style B fill:#fecaca,stroke:#ef4444
    style C fill:#bfdbfe,stroke:#3b82f6
    style D fill:#fef3c7,stroke:#f59e0b
    style E fill:#bbf7d0,stroke:#22c55e
```

**Que significa para Avianca:** La inversion en esta capacitacion no es sobre aprender a usar un boton. Es sobre desarrollar la habilidad de **pensar junto con la IA**, de saber que pedirle, cuando confiar en su respuesta y cuando cuestionarla.

---

## Linea de tiempo: evolucion de las tendencias

```mermaid
timeline
    title Horizonte de tendencias en IA empresarial
    2025 : Adopcion masiva de Copilot
         : Primeros agentes en produccion
         : EU AI Act entra en vigor
    2026 : 40% apps con agentes integrados
         : Edge AI en dispositivos comerciales
         : Punto de inflexion cuantica segun IBM
    2027 : 50%+ modelos especializados por sector
         : Regulacion consolidada en Latam
         : IA como commodity generalizado
    2028+ : Agentes autonomos multi-sistema
          : Cuantica + IA en produccion
          : Diferenciador puro en habilidad humana
```

---

## Reflexion final: tu ventaja competitiva es tu criterio, no la herramienta

Las 7 tendencias que revisamos tienen un hilo comun: **la tecnologia avanza, pero el valor lo aporta la persona que la usa con criterio**.

Los agentes autonomos necesitan supervisores humanos. Los modelos especializados necesitan quien sepa formular la pregunta correcta. La regulacion exige responsabilidad humana. Y cuando todas las herramientas sean iguales, el diferenciador sera quien sepa extraer el maximo valor de ellas.

Tu no compites contra la IA. Compites contra otros profesionales que tambien la usan. Tu ventaja no esta en tener acceso a Copilot, porque eso lo tienen todos. Tu ventaja esta en **tu conocimiento del negocio, tu criterio para evaluar respuestas y tu capacidad de hacer las preguntas correctas**.

Eso es exactamente lo que esta capacitacion te esta ayudando a construir.

> Lo que te hace valioso no es la herramienta que usas, sino lo que sabes hacer con ella. La IA amplifica tu criterio, pero no lo reemplaza.

---

## Fuentes

- Microsoft News Latam. *Que viene en IA: 7 tendencias a seguir en 2026*. [https://news.microsoft.com/source/latam/features/ia/que-viene-en-ia-7-tendencias-a-seguir-en-2026/](https://news.microsoft.com/source/latam/features/ia/que-viene-en-ia-7-tendencias-a-seguir-en-2026/)
- IBM Think. *AI tech trends predictions 2026*. [https://www.ibm.com/think/news/ai-tech-trends-predictions-2026](https://www.ibm.com/think/news/ai-tech-trends-predictions-2026)
- UOC. *Seis tendencias clave de la IA en 2026*. [https://www.uoc.edu/es/news/2025/seis-tendencias-clave-de-la-ia-en-2026](https://www.uoc.edu/es/news/2025/seis-tendencias-clave-de-la-ia-en-2026)
- IT Masters Mag. *Mas alla del hype: 10 predicciones para la AI empresarial en 2026*. [https://www.itmastersmag.com/inteligencia-artificial/mas-alla-del-hype-10-predicciones-para-la-ai-empresarial-en-2026/](https://www.itmastersmag.com/inteligencia-artificial/mas-alla-del-hype-10-predicciones-para-la-ai-empresarial-en-2026/)$md$), 15);

-- ============================================================
-- MODULO 8: Reto final
-- ============================================================

INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
((SELECT id FROM modulos WHERE orden = 8), 1, 'Reto final: demuestra todo lo que aprendiste', 'texto',
 jsonb_build_object('texto', $md$# Reto final: demuestra todo lo que aprendiste

Has recorrido siete modulos donde aprendiste a comunicarte con la IA, proteger datos sensibles, estructurar instrucciones complejas, crear contenido profesional y automatizar tareas con agentes. Este es el momento de poner todo en practica.

No es un examen. No hay respuestas correctas ni incorrectas. Es un reto integrador donde vas a disenar una solucion real combinando las tecnicas que aprendiste a lo largo del taller.

---

## Lo que aprendiste en el camino

Antes de lanzarte al reto, repasemos las habilidades que construiste modulo a modulo:

| Modulo | Habilidad clave |
|--------|----------------|
| **Modulo 1** | Entender las capacidades y limitaciones de la IA en el entorno laboral |
| **Modulo 2** | Escribir prompts efectivos y aplicar protocolos de anonimizacion de datos |
| **Modulo 3** | Usar tecnicas de Few-shot y Prompt Chaining para tareas complejas |
| **Modulo 4** | Estructurar instrucciones con XML/JSON y aplicar principios de seguridad |
| **Modulo 5** | Crear contenido profesional con Microsoft Copilot |
| **Modulo 6** | Disenar agentes de IA y automatizar tareas en Excel |
| **Modulo 7** | Aplicar la IA como herramienta para la vida personal |

Cada una de estas habilidades es una pieza del rompecabezas. El reto que sigue te pide ensamblarlas todas.

---

## El escenario

> Tu departamento necesita crear un proceso completo de onboarding digital usando IA. Disena el flujo completo: desde la recopilacion de informacion (anonimizada), la generacion de materiales de capacitacion, la creacion de un agente de preguntas frecuentes, hasta la evaluacion del proceso.

Imagina que te asignan liderar este proyecto. Tienes acceso a Microsoft Copilot y a todo lo que aprendiste en el taller. Tu entregable es un documento que describa el proceso completo, con los prompts que usarias en cada etapa y los resultados esperados.

---

## Flujo esperado del entregable

```mermaid
flowchart TD
    A["Etapa 1\nRecopilacion de informacion"] --> B["Etapa 2\nAnonimizacion de datos"]
    B --> C["Etapa 3\nGeneracion de materiales\nde capacitacion"]
    C --> D["Etapa 4\nCreacion del agente\nde preguntas frecuentes"]
    D --> E["Etapa 5\nEvaluacion del proceso"]
    E --> F["Entregable final\ndocumentado"]
    style A fill:#dbeafe,stroke:#3b82f6
    style B fill:#fce7f3,stroke:#ec4899
    style C fill:#e0e7ff,stroke:#6366f1
    style D fill:#d1fae5,stroke:#10b981
    style E fill:#fef3c7,stroke:#f59e0b
    style F fill:#bbf7d0,stroke:#22c55e
```

---

## Que se espera en cada etapa

### Etapa 1: Recopilacion de informacion

Define que datos necesitas para disenar el onboarding. Usa prompts para identificar las preguntas clave que le harias al area de Recursos Humanos, los requisitos del puesto y la informacion del nuevo colaborador.

### Etapa 2: Anonimizacion de datos

Aplica el protocolo de anonimizacion del Modulo 2 a toda la informacion personal recopilada. Demuestra que puedes trabajar con IA sin exponer datos sensibles de empleados ni de la organizacion.

### Etapa 3: Generacion de materiales de capacitacion

Usa tecnicas de Prompt Chaining y estructuras XML o JSON para generar los materiales del onboarding: guias, presentaciones, correos de bienvenida o cualquier recurso que consideres necesario. Aplica al menos dos tecnicas distintas de los modulos anteriores.

### Etapa 4: Creacion del agente de preguntas frecuentes

Disena un agente con Copilot que pueda responder las preguntas mas comunes de un nuevo colaborador: beneficios, herramientas disponibles, contactos clave, politicas internas. Define su rol, sus instrucciones y sus limites.

### Etapa 5: Evaluacion del proceso

Propone como medirias la efectividad del onboarding digital. Usa la IA para generar una encuesta de satisfaccion, metricas de seguimiento o un dashboard de indicadores.

---

## Criterios de evaluacion

Tu entregable sera evaluado con base en cuatro criterios:

| Criterio | Que se evalua |
|----------|--------------|
| **Aplicacion de tecnicas** | Uso demostrable de al menos 4 tecnicas de los modulos anteriores (Few-shot, Chaining, XML/JSON, anonimizacion, agentes, etc.) |
| **Proteccion de datos** | Ningun dato corporativo real queda expuesto en los prompts. Se aplica anonimizacion de forma consistente en todo el proceso |
| **Calidad del resultado** | Los materiales generados son profesionales, coherentes y listos para usar en un contexto corporativo real |
| **Documentacion del proceso** | Cada etapa esta explicada con claridad: que prompt se uso, por que se eligio esa tecnica y que resultado se obtuvo |

---

## Estructura sugerida del entregable

No es obligatorio seguir este formato, pero puede ayudarte a organizar tu trabajo:

1. **Introduccion** - Breve descripcion del problema y tu enfoque
2. **Etapa 1 a 5** - Para cada etapa incluir:
   - Prompt utilizado (completo)
   - Tecnica aplicada y por que la elegiste
   - Resultado obtenido de Copilot
   - Ajustes que hiciste al resultado (si aplica)
3. **Reflexion final** - Que aprendiste del proceso y que harias diferente

---

## Flujo de tecnicas aplicadas por etapa

```mermaid
flowchart LR
    subgraph E1["Etapa 1"]
        T1["Prompt Engineering\nbasico"]
    end
    subgraph E2["Etapa 2"]
        T2["Protocolo de\nanonimizacion"]
    end
    subgraph E3["Etapa 3"]
        T3["Prompt Chaining\n+ XML/JSON"]
    end
    subgraph E4["Etapa 4"]
        T4["Diseno de\nagentes"]
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

- Revisa tus notas de los modulos anteriores
- Ten Copilot abierto y listo para usar
- No intentes resolver todo de una vez: ve etapa por etapa
- Si un prompt no da el resultado esperado, itera y mejora. Eso tambien es parte de la habilidad

---

> La IA es un amplificador de tus capacidades. Tu criterio profesional es lo que marca la diferencia.$md$), 30);

COMMIT;
