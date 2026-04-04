Convierte texto plano en markdown optimizado para el componente RichMarkdown de la plataforma LMS con formato Notion-style.

## Proceso

1. El usuario pega o describe el contenido fuente
2. Analizar estructura: identificar secciones, listas, conceptos clave, y puntos donde agregar diagramas o imagenes
3. **Buscar imagenes**: Para cada seccion o concepto principal, usar WebSearch para encontrar imagenes publicas relevantes (diagramas, infografias, ilustraciones) que refuercen la explicacion. Buscar en ingles y español para mejores resultados.
4. Generar markdown optimizado usando las convenciones del componente RichMarkdown
5. Guardar el archivo en `texts/<nombre-descriptivo>.md`
6. Mostrar el markdown generado para revision

## Busqueda de imagenes (OBLIGATORIO)

Para cada seccion principal del contenido, DEBES buscar al menos una imagen publica que refuerce el concepto. Sigue estos pasos:

1. **Identificar conceptos visualizables**: Para cada seccion `##`, determinar que concepto se beneficia de una imagen (diagrama, infografia, captura, ilustracion)
2. **Buscar con WebSearch**: Usar queries como:
   - `"<concepto>" infographic PNG`
   - `"<concepto>" diagram illustration`
   - `"<concepto>" visual explanation`
3. **Validar la URL**: Verificar que la URL de la imagen es publica y accesible (dominio confiable, extension de imagen visible como .png, .jpg, .svg, .webp)
4. **Preferir fuentes confiables**: Wikipedia Commons, Unsplash, publicaciones tecnicas, blogs reconocidos, documentacion oficial
5. **Insertar con alt descriptivo**: `![Descripcion clara del contenido visual](url-directa-imagen)`

Si no se encuentra una imagen adecuada para una seccion, usar un diagrama mermaid en su lugar. Nunca dejar una seccion sin apoyo visual (imagen o mermaid).

## Convenciones de formato

El componente `RichMarkdown` (`src/components/rich-markdown.jsx`) renderiza estos elementos con estilos Notion-like:

- `# H1` — extra bold con border-bottom
- `## H2` — bold
- `### H3` — semibold
- `![alt](url)` — imagenes centradas con caption del alt text
- `- item` — listas con dot cyan, sin bullets nativos
- `1. item` — listas numeradas con marker slate
- `> texto` — blockquote estilo callout cyan
- ` ```mermaid ` — diagramas mermaid renderizados como SVG
- `| col |` — tablas con bordes redondeados y header con fondo
- `` `code` `` — inline code con fondo slate y color magenta
- `---` — separador horizontal

## Estructura recomendada para lecciones

```
# Titulo de la leccion

Parrafo introductorio que contextualiza el tema.

## Concepto principal

Explicacion clara y concisa.

> Punto clave que el estudiante debe recordar.

![Diagrama que ilustra el concepto](url-imagen-publica)

## Paso a paso

1. Primer paso
2. Segundo paso
3. Tercer paso

![Captura o infografia del proceso](url-imagen-publica)

## Resumen

- Punto clave 1
- Punto clave 2
- Punto clave 3
```

## Reglas

- Usar emojis como recurso grafico en headings, listas, tablas y blockquotes para reforzar el mensaje visual
- OBLIGATORIO: Escribir con ortografía correcta incluyendo tildes (á, é, í, ó, ú, ñ). El contenido es educativo y debe ser impecable
- En diagramas mermaid, NUNCA usar `color:white` en estilos — no funciona en block-beta. Usar colores de fondo claros/pastel (ej: `#93c5fd`, `#86efac`, `#94a3b8`, `#fca5a5`) que se lean bien con texto oscuro por defecto
- Parrafos cortos (3-4 lineas max)
- Un concepto por seccion
- Usar blockquotes para tips, advertencias o datos clave
- Usar mermaid cuando un flujo o proceso se explica mejor visualmente
- Las imagenes siempre llevan texto alt descriptivo
- SIEMPRE buscar imagenes publicas para cada seccion principal
- Idioma: el mismo que el texto fuente

## Input del usuario

$ARGUMENTS
