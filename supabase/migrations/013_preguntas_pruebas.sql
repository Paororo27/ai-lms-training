BEGIN;

-- ============================================================
-- PASO 1: Limpiar preguntas existentes
-- ============================================================
DELETE FROM preguntas;

-- ============================================================
-- PASO 2: Actualizar diagnosticos a 7 preguntas por intento
-- ============================================================
UPDATE pruebas SET preguntas_por_intento = 7 WHERE tipo IN ('diagnostico_pre', 'diagnostico_post');

-- ============================================================
-- PASO 3: Crear prueba modulo 7 y ajustar orden diagnostico_post
-- ============================================================
INSERT INTO pruebas (modulo_id, tipo, titulo, preguntas_por_intento, puntaje_aprobatorio, orden)
VALUES ((SELECT id FROM modulos WHERE orden = 7), 'modular', 'Prueba: IA para tu vida personal', 5, 80, 8)
ON CONFLICT (orden) DO UPDATE SET modulo_id = EXCLUDED.modulo_id, titulo = EXCLUDED.titulo, preguntas_por_intento = EXCLUDED.preguntas_por_intento;

UPDATE pruebas SET orden = 9 WHERE tipo = 'diagnostico_post' AND orden != 9;

-- ============================================================
-- PASO 4: Insertar preguntas
-- ============================================================

-- ************************************************************
-- DIAGNOSTICO DE ENTRADA (15 preguntas, 7 por intento)
-- ************************************************************

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE tipo = 'diagnostico_pre'),
'Tu jefe te pide urgentemente un resumen ejecutivo de un informe de 40 paginas para una reunion en 30 minutos. Tienes acceso a Copilot. Cual es la MEJOR estrategia?',
'[{"texto": "Copiar y pegar todo el informe en Copilot y pedir el resumen", "es_correcta": false}, {"texto": "Verificar que el informe no contenga datos confidenciales, luego usar Copilot para resumir seccion por seccion", "es_correcta": true}, {"texto": "No usar IA porque el informe puede tener datos sensibles, y hacer el resumen manualmente", "es_correcta": false}, {"texto": "Usar Copilot para resumir y enviar directamente sin revisar", "es_correcta": false}]',
'La urgencia no justifica saltarse la seguridad (elimina A y D), pero negarse a usar la herramienta cuando se puede hacer de forma segura tampoco es optimo (elimina C).');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE tipo = 'diagnostico_pre'),
'Un companero te dice: ''Le pedi a ChatGPT gratuito que revisara el contrato con nuestro nuevo cliente y me dio sugerencias excelentes.'' Cual es el problema PRINCIPAL?',
'[{"texto": "ChatGPT no es bueno para revision legal", "es_correcta": false}, {"texto": "La version gratuita puede usar esas conversaciones para entrenamiento, exponiendo datos contractuales confidenciales", "es_correcta": true}, {"texto": "No hay problema si el contrato ya esta firmado", "es_correcta": false}, {"texto": "El problema es que no uso Copilot", "es_correcta": false}]',
'El 34.8% de los datos que empleados pegan en ChatGPT son sensibles. La version gratuita usa conversaciones para entrenamiento.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE tipo = 'diagnostico_pre'),
'Le pediste a una IA los 5 estudios mas relevantes sobre liderazgo remoto de 2025. Te dio una lista profesional. Cual deberia ser tu SIGUIENTE paso?',
'[{"texto": "Incluirlos en tu presentacion", "es_correcta": false}, {"texto": "Verificar que cada estudio realmente exista en Google Scholar", "es_correcta": true}, {"texto": "Confiar en los de universidades reconocidas", "es_correcta": false}, {"texto": "Pedir a la IA que confirme que son reales", "es_correcta": false}]',
'Los modelos alucinan referencias academicas con frecuencia. La IA confirmara sus propias alucinaciones.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE tipo = 'diagnostico_pre'),
'Usas IA para analizar ventas. La IA dice que cayeron 15% por estacionalidad. Tu sabes que hubo cambio de precio y competidor nuevo. Que haces?',
'[{"texto": "Aceptar el analisis porque la IA proceso todos los datos", "es_correcta": false}, {"texto": "Rechazar completamente y hacerlo manualmente", "es_correcta": false}, {"texto": "Cuestionar la conclusion, pedir que considere las variables adicionales, y validar contra tu experiencia", "es_correcta": true}, {"texto": "Agregar nota ''segun IA''", "es_correcta": false}]',
'La IA no tiene contexto empresarial que tu si tienes. Combina su procesamiento con tu conocimiento.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE tipo = 'diagnostico_pre'),
'En cuales de estas tareas la IA es MENOS confiable?',
'[{"texto": "Resumir un documento largo", "es_correcta": false}, {"texto": "Hacer calculos matematicos complejos", "es_correcta": false}, {"texto": "Generar ideas para lluvia de ideas", "es_correcta": false}, {"texto": "Proporcionar datos estadisticos especificos y actualizados", "es_correcta": true}]',
'Para datos estadisticos especificos la IA tiene fecha de corte, no accede a bases de datos en tiempo real, y tiende a inventar cifras.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE tipo = 'diagnostico_pre'),
'Trabajas en RRHH y necesitas redactar un correo de retroalimentacion para un empleado con bajo desempeno. Cual es la forma CORRECTA de usar IA?',
'[{"texto": "Incluir nombre, departamento y datos del empleado en el prompt", "es_correcta": false}, {"texto": "Anonimizar: ''correo de retroalimentacion para un analista que no alcanzo metas trimestrales en un 20%''", "es_correcta": true}, {"texto": "No usar IA en temas de RRHH", "es_correcta": false}, {"texto": "Usar IA pero borrar el historial despues", "es_correcta": false}]',
'Anonimiza sin nombre ni departamento. Borrar historial no protege nada.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE tipo = 'diagnostico_pre'),
'Tu companero afirma: ''ChatGPT tiene acceso a internet y siempre da informacion actualizada.'' Esta afirmacion es:',
'[{"texto": "Correcta, todos los modelos tienen acceso", "es_correcta": false}, {"texto": "Parcialmente correcta: algunos modelos buscan en internet, pero tienen fecha de corte y los resultados deben verificarse", "es_correcta": true}, {"texto": "Incorrecta, ningun modelo tiene acceso a internet", "es_correcta": false}, {"texto": "Correcta solo con version de pago", "es_correcta": false}]',
'Algunos modelos pueden buscar, pero no garantiza precision. Siguen teniendo fecha de corte.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE tipo = 'diagnostico_pre'),
'La IA escribe un correo de disculpa perfecto pero con frases como ''lamentamos profundamente las molestias''. Que problema tiene?',
'[{"texto": "Ninguno, es profesional", "es_correcta": false}, {"texto": "El tono es generico y suena a IA; el cliente podria percibirlo como insincero", "es_correcta": true}, {"texto": "Es demasiado formal", "es_correcta": false}, {"texto": "Deberia incluir emojis", "es_correcta": false}]',
'La IA genera texto correcto pero generico. En disculpas, el toque humano es critico.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE tipo = 'diagnostico_pre'),
'Se venden credenciales de ChatGPT con historial en la dark web (225,000+ en 2025). Que implica?',
'[{"texto": "No importa con version empresarial", "es_correcta": false}, {"texto": "NUNCA ingresar info confidencial en herramientas personales, usar cuentas corporativas con MFA", "es_correcta": true}, {"texto": "Dejar de usar IA", "es_correcta": false}, {"texto": "Solo afecta a contrasenas debiles", "es_correcta": false}]',
'El robo expone todo el historial. Refuerza usar cuentas corporativas con SSO y MFA.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE tipo = 'diagnostico_pre'),
'Usas IA para filtrar CVs. Notas que califica mas alto a ciertas universidades y mas bajo a ciertos nombres etnicos. Esto es:',
'[{"texto": "Normal, identifica mejores candidatos", "es_correcta": false}, {"texto": "Reflejo de sesgos en datos de entrenamiento que la IA replica y amplifica", "es_correcta": true}, {"texto": "Error tecnico que se corrige con mas datos", "es_correcta": false}, {"texto": "Imposible, la IA es objetiva", "es_correcta": false}]',
'Los modelos replican sesgos. Amazon tuvo que descartar su herramienta de reclutamiento por discriminacion.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE tipo = 'diagnostico_pre'),
'Para cual tarea seria MAS INAPROPIADO usar IA sin supervision experta?',
'[{"texto": "Plan de marketing", "es_correcta": false}, {"texto": "Diagnostico medico basado en sintomas", "es_correcta": true}, {"texto": "Agenda para reunion", "es_correcta": false}, {"texto": "Temas para newsletter", "es_correcta": false}]',
'Tareas con consecuencias graves (medicina, legal) requieren supervision experta obligatoria.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE tipo = 'diagnostico_pre'),
'La IA genera un logo profesional para tu proyecto. Puedes usarlo sin restricciones?',
'[{"texto": "Si, es completamente tuyo", "es_correcta": false}, {"texto": "Depende: las leyes de propiedad intelectual sobre contenido de IA varian y estan evolucionando", "es_correcta": true}, {"texto": "No, pertenece a la empresa del modelo", "es_correcta": false}, {"texto": "Si, porque tu prompt es original", "es_correcta": false}]',
'El marco legal esta en evolucion. No hay proteccion de copyright clara para obras sin autor humano.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE tipo = 'diagnostico_pre'),
'Un equipo usa IA para TODAS sus comunicaciones. Cual es el riesgo principal?',
'[{"texto": "Que la IA no sea suficientemente buena", "es_correcta": false}, {"texto": "Perdida de voz autentica, dependencia y atrofia de capacidad de comunicacion", "es_correcta": true}, {"texto": "Que sea demasiado caro", "es_correcta": false}, {"texto": "Ningun riesgo", "es_correcta": false}]',
'Sobredependencia genera homogeneidad y perdida de habilidades.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE tipo = 'diagnostico_pre'),
'La IA dice: ''segun McKinsey 2025, el 73% de empresas latinoamericanas ya implementaron IA.'' Que nivel de confianza?',
'[{"texto": "Alto, McKinsey es confiable", "es_correcta": false}, {"texto": "Bajo hasta verificar: la IA pudo inventar la cifra, la fuente, o ambas", "es_correcta": true}, {"texto": "Medio, probablemente redondeo", "es_correcta": false}, {"texto": "Alto si pregunto dos veces y da lo mismo", "es_correcta": false}]',
'Las alucinaciones frecuentemente involucran fuentes respetadas con datos inventados.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE tipo = 'diagnostico_pre'),
'Un colega dice: ''Con Copilot vamos a reducir el equipo de analistas.'' Cual es la mejor respuesta?',
'[{"texto": "Tiene razon, la IA analiza mejor", "es_correcta": false}, {"texto": "La IA aumenta la capacidad pero no reemplaza juicio experto ni conocimiento del negocio", "es_correcta": true}, {"texto": "Esperar a ver resultados", "es_correcta": false}, {"texto": "Depende del costo licencias vs salarios", "es_correcta": false}]',
'La IA es amplificador, no reemplazo. Los analistas contextualizan y cuestionan.');

-- ************************************************************
-- DIAGNOSTICO DE SALIDA (15 preguntas, 7 por intento)
-- ************************************************************

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE tipo = 'diagnostico_post'),
'Tienes Excel con 500 registros de quejas (nombre, monto, tipo, resolucion). Mejor approach?',
'[{"texto": "Subir a ChatGPT y pedir analisis", "es_correcta": false}, {"texto": "Anonimizar, estructurar prompt con contexto y formato, procesar en herramienta corporativa", "es_correcta": true}, {"texto": "Solo analizar campo ''tipo de queja''", "es_correcta": false}, {"texto": "Analizar y borrar historial", "es_correcta": false}]',
'Combina anonimizacion + prompt estructurado + herramienta corporativa.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE tipo = 'diagnostico_post'),
'Necesitas 5 correos de follow-up con tono progresivo (informativo a urgente). Mejor estrategia?',
'[{"texto": "Pedir los 5 en un solo prompt", "es_correcta": false}, {"texto": "Prompt chaining: definir tonos, generar con few-shot, evaluar, encadenar ajustando", "es_correcta": true}, {"texto": "Generar uno y pedir variaciones", "es_correcta": false}, {"texto": "Escribirlos manualmente", "es_correcta": false}]',
'Aplica chaining + few-shot para control de tono progresivo.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE tipo = 'diagnostico_post'),
'Tu jefa pide que uses IA para redactar evaluaciones de desempeno de 8 personas. Respuesta MAS profesional?',
'[{"texto": "Hacerlo tal cual", "es_correcta": false}, {"texto": "Negarse rotundamente", "es_correcta": false}, {"texto": "Proponer enfoque intermedio: IA para estructura y guia, jefa escribe con conocimiento directo, IA pule redaccion sin datos identificables", "es_correcta": true}, {"texto": "Hacerlo pero no decir a empleados", "es_correcta": false}]',
'Enfoque intermedio respeta autoridad, protege integridad y usa IA donde agrega valor.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE tipo = 'diagnostico_post'),
'Proveedor te envia agente de IA que pide acceso a tu base de clientes. Que riesgos?',
'[{"texto": "Podria extraer datos al proveedor", "es_correcta": false}, {"texto": "Datos para entrenar modelos de competidores", "es_correcta": false}, {"texto": "Sin auditoria de que hace con los datos", "es_correcta": false}, {"texto": "Todas las anteriores", "es_correcta": true}]',
'Multiples vectores: fuga, uso no autorizado, falta de transparencia.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE tipo = 'diagnostico_post'),
'Chatbot con 95% precision pero 5% error en politicas de devolucion. El equipo dice ''excelente, lancemoslo.'' Tu analisis?',
'[{"texto": "Estan en lo correcto", "es_correcta": false}, {"texto": "El 5% de error en politicas genera riesgo legal y reputacional desproporcionado; se necesita escalado humano", "es_correcta": true}, {"texto": "Mejorar hasta 99%", "es_correcta": false}, {"texto": "No lanzar hasta 100%", "es_correcta": false}]',
'El impacto del error importa mas que su frecuencia.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE tipo = 'diagnostico_post'),
'Necesitas analizar 200 comentarios de clima laboral, algunos mencionan gerentes por nombre. Secuencia correcta?',
'[{"texto": "Subir archivo y pedir analisis", "es_correcta": false}, {"texto": "Anonimizar nombres, estructurar prompt con rol+contexto+formato, herramienta corporativa, validar con RRHH", "es_correcta": true}, {"texto": "Solo extraer palabras clave", "es_correcta": false}, {"texto": "Pedir al LLM que anonimice automaticamente", "es_correcta": false}]',
'Flujo completo del curso. Para anonimizar, la IA tiene que LEER los nombres primero (D es riesgoso).');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE tipo = 'diagnostico_post'),
'Marketing creo campana completa con IA. Director pregunta: ''Lo hizo nuestro equipo creativo?'' Respuesta correcta?',
'[{"texto": "Si, el equipo lo creo", "es_correcta": false}, {"texto": "El equipo creo estrategia y direccion, uso IA generativa para producir assets, revisando y ajustando", "es_correcta": true}, {"texto": "Lo hizo la IA, nosotros revisamos", "es_correcta": false}, {"texto": "No es necesario mencionarlo", "es_correcta": false}]',
'Transparencia sobre uso de IA es principio etico fundamental.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE tipo = 'diagnostico_post'),
'RRHH ofrece sistema de IA que monitorea pulsaciones, tiempo en apps, navegacion. Promete +25% productividad. Mejor analisis?',
'[{"texto": "Si el ROI justifica inversion", "es_correcta": false}, {"texto": "Privacidad, impacto en confianza y moral, legalidad, si metricas miden productividad real o actividad, riesgo de gaming", "es_correcta": true}, {"texto": "Si empleados estan de acuerdo", "es_correcta": false}, {"texto": "Probarlo con piloto", "es_correcta": false}]',
'Analisis multi-dimensional: etica, psicologia, legalidad, validez de metricas, efectos secundarios.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE tipo = 'diagnostico_post'),
'Creaste informe con IA para CEO: 8 estadisticas, 3 graficas, 5 fuentes. Tu checklist?',
'[{"texto": "Revisar ortografia", "es_correcta": false}, {"texto": "Verificar cada estadistica contra fuente original, confirmar fuentes existen, validar graficas, agregar nota de metodologia", "es_correcta": true}, {"texto": "Pedirle a la IA que revise su propio informe", "es_correcta": false}, {"texto": "Enviar con nota ''datos sujetos a verificacion''", "es_correcta": false}]',
'Verificar CADA dato. La IA confirma sus propios errores.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE tipo = 'diagnostico_post'),
'Agente de Copilot para politicas internas. Empleado pregunta sobre dia libre por emergencia, agente dice ''si puedes''. La politica real dice siempre notificar. Que implica?',
'[{"texto": "Necesita mas entrenamiento", "es_correcta": false}, {"texto": "Agentes deben: citar seccion exacta, incluir disclaimer ''verifica con RRHH'', revision periodica, nunca respuestas definitivas sobre derechos laborales", "es_correcta": true}, {"texto": "Desactivar inmediatamente", "es_correcta": false}, {"texto": "Caso aislado, 95% correcto", "es_correcta": false}]',
'Error en politicas laborales puede crear precedentes legales. Disenar con salvaguardas.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE tipo = 'diagnostico_post'),
'Automatizar propuestas comerciales (analizar necesidades, consultar catalogo, calcular presupuesto, redactar). Mejor diseno?',
'[{"texto": "Un solo prompt largo", "es_correcta": false}, {"texto": "Pipeline encadenado: analisis estructurado -> matching con catalogo -> calculo verificado por humano -> redaccion con template, revision al final", "es_correcta": true}, {"texto": "IA genera todo, humano revisa", "es_correcta": false}, {"texto": "Solo IA para redaccion final", "es_correcta": false}]',
'Chaining con herramienta correcta para cada paso y supervision humana.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE tipo = 'diagnostico_post'),
'Puedes generar resenas positivas falsas indistinguibles de reales. Jefe dice ''la competencia lo hace.'' Tu posicion?',
'[{"texto": "Si la competencia lo hace, debemos", "es_correcta": false}, {"texto": "Es deshonesta, puede tener consecuencias legales, dano reputacional devastador si se descubre; proponer alternativas eticas", "es_correcta": true}, {"texto": "Hacerlo moderadamente", "es_correcta": false}, {"texto": "Consultar legal", "es_correcta": false}]',
'''La competencia lo hace'' nunca es justificacion etica. En muchas jurisdicciones es ilegal.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE tipo = 'diagnostico_post'),
'IA empresarial: empleado junior pregunta salario del CEO y la herramienta responde. Que fallo?',
'[{"texto": "No deberia tener acceso a datos salariales", "es_correcta": false}, {"texto": "No implementa control de acceso basado en roles: responde basandose en lo que SABE, no en lo que el usuario esta AUTORIZADO a saber", "es_correcta": true}, {"texto": "El empleado no deberia preguntar", "es_correcta": false}, {"texto": "Bug de filtrado de palabras clave", "es_correcta": false}]',
'Problema de arquitectura de seguridad (RBAC), no de filtrado.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE tipo = 'diagnostico_post'),
'Articulo 1: ''IA reemplazara 40% empleos.'' Articulo 2: ''IA creara mas empleos.'' Posicion MAS informada?',
'[{"texto": "El primero, automatizacion elimina empleos", "es_correcta": false}, {"texto": "El segundo, tecnologia crea empleos", "es_correcta": false}, {"texto": "Ambas probablemente extremas; IA transformara roles y el impacto depende del sector, velocidad de adopcion, politicas y reskilling", "es_correcta": true}, {"texto": "Imposible predecir", "es_correcta": false}]',
'Pensamiento critico requiere resistir narrativas simplistas.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE tipo = 'diagnostico_post'),
'Cual afirmacion refleja MEJOR la relacion ideal profesional-IA?',
'[{"texto": "IA eventualmente hara la mayoria de nuestro trabajo", "es_correcta": false}, {"texto": "IA es amplificador que funciona mejor con criterio humano, pensamiento critico y conciencia de limitaciones", "es_correcta": true}, {"texto": "IA es util pero sobrevalorada", "es_correcta": false}, {"texto": "IA es peligrosa y debemos limitar su uso", "es_correcta": false}]',
'Resume la filosofia del curso: IA como amplificador con criterio profesional.');

-- ************************************************************
-- MODULO 2: Prompt Engineering + Seguridad (orden=2)
-- ************************************************************

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 2),
'Tu companera escribe este prompt: ''Hazme un analisis de ventas.'' El resultado es vago e inutil. Usando el framework GOCE, que componente falta PRINCIPALMENTE?',
'[{"texto": "Goal (objetivo claro)", "es_correcta": false}, {"texto": "Orientacion (contexto de quien eres y para que)", "es_correcta": true}, {"texto": "Constraint (restricciones)", "es_correcta": false}, {"texto": "Ejemplo (formato esperado)", "es_correcta": false}]',
'Sin contexto de rol, audiencia o proposito, la IA no puede orientar su respuesta. La Orientacion da el marco necesario.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 2),
'Necesitas que la IA redacte un correo para un cliente molesto. Cual prompt aplica MEJOR el componente de Constraint del framework GOCE?',
'[{"texto": "''Escribe un correo profesional para un cliente''", "es_correcta": false}, {"texto": "''Redacta un correo de maximo 150 palabras, tono empatico pero firme, sin prometer reembolso, en formato parrafo corto''", "es_correcta": true}, {"texto": "''Escribe el mejor correo posible para calmar a un cliente''", "es_correcta": false}, {"texto": "''Genera 3 versiones de correo para cliente molesto''", "es_correcta": false}]',
'Las restricciones (longitud, tono, prohibiciones, formato) acotan la respuesta y evitan resultados genericos.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 2),
'Un analista escribe: ''Analiza las quejas del cliente Juan Perez, cuenta #4521, sobre el producto Premium que compro el 15 de marzo por $2,500.'' Cual es el problema de seguridad?',
'[{"texto": "El prompt es demasiado largo", "es_correcta": false}, {"texto": "Incluye datos personales identificables (nombre, cuenta, producto, fecha, monto) que no deberian enviarse a la IA", "es_correcta": true}, {"texto": "Deberia usar Copilot en vez de ChatGPT", "es_correcta": false}, {"texto": "No hay problema si es herramienta corporativa", "es_correcta": false}]',
'Incluso en herramientas corporativas, el principio de minimizacion de datos aplica: solo enviar lo necesario, anonimizado.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 2),
'Quieres que la IA genere un reporte financiero trimestral. Cual es la forma CORRECTA de anonimizar los datos antes de enviarlos?',
'[{"texto": "Cambiar solo los nombres de personas", "es_correcta": false}, {"texto": "Reemplazar nombres, cuentas, montos exactos y fechas especificas por identificadores genericos manteniendo la estructura", "es_correcta": true}, {"texto": "Pedirle a la IA que ignore los datos personales", "es_correcta": false}, {"texto": "Enviar todo y borrar el chat despues", "es_correcta": false}]',
'La anonimizacion efectiva cubre todos los campos identificables. La IA no puede ''ignorar'' lo que ya leyo.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 2),
'Estas construyendo un prompt para analizar encuestas de satisfaccion. Cual orden de componentes GOCE produce mejores resultados?',
'[{"texto": "Ejemplo -> Goal -> Constraint -> Orientacion", "es_correcta": false}, {"texto": "Goal -> Orientacion -> Constraint -> Ejemplo", "es_correcta": true}, {"texto": "Constraint -> Ejemplo -> Goal -> Orientacion", "es_correcta": false}, {"texto": "El orden no importa", "es_correcta": false}]',
'GOCE sigue un flujo logico: primero que quieres, luego contexto, despues limites, y finalmente un ejemplo de formato.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 2),
'Tu jefe te pide usar IA para resumir las actas de la junta directiva que incluyen discusiones sobre despidos y reestructuracion. Mejor enfoque?',
'[{"texto": "Resumir directamente en Copilot ya que es herramienta corporativa", "es_correcta": false}, {"texto": "Reemplazar nombres por roles genericos, omitir montos de liquidacion, y resumir temas sin detalles identificables", "es_correcta": true}, {"texto": "Hacer el resumen manualmente sin usar IA", "es_correcta": false}, {"texto": "Usar IA pero agregar disclaimer de confidencialidad al prompt", "es_correcta": false}]',
'Las actas de junta directiva contienen informacion altamente sensible. Anonimizar es obligatorio incluso en herramientas corporativas.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 2),
'Escribes: ''Eres un experto en marketing digital. Crea una estrategia para redes sociales.'' La IA da algo generico. Que componente GOCE mejorar primero?',
'[{"texto": "Orientacion - ya la tienes", "es_correcta": false}, {"texto": "Goal - necesitas especificar objetivo medible y audiencia concreta", "es_correcta": true}, {"texto": "Ejemplo - falta un ejemplo", "es_correcta": false}, {"texto": "Constraint - faltan restricciones", "es_correcta": false}]',
'El Goal es vago (''crea una estrategia''). Especificar objetivo (ej: aumentar engagement 20%), plataforma, audiencia y plazo hace la diferencia.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 2),
'Un companero dice: ''Si uso Copilot de Microsoft, no necesito preocuparme por seguridad porque Microsoft protege todo.'' Esta afirmacion es:',
'[{"texto": "Correcta, Copilot tiene todas las protecciones necesarias", "es_correcta": false}, {"texto": "Incorrecta: la herramienta corporativa reduce riesgos pero el usuario sigue siendo responsable de que datos comparte y como los usa", "es_correcta": true}, {"texto": "Correcta si tienes licencia empresarial", "es_correcta": false}, {"texto": "Correcta para documentos internos, incorrecta para datos de clientes", "es_correcta": false}]',
'La herramienta segura no elimina la responsabilidad del usuario. El principio de minimizacion siempre aplica.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 2),
'Necesitas que la IA genere un template de propuesta comercial. El componente Ejemplo de GOCE seria:',
'[{"texto": "Decirle ''haz algo profesional''", "es_correcta": false}, {"texto": "Mostrarle una propuesta anterior exitosa (anonimizada) como referencia de estructura y tono", "es_correcta": true}, {"texto": "Pedirle que busque ejemplos en internet", "es_correcta": false}, {"texto": "Darle el nombre de un competidor para que copie su estilo", "es_correcta": false}]',
'El Ejemplo muestra a la IA exactamente que formato y estilo esperas. Un ejemplo real anonimizado es la mejor referencia.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 2),
'Descubres que un equipo de tu empresa comparte un login de ChatGPT Plus entre 5 personas para ''ahorrar licencias.'' Cual es el riesgo PRINCIPAL?',
'[{"texto": "Violacion de terminos de servicio", "es_correcta": false}, {"texto": "Todos ven el historial de prompts de todos, incluyendo datos confidenciales que cada uno ingreso", "es_correcta": true}, {"texto": "La cuenta podria ser bloqueada", "es_correcta": false}, {"texto": "No hay riesgo si todos son del mismo equipo", "es_correcta": false}]',
'Compartir cuenta expone historiales cruzados. Un usuario podria ver datos sensibles de RRHH, finanzas o clientes que otro ingreso.');

-- ************************************************************
-- MODULO 3: Few-shot + Chaining (orden=3)
-- ************************************************************

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 3),
'Necesitas clasificar 50 correos de clientes como ''queja'', ''consulta'' o ''felicitacion''. Nunca has hecho esto con IA. Mejor approach?',
'[{"texto": "Zero-shot: ''Clasifica este correo''", "es_correcta": false}, {"texto": "Few-shot: dar 2-3 ejemplos de cada categoria antes de pedir la clasificacion", "es_correcta": true}, {"texto": "Pedirle que invente sus propias categorias", "es_correcta": false}, {"texto": "Clasificar manualmente los primeros 10 y dejar el resto a la IA", "es_correcta": false}]',
'Few-shot con ejemplos por categoria le muestra a la IA exactamente tu criterio de clasificacion, reduciendo ambiguedad.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 3),
'Quieres que la IA escriba descripciones de producto en tu estilo especifico. Tus ejemplos few-shot deben:',
'[{"texto": "Ser los mejores textos que encuentres en internet", "es_correcta": false}, {"texto": "Ser textos reales de TU marca que representen el tono y estructura deseada", "es_correcta": true}, {"texto": "Ser lo mas variados posible en estilo", "es_correcta": false}, {"texto": "Incluir al menos 10 ejemplos para precision", "es_correcta": false}]',
'Los ejemplos few-shot deben reflejar TU estilo deseado. 2-3 ejemplos consistentes son mas efectivos que 10 variados.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 3),
'Estas usando chaining para crear una propuesta: Paso 1 analiza necesidades, Paso 2 busca soluciones, Paso 3 redacta. El Paso 2 da resultados irrelevantes. Que haces?',
'[{"texto": "Repetir todo el chain desde el inicio", "es_correcta": false}, {"texto": "Revisar y corregir solo el Paso 2, verificando que recibio bien el output del Paso 1", "es_correcta": true}, {"texto": "Agregar un Paso 2.5 para filtrar", "es_correcta": false}, {"texto": "Saltar al Paso 3 con lo que hay", "es_correcta": false}]',
'La ventaja del chaining es que puedes depurar cada paso independientemente sin repetir todo.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 3),
'Tu equipo necesita estandarizar respuestas a preguntas frecuentes de clientes. Zero-shot o few-shot?',
'[{"texto": "Zero-shot, porque las preguntas son simples", "es_correcta": false}, {"texto": "Few-shot con ejemplos de respuestas aprobadas, para garantizar consistencia de tono y precision", "es_correcta": true}, {"texto": "Da igual, el resultado sera similar", "es_correcta": false}, {"texto": "Zero-shot con instrucciones muy detalladas", "es_correcta": false}]',
'Cuando necesitas consistencia y un estilo especifico, few-shot con ejemplos aprobados es superior a instrucciones detalladas.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 3),
'Diseñas un chain de 6 pasos para generar un informe completo. Al ejecutarlo, el resultado final es incoherente. Cual es la causa MAS probable?',
'[{"texto": "La IA no puede manejar 6 pasos", "es_correcta": false}, {"texto": "Un paso intermedio genero output incorrecto que contamino los pasos siguientes (error en cascada)", "es_correcta": true}, {"texto": "Necesitas un modelo mas potente", "es_correcta": false}, {"texto": "El chain es demasiado largo, maximo 3 pasos", "es_correcta": false}]',
'El error en cascada es el riesgo principal del chaining. Validar outputs intermedios es esencial.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 3),
'Quieres que la IA extraiga datos especificos de contratos (fechas, montos, partes). Tu ejemplo few-shot muestra: Input: contrato completo -> Output: tabla con campos. Que falta?',
'[{"texto": "Mas ejemplos", "es_correcta": false}, {"texto": "Un ejemplo donde el dato NO existe en el contrato, para que la IA aprenda a decir ''no encontrado'' en vez de inventar", "es_correcta": true}, {"texto": "Instrucciones mas largas", "es_correcta": false}, {"texto": "Nada, el ejemplo es suficiente", "es_correcta": false}]',
'Los ejemplos few-shot deben incluir casos negativos. Sin ellos, la IA inventara datos faltantes en vez de indicar ausencia.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 3),
'Para un proceso de onboarding, diseñas este chain: 1) Generar temario -> 2) Crear contenido por tema -> 3) Disenar evaluacion. Cual es la MEJOR mejora?',
'[{"texto": "Hacerlo todo en un solo prompt", "es_correcta": false}, {"texto": "Agregar paso de validacion humana entre cada paso antes de continuar al siguiente", "es_correcta": true}, {"texto": "Agregar mas pasos para mayor detalle", "es_correcta": false}, {"texto": "Usar modelos diferentes para cada paso", "es_correcta": false}]',
'La validacion humana entre pasos previene error en cascada y asegura que cada etapa cumple el objetivo antes de avanzar.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 3),
'Tu jefe te pide analizar sentimiento en 100 resenas de producto. Tienes 3 resenas ya clasificadas por el equipo. Mejor estrategia?',
'[{"texto": "Zero-shot con instrucciones de que es positivo/negativo", "es_correcta": false}, {"texto": "Usar las 3 resenas clasificadas como few-shot examples y luego procesar en lotes con chaining", "es_correcta": true}, {"texto": "Pedir a la IA que clasifique sin contexto", "es_correcta": false}, {"texto": "Clasificar las 100 manualmente", "es_correcta": false}]',
'Combinacion optima: few-shot para calibrar criterio con ejemplos reales + chaining para procesar en lotes manejables.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 3),
'Estas encadenando prompts y el Paso 3 necesita informacion del Paso 1 que el Paso 2 no paso. Solucion?',
'[{"texto": "Repetir la informacion del Paso 1 en el Paso 3", "es_correcta": false}, {"texto": "Redisenar el chain para que cada paso pase explicitamente toda la informacion necesaria al siguiente", "es_correcta": true}, {"texto": "Hacer los 3 pasos en un solo prompt", "es_correcta": false}, {"texto": "Crear un Paso 2.5 que recupere la informacion", "es_correcta": false}]',
'En chaining, cada paso debe recibir todo el contexto necesario. Perder informacion entre pasos es un error de diseno del chain.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 3),
'Cuando es MEJOR usar zero-shot en vez de few-shot?',
'[{"texto": "Siempre, es mas rapido", "es_correcta": false}, {"texto": "Cuando la tarea es estandar y no requiere formato o criterio especifico de tu organizacion", "es_correcta": true}, {"texto": "Cuando tienes muchos ejemplos disponibles", "es_correcta": false}, {"texto": "Cuando el resultado debe ser preciso", "es_correcta": false}]',
'Zero-shot funciona bien para tareas genericas. Few-shot es necesario cuando necesitas un estilo, formato o criterio organizacional especifico.');

-- ************************************************************
-- MODULO 4: Prompting avanzado + Seguridad (orden=4)
-- ************************************************************

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 4),
'Necesitas que la IA procese datos de encuestas con campos anidados (preguntas con sub-preguntas y opciones multiples). Mejor formato de prompt?',
'[{"texto": "Texto plano con guiones", "es_correcta": false}, {"texto": "JSON para datos estructurados con niveles de anidacion claros", "es_correcta": true}, {"texto": "Tabla markdown", "es_correcta": false}, {"texto": "XML siempre es mejor para datos", "es_correcta": false}]',
'JSON es ideal para datos con estructura jerarquica y campos multiples. XML es mejor para documentos con mezcla de texto y metadatos.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 4),
'Tu empresa no tiene politica de IA. Descubres que 8 equipos usan ChatGPT personal, 3 usan herramientas de IA no autorizadas, y nadie sabe que datos han compartido. Esto se llama:',
'[{"texto": "Innovacion organica", "es_correcta": false}, {"texto": "Shadow AI: uso no autorizado de herramientas de IA sin gobernanza que genera riesgos invisibles", "es_correcta": true}, {"texto": "Adopcion temprana", "es_correcta": false}, {"texto": "Problema de TI", "es_correcta": false}]',
'Shadow AI es el uso de herramientas de IA fuera del control organizacional. El riesgo principal es que nadie sabe que datos ya fueron expuestos.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 4),
'Creas un template para que tu equipo analice reportes mensuales con IA. El template debe incluir:',
'[{"texto": "Solo el prompt", "es_correcta": false}, {"texto": "Instrucciones de anonimizacion, prompt con marcadores de posicion, formato de salida esperado, y checklist de verificacion", "es_correcta": true}, {"texto": "Ejemplo de reporte completo", "es_correcta": false}, {"texto": "Link a la herramienta de IA preferida", "es_correcta": false}]',
'Un template reutilizable completo incluye seguridad (anonimizacion), estructura (prompt), expectativa (formato) y calidad (verificacion).');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 4),
'Un proveedor ofrece un plugin de IA para tu CRM que ''automatiza analisis de clientes.'' Antes de instalarlo, que debes verificar?',
'[{"texto": "Que tenga buenas resenas", "es_correcta": false}, {"texto": "Que datos accede, donde los procesa, si los usa para entrenar modelos, y que pasa si el proveedor cierra", "es_correcta": true}, {"texto": "Que sea compatible con tu version de CRM", "es_correcta": false}, {"texto": "Que el precio sea razonable", "es_correcta": false}]',
'Herramientas externas de IA pueden acceder a datos sensibles del CRM. Evaluar flujo de datos, politicas de uso y riesgo de dependencia.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 4),
'Necesitas estructurar un prompt largo con secciones de contexto, instrucciones y restricciones claramente separadas. Mejor formato?',
'[{"texto": "Todo en un parrafo", "es_correcta": false}, {"texto": "XML con tags semanticos como <contexto>, <instrucciones>, <restricciones> para separacion clara", "es_correcta": true}, {"texto": "JSON con campos", "es_correcta": false}, {"texto": "Bullet points simples", "es_correcta": false}]',
'XML con tags semanticos organiza prompts largos de forma clara. El modelo identifica cada seccion por su tag.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 4),
'Diseñas un template para generar reportes de ventas. El template tiene [PERIODO], [REGION], [PRODUCTO]. Un usuario pone datos de clientes reales en [REGION]. Que fallo?',
'[{"texto": "El template esta mal diseñado", "es_correcta": false}, {"texto": "El template necesita instrucciones claras sobre que datos son permitidos en cada campo y cuales requieren anonimizacion", "es_correcta": true}, {"texto": "El usuario no siguio instrucciones", "es_correcta": false}, {"texto": "No deberia tener campo REGION", "es_correcta": false}]',
'Los templates deben incluir guia de seguridad por campo. Sin ella, los usuarios ingresaran datos sensibles por conveniencia.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 4),
'Tu equipo usa 5 herramientas de IA diferentes (ChatGPT, Copilot, Midjourney, Jasper, Notion AI). Para reducir riesgo de Shadow AI, la PRIMERA accion debe ser:',
'[{"texto": "Prohibir todas excepto una", "es_correcta": false}, {"texto": "Inventariar todas las herramientas en uso, clasificar riesgo por tipo de dato que manejan, y establecer politica de uso aprobado", "es_correcta": true}, {"texto": "Esperar a que TI se encargue", "es_correcta": false}, {"texto": "Capacitar al equipo en la que el lider prefiera", "es_correcta": false}]',
'No puedes gobernar lo que no conoces. El inventario es el primer paso para pasar de Shadow AI a IA gobernada.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 4),
'Quieres que la IA analice feedback de clientes y devuelva resultados estructurados. Que formato de salida pedirle?',
'[{"texto": "Texto libre para que sea natural", "es_correcta": false}, {"texto": "JSON con campos predefinidos (sentimiento, categoria, urgencia, resumen) para procesamiento automatizado posterior", "es_correcta": true}, {"texto": "Una tabla simple", "es_correcta": false}, {"texto": "XML porque es mas seguro", "es_correcta": false}]',
'Si los resultados alimentan otro sistema o proceso, JSON con esquema predefinido permite automatizacion confiable.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 4),
'Un companero copia un template de prompts de un blog para analizar datos financieros de la empresa. Cual es el riesgo que NO esta considerando?',
'[{"texto": "Que el prompt no funcione bien", "es_correcta": false}, {"texto": "El template podria contener instrucciones ocultas (prompt injection) que exfiltren datos o modifiquen el comportamiento del modelo", "es_correcta": true}, {"texto": "Que el blog tenga informacion desactualizada", "es_correcta": false}, {"texto": "Que el formato no sea compatible", "es_correcta": false}]',
'Los templates externos pueden contener instrucciones maliciosas no visibles que manipulan al modelo para filtrar datos.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 4),
'Para una tarea compleja necesitas mezclar texto narrativo con datos estructurados en el prompt. Mejor combinacion de formatos?',
'[{"texto": "Todo en JSON", "es_correcta": false}, {"texto": "XML para la estructura general con secciones narrativas en texto y datos en JSON embebido", "es_correcta": true}, {"texto": "Todo en texto plano", "es_correcta": false}, {"texto": "Markdown con tablas", "es_correcta": false}]',
'XML permite mezclar contenido narrativo con datos estructurados en JSON embebido, aprovechando lo mejor de ambos formatos.');

-- ************************************************************
-- MODULO 5: Crear con Copilot (orden=5)
-- ************************************************************

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 5),
'Necesitas crear una presentacion de 15 slides para el comite directivo. Copilot genera un borrador en PowerPoint. Tu siguiente paso?',
'[{"texto": "Enviarla directamente, Copilot la hizo bien", "es_correcta": false}, {"texto": "Revisar narrativa, verificar datos, ajustar diseño a la marca, y validar que cada slide tenga un mensaje clave claro", "es_correcta": true}, {"texto": "Regenerar hasta que quede perfecta", "es_correcta": false}, {"texto": "Agregar mas slides por si faltan temas", "es_correcta": false}]',
'Copilot genera borradores utiles pero requiere revision de contenido, datos, marca y claridad de mensaje.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 5),
'Quieres usar Designer de Copilot para crear un banner. Le pides ''un banner corporativo azul con logo.'' El resultado no tiene tu logo. Por que?',
'[{"texto": "Designer no puede generar logos de marca", "es_correcta": false}, {"texto": "Designer genera imagenes desde cero basandose en texto; no accede a tus assets de marca ni puede reproducir logos existentes", "es_correcta": true}, {"texto": "Necesitas subir el logo primero", "es_correcta": false}, {"texto": "Debes describir el logo con mas detalle", "es_correcta": false}]',
'Designer es IA generativa de imagenes, no un editor. No accede a archivos de marca ni reproduce elementos visuales especificos.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 5),
'Tu equipo necesita una encuesta de satisfaccion para un evento. Quieres usar Copilot en Forms. Cual es la MEJOR instruccion?',
'[{"texto": "''Crea una encuesta de satisfaccion''", "es_correcta": false}, {"texto": "''Crea encuesta de 10 preguntas para evento corporativo: 3 de logistica (escala 1-5), 3 de contenido (opcion multiple), 2 abiertas de mejora, 2 de NPS''", "es_correcta": true}, {"texto": "''Encuesta profesional con preguntas variadas''", "es_correcta": false}, {"texto": "''Encuesta rapida de 5 preguntas''", "es_correcta": false}]',
'Especificar cantidad, tipo de preguntas, escalas y categorias da a Copilot suficiente contexto para generar algo util.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 5),
'Necesitas crear contenido visual para redes sociales, un formulario de feedback, y un deck de ventas. Que herramienta de Copilot para cada uno?',
'[{"texto": "PowerPoint para todo", "es_correcta": false}, {"texto": "Designer para visual de redes, Forms para feedback, PowerPoint para deck de ventas", "es_correcta": true}, {"texto": "Designer para todo lo visual, Word para lo demas", "es_correcta": false}, {"texto": "ChatGPT para generar todo y copiar a cada herramienta", "es_correcta": false}]',
'Cada herramienta de Copilot tiene su fortaleza: Designer para imagenes, Forms para encuestas/formularios, PowerPoint para presentaciones.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 5),
'Copilot en PowerPoint genera slides con datos estadisticos impresionantes sobre tu industria. Cual es el riesgo PRINCIPAL?',
'[{"texto": "Que los datos esten desactualizados", "es_correcta": false}, {"texto": "Los datos pueden ser completamente inventados (alucinaciones) y al estar en formato profesional parecen mas creibles", "es_correcta": true}, {"texto": "Que no sean relevantes para tu audiencia", "es_correcta": false}, {"texto": "Que la fuente no sea reconocida", "es_correcta": false}]',
'El formato profesional de las slides hace que datos alucinados parezcan mas creibles. Verificar cada dato contra fuentes reales.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 5),
'Quieres que Copilot en Forms cree un quiz de capacitacion para tu equipo. Mejor estrategia?',
'[{"texto": "''Crea un quiz de capacitacion''", "es_correcta": false}, {"texto": "Dar el tema especifico, nivel de dificultad, tipos de pregunta deseados, y pedir respuestas correctas para luego verificarlas tu", "es_correcta": true}, {"texto": "Crear las preguntas manualmente y solo usar Copilot para el formato", "es_correcta": false}, {"texto": "Generar multiples quizzes y elegir el mejor", "es_correcta": false}]',
'Copilot puede generar quizzes utiles pero las respuestas correctas DEBEN verificarse por un experto en el tema.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 5),
'Designer de Copilot es MAS util para:',
'[{"texto": "Editar fotos existentes con precision", "es_correcta": false}, {"texto": "Generar imagenes conceptuales rapidas para brainstorming, mockups iniciales o inspiracion visual", "es_correcta": true}, {"texto": "Crear material de marca final listo para publicar", "es_correcta": false}, {"texto": "Reemplazar al equipo de diseño grafico", "es_correcta": false}]',
'Designer es ideal para exploracion visual rapida, no para produccion final de marca. Siempre necesita refinamiento profesional.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 5),
'Tu presentacion de PowerPoint generada por Copilot tiene 20 slides pero el comite solo tiene 10 minutos. Que haces?',
'[{"texto": "Pedir a Copilot que la resuma", "es_correcta": false}, {"texto": "Identificar los 3-5 mensajes clave, reducir a slides esenciales, y usar notas del presentador para detalles adicionales", "es_correcta": true}, {"texto": "Hablar mas rapido", "es_correcta": false}, {"texto": "Enviar las 20 slides por correo antes de la reunion", "es_correcta": false}]',
'La edicion humana para adaptar al contexto (tiempo, audiencia, objetivo) es donde el profesional agrega valor sobre el borrador de IA.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 5),
'Un companero dice: ''Copilot en Forms puede crear formularios de evaluacion 360 completos automaticamente.'' La realidad es:',
'[{"texto": "Correcto, Forms es muy avanzado", "es_correcta": false}, {"texto": "Copilot genera un borrador util pero las preguntas de evaluacion 360 requieren revision de RRHH para alinearse con competencias organizacionales", "es_correcta": true}, {"texto": "Incorrecto, Forms no puede crear evaluaciones", "es_correcta": false}, {"texto": "Correcto solo con licencia E5", "es_correcta": false}]',
'Copilot acelera la creacion pero evaluaciones de desempeno requieren alineacion con el modelo de competencias de la organizacion.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 5),
'Para una campana de marketing necesitas: 5 variantes de imagen, encuesta de preferencia, y deck de resultados. Cual es el flujo OPTIMO?',
'[{"texto": "Crear todo en paralelo con diferentes herramientas", "es_correcta": false}, {"texto": "Designer para variantes visuales -> Forms para encuesta comparativa con las imagenes -> PowerPoint para deck con resultados y ganadora", "es_correcta": true}, {"texto": "PowerPoint para todo incluyendo las imagenes", "es_correcta": false}, {"texto": "Pedir a ChatGPT que diseñe todo el flujo", "es_correcta": false}]',
'El flujo secuencial aprovecha cada herramienta para su fortaleza y el output de una alimenta la siguiente.');

-- ************************************************************
-- MODULO 6: Agentes + Excel (orden=6)
-- ************************************************************

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 6),
'Tu jefe quiere un agente de Copilot que apruebe gastos automaticamente segun politicas internas. Cual es el riesgo PRINCIPAL?',
'[{"texto": "Que apruebe demasiado rapido", "es_correcta": false}, {"texto": "Un agente puede malinterpretar casos ambiguos en politicas y aprobar gastos fuera de politica sin juicio contextual humano", "es_correcta": true}, {"texto": "Que los empleados no confien en el agente", "es_correcta": false}, {"texto": "Que sea mas lento que un humano", "es_correcta": false}]',
'Los agentes ejecutan segun reglas pero carecen de juicio para casos grises. Aprobaciones financieras necesitan supervision humana para excepciones.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 6),
'Tienes un Excel con 10,000 filas de transacciones. Copilot en Excel puede ayudarte a:',
'[{"texto": "Solo crear graficas basicas", "es_correcta": false}, {"texto": "Analizar patrones, crear tablas dinamicas, generar formulas complejas, identificar anomalias y visualizar tendencias", "es_correcta": true}, {"texto": "Solo ordenar y filtrar", "es_correcta": false}, {"texto": "Reemplazar todo analisis manual", "es_correcta": false}]',
'Copilot en Excel es potente para analisis pero los resultados deben validarse, especialmente formulas y conclusiones.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 6),
'Un agente de Copilot busca informacion en SharePoint y responde preguntas de empleados. Un empleado recibe respuesta incorrecta sobre politica de vacaciones. Que fallo?',
'[{"texto": "SharePoint tiene info desactualizada", "es_correcta": false}, {"texto": "Puede ser ambas: el agente pudo interpretar mal un documento correcto, O el documento en SharePoint esta desactualizado; ambos riesgos deben gestionarse", "es_correcta": true}, {"texto": "El empleado hizo la pregunta mal", "es_correcta": false}, {"texto": "El agente necesita mas entrenamiento", "es_correcta": false}]',
'Dos puntos de falla: calidad de la fuente Y capacidad de interpretacion del agente. Hay que gestionar ambos.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 6),
'Le pides a Copilot en Excel: ''Calcula el ROI de cada campana de marketing.'' Los resultados parecen razonables. Que debes hacer ANTES de presentarlos?',
'[{"texto": "Nada, Copilot calcula bien", "es_correcta": false}, {"texto": "Verificar la formula que Copilot genero, validar con 2-3 calculos manuales, y confirmar que la definicion de ROI usada es la de tu empresa", "es_correcta": true}, {"texto": "Pedir que recalcule para confirmar", "es_correcta": false}, {"texto": "Agregar nota de que fue calculado por IA", "es_correcta": false}]',
'Copilot puede usar una formula de ROI diferente a la de tu empresa. Siempre verifica la formula, no solo el resultado.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 6),
'Quieres crear un agente que resuma correos del dia y priorice los urgentes. Para que esto funcione, el agente necesita:',
'[{"texto": "Acceso a todos los correos de la empresa", "es_correcta": false}, {"texto": "Acceso solo a TUS correos, criterios claros de urgencia definidos por ti, y limite de acciones (solo leer y resumir, no responder)", "es_correcta": true}, {"texto": "Integracion con calendario tambien", "es_correcta": false}, {"texto": "Entrenamiento con correos historicos", "es_correcta": false}]',
'Principio de minimo privilegio: el agente solo accede a lo necesario y solo ejecuta acciones permitidas.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 6),
'Tu Excel tiene datos de ventas con celdas vacias, formatos inconsistentes de fecha, y duplicados. Le pides analisis a Copilot. Que pasara?',
'[{"texto": "Copilot limpiara los datos automaticamente", "es_correcta": false}, {"texto": "Los resultados seran poco confiables: basura entra, basura sale. Debes limpiar datos ANTES de analizar", "es_correcta": true}, {"texto": "Copilot te advertira de los problemas", "es_correcta": false}, {"texto": "Solo los duplicados afectaran el resultado", "es_correcta": false}]',
'Garbage in, garbage out. La calidad del analisis depende de la calidad de los datos. Limpiar primero es fundamental.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 6),
'Un agente de IA tiene acceso a tu CRM y calendario. Un dia, envia correos a clientes cancelando reuniones ''para optimizar tu agenda.'' Que principio se violo?',
'[{"texto": "El agente tomo demasiado tiempo", "es_correcta": false}, {"texto": "El agente actuo autonomamente sin autorizacion explicita: los agentes deben tener limites claros de accion y requerir aprobacion para decisiones con impacto externo", "es_correcta": true}, {"texto": "El CRM no deberia conectarse al calendario", "es_correcta": false}, {"texto": "Los clientes deberian haber sido notificados", "es_correcta": false}]',
'Agentes con demasiada autonomia pueden tomar acciones daninas. Las acciones con impacto externo siempre requieren aprobacion humana.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 6),
'Copilot en Excel te sugiere una formula LAMBDA compleja para tu analisis. Tu no entiendes LAMBDA. Que haces?',
'[{"texto": "Usarla, Copilot sabe lo que hace", "es_correcta": false}, {"texto": "Pedir a Copilot que explique paso a paso que hace la formula, probarla con datos conocidos, y asegurarte de entenderla antes de usarla en produccion", "es_correcta": true}, {"texto": "Rechazarla y pedir algo mas simple", "es_correcta": false}, {"texto": "Buscar LAMBDA en Google", "es_correcta": false}]',
'Nunca uses formulas que no entiendas. Pedir explicacion a Copilot y validar con datos conocidos es el camino correcto.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 6),
'Para cual escenario un agente de IA es MAS apropiado?',
'[{"texto": "Decidir a quien promover en el equipo", "es_correcta": false}, {"texto": "Monitorear inventario y alertar cuando un producto baja del minimo, sugiriendo orden de reposicion para aprobacion humana", "es_correcta": true}, {"texto": "Negociar precios con proveedores", "es_correcta": false}, {"texto": "Evaluar desempeno de empleados", "es_correcta": false}]',
'Los agentes son ideales para monitoreo y alerta con reglas claras. Decisiones sobre personas requieren juicio humano.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 6),
'Tu equipo quiere conectar un agente de Copilot a la base de datos de clientes, sistema de facturacion, y correo corporativo. Cual es la regla de oro?',
'[{"texto": "Conectar todo para maximo valor", "es_correcta": false}, {"texto": "Cada conexion es un vector de riesgo: conectar solo lo necesario, con permisos minimos, acciones limitadas, y auditoria de cada interaccion", "es_correcta": true}, {"texto": "Conectar solo la base de clientes", "es_correcta": false}, {"texto": "Esperar a que TI lo configure", "es_correcta": false}]',
'Principio de minimo privilegio aplicado a agentes: cada conexion amplia la superficie de ataque. Solo lo estrictamente necesario.');

-- ************************************************************
-- MODULO 7: IA para tu vida personal (orden=7)
-- ************************************************************

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 8),
'Quieres usar IA para planificar un viaje familiar a Europa. Cual es la MEJOR forma de empezar?',
'[{"texto": "''Planifica un viaje a Europa''", "es_correcta": false}, {"texto": "Dar contexto especifico: fechas, presupuesto, edades del grupo, intereses, restricciones alimentarias, y pedir itinerario dia por dia para validar", "es_correcta": true}, {"texto": "Pedir a la IA que elija el mejor destino", "es_correcta": false}, {"texto": "Buscar paquetes turisticos y luego pedir opinion a la IA", "es_correcta": false}]',
'El mismo principio del curso aplica: contexto especifico genera resultados utiles. Sin datos, la IA da recomendaciones genericas.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 8),
'Usas la version gratuita de ChatGPT para pedir consejo medico sobre un sintoma persistente. La IA te da un diagnostico detallado. Que debes considerar?',
'[{"texto": "Si el diagnostico suena logico, seguirlo", "es_correcta": false}, {"texto": "La IA no es profesional medico, puede dar informacion incorrecta o incompleta, y la version gratuita puede usar tus datos de salud para entrenamiento", "es_correcta": true}, {"texto": "Pedir segunda opinion a otra IA", "es_correcta": false}, {"texto": "Confiar si cita fuentes medicas", "es_correcta": false}]',
'Doble riesgo: precision cuestionable en temas medicos + datos de salud expuestos en version gratuita. Consultar profesional siempre.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 8),
'Tu hijo de 14 anos usa ChatGPT para hacer toda su tarea escolar. Cual es tu preocupacion PRINCIPAL como padre?',
'[{"texto": "Que lo descubran en la escuela", "es_correcta": false}, {"texto": "No esta desarrollando pensamiento critico, capacidad de escritura ni aprendizaje real; la IA esta reemplazando el proceso educativo, no complementandolo", "es_correcta": true}, {"texto": "Que use la version de pago sin permiso", "es_correcta": false}, {"texto": "Que la tarea tenga errores", "es_correcta": false}]',
'El objetivo de la tarea es aprender, no entregarla. Usar IA para reemplazar el proceso atrofia habilidades criticas en desarrollo.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 8),
'Quieres usar IA para gestionar tus finanzas personales. Cual es el enfoque MAS seguro?',
'[{"texto": "Compartir estados de cuenta con la IA para que analice tus gastos", "es_correcta": false}, {"texto": "Crear categorias de gasto anonimizadas (sin numeros de cuenta ni montos exactos) y pedir estrategias de ahorro generales adaptadas a tu perfil", "es_correcta": true}, {"texto": "Usar apps de finanzas con IA integrada sin revisar politicas de privacidad", "es_correcta": false}, {"texto": "No usar IA para finanzas personales", "es_correcta": false}]',
'Los principios de seguridad del curso aplican a lo personal: anonimizar datos financieros y nunca compartir numeros de cuenta.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 8),
'La version gratuita de ChatGPT vs la version de pago (Plus/Pro). Cual es la diferencia MAS importante para un usuario personal?',
'[{"texto": "La de pago es mas rapida", "es_correcta": false}, {"texto": "La de pago tiene mejores politicas de privacidad (no usa conversaciones para entrenamiento), acceso a modelos mas capaces, y funciones avanzadas como vision y analisis de archivos", "es_correcta": true}, {"texto": "La de pago no tiene limites de uso", "es_correcta": false}, {"texto": "No hay diferencia real, solo marketing", "es_correcta": false}]',
'La diferencia clave es privacidad: la version gratuita puede usar tus datos para entrenamiento. Para datos sensibles, esto importa.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 8),
'Un amigo te dice: ''Use IA para escribir mi CV y carta de presentacion. Las envie a 50 empresas identicas.'' Cual es el problema?',
'[{"texto": "Que las 50 empresas reciban lo mismo", "es_correcta": false}, {"texto": "CVs genericos de IA son detectables, no reflejan voz autentica, y sin personalizacion por empresa demuestran falta de interes genuino", "es_correcta": true}, {"texto": "Que la IA no tenga datos actualizados del mercado laboral", "es_correcta": false}, {"texto": "Ningun problema, es eficiente", "es_correcta": false}]',
'La IA es herramienta para personalizar y mejorar, no para reemplazar autenticidad. Reclutadores detectan contenido generico de IA.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 8),
'Quieres usar IA para aprender un nuevo idioma. Cual es la estrategia MAS efectiva?',
'[{"texto": "Pedirle que traduzca todo lo que necesites", "es_correcta": false}, {"texto": "Usarla como tutor conversacional: practicar dialogos, pedir correccion con explicaciones, y crear ejercicios personalizados a tu nivel", "es_correcta": true}, {"texto": "Solo usar apps dedicadas de idiomas", "es_correcta": false}, {"texto": "Memorizar vocabulario que la IA genere", "es_correcta": false}]',
'La IA como tutor interactivo permite practica personalizada ilimitada. Traducir todo no desarrolla la habilidad.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 8),
'Ves un anuncio de una ''IA que predice tu futuro financiero con 95% de precision.'' Tu reaccion deberia ser:',
'[{"texto": "Probarlo, 95% es muy alto", "es_correcta": false}, {"texto": "Escepticismo: ninguna IA predice el futuro con esa precision, probablemente es marketing enganoso o estafa para obtener datos financieros", "es_correcta": true}, {"texto": "Investigar la empresa detras", "es_correcta": false}, {"texto": "Probarlo con datos falsos primero", "es_correcta": false}]',
'El pensamiento critico del curso aplica a la vida personal: afirmaciones extraordinarias requieren evidencia extraordinaria.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 8),
'Con la evolucion de la IA, cual habilidad personal sera MAS valiosa en los proximos anos?',
'[{"texto": "Aprender a programar IA", "es_correcta": false}, {"texto": "Pensamiento critico, capacidad de hacer las preguntas correctas, y saber cuando confiar o cuestionar resultados de IA", "es_correcta": true}, {"texto": "Usar la mayor cantidad de herramientas de IA posible", "es_correcta": false}, {"texto": "Especializarse en un area que la IA no pueda hacer", "es_correcta": false}]',
'La habilidad meta es saber trabajar CON la IA: criterio para evaluar, creatividad para dirigir, y etica para decidir.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 8),
'Usas IA para generar un plan de ejercicios personalizado. Le diste tu edad, peso, condiciones medicas y objetivos. Que riesgo acabas de crear?',
'[{"texto": "Ningun riesgo, es informacion basica", "es_correcta": false}, {"texto": "Compartiste datos de salud sensibles que quedan en el historial del proveedor; ademas, el plan podria ser inadecuado para tus condiciones medicas sin supervision profesional", "es_correcta": true}, {"texto": "Solo el riesgo de que el plan no funcione", "es_correcta": false}, {"texto": "Riesgo de que te cobren mas por tus datos", "es_correcta": false}]',
'Doble riesgo: datos de salud expuestos al proveedor + recomendaciones de ejercicio que podrian ser daninas para tus condiciones.');

COMMIT;
