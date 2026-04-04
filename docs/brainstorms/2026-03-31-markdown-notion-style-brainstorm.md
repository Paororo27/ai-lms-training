---
date: 2026-03-31
topic: markdown-notion-style
---

# Markdown Notion-style para LMS

## Que estamos construyendo

Estilizar el renderizado de markdown en la plataforma para que se vea como Notion: tipografia limpia, imagenes centradas con tamaño controlado, listas estilizadas con iconos/espaciado, y soporte de diagramas mermaid renderizados visualmente.

## Estado actual

- `react-markdown` + `remark-gfm` con `prose prose-slate prose-sm`
- Renderizado en un solo archivo: `src/course/modulo.jsx` (lineas 203 y 211)
- Sin soporte de mermaid, sin custom components para imagenes, sin estilos Notion-like
- Tailwind v4 con `@tailwindcss/vite`, sin `tailwind.config.js` dedicado
- Tema CSS en `src/index.css` con variables Avianca

## Decisiones clave

- **Componente reutilizable**: Crear `src/components/rich-markdown.jsx` que encapsule toda la config de react-markdown con custom renderers. Usar en modulo.jsx y cualquier otro lugar que necesite markdown enriquecido.
- **Imagenes**: Custom renderer `img` que centra y limita el ancho (`max-w-lg`, `mx-auto`, `rounded-xl`). Sin libreria extra.
- **Listas**: Subir de `prose-sm` a `prose-base` y customizar con Tailwind prose modifiers para mejor spacing.
- **Mermaid**: Usar `mermaid` (npm) con renderizado lazy. Custom code block renderer que detecta bloques ` ```mermaid ` y los renderiza como SVG.
- **No agregar**: syntax highlighting para otros lenguajes (YAGNI, es un LMS no un IDE).

## Alcance

### Incluido
- Componente `rich-markdown.jsx` con custom renderers
- Imagenes centradas, redondeadas, max-width controlado
- Listas con spacing Notion-like
- Headings con peso visual claro
- Diagramas mermaid renderizados
- Blockquotes estilizados (callout-style)

### Excluido
- Syntax highlighting para codigo
- Editor WYSIWYG
- Table of contents
- Embeds de video inline en markdown

## Open Questions

*Ninguna — alcance definido.*

## Next Steps

-> `/ce:plan` para detallar la implementacion
