import { useEffect, useState } from 'react'
import { useParams, useNavigate } from 'react-router'
import { supabase } from '../lib/supabase'
import { useAuth } from '../context/auth-context'
import { CheckCircle, Circle, Play, FileText, Wrench, Gamepad2, ExternalLink, ChevronLeft, ChevronRight, ArrowRight } from 'lucide-react'
import Markdown from 'react-markdown'
import remarkGfm from 'remark-gfm'
import 'lite-youtube-embed'
import 'lite-youtube-embed/src/lite-yt-embed.css'

export default function Modulo() {
  const { id } = useParams()
  const { user } = useAuth()
  const navigate = useNavigate()
  const [modulo, setModulo] = useState(null)
  const [lecciones, setLecciones] = useState([])
  const [progresoMap, setProgresoMap] = useState({})
  const [currentIdx, setCurrentIdx] = useState(0)
  const [loading, setLoading] = useState(true)
  const [marking, setMarking] = useState(false)

  useEffect(() => {
    if (!user || !id) return
    loadModulo()
  }, [user, id])

  const loadModulo = async () => {
    const [moduloRes, leccionesRes, progresoRes] = await Promise.all([
      supabase.from('modulos').select('*').eq('id', id).single(),
      supabase.from('lecciones').select('*').eq('modulo_id', id).order('orden'),
      supabase.from('progreso_usuario').select('leccion_id, completado')
        .eq('usuario_id', user.id),
    ])

    setModulo(moduloRes.data)
    setLecciones(leccionesRes.data || [])

    const map = {}
    ;(progresoRes.data || []).forEach(p => { map[p.leccion_id] = p.completado })
    setProgresoMap(map)

    // Ir a la primera leccion no completada
    const firstIncomplete = (leccionesRes.data || []).findIndex(l => !map[l.id])
    setCurrentIdx(firstIncomplete >= 0 ? firstIncomplete : 0)
    setLoading(false)
  }

  const markComplete = async (leccionId) => {
    setMarking(true)
    const { error } = await supabase.from('progreso_usuario').upsert(
      { usuario_id: user.id, leccion_id: leccionId, completado: true, completado_at: new Date().toISOString() },
      { onConflict: 'usuario_id,leccion_id' }
    )
    if (!error) {
      setProgresoMap(prev => ({ ...prev, [leccionId]: true }))
    }
    setMarking(false)
  }

  if (loading) {
    return (
      <div className="flex justify-center py-20">
        <div className="animate-spin rounded-full h-8 w-8 border-t-2 border-avianca-cyan" />
      </div>
    )
  }

  if (!modulo) {
    return <p className="text-center text-slate-500 py-20">Modulo no encontrado.</p>
  }

  const current = lecciones[currentIdx]
  const isComplete = current ? progresoMap[current.id] : false
  const allComplete = lecciones.every(l => progresoMap[l.id])
  const completedCount = lecciones.filter(l => progresoMap[l.id]).length

  const TIPO_ICONS = { video: Play, texto: FileText, ejercicio: Wrench, recurso_externo: Gamepad2 }
  const TIPO_LABELS = { video: 'Video', texto: 'Lectura', ejercicio: 'Ejercicio practico', recurso_externo: 'Actividad interactiva' }

  return (
    <div className="space-y-6">
      {/* Header del modulo */}
      <div className="flex items-center justify-between">
        <div>
          <button onClick={() => navigate('/course')} className="text-sm text-slate-500 hover:text-avianca-dark flex items-center gap-1 mb-1 cursor-pointer">
            <ChevronLeft className="w-4 h-4" /> Dashboard
          </button>
          <h1 className="text-xl font-bold text-avianca-dark">{modulo.titulo}</h1>
          <p className="text-sm text-slate-500 mt-0.5">
            Semana {modulo.semana} &middot; {completedCount}/{lecciones.length} lecciones
          </p>
        </div>
      </div>

      <div className="flex flex-col lg:flex-row gap-6">
        {/* Sidebar: lista de lecciones */}
        <div className="lg:w-64 shrink-0">
          <div className="bg-white rounded-xl border border-slate-200 overflow-hidden">
            <div className="px-4 py-3 border-b border-slate-100">
              <p className="text-xs font-semibold text-slate-500 uppercase tracking-wider">Lecciones</p>
            </div>
            <nav className="divide-y divide-slate-100">
              {lecciones.map((leccion, idx) => {
                const done = progresoMap[leccion.id]
                const isCurrent = idx === currentIdx
                const Icon = TIPO_ICONS[leccion.tipo] || FileText

                return (
                  <button
                    key={leccion.id}
                    onClick={() => setCurrentIdx(idx)}
                    className={`w-full text-left px-4 py-3 flex items-center gap-3 transition-colors cursor-pointer ${
                      isCurrent ? 'bg-avianca-cyan/10' : 'hover:bg-slate-50'
                    }`}
                  >
                    {done ? (
                      <CheckCircle className="w-4 h-4 text-avianca-green shrink-0" />
                    ) : (
                      <Circle className={`w-4 h-4 shrink-0 ${isCurrent ? 'text-avianca-cyan' : 'text-slate-300'}`} />
                    )}
                    <div className="min-w-0">
                      <p className={`text-sm truncate ${isCurrent ? 'font-semibold text-avianca-dark' : 'text-slate-600'}`}>
                        {leccion.titulo}
                      </p>
                      <p className="text-[10px] text-slate-400 flex items-center gap-1 mt-0.5">
                        <Icon className="w-3 h-3" /> {TIPO_LABELS[leccion.tipo]} &middot; {leccion.duracion_minutos} min
                      </p>
                    </div>
                  </button>
                )
              })}
            </nav>
          </div>

          {/* Boton prueba */}
          {allComplete && (
            <button
              onClick={() => navigate(`/course/modulo/${id}/prueba`)}
              className="w-full mt-3 py-3 bg-gradient-to-r from-avianca-red to-avianca-magenta text-white font-semibold rounded-xl hover:opacity-90 transition-all flex items-center justify-center gap-2 cursor-pointer"
            >
              Ir a la prueba <ArrowRight className="w-4 h-4" />
            </button>
          )}
        </div>

        {/* Contenido principal */}
        {current && (
          <div className="flex-1 min-w-0">
            <div className="bg-white rounded-2xl border border-slate-200 overflow-hidden">
              {/* Tipo badge */}
              <div className="px-6 py-3 border-b border-slate-100 flex items-center justify-between">
                <div className="flex items-center gap-2">
                  {(() => { const I = TIPO_ICONS[current.tipo]; return <I className="w-4 h-4 text-slate-400" /> })()}
                  <span className="text-xs font-medium text-slate-500">{TIPO_LABELS[current.tipo]}</span>
                </div>
                <span className="text-xs text-slate-400">{current.duracion_minutos} min</span>
              </div>

              {/* Titulo */}
              <div className="px-6 pt-5 pb-4">
                <h2 className="text-lg font-bold text-avianca-dark">{current.titulo}</h2>
              </div>

              {/* Contenido segun tipo */}
              <div className="px-6 pb-6">
                {current.tipo === 'video' && current.contenido?.media_url && (
                  <div className="mb-4 rounded-xl overflow-hidden">
                    <lite-youtube videoid={current.contenido.media_url} />
                  </div>
                )}

                {current.tipo === 'recurso_externo' && current.contenido?.url && current.contenido?.modo !== 'redireccion' && (
                  <div className="mb-4 relative w-full max-w-[795px]" style={{ aspectRatio: '795/690' }}>
                    <div className="absolute inset-0 flex items-center justify-center bg-slate-100 rounded-xl">
                      <div className="animate-spin rounded-full h-8 w-8 border-t-2 border-avianca-cyan" />
                    </div>
                    <iframe
                      src={current.contenido.url}
                      sandbox="allow-scripts allow-same-origin allow-popups"
                      allow="fullscreen"
                      referrerPolicy="strict-origin-when-cross-origin"
                      onLoad={(e) => e.target.previousElementSibling?.remove()}
                      className="absolute inset-0 w-full h-full border-0 rounded-xl"
                    />
                  </div>
                )}

                {current.tipo === 'recurso_externo' && current.contenido?.url && current.contenido?.modo === 'redireccion' && (
                  <div className="mb-4">
                    <a
                      href={current.contenido.url}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="inline-flex items-center gap-2 px-6 py-3 bg-gradient-to-r from-avianca-cyan to-avianca-blue text-white font-semibold rounded-xl hover:opacity-90 transition-opacity"
                    >
                      <ExternalLink className="w-5 h-5" />
                      Ir al recurso externo
                    </a>
                  </div>
                )}

                {current.contenido?.texto && (
                  <div className="prose prose-slate prose-sm max-w-none">
                    <Markdown remarkPlugins={[remarkGfm]}>{current.contenido.texto}</Markdown>
                  </div>
                )}

                {current.tipo === 'ejercicio' && current.contenido?.instrucciones && (
                  <div className="mt-4 bg-avianca-cyan/5 border border-avianca-cyan/20 rounded-xl p-5">
                    <h3 className="font-semibold text-avianca-dark text-sm mb-2">Instrucciones del ejercicio</h3>
                    <div className="text-sm text-slate-600 prose prose-sm max-w-none">
                      <Markdown remarkPlugins={[remarkGfm]}>{current.contenido.instrucciones}</Markdown>
                    </div>
                  </div>
                )}
              </div>

              {/* Acciones */}
              <div className="px-6 pb-6 flex items-center justify-between gap-3">
                <button
                  onClick={() => setCurrentIdx(Math.max(0, currentIdx - 1))}
                  disabled={currentIdx === 0}
                  className="px-4 py-2 text-sm text-slate-500 hover:text-avianca-dark disabled:opacity-30 flex items-center gap-1 cursor-pointer disabled:cursor-not-allowed"
                >
                  <ChevronLeft className="w-4 h-4" /> Anterior
                </button>

                <div className="flex items-center gap-3">
                  {!isComplete && (
                    <button
                      onClick={() => markComplete(current.id)}
                      disabled={marking}
                      className="px-5 py-2.5 bg-avianca-green text-white text-sm font-medium rounded-xl hover:opacity-90 disabled:opacity-50 flex items-center gap-2 cursor-pointer"
                    >
                      <CheckCircle className="w-4 h-4" />
                      {marking ? 'Guardando...' : 'Marcar como completado'}
                    </button>
                  )}

                  {currentIdx < lecciones.length - 1 && (
                    <button
                      onClick={() => setCurrentIdx(currentIdx + 1)}
                      className="px-4 py-2 text-sm text-avianca-cyan hover:text-avianca-dark flex items-center gap-1 cursor-pointer"
                    >
                      Siguiente <ChevronRight className="w-4 h-4" />
                    </button>
                  )}
                </div>
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  )
}
