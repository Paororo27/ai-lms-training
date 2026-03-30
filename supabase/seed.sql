-- ============================================================
-- Seed data para desarrollo y testing
-- ============================================================

-- Modulos del taller (6 modulos en 4 semanas)
INSERT INTO modulos (orden, semana, titulo, descripcion, contenido, duracion_minutos) VALUES
(1, 1, 'Fundamentos de Copilot', 'Que es Copilot Chat, como acceder, interfaz y primeros prompts.', '{}', 30),
(2, 1, 'Prompt Engineering', 'Tecnicas de prompting: contexto, rol, formato, cadena de pensamiento.', '{}', 30),
(3, 2, 'Productividad Real', 'Casos de uso: resumenes, emails, analisis de datos, automatizacion.', '{}', 30),
(4, 2, 'Inteligencia de Datos', 'Analisis de informacion con Copilot, Excel, extraccion de insights.', '{}', 30),
(5, 3, 'Etica y Seguridad en IA', 'Uso responsable, proteccion de info empresarial, control humano.', '{}', 30),
(6, 3, 'IA para RR.HH. y mas alla', 'Herramientas IA para gestion de talento y uso personal.', '{}', 30);

-- Lecciones del modulo 1 (ejemplo)
INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
(1, 1, 'Que es Copilot Chat', 'video', '{"media_url": "dQw4w9WgXcQ", "texto": "Copilot Chat es un asistente de IA integrado en Microsoft 365..."}', 10),
(1, 2, 'Accediendo a Copilot', 'texto', '{"texto": "Para acceder a Copilot Chat, abre Microsoft Teams y busca el icono de Copilot en la barra lateral..."}', 5),
(1, 3, 'Tu primer prompt', 'ejercicio', '{"instrucciones": "Abre Copilot Chat y escribe: Hazme un resumen de las principales funciones de Copilot. Observa la respuesta y marca como completado.", "texto": "Practica enviando tu primer mensaje a Copilot."}', 15);

-- Lecciones del modulo 2 (ejemplo)
INSERT INTO lecciones (modulo_id, orden, titulo, tipo, contenido, duracion_minutos) VALUES
(2, 1, 'Que es un prompt', 'video', '{"media_url": "dQw4w9WgXcQ", "texto": "Un prompt es la instruccion que le das a la IA..."}', 10),
(2, 2, 'Tecnicas basicas de prompting', 'texto', '{"texto": "Las tecnicas fundamentales incluyen: dar contexto, asignar un rol, especificar formato de salida..."}', 10),
(2, 3, 'Ejercicio: Mejora tu prompt', 'ejercicio', '{"instrucciones": "Toma un email que necesites escribir. Pidele a Copilot que lo redacte. Luego mejora el prompt agregando contexto y tono. Compara ambas respuestas.", "texto": "Practica la iteracion de prompts."}', 10);

-- Pruebas (diagnosticos + modulares)
INSERT INTO pruebas (modulo_id, tipo, titulo, preguntas_por_intento, puntaje_aprobatorio, orden) VALUES
(NULL, 'diagnostico_pre', 'Diagnostico de entrada', 5, 0, 0),
(1, 'modular', 'Prueba: Fundamentos de Copilot', 5, 80, 1),
(2, 'modular', 'Prueba: Prompt Engineering', 5, 80, 2),
(3, 'modular', 'Prueba: Productividad Real', 5, 80, 3),
(4, 'modular', 'Prueba: Inteligencia de Datos', 5, 80, 4),
(5, 'modular', 'Prueba: Etica y Seguridad', 5, 80, 5),
(6, 'modular', 'Prueba: IA para RR.HH.', 5, 80, 6),
(NULL, 'diagnostico_post', 'Diagnostico de salida', 5, 0, 7);

-- Preguntas de ejemplo para diagnostico pre (banco de 10 para 5 por intento)
INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
(1, 'Que es la inteligencia artificial?',
 '[{"texto": "Un programa que imita la inteligencia humana", "es_correcta": true}, {"texto": "Un tipo de hardware", "es_correcta": false}, {"texto": "Una red social", "es_correcta": false}, {"texto": "Un sistema operativo", "es_correcta": false}]',
 'La IA es un campo de la informatica que busca crear sistemas capaces de realizar tareas que normalmente requieren inteligencia humana.'),
(1, 'Que es un chatbot?',
 '[{"texto": "Un robot fisico", "es_correcta": false}, {"texto": "Un programa que simula conversacion", "es_correcta": true}, {"texto": "Un tipo de virus", "es_correcta": false}, {"texto": "Una base de datos", "es_correcta": false}]',
 'Un chatbot es un programa disenado para simular conversaciones con usuarios humanos.'),
(1, 'Cual de estas es una herramienta de IA?',
 '[{"texto": "Microsoft Word", "es_correcta": false}, {"texto": "ChatGPT", "es_correcta": true}, {"texto": "Windows", "es_correcta": false}, {"texto": "Excel basico", "es_correcta": false}]',
 'ChatGPT es un modelo de lenguaje de OpenAI, una de las herramientas de IA mas conocidas.'),
(1, 'Que significa IA generativa?',
 '[{"texto": "IA que genera contenido nuevo", "es_correcta": true}, {"texto": "IA que solo analiza datos", "es_correcta": false}, {"texto": "IA que genera electricidad", "es_correcta": false}, {"texto": "IA que elimina archivos", "es_correcta": false}]',
 'La IA generativa crea contenido nuevo como texto, imagenes o codigo basandose en patrones aprendidos.'),
(1, 'Que es Microsoft Copilot?',
 '[{"texto": "Un sistema operativo", "es_correcta": false}, {"texto": "Un asistente de IA integrado en Microsoft 365", "es_correcta": true}, {"texto": "Un navegador web", "es_correcta": false}, {"texto": "Una impresora virtual", "es_correcta": false}]',
 'Microsoft Copilot es un asistente de IA que se integra en las aplicaciones de Microsoft 365.'),
(1, 'Que es un prompt?',
 '[{"texto": "Una pantalla de computador", "es_correcta": false}, {"texto": "Una instruccion dada a la IA", "es_correcta": true}, {"texto": "Un tipo de archivo", "es_correcta": false}, {"texto": "Un cable de red", "es_correcta": false}]',
 'Un prompt es la instruccion o pregunta que el usuario le da a un sistema de IA para obtener una respuesta.'),
(1, 'Cual es un riesgo del uso de IA en empresas?',
 '[{"texto": "Que la IA tome vacaciones", "es_correcta": false}, {"texto": "Compartir informacion confidencial", "es_correcta": true}, {"texto": "Que consuma mucha electricidad", "es_correcta": false}, {"texto": "Que hable con otros programas", "es_correcta": false}]',
 'Uno de los principales riesgos es compartir informacion confidencial de la empresa con herramientas de IA externas.'),
(1, 'Que es Machine Learning?',
 '[{"texto": "Un tipo de machine fisica", "es_correcta": false}, {"texto": "Aprendizaje automatico basado en datos", "es_correcta": true}, {"texto": "Un lenguaje de programacion", "es_correcta": false}, {"texto": "Una red social profesional", "es_correcta": false}]',
 'Machine Learning es una rama de la IA donde los sistemas aprenden de datos sin ser programados explicitamente.'),
(1, 'Para que sirve la IA en RR.HH.?',
 '[{"texto": "Solo para despedir empleados", "es_correcta": false}, {"texto": "Para automatizar tareas repetitivas y mejorar procesos", "es_correcta": true}, {"texto": "Para reemplazar a todos los empleados", "es_correcta": false}, {"texto": "No tiene uso en RR.HH.", "es_correcta": false}]',
 'La IA en RR.HH. ayuda a automatizar procesos como seleccion, nomina y analisis de datos de talento.'),
(1, 'Que es la etica en IA?',
 '[{"texto": "Usar IA solo en horario laboral", "es_correcta": false}, {"texto": "Principios para el uso responsable de la IA", "es_correcta": true}, {"texto": "Un tipo de licencia de software", "es_correcta": false}, {"texto": "Una marca de computadoras", "es_correcta": false}]',
 'La etica en IA se refiere a los principios y guias para usar la inteligencia artificial de manera responsable y justa.');

-- Preguntas de ejemplo para prueba modulo 1 (banco de 10)
INSERT INTO preguntas (prueba_id, texto, opciones, explicacion) VALUES
(2, 'Donde se accede a Copilot Chat?',
 '[{"texto": "En Microsoft Teams", "es_correcta": true}, {"texto": "En el Panel de Control", "es_correcta": false}, {"texto": "En el Bloc de Notas", "es_correcta": false}, {"texto": "En la Calculadora", "es_correcta": false}]',
 'Copilot Chat esta disponible en Microsoft Teams y otras aplicaciones de Microsoft 365.'),
(2, 'Que tipo de respuestas puede dar Copilot?',
 '[{"texto": "Solo numeros", "es_correcta": false}, {"texto": "Texto, resumenes, codigo y mas", "es_correcta": true}, {"texto": "Solo imagenes", "es_correcta": false}, {"texto": "Solo archivos PDF", "es_correcta": false}]',
 'Copilot puede generar diversos tipos de contenido incluyendo texto, resumenes, codigo y analisis.'),
(2, 'Copilot reemplaza el trabajo humano?',
 '[{"texto": "Si, completamente", "es_correcta": false}, {"texto": "No, es un asistente que complementa", "es_correcta": true}, {"texto": "Solo en matematicas", "es_correcta": false}, {"texto": "Solo los fines de semana", "es_correcta": false}]',
 'Copilot es un asistente que complementa el trabajo humano, no lo reemplaza. Siempre requiere supervision.'),
(2, 'Que limitacion tiene Copilot?',
 '[{"texto": "No tiene ninguna", "es_correcta": false}, {"texto": "Puede generar informacion incorrecta", "es_correcta": true}, {"texto": "Solo funciona en ingles", "es_correcta": false}, {"texto": "No puede escribir texto", "es_correcta": false}]',
 'Como toda IA, Copilot puede generar informacion incorrecta (alucinaciones). Es importante verificar sus respuestas.'),
(2, 'Que es una alucinacion en IA?',
 '[{"texto": "Cuando la IA se apaga", "es_correcta": false}, {"texto": "Cuando genera informacion falsa como si fuera real", "es_correcta": true}, {"texto": "Cuando habla en otro idioma", "es_correcta": false}, {"texto": "Cuando tarda mucho en responder", "es_correcta": false}]',
 'Una alucinacion es cuando la IA genera contenido que parece real pero es incorrecto o inventado.'),
(2, 'Para que sirve Copilot en el dia a dia?',
 '[{"texto": "Solo para jugar", "es_correcta": false}, {"texto": "Para resumir, redactar, analizar y automatizar tareas", "es_correcta": true}, {"texto": "Solo para hacer presentaciones", "es_correcta": false}, {"texto": "Solo para enviar emails", "es_correcta": false}]',
 'Copilot sirve para multiples tareas diarias: resumir documentos, redactar textos, analizar datos y automatizar procesos.'),
(2, 'Que debes verificar siempre despues de usar Copilot?',
 '[{"texto": "El color de la respuesta", "es_correcta": false}, {"texto": "La precision y veracidad de la informacion", "es_correcta": true}, {"texto": "El tamano del archivo", "es_correcta": false}, {"texto": "La hora de la respuesta", "es_correcta": false}]',
 'Siempre debes verificar que la informacion generada por Copilot sea precisa y veraz antes de usarla.'),
(2, 'Copilot puede acceder a tus archivos de trabajo?',
 '[{"texto": "No, nunca", "es_correcta": false}, {"texto": "Si, a los archivos dentro de tu Microsoft 365", "es_correcta": true}, {"texto": "Solo a archivos de imagen", "es_correcta": false}, {"texto": "Solo si estan en USB", "es_correcta": false}]',
 'Copilot puede acceder a los archivos y datos dentro de tu entorno de Microsoft 365 para proporcionar respuestas contextualizadas.'),
(2, 'Cual es la mejor practica al usar Copilot?',
 '[{"texto": "Copiar todo sin revisar", "es_correcta": false}, {"texto": "Ser especifico en las instrucciones y verificar", "es_correcta": true}, {"texto": "Usarlo solo una vez al mes", "es_correcta": false}, {"texto": "Nunca dar contexto", "es_correcta": false}]',
 'La mejor practica es dar instrucciones claras y especificas, y siempre verificar el resultado.'),
(2, 'Que pasa si le das informacion confidencial a Copilot?',
 '[{"texto": "Nada, es seguro porque es Microsoft", "es_correcta": false}, {"texto": "Depende de la configuracion de seguridad de la empresa", "es_correcta": true}, {"texto": "Se borra automaticamente", "es_correcta": false}, {"texto": "Se publica en internet", "es_correcta": false}]',
 'La seguridad depende de la configuracion empresarial. Siempre sigue las politicas de tu empresa sobre informacion confidencial.');

-- Retos de ejemplo
INSERT INTO retos (titulo, escenario, criterios_evaluacion) VALUES
('Automatizacion de proceso de seleccion',
 'Tu equipo de seleccion recibe 50 hojas de vida por semana para una posicion. Actualmente, un analista dedica 3 horas revisando cada lote. Describe paso a paso como usarias Copilot Chat para optimizar este proceso. Incluye los prompts exactos que usarias y explica como verificarias los resultados.',
 '["Claridad del proceso propuesto", "Calidad de los prompts", "Consideracion de riesgos y verificacion", "Ahorro de tiempo estimado"]'),
('Reporte de clima organizacional',
 'Tienes los resultados de una encuesta de clima organizacional con 500 respuestas abiertas. Tu jefe necesita un resumen ejecutivo para manana. Describe como usarias Copilot y otras herramientas de IA para analizar las respuestas, identificar patrones y generar el reporte. Incluye prompts y pasos de verificacion.',
 '["Proceso de analisis propuesto", "Uso efectivo de Copilot", "Verificacion de resultados", "Presentacion del reporte"]'),
('Capacitacion con IA para el equipo',
 'Te piden disenar un plan de capacitacion de 2 horas sobre uso basico de IA para un equipo de 20 personas de nomina que nunca han usado herramientas de IA. Describe como usarias Copilot para crear el contenido, las actividades practicas que incluirias, y como mediras el aprendizaje.',
 '["Estructura del plan de capacitacion", "Uso de Copilot en la creacion de contenido", "Actividades practicas relevantes", "Metricas de aprendizaje"]'),
('Optimizacion de comunicaciones internas',
 'Tu area envia 15 comunicados al mes a diferentes publicos (operaciones, administrativos, tripulaciones). Cada uno toma 2 horas de redaccion y revision. Propone un flujo de trabajo con Copilot para reducir este tiempo a la mitad. Incluye prompts, plantillas y controles de calidad.',
 '["Flujo de trabajo propuesto", "Prompts y plantillas", "Controles de calidad", "Estimacion de ahorro de tiempo"]'),
('Analisis de rotacion de personal',
 'Los ultimos 6 meses has notado un aumento del 15% en la rotacion de personal en areas operativas. Tienes acceso a datos de salida, encuestas de clima y metricas de desempeno. Describe como usarias Copilot y herramientas de IA para analizar la situacion, identificar causas raiz y proponer acciones. Detalla los prompts y la estrategia de analisis.',
 '["Enfoque analitico", "Uso de datos disponibles", "Prompts para analisis", "Propuestas de accion basadas en hallazgos"]');
