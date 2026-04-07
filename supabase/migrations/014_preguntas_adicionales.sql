BEGIN;

-- ============================================================
-- Preguntas adicionales para expandir el banco de preguntas
-- NO elimina preguntas existentes, solo agrega nuevas
-- Total: 46 preguntas (8 diag_pre + 8 diag_post + 5x6 modulos)
-- ============================================================

-- ************************************************************
-- DIAGNOSTICO DE ENTRADA - 8 preguntas adicionales (orden=0)
-- Enfoque: pensamiento critico, tradeoffs, riesgos ocultos
-- ************************************************************

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 0),
'Tu equipo de marketing quiere usar IA para personalizar correos masivos a 50,000 clientes usando su historial de compras, preferencias y ubicacion. El proyecto promete +35% de conversion. Cual es el riesgo que el equipo probablemente NO esta considerando?',
'[{"texto": "Que la IA escriba correos con errores gramaticales", "es_correcta": false}, {"texto": "Que la personalizacion a ese nivel revele que la empresa tiene mas datos del cliente de lo que el cree, generando desconfianza", "es_correcta": true}, {"texto": "Que el costo de la herramienta sea alto", "es_correcta": false}, {"texto": "Que los correos lleguen a spam", "es_correcta": false}]',
'La hiperpersonalizacion puede cruzar la linea entre ''util'' y ''invasivo''. Los clientes que perciben vigilancia reaccionan negativamente, el efecto contrario al esperado.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 0),
'Un gerente propone usar IA para transcribir y resumir automaticamente TODAS las reuniones del equipo, guardando las transcripciones en un repositorio compartido. La intencion es mejorar la documentacion. Por que podria ser contraproducente?',
'[{"texto": "Porque la IA no transcribe bien", "es_correcta": false}, {"texto": "Porque la gente dejara de hablar con franqueza sabiendo que todo queda grabado y procesado por IA", "es_correcta": true}, {"texto": "Porque consume muchos tokens", "es_correcta": false}, {"texto": "Porque no todos hablan claro", "es_correcta": false}]',
'El efecto ''chilling'': cuando las personas saben que una IA procesa sus palabras, se autocensuran. La calidad de las discusiones baja y las conversaciones dificiles se evitan.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 0),
'Una startup te ofrece una herramienta de IA que analiza el tono de voz en llamadas de servicio al cliente para detectar emociones y evaluar agentes. En que escenario seria MEJOR no implementarla, a pesar de los beneficios prometidos?',
'[{"texto": "Cuando es cara", "es_correcta": false}, {"texto": "Cuando la legislacion local requiere consentimiento para monitoreo biometrico y los empleados no han sido informados", "es_correcta": true}, {"texto": "Cuando los agentes tienen buen desempeno", "es_correcta": false}, {"texto": "Cuando ya tienes encuestas de satisfaccion", "es_correcta": false}]',
'El analisis de voz es dato biometrico en muchas jurisdicciones. Implementar sin cumplir normativa legal expone a la empresa a demandas, independientemente de los beneficios operativos.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 0),
'Tu jefe quiere que uses IA para redactar las respuestas a una auditoria de cumplimiento regulatorio. Cual es la razon MAS fuerte para no hacerlo sin supervision experta?',
'[{"texto": "La IA no entiende regulaciones", "es_correcta": false}, {"texto": "La IA puede generar respuestas que suenan correctas pero malinterpretan requisitos especificos, creando evidencia escrita de incumplimiento", "es_correcta": true}, {"texto": "Los auditores lo notaran", "es_correcta": false}, {"texto": "No es etico", "es_correcta": false}]',
'En auditorias, una respuesta incorrecta documentada es peor que no responder. La IA puede generar lenguaje regulatorio convincente pero impreciso, creando problemas legales.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 0),
'Un colega automatizo con IA la generacion de reportes semanales que antes le tomaban 4 horas. Ahora los genera en 10 minutos pero dedica el tiempo ahorrado a otras tareas sin revisar los reportes. Que problema se esta gestando?',
'[{"texto": "Ninguno, es mas eficiente", "es_correcta": false}, {"texto": "Deuda de calidad: errores no detectados se acumulan hasta que un reporte incorrecto causa una mala decision de negocio", "es_correcta": true}, {"texto": "Los reportes son demasiado genericos", "es_correcta": false}, {"texto": "Sus colegas se sentiran reemplazados", "es_correcta": false}]',
'La automatizacion sin verificacion crea una falsa sensacion de productividad. El riesgo se acumula silenciosamente hasta que un error tiene consecuencias reales.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 0),
'En una reunion, alguien propone: ''Dejemos que la IA decida a que clientes darles credito, asi eliminamos el sesgo humano.'' Cual es la falla en este razonamiento?',
'[{"texto": "La IA no puede analizar datos financieros", "es_correcta": false}, {"texto": "La IA hereda sesgos de los datos historicos con los que fue entrenada, potencialmente discriminando contra los mismos grupos que el sesgo humano afectaba", "es_correcta": true}, {"texto": "Es ilegal usar IA para credito", "es_correcta": false}, {"texto": "La IA es mas sesgada que los humanos", "es_correcta": false}]',
'Los modelos entrenados con datos historicos replican patrones discriminatorios del pasado. Eliminar sesgo humano no elimina sesgo sistematico en los datos.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 0),
'Tienes dos opciones para un analisis urgente: (A) usar una herramienta de IA gratuita que da resultados en 2 minutos, o (B) esperar 2 horas a que el analista del equipo lo haga manualmente. Los datos contienen nombres de clientes y montos de facturacion. Cual es la decision CORRECTA?',
'[{"texto": "Opcion A, la urgencia lo justifica", "es_correcta": false}, {"texto": "Opcion B, porque los datos contienen informacion sensible de clientes que no debe procesarse en herramientas no autorizadas", "es_correcta": false}, {"texto": "Opcion A pero anonimizando los datos antes de enviarlos", "es_correcta": false}, {"texto": "Depende: si existe herramienta corporativa autorizada, anonimizar y usarla; si no, opcion B", "es_correcta": true}]',
'No es binario. La respuesta correcta evalua si hay una herramienta autorizada disponible. Ni la urgencia justifica exponer datos, ni hay que rechazar toda IA por precaucion.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 0),
'Una IA genera un analisis que contradice tu experiencia de 10 anos en el sector. El analisis esta bien redactado y cita tendencias de mercado. Cual es la actitud MAS profesional?',
'[{"texto": "Confiar en la IA porque procesa mas datos que tu", "es_correcta": false}, {"texto": "Descartar el analisis porque tu experiencia es mas valiosa", "es_correcta": false}, {"texto": "Investigar la discrepancia: verificar los datos de la IA, cuestionar tus supuestos, y llegar a una conclusion informada que combine ambas perspectivas", "es_correcta": true}, {"texto": "Pedir una segunda opinion a otra IA", "es_correcta": false}]',
'Ni aceptar ciegamente ni rechazar por orgullo. La discrepancia es una oportunidad para descubrir algo nuevo o confirmar que la IA se equivoca, pero requiere investigacion.');

-- ************************************************************
-- DIAGNOSTICO DE SALIDA - 8 preguntas adicionales (orden=9)
-- Las MAS dificiles del curso. Combinan 3+ conceptos.
-- ************************************************************

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 9),
'Tu empresa lanza un agente de Copilot para responder consultas de pasajeros sobre politicas de equipaje. El agente usa documentos de SharePoint como fuente. Un pasajero pregunta: ''Mi vuelo fue cancelado, tengo derecho a compensacion?'' El agente responde ''Si, tienes derecho a USD 250.'' Pero la politica real tiene condiciones (causa de cancelacion, antelacion, ruta). Que combinacion de fallas explica este error?',
'[{"texto": "El modelo alucinó el monto y las condiciones", "es_correcta": false}, {"texto": "El agente no tiene acceso a los documentos correctos", "es_correcta": false}, {"texto": "Falla de diseno: las instrucciones del agente no incluyen restriccion de dar respuestas condicionales como definitivas, no cita la seccion de la politica, y no escala a humano en temas legales/compensatorios", "es_correcta": true}, {"texto": "El documento de SharePoint esta desactualizado", "es_correcta": false}]',
'Combina: limitaciones de agentes (M6), restricciones en prompts (M4/GOCE), y principio de que la IA no reemplaza juicio humano. Es un problema de arquitectura del agente, no del modelo.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 9),
'Disenaste un pipeline con chaining de 4 pasos para procesar encuestas de clima laboral: 1) Anonimizar, 2) Clasificar sentimiento con few-shot, 3) Agrupar por tema, 4) Generar recomendaciones. Al revisar los resultados, las recomendaciones no tienen relacion con los datos originales. Aplicas depuracion: el Paso 1 funciona bien, el Paso 2 funciona bien, el Paso 3 agrupa correctamente. Donde esta el error?',
'[{"texto": "El Paso 4 necesita mas contexto en el prompt", "es_correcta": false}, {"texto": "El Paso 3 paso las agrupaciones al Paso 4 sin incluir los comentarios originales anonimizados, y el Paso 4 genero recomendaciones solo a partir de etiquetas de categoria sin datos de respaldo", "es_correcta": true}, {"texto": "El modelo alucinó en el Paso 4", "es_correcta": false}, {"texto": "Necesitas agregar un Paso 5 de validacion", "es_correcta": false}]',
'Combina: error de diseno de chaining (M3) donde se pierde contexto entre pasos, anonimizacion (M2), y validacion de outputs. El chain debe pasar toda la informacion necesaria a cada paso.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 9),
'La VP de Operaciones te pide crear una presentacion en PowerPoint con Copilot sobre la baja de puntualidad del trimestre, usando datos de un Excel con informacion de 200 vuelos (ruta, hora, causa de retraso, minutos de demora). Los datos incluyen nombres de pilotos y numeros de vuelo activos. Cual es la secuencia CORRECTA?',
'[{"texto": "Subir el Excel a Copilot en PowerPoint y pedir la presentacion", "es_correcta": false}, {"texto": "Anonimizar el Excel (quitar nombres de pilotos, generalizar numeros de vuelo), analizar primero en Excel con Copilot para extraer insights, luego crear la presentacion en PowerPoint con los hallazgos verificados, y revisar que las graficas reflejen datos reales", "es_correcta": true}, {"texto": "Crear la presentacion manualmente y usar Copilot solo para mejorar el diseno", "es_correcta": false}, {"texto": "Usar Copilot Chat para generar la presentacion directamente desde el prompt", "es_correcta": false}]',
'Combina: anonimizacion (M2), Excel con Copilot (M6), PowerPoint con Copilot (M5), y verificacion de datos. Cada herramienta cumple un rol en la secuencia correcta.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 9),
'Un equipo de 3 personas usa diferentes estrategias de IA: Ana usa prompts zero-shot largos con mucho contexto. Carlos usa few-shot con 8 ejemplos por tarea. Maria usa chaining de 2 pasos con prompts XML estructurados. Los tres trabajan sobre las mismas tareas de clasificacion de tickets con 4 categorias. Quien probablemente obtiene los resultados MAS consistentes y por que?',
'[{"texto": "Ana, porque mas contexto siempre es mejor", "es_correcta": false}, {"texto": "Carlos, porque mas ejemplos eliminan toda ambiguedad", "es_correcta": false}, {"texto": "Maria, porque la estructura XML separa instrucciones claramente y el chaining permite verificar la clasificacion antes de actuar sobre ella", "es_correcta": true}, {"texto": "Los tres obtendran resultados similares", "es_correcta": false}]',
'Ana pierde consistencia por falta de patron (M3). Carlos excede los 3-5 ejemplos optimos y puede introducir sesgo (M3). Maria combina estructura (M4) con verificacion intermedia (M3), maximizando consistencia.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 9),
'Tu empresa adopta un modelo de IA especializado en aviacion (tendencia de modelos especializados) que corre localmente en las laptops del equipo (Edge AI). Un gerente dice: ''Perfecto, ahora no necesitamos anonimizar porque los datos no salen del dispositivo.'' Es correcto?',
'[{"texto": "Si, Edge AI elimina riesgos de privacidad", "es_correcta": false}, {"texto": "No: el modelo local puede guardar logs, la laptop puede ser robada, otros usuarios del equipo pueden acceder al historial, y el principio de minimizacion de datos aplica independientemente de donde corra el modelo", "es_correcta": true}, {"texto": "Parcialmente: solo hay que anonimizar datos de clientes, no internos", "es_correcta": false}, {"texto": "Depende de si la laptop tiene cifrado de disco", "es_correcta": false}]',
'Combina: Edge AI (M7), anonimizacion (M2), y 6 reglas de oro de Shadow AI (M4). La ubicacion del procesamiento no elimina la disciplina de proteccion de datos.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 9),
'Diseñas un formulario en Forms con Copilot para evaluar la satisfaccion de 500 empleados. Quieres analizar los resultados en Excel con Copilot y luego crear una presentacion para el comite. Al analizar en Excel, Copilot genera una formula que dice que la satisfaccion promedio es 4.2/5. Tu revisas manualmente 5 registros al azar y calculas 3.6/5. Que deberias hacer ANTES de investigar la discrepancia?',
'[{"texto": "Confiar en Copilot porque proceso todos los datos", "es_correcta": false}, {"texto": "Confiar en tu muestra manual", "es_correcta": false}, {"texto": "Verificar que los datos en Excel estan formateados como Tabla, que los encabezados son claros, y que no hay celdas vacias o formatos mixtos que puedan confundir a Copilot", "es_correcta": true}, {"texto": "Pedir a Copilot que recalcule", "es_correcta": false}]',
'Combina: Forms (M5), Excel con Copilot (M6), y principio de verificacion. La causa mas probable es que los datos no estan limpios, que es la primera limitacion documentada de Copilot en Excel.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 9),
'Tu colega creo una imagen con Copilot Designer para una publicacion de LinkedIn de la empresa. La imagen muestra ''empleados diversos en una oficina moderna''. El texto del post, generado por Copilot Chat, dice que la empresa fue reconocida por su cultura inclusiva. Ni la foto ni el reconocimiento son reales. Cuantos problemas eticos y practicos hay en esta situacion?',
'[{"texto": "Uno: la foto es generada por IA", "es_correcta": false}, {"texto": "Dos: foto falsa y dato inventado", "es_correcta": false}, {"texto": "Al menos cuatro: personas ficticias presentadas como empleados reales, dato de reconocimiento posiblemente alucinado por la IA, falta de transparencia sobre uso de IA en comunicacion publica, y riesgo reputacional si se descubre", "es_correcta": true}, {"texto": "Tres: foto falsa, dato falso, y falta de disclosure", "es_correcta": false}]',
'Combina: limitaciones de Designer/DALL-E (M5), alucinaciones (diagnostico), etica y transparencia (M4/M7), y regulacion que exige indicar cuando se usa IA. Cada capa agrega un riesgo.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 9),
'Un directivo propone reemplazar el proceso de creacion de propuestas comerciales (que toma 3 dias) con un pipeline de IA que lo haga en 2 horas. El pipeline usaria: agente de Copilot para recopilar info del cliente desde SharePoint, chaining para analizar necesidades y generar la propuesta, template XML para formato estandar, y Designer para imagenes. Tu evaluacion profesional MAS completa es:',
'[{"texto": "Excelente idea, la IA puede hacer todo eso", "es_correcta": false}, {"texto": "El pipeline es viable pero necesita: revision humana entre cada paso del chaining, verificacion de que el agente no invente datos del cliente, anonimizacion si se usan datos de propuestas anteriores como few-shot, y que las imagenes de Designer se marquen como generadas por IA", "es_correcta": true}, {"texto": "Demasiado complejo, mejor usar IA solo para la redaccion final", "es_correcta": false}, {"texto": "Viable si se entrena al equipo primero", "es_correcta": false}]',
'Integra: agentes y sus limitaciones (M6), chaining con validacion (M3), XML/templates (M4), anonimizacion (M2), Designer y transparencia (M5). La respuesta correcta no rechaza la idea sino que agrega las salvaguardas que el curso ensena.');

-- ************************************************************
-- MODULO 2: Prompt Engineering + Seguridad - 5 adicionales (orden=2)
-- Enfoque: aplicacion de GOCE y anonimizacion en escenarios complejos
-- ************************************************************

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 2),
'Un analista escribe este prompt: ''Actua como analista financiero senior. El area de tesoreria necesita un informe del flujo de caja de marzo para el comite directivo. Usa formato ejecutivo con 3 parrafos.'' Al aplicar el framework de 5 componentes expandido, que componente CRITICO falta que podria causar un resultado inapropiado?',
'[{"texto": "Rol, ya que ''analista financiero'' es muy generico", "es_correcta": false}, {"texto": "Restricciones: sin limites sobre que NO incluir, la IA podria agregar proyecciones especulativas, datos sensibles o recomendaciones fuera de su alcance", "es_correcta": true}, {"texto": "Contexto, porque no especifica el mes exacto", "es_correcta": false}, {"texto": "Formato, porque ''3 parrafos'' no es suficiente", "es_correcta": false}]',
'El framework de 5 componentes agrega Restricciones como quinto elemento. Sin restricciones, la IA puede incluir contenido inapropiado para la audiencia o el nivel de confidencialidad.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 2),
'Necesitas anonimizar esta frase para un prompt: ''La gerente de operaciones Maria Lopez reporto que el vuelo AV204 del 15 de marzo tuvo 3 horas de retraso por falla en el motor #2, afectando a 180 pasajeros del programa LifeMiles Gold.'' Cual anonimizacion es INSUFICIENTE?',
'[{"texto": "Reemplazar ''Maria Lopez'' por [GERENTE_AREA] y ''AV204'' por [VUELO]", "es_correcta": true}, {"texto": "Reemplazar nombre, vuelo, fecha exacta, detalle tecnico del motor y categoria de pasajeros", "es_correcta": false}, {"texto": "Generalizar todo: ''Una gerente reporto retraso significativo en un vuelo por problema tecnico, afectando pasajeros frecuentes''", "es_correcta": false}, {"texto": "Usar seudonimizacion: ''Empleada A reporto que el vuelo X tuvo retraso por falla en sistema Y''", "es_correcta": false}]',
'Solo cambiar nombre y vuelo es insuficiente. La fecha exacta, el detalle tecnico (motor #2) y la categoria especifica (Gold) permiten identificar el incidente y las personas. La anonimizacion debe cubrir TODOS los campos identificables.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 2),
'Tu prompt genera un resultado mediocre. Iteraste 3 veces pero sigue sin mejorar. El prompt actual tiene Goal claro, Context detallado, Expectations de formato, y Source definida. Segun el proceso de construccion de prompts, cual es la estrategia de iteracion MAS efectiva en este punto?',
'[{"texto": "Agregar mas contexto al prompt", "es_correcta": false}, {"texto": "Cambiar de herramienta de IA", "es_correcta": false}, {"texto": "Replantear el Goal: quizas el objetivo esta mal definido o es demasiado amplio, y todo el prompt esta optimizando para la pregunta equivocada", "es_correcta": true}, {"texto": "Agregar un ejemplo de formato esperado", "es_correcta": false}]',
'Segun el proceso de construccion de prompts, cuando la iteracion no mejora resultados, hay que volver al inicio del ciclo: replantear si el objetivo mismo es correcto. Los demas componentes no compensan un Goal mal definido.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 2),
'Tu colega aplica la ''prueba de la valla publicitaria'' a un prompt y concluye que es seguro porque no tiene nombres de personas. Sin embargo, el prompt dice: ''Analiza el desempeno del unico piloto que vuela la ruta Bogota-Toronto los martes y jueves.'' Pasa la prueba?',
'[{"texto": "Si, porque no hay nombres ni documentos de identidad", "es_correcta": false}, {"texto": "No, porque la combinacion de ruta unica + dias especificos + rol de piloto identifica a una persona sin necesidad de nombrarla", "es_correcta": true}, {"texto": "Si, porque la ruta y los dias no son datos personales", "es_correcta": false}, {"texto": "Depende de si el piloto es conocido publicamente", "es_correcta": false}]',
'La prueba de la valla publicitaria evalua si alguien podria identificar personas, no solo si hay nombres. La combinacion de atributos unicos puede ser tan identificable como un nombre completo.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 2),
'Copilot empresarial opera dentro del tenant de Microsoft 365 y no entrena con tus datos. Un colega argumenta: ''Entonces no hay diferencia entre pegar un contrato completo o solo las clausulas relevantes.'' Por que esta equivocado?',
'[{"texto": "Porque Copilot podria fallar con documentos largos", "es_correcta": false}, {"texto": "Porque el principio de minimo privilegio aplica independientemente de la seguridad de la herramienta: no compartir mas datos de los necesarios reduce riesgo ante errores de canal, auditorias y exposicion accidental", "es_correcta": true}, {"texto": "Porque Copilot si entrena con algunos datos", "es_correcta": false}, {"texto": "Porque los contratos son confidenciales incluso para herramientas corporativas", "es_correcta": false}]',
'El protocolo de anonimizacion ensena que la seguridad de la herramienta y la higiene del dato son capas complementarias, no sustitutas. El principio de minimo privilegio aplica siempre.');

-- ************************************************************
-- MODULO 3: Few-shot + Chaining - 5 adicionales (orden=3)
-- Enfoque: patrones de encadenamiento, errores en ejemplos
-- ************************************************************

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 3),
'Creas un prompt few-shot para clasificar quejas en 4 categorias: [Equipaje], [Retraso], [Servicio], [Reservas]. Tus 5 ejemplos son: 3 de [Equipaje], 1 de [Retraso], 1 de [Servicio], y ninguno de [Reservas]. Al clasificar una queja real sobre cobro duplicado en la app, la IA dice [Equipaje]. Que regla few-shot violaste?',
'[{"texto": "Cantidad optima: deberian ser solo 3 ejemplos", "es_correcta": false}, {"texto": "Variedad: los ejemplos deben cubrir todas las categorias. Sin ejemplo de [Reservas] y con sesgo hacia [Equipaje], la IA no puede clasificar correctamente fuera de la clase dominante", "es_correcta": true}, {"texto": "Representatividad: los ejemplos no son reales", "es_correcta": false}, {"texto": "Formato consistente: falta estandarizar la estructura", "es_correcta": false}]',
'La regla de variedad dice que los ejemplos deben cubrir todas o la mayoria de las categorias. 3 de 5 ejemplos de la misma categoria sesga las respuestas hacia ella.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 3),
'Tu chain de 3 pasos procesa encuestas de satisfaccion: Paso 1 extrae datos -> Paso 2 clasifica sentimiento -> Paso 3 genera reporte. La instruccion del Paso 2 dice ''clasifica como positivo o negativo'' pero tus ejemplos few-shot incluyen clasificaciones de ''positivo'', ''negativo'' y ''mixto''. Que va a hacer la IA?',
'[{"texto": "Seguir la instruccion e ignorar la categoria ''mixto''", "es_correcta": false}, {"texto": "Imitar los ejemplos y usar tres categorias incluyendo ''mixto'', porque los ejemplos siempre ganan sobre las instrucciones cuando hay contradiccion", "es_correcta": true}, {"texto": "Dar un error por la contradiccion", "es_correcta": false}, {"texto": "Alternar entre 2 y 3 categorias al azar", "es_correcta": false}]',
'Una de las trampas del few-shot: cuando los ejemplos contradicen la instruccion, el modelo imita los ejemplos. Es un error comun documentado en las reglas de few-shot.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 3),
'Necesitas generar un informe mensual que combina datos de ventas (Excel) con feedback de clientes (correos). Diseñas un chain: Paso A analiza ventas, Paso B analiza feedback. Ambos deben alimentar el Paso C que genera el informe unificado. Que patron de chaining estas usando?',
'[{"texto": "Secuencial: A -> B -> C", "es_correcta": false}, {"texto": "Paralelo con merge: A + B -> C, donde dos ramas independientes alimentan un paso final de sintesis", "es_correcta": true}, {"texto": "Condicional: si ventas bajan, incluir feedback", "es_correcta": false}, {"texto": "Loop de refinamiento: borrador -> revision -> final", "es_correcta": false}]',
'El patron paralelo con merge ejecuta ramas independientes que luego convergen. Es el patron correcto cuando dos fuentes de datos distintas deben combinarse en un resultado final.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 3),
'Tu jefe quiere que clasifiques 500 correos de proveedores como ''urgente'', ''informativo'' o ''accion requerida''. Te pide hacerlo zero-shot para ahorrar tiempo. Tu sabes que la clasificacion tiene criterios especificos de tu empresa (ej: cualquier mencion de SLA vencido es ''urgente''). Cual es tu MEJOR argumento?',
'[{"texto": "Zero-shot es mas rapido y el resultado sera similar", "es_correcta": false}, {"texto": "Few-shot con 3-5 ejemplos que reflejen los criterios internos tomara 10 minutos extra de preparacion pero mejorara dramaticamente la consistencia, porque sin ejemplos la IA no conoce las reglas especificas de la empresa", "es_correcta": true}, {"texto": "Mejor hacerlo manualmente para garantizar calidad", "es_correcta": false}, {"texto": "Usar zero-shot con instrucciones muy detalladas del criterio", "es_correcta": false}]',
'La regla practica: cuando el criterio tiene una interpretacion especifica de la organizacion, few-shot supera a zero-shot con instrucciones detalladas, porque los ejemplos anclan el comportamiento.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 3),
'Diseñas un chain para generar un plan de capacitacion: Paso 1 define temas, Paso 2 crea contenido por tema, Paso 3 diseña evaluacion. Segun el tip ''valida antes de avanzar'', decides revisar el output del Paso 1 antes de continuar. Encuentras que uno de los 5 temas propuestos es irrelevante. En vez de regenerar todo el Paso 1, que es lo MAS eficiente?',
'[{"texto": "Ignorar el tema irrelevante y continuar con los 4 buenos", "es_correcta": false}, {"texto": "Editar manualmente el output del Paso 1 eliminando el tema irrelevante y agregando uno correcto, y luego pasar ese output corregido al Paso 2", "es_correcta": true}, {"texto": "Agregar una instruccion al Paso 2 para que ignore ese tema", "es_correcta": false}, {"texto": "Regenerar el Paso 1 completo con un prompt mejor", "es_correcta": false}]',
'La ventaja del chaining es que puedes intervenir entre pasos. Editar el output intermedio es mas eficiente que regenerar o propagar un error con workarounds en pasos posteriores.');

-- ************************************************************
-- MODULO 4: XML/JSON + Shadow AI - 5 adicionales (orden=4)
-- Enfoque: seguridad de templates, riesgos ocultos, estructura
-- ************************************************************

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 4),
'Tu colega creo este template XML reutilizable para el equipo: <contexto>Datos del cliente: [NOMBRE_CLIENTE], contrato #[NUMERO_CONTRATO], monto: [MONTO_USD]</contexto>. Lo comparte en un canal de Teams para que todos lo usen con ChatGPT gratuito en casa. Cuantos riesgos de seguridad hay?',
'[{"texto": "Uno: los datos no estan anonimizados", "es_correcta": false}, {"texto": "Dos: datos sin anonimizar y uso de herramienta no autorizada", "es_correcta": false}, {"texto": "Tres: los placeholders invitan a pegar datos reales, la herramienta destino es gratuita (entrena con datos), y se distribuye sin instrucciones de anonimizacion ni advertencias", "es_correcta": true}, {"texto": "Ninguno, los placeholders protegen los datos", "es_correcta": false}]',
'El template tiene un diseno de seguridad defectuoso: los placeholders invitan a insertar datos reales, la herramienta sugerida es gratuita (Shadow AI), y no incluye protocolo de anonimizacion. Combina problemas de M4 y M2.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 4),
'Segun las estadisticas de Shadow AI, el 77% de empleados comparten datos corporativos en herramientas no autorizadas y el costo promedio de una brecha es $670,000 USD. Tu jefe dice: ''Pero nosotros usamos Copilot, asi que eso no nos aplica.'' Cual es la falla en su razonamiento?',
'[{"texto": "Copilot no es tan seguro como cree", "es_correcta": false}, {"texto": "El 77% incluye a SUS empleados: tener Copilot no impide que personas del equipo usen herramientas gratuitas en paralelo, especialmente para tareas que perciben como rapidas o personales", "es_correcta": true}, {"texto": "Las estadisticas estan desactualizadas", "es_correcta": false}, {"texto": "Solo aplica a empresas sin politica de IA", "es_correcta": false}]',
'Tener herramienta corporativa no elimina Shadow AI. El caso Samsung demostro que incluso empresas tecnologicas enfrentan este problema. La cultura de uso seguro es tan importante como la herramienta.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 4),
'Necesitas crear un prompt estructurado para generar reportes de incidentes que incluyen: datos del evento (fecha, tipo, severidad), personas involucradas, acciones tomadas, y lecciones aprendidas. XML o JSON seria mejor, y por que?',
'[{"texto": "JSON, porque tiene mejor rendimiento", "es_correcta": false}, {"texto": "XML, porque el reporte mezcla secciones narrativas (acciones tomadas, lecciones) con datos estructurados (fecha, tipo), y las etiquetas XML manejan mejor esa combinacion que JSON", "es_correcta": true}, {"texto": "Da igual, ambos producen el mismo resultado", "es_correcta": false}, {"texto": "JSON, porque es mas moderno", "es_correcta": false}]',
'La comparacion del curso dice: XML es mejor para prompts largos con secciones narrativas, JSON es mejor para datos, listas y parametros numericos. Un reporte de incidentes mezcla ambos, pero el componente narrativo domina.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 4),
'El caso Samsung involucro a 3 ingenieros que: pegaron codigo fuente, notas de reunion estrategica, y un reporte tecnico en ChatGPT gratuito. Si estos ingenieros hubieran aplicado una SOLA de las 6 reglas de oro, cual habria prevenido los 3 incidentes?',
'[{"texto": "No usar cuentas personales para IA laboral", "es_correcta": false}, {"texto": "Usar unicamente las herramientas aprobadas por TI: si ChatGPT gratuito no estaba autorizado, ninguno de los 3 habria tenido donde pegar los datos", "es_correcta": true}, {"texto": "Nunca confiar ciegamente en la IA", "es_correcta": false}, {"texto": "Consultar con TI antes de probar nuevas aplicaciones", "es_correcta": false}]',
'La regla #1 (usar solo herramientas aprobadas) es el control mas efectivo porque actua como puerta de entrada. Las demas reglas son capas adicionales, pero si la herramienta no autorizada nunca se usa, el riesgo se elimina de raiz.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 4),
'Creas una plantilla JSON con placeholders para que tu equipo genere agendas de capacitacion con IA. La plantilla incluye: tema, duracion, audiencia, nivel, formato_entrega, y restricciones. Un miembro del equipo la usa pero cambia "audiencia": "[NOMBRE_AREA]" por "audiencia": "Los 12 coordinadores de la regional de Bogota que reportan a Patricia Vega". Que regla del protocolo violo?',
'[{"texto": "Uso de herramienta no autorizada", "es_correcta": false}, {"texto": "Principio de minimizacion y anonimizacion: incluyo cantidad exacta de personas, ubicacion, cargo, nombre de jefe directo, datos que combinados identifican al grupo y su lider", "es_correcta": true}, {"texto": "Formato incorrecto del JSON", "es_correcta": false}, {"texto": "No violo ninguna regla, son datos internos", "es_correcta": false}]',
'El placeholder invitaba a generalizar (ej: "equipo regional de area operativa"), pero el usuario especifico datos que identifican personas. La combinacion de detalles es tan identificable como poner nombres.');

-- ************************************************************
-- MODULO 5: Imagenes + Forms + PowerPoint - 5 adicionales (orden=5)
-- Enfoque: seleccion de herramienta, limitaciones, flujos
-- ************************************************************

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 5),
'Necesitas preparar 3 entregables para una reunion: (1) encuesta previa para recopilar expectativas de los asistentes, (2) presentacion de 10 slides con datos del trimestre, (3) imagen personalizada para la portada. Cual es la secuencia CORRECTA de herramientas y por que importa el orden?',
'[{"texto": "Crear todo en paralelo con Copilot Chat", "es_correcta": false}, {"texto": "Primero Forms para la encuesta (recopila datos), luego Excel para analizar respuestas, despues PowerPoint con los datos verificados, y finalmente Designer para la portada que refleje el contenido", "es_correcta": true}, {"texto": "PowerPoint primero, luego Forms, luego Designer", "es_correcta": false}, {"texto": "Designer primero para definir el estilo visual, luego lo demas", "es_correcta": false}]',
'El orden importa porque cada paso alimenta al siguiente: Forms recopila datos, Excel los analiza, PowerPoint los presenta, y Designer crea la imagen sabiendo el contenido. Invertir el orden genera retrabajo.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 5),
'Tu jefe pide que la presentacion de PowerPoint incluya el logo de la empresa generado por IA ''para que se vea mas moderno''. Por que deberias rechazar esta solicitud especifica?',
'[{"texto": "Porque Copilot no puede crear presentaciones", "es_correcta": false}, {"texto": "Porque DALL-E no puede reproducir logotipos ni marcas registradas con precision; los logos generados tendran errores, y ademas se deben usar los archivos oficiales del manual de marca", "es_correcta": true}, {"texto": "Porque es ilegal generar logos con IA", "es_correcta": false}, {"texto": "Porque los logos generados no tienen suficiente resolucion", "es_correcta": false}]',
'Es una limitacion documentada de DALL-E/Designer: no genera texto legible ni marcas registradas con precision. Los logos siempre deben ser los archivos oficiales.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 5),
'Quieres crear un formulario en Forms para evaluar el conocimiento de tu equipo sobre seguridad de datos. Le pides a Copilot que genere las preguntas. El resultado tiene 15 preguntas, todas de opcion multiple con 3 opciones. Que deberia ajustarse segun las mejores practicas?',
'[{"texto": "Agregar mas preguntas", "es_correcta": false}, {"texto": "Pedir que incluya variedad de tipos de pregunta (escala Likert, texto abierto, seleccion multiple), agregar opcion ''No se/No aplica'', y revisar que la redaccion sea clara para tu audiencia especifica", "es_correcta": true}, {"texto": "Las 15 preguntas de opcion multiple estan bien", "es_correcta": false}, {"texto": "Reducir a 5 preguntas", "es_correcta": false}]',
'Los tips de Forms con Copilot recomiendan: especificar tipos de pregunta variados, incluir opciones de ''Otro'' o ''N/A'', y adaptar el lenguaje a la audiencia. Copilot genera un borrador funcional, no un producto terminado.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 5),
'Generas una imagen en Copilot Designer con este prompt: ''Foto de nuestro equipo de ventas celebrando los resultados del trimestre en la oficina de Bogota.'' La imagen sale bien. Quieres usarla en el newsletter interno. Cual es el problema que probablemente NO estás considerando?',
'[{"texto": "La imagen no tiene suficiente resolucion", "es_correcta": false}, {"texto": "Los empleados reales podrian sentirse incomodos al ver personas ficticias presentadas como su equipo, y se debe incluir nota de que la imagen fue generada con IA", "es_correcta": true}, {"texto": "La imagen podria tener errores de ortografia", "es_correcta": false}, {"texto": "El fondo no coincidira con la oficina real", "es_correcta": false}]',
'La leccion de Designer advierte: nunca usar imagenes generadas como fotos de empleados reales. En comunicaciones internas debe indicarse que es generada con IA. Presentar personas ficticias como reales viola principios de transparencia.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 5),
'Tu equipo discute dos metodos para crear una presentacion sobre resultados trimestrales: Metodo A (generar desde PowerPoint con prompt) vs Metodo B (usar Copilot Chat para crear el archivo). Ambos producen resultados similares. En que situacion concreta es Metodo A claramente superior?',
'[{"texto": "Cuando tienes prisa", "es_correcta": false}, {"texto": "Cuando necesitas iterar rapidamente sobre el diseno y contenido, porque trabajar directamente en PowerPoint da acceso inmediato a herramientas de edicion sin tener que descargar y abrir un archivo generado externamente", "es_correcta": true}, {"texto": "Cuando la presentacion es corta", "es_correcta": false}, {"texto": "No hay diferencia practica", "es_correcta": false}]',
'La leccion documenta que ambos metodos producen resultados similares, pero PowerPoint directo da acceso inmediato a edicion y diseno. Para iteracion rapida, el flujo sin descarga es superior.');

-- ************************************************************
-- MODULO 6: Agentes + Excel con Copilot - 5 adicionales (orden=6)
-- Enfoque: limitaciones arquitectonicas, verificacion de datos
-- ************************************************************

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 6),
'Creaste un agente simple en M365 para responder preguntas sobre politicas de viaje de la empresa. Le subiste el manual como fuente de conocimiento. Un empleado pregunta: ''Cual es el presupuesto maximo para hotel en Nueva York?'' y el agente responde con un monto que era correcto el ano pasado pero fue actualizado hace 2 meses. Que fallo arquitectonico explica esto?',
'[{"texto": "El agente no tiene acceso a internet", "es_correcta": false}, {"texto": "Los agentes simples no aprenden de interacciones pasadas ni actualizan automaticamente sus fuentes: el documento de SharePoint que tiene como fuente esta desactualizado y nadie lo ha reemplazado", "es_correcta": true}, {"texto": "El modelo tiene fecha de corte", "es_correcta": false}, {"texto": "El empleado formulo mal la pregunta", "es_correcta": false}]',
'Los agentes simples NO mejoran automaticamente con el uso y dependen de las fuentes que les subiste. Si el documento esta desactualizado, el agente da informacion obsoleta con total confianza.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 6),
'Tu equipo quiere un agente que: reciba solicitudes de vacaciones, consulte el saldo en SAP, verifique con el calendario del equipo en Outlook, y envie la aprobacion al gerente. Cual de estas acciones NO puede hacer un agente simple (sin codigo)?',
'[{"texto": "Recibir solicitudes en lenguaje natural", "es_correcta": false}, {"texto": "Consultar SAP, porque los agentes simples no acceden a sistemas externos sin conectores configurados por TI", "es_correcta": true}, {"texto": "Verificar el calendario de Outlook", "es_correcta": false}, {"texto": "Redactar un correo de respuesta", "es_correcta": false}]',
'Limitacion clave de agentes simples: no acceden a sistemas externos a Microsoft 365. SAP requiere agentes avanzados con conectores configurados por TI (Copilot Studio).');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 6),
'Copilot en Excel genera una formula BUSCARV para cruzar datos de ventas con datos de costos por ruta. La formula funciona para las primeras 10 filas pero da #N/A en las siguientes. Cual es la causa MAS probable segun las limitaciones documentadas?',
'[{"texto": "BUSCARV tiene un limite de filas", "es_correcta": false}, {"texto": "Los datos no estan formateados como Tabla, o hay inconsistencias de formato entre las hojas (espacios extra, formatos de texto vs numero) que confunden tanto a la formula como a Copilot", "es_correcta": true}, {"texto": "Copilot genero una formula incorrecta", "es_correcta": false}, {"texto": "Excel tiene un bug con BUSCARV", "es_correcta": false}]',
'La primera recomendacion para Copilot en Excel es formatear datos como Tabla con encabezados claros. Inconsistencias de formato son la causa mas comun de errores parciales en formulas.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 6),
'Copilot en Excel analiza tu dataset de 50,000 filas y genera un insight: ''La ruta BOG-MDE tiene el margen mas alto con 23.5%.'' Tu verificacion manual de 5 filas al azar muestra margenes negativos para esa ruta. Antes de reportar el error, que debes revisar?',
'[{"texto": "Si el modelo de Copilot esta actualizado", "es_correcta": false}, {"texto": "Si hay celdas vacias, formatos mixtos en las columnas de costos e ingresos, o si la hoja mezcla datasets no relacionados que Copilot pudo confundir en el calculo", "es_correcta": true}, {"texto": "Si Copilot uso la formula correcta", "es_correcta": false}, {"texto": "Ejecutar el analisis en otra herramienta de IA", "es_correcta": false}]',
'El tip de verificacion dice: revisar datos limpios primero (celdas vacias, formatos mixtos, datasets mezclados). Copilot procesa lo que ve. Si los datos estan sucios, el output sera incorrecto.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 6),
'Un gerente crea un agente de Copilot para su equipo de finanzas y le sube 15 documentos de SharePoint como fuente de conocimiento. El agente responde preguntas sobre presupuestos citando secciones de documentos. Un dia, responde una pregunta sobre politica de gastos mezclando informacion de dos documentos diferentes que se contradicen (uno de 2024 y otro de 2025). Cual es el error de diseno?',
'[{"texto": "El agente necesita un modelo mas potente", "es_correcta": false}, {"texto": "Las fuentes de conocimiento incluyen versiones contradictorias del mismo documento y no hay instrucciones que le digan al agente priorizar el mas reciente o senalar cuando detecte conflictos", "es_correcta": true}, {"texto": "15 documentos son demasiados para un agente", "es_correcta": false}, {"texto": "El agente deberia tener acceso a internet para verificar", "es_correcta": false}]',
'Los agentes no toman decisiones autonomas ni priorizan fuentes por fecha automaticamente. Las instrucciones del agente deben incluir reglas de prioridad y el creador debe curar las fuentes eliminando versiones obsoletas.');

-- ************************************************************
-- MODULO 7: IA personal + Tendencias - 5 adicionales (orden=8)
-- Enfoque: evaluacion critica de herramientas, tendencias
-- ************************************************************

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 8),
'Un amigo te recomienda una app de IA para ''gestionar tus finanzas automaticamente'' que pide acceso a tus cuentas bancarias. Segun los principios del curso, que deberias verificar ANTES de darle acceso?',
'[{"texto": "Que tenga buenas calificaciones en la tienda de apps", "es_correcta": false}, {"texto": "Que datos accede la app, como los procesa, si los usa para entrenar modelos, que pasa si la empresa cierra, y si tiene respaldo de supervision clinica o financiera profesional", "es_correcta": true}, {"texto": "Que sea gratuita", "es_correcta": false}, {"texto": "Que funcione en tu telefono", "es_correcta": false}]',
'La leccion de IA para vida personal advierte: nunca ingresar datos financieros sensibles en herramientas no verificadas. Evaluar flujo de datos, politicas de uso, y respaldo profesional.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 8),
'Segun las 7 tendencias, Gartner predice que el 40% de las aplicaciones empresariales integraran agentes de IA para finales de 2026. Tu director pregunta: ''Entonces debemos reemplazar a nuestros analistas con agentes?'' Cual es la respuesta MAS alineada con la tendencia real?',
'[{"texto": "Si, los agentes son mas eficientes", "es_correcta": false}, {"texto": "No, los agentes son una moda pasajera", "es_correcta": false}, {"texto": "Los agentes autonomos necesitan supervisores humanos y liberan tiempo de tareas repetitivas para que los analistas se enfoquen en decisiones que requieren criterio; el diferenciador es la habilidad humana, no la herramienta", "es_correcta": true}, {"texto": "Depende del costo de licencias", "es_correcta": false}]',
'La tendencia #1 (agentes autonomos) y la #7 (IA como commodity) convergen: los agentes automatizan lo repetitivo, pero el valor diferencial esta en el criterio humano que los supervisa.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 8),
'Usas ChatGPT como ''profesor personal'' para aprender Excel avanzado siguiendo la tecnica de 4 pasos. Completaste los pasos 1 (definir tema y nivel) y 2 (explicacion adaptada). En el paso 3, la IA te da 3 ejercicios pero los 3 son triviales. Que deberia decirle?',
'[{"texto": "Gracias, ya entendi todo", "es_correcta": false}, {"texto": "Pedir que aumente la dificultad progresivamente: ''El ejercicio 1 esta bien como basico, pero necesito que el 2 sea intermedio y el 3 requiera combinar multiples funciones. No me des las respuestas.''", "es_correcta": true}, {"texto": "Buscar ejercicios en YouTube", "es_correcta": false}, {"texto": "Pasar directamente al paso 4 de evaluacion", "es_correcta": false}]',
'La tecnica de profesor personal dice: solicitar ejercicios con dificultad progresiva. Si los 3 son faciles, el paso correcto es iterar la solicitud, no aceptar ni abandonar.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 8),
'La tendencia de ''fatiga del hype'' describe empresas que automatizaron produccion de contenido con IA sin supervision y vieron resultados negativos. Tu equipo genera newsletters semanales completamente con Copilot sin revision humana. Segun esta tendencia, que problemas se estan acumulando?',
'[{"texto": "Los newsletters llegan tarde", "es_correcta": false}, {"texto": "Contenido repetitivo, posibles errores factuales no detectados, perdida de voz de marca autentica, y audiencia que eventualmente identifica el patron generico y deja de leer", "es_correcta": true}, {"texto": "El costo de Copilot se vuelve insostenible", "es_correcta": false}, {"texto": "No hay problema si el contenido es correcto", "es_correcta": false}]',
'La tendencia #6 (fatiga del hype) documenta: contenido generado sin supervision es repetitivo, pierde voz autentica y genera desconfianza. La IA genera el borrador, el humano aporta criterio editorial.');

INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
((SELECT id FROM pruebas WHERE orden = 8),
'Edge AI permite que modelos corran en el dispositivo sin enviar datos a la nube. Tu colega dice: ''Perfecto, ahora puedo usar IA para todo sin preocuparme por nada.'' Ademas de los riesgos de privacidad que ya discutimos, que limitacion PRACTICA de Edge AI esta ignorando?',
'[{"texto": "Edge AI es muy cara", "es_correcta": false}, {"texto": "Los modelos que corren localmente son mas pequenos y especializados, lo que significa que pueden ser menos capaces que los modelos completos en la nube para tareas complejas o generales", "es_correcta": true}, {"texto": "Edge AI no existe todavia", "es_correcta": false}, {"texto": "Solo funciona con Microsoft", "es_correcta": false}]',
'La tendencia #2 (Edge AI) y #3 (modelos especializados) se conectan: los modelos locales son mas pequenos por necesidad. Ganas privacidad y velocidad, pero pierdes capacidad general. No es un reemplazo universal de la nube.');

COMMIT;
