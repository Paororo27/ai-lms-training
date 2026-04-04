import { useEffect, useRef, useState } from 'react'
import Markdown from 'react-markdown'
import remarkGfm from 'remark-gfm'

function MermaidBlock({ code }) {
  const ref = useRef(null)
  const [svg, setSvg] = useState('')

  useEffect(() => {
    let cancelled = false
    import('mermaid').then(({ default: mermaid }) => {
      mermaid.initialize({ startOnLoad: false, theme: 'neutral', fontFamily: 'inherit' })
      const id = `mermaid-${Math.random().toString(36).slice(2, 9)}`
      mermaid.render(id, code).then(({ svg }) => {
        if (!cancelled) setSvg(svg)
      }).catch(() => {
        if (!cancelled) setSvg('')
      })
    })
    return () => { cancelled = true }
  }, [code])

  if (!svg) {
    return (
      <pre className="bg-slate-50 border border-slate-200 rounded-xl p-4 text-sm text-slate-600 overflow-x-auto">
        <code>{code}</code>
      </pre>
    )
  }

  return (
    <div
      ref={ref}
      className="my-6 flex justify-center [&>svg]:max-w-full"
      dangerouslySetInnerHTML={{ __html: svg }}
    />
  )
}

const components = {
  h1: ({ children }) => (
    <h1 className="text-2xl font-extrabold text-avianca-dark mt-8 mb-4 pb-2 border-b border-slate-200">
      {children}
    </h1>
  ),
  h2: ({ children }) => (
    <h2 className="text-xl font-bold text-avianca-dark mt-7 mb-3">{children}</h2>
  ),
  h3: ({ children }) => (
    <h3 className="text-lg font-semibold text-avianca-dark mt-5 mb-2">{children}</h3>
  ),
  p: ({ children }) => (
    <p className="text-slate-700 leading-relaxed mb-4">{children}</p>
  ),
  img: ({ src, alt }) => (
    <figure className="my-6 flex flex-col items-center">
      <img
        src={src}
        alt={alt || ''}
        className="max-w-lg w-full rounded-xl shadow-sm border border-slate-100"
        loading="lazy"
      />
      {alt && <figcaption className="mt-2 text-xs text-slate-400 text-center">{alt}</figcaption>}
    </figure>
  ),
  ul: ({ children }) => (
    <ul className="my-3 ml-1 space-y-1.5 list-none">{children}</ul>
  ),
  ol: ({ children }) => (
    <ol className="my-3 ml-1 space-y-1.5 list-decimal list-inside marker:text-slate-400 marker:font-semibold">{children}</ol>
  ),
  li: ({ children, ordered }) => (
    <li className={`text-slate-700 leading-relaxed ${!ordered ? 'flex items-start gap-2' : ''}`}>
      {!ordered && <span className="mt-1.5 w-1.5 h-1.5 rounded-full bg-avianca-cyan shrink-0" />}
      <span>{children}</span>
    </li>
  ),
  blockquote: ({ children }) => (
    <blockquote className="my-4 border-l-4 border-avianca-cyan bg-avianca-soft-cyan rounded-r-xl px-5 py-3 text-slate-600 [&>p]:mb-0">
      {children}
    </blockquote>
  ),
  a: ({ href, children }) => (
    <a href={href} target="_blank" rel="noopener noreferrer" className="text-avianca-blue hover:underline font-medium">
      {children}
    </a>
  ),
  table: ({ children }) => (
    <div className="my-4 overflow-x-auto rounded-xl border border-slate-200">
      <table className="w-full text-sm">{children}</table>
    </div>
  ),
  thead: ({ children }) => (
    <thead className="bg-slate-50 text-left">{children}</thead>
  ),
  th: ({ children }) => (
    <th className="px-4 py-2.5 font-semibold text-slate-600 border-b border-slate-200">{children}</th>
  ),
  td: ({ children }) => (
    <td className="px-4 py-2.5 text-slate-700 border-b border-slate-100">{children}</td>
  ),
  hr: () => <hr className="my-8 border-slate-200" />,
  code: ({ children, className }) => {
    const isMermaid = className === 'language-mermaid'
    if (isMermaid) {
      return <MermaidBlock code={String(children).trim()} />
    }
    if (className) {
      return (
        <code className={`${className} block bg-slate-50 border border-slate-200 rounded-xl p-4 text-sm text-slate-700 overflow-x-auto my-4`}>
          {children}
        </code>
      )
    }
    return (
      <code className="bg-slate-100 text-avianca-magenta px-1.5 py-0.5 rounded text-sm font-mono">
        {children}
      </code>
    )
  },
  pre: ({ children }) => {
    if (children?.props?.className === 'language-mermaid') {
      return <>{children}</>
    }
    return (
      <pre className="bg-slate-50 border border-slate-200 rounded-xl p-4 text-sm overflow-x-auto my-4">
        {children}
      </pre>
    )
  },
}

export default function RichMarkdown({ children }) {
  return (
    <div className="rich-markdown max-w-none">
      <Markdown remarkPlugins={[remarkGfm]} components={components}>
        {children}
      </Markdown>
    </div>
  )
}
