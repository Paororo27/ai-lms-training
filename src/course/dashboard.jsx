import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router'
import { supabase } from '../lib/supabase'
import { useAuth } from '../context/auth-context'
import ProgressBar from '../components/progress-bar'
import { Lock, CheckCircle, ChevronRight, ChevronDown, Sparkles, Brain, Copy, Layout, FileSearch, Database, Globe, Heart, ClipboardCheck, Award, ArrowRight, Clock } from 'lucide-react'

const MODULE_ICONS = [Sparkles, Brain, Copy, Layout, FileSearch, Database, Globe, Heart]
const MODULE_COLORS = ['#89D4E1', '#F98013', '#FF3093', '#1D9BF0', '#23C847', '#FF0000', '#B50080', '#FF0000']

export default function Dashboard() {
  const { user, role } = useAuth()
  const navigate = useNavigate()
  const [modulos, setModulos] = useState([])
  const [progreso, setProgreso] = useState({ lecciones: [], intentos: [], entregas: [] })
  const [retos, setRetos] = useState([])
  const [diagData, setDiagData] = useState({ preId: null, postId: null, preCompleted: false, postCompleted: false })
  const [loading, setLoading] = useState(true)
  const [openWeeks, setOpenWeeks] = useState(null)

  useEffect(() => {
    if (!user) return
    loadData()
  }, [user])

  const loadData = async () => {
    const [modulosRes, leccionesRes, intentosRes, entregasRes, diagsRes, retosRes] = await Promise.all([
      supabase.from('modulos').select('*, lecciones(id), pruebas(id, tipo, puntaje_aprobatorio)').order('orden'),
      supabase.from('progreso_usuario').select('leccion_id, completado').eq('usuario_id', user.id),
      supabase.from('intentos_prueba').select('prueba_id, puntaje, aprobado, numero_intento').eq('usuario_id', user.id),
      supabase.from('entregas_reto').select('reto_id, estado').eq('usuario_id', user.id),
      supabase.from('pruebas').select('id, tipo').in('tipo', ['diagnostico_pre', 'diagnostico_post']),
      supabase.from('retos').select('id, modulo_id').not('modulo_id', 'is', null),
    ])

    const intentos = intentosRes.data || []
    const diags = diagsRes.data || []
    const pre = diags.find(d => d.tipo === 'diagnostico_pre')
    const post = diags.find(d => d.tipo === 'diagnostico_post')

    setModulos(modulosRes.data || [])
    setRetos(retosRes.data || [])
    setProgreso({
      lecciones: leccionesRes.data || [],
      intentos,
      entregas: entregasRes.data || [],
    })
    setDiagData({
      preId: pre?.id || null,
      postId: post?.id || null,
      preCompleted: pre ? intentos.some(i => i.prueba_id === pre.id) : false,
      postCompleted: post ? intentos.some(i => i.prueba_id === post.id) : false,
    })
    setLoading(false)
  }

  if (loading) {
    return (
      <div className="flex justify-center py-20">
        <div className="animate-spin rounded-full h-8 w-8 border-t-2 border-avianca-cyan" />
      </div>
    )
  }

  const completedLessons = new Set(
    progreso.lecciones.filter(l => l.completado).map(l => l.leccion_id)
  )

  const approvedTests = new Set(
    progreso.intentos.filter(i => i.aprobado).map(i => i.prueba_id)
  )

  const bestScores = {}
  progreso.intentos.forEach(i => {
    if (!bestScores[i.prueba_id] || i.puntaje > bestScores[i.prueba_id]) {
      bestScores[i.prueba_id] = i.puntaje
    }
  })

  const isAdmin = role === 'admin'

  const getModuleStatus = (modulo, index) => {
    const moduleLessons = modulo.lecciones?.map(l => l.id) || []
    const allLessonsComplete = moduleLessons.length > 0 && moduleLessons.every(id => completedLessons.has(id))
    const modulePrueba = modulo.pruebas?.find(p => p.tipo === 'modular')
    const pruebaAprobada = modulePrueba ? approvedTests.has(modulePrueba.id) : false
    const moduleReto = retos.find(r => r.modulo_id === modulo.id)
    const retoEnviado = moduleReto
      ? progreso.entregas.some(e => e.reto_id === moduleReto.id && e.estado === 'enviado')
      : true

    if (allLessonsComplete && retoEnviado && pruebaAprobada) return 'completado'
    if (isAdmin) return 'disponible'
    if (!modulo.disponible) return 'proximamente'
    if (index === 0) return diagData.preCompleted ? 'disponible' : 'bloqueado'

    const prevModulo = modulos[index - 1]
    const prevLessons = prevModulo?.lecciones?.map(l => l.id) || []
    const prevAllComplete = prevLessons.length > 0 && prevLessons.every(id => completedLessons.has(id))
    const prevPrueba = prevModulo?.pruebas?.find(p => p.tipo === 'modular')
    const prevAprobada = prevPrueba ? approvedTests.has(prevPrueba.id) : false

    return (prevAllComplete && prevAprobada) ? 'disponible' : 'bloqueado'
  }

  // Filtrar modulos disponibles para calculos de progreso
  const modulosActivos = isAdmin ? modulos : modulos.filter(m => m.disponible)
  const totalModulos = modulosActivos.length
  const completedModulos = modulosActivos.filter((m) => getModuleStatus(m, modulos.indexOf(m)) === 'completado').length

  // Progreso granular: pruebas aprobadas + retos enviados + diagnosticos
  const pruebasModulares = modulosActivos.flatMap(m => m.pruebas?.filter(p => p.tipo === 'modular') || [])
  const pruebasAprobadas = pruebasModulares.filter(p => approvedTests.has(p.id)).length
  const retosActivos = retos.filter(r => modulosActivos.some(m => m.id === r.modulo_id))
  const retosEnviados = retosActivos.filter(r => progreso.entregas.some(e => e.reto_id === r.id && e.estado === 'enviado')).length
  const totalSteps = pruebasModulares.length + retosActivos.length + 2
  let completedSteps = pruebasAprobadas + retosEnviados
  if (diagData.preCompleted) completedSteps++
  if (diagData.postCompleted) completedSteps++
  const progressPercent = totalSteps > 0 ? (completedSteps / totalSteps) * 100 : 0

  const modularPruebaIds = new Set(pruebasModulares.map(p => p.id))
  const modularScores = [...modularPruebaIds].map(id => bestScores[id]).filter(s => s !== undefined)
  const avgScore = modularScores.length > 0
    ? Math.round(modularScores.reduce((a, b) => a + b, 0) / modularScores.length)
    : null

  const diagPreScore = diagData.preId ? bestScores[diagData.preId] ?? null : null
  const diagPostScore = diagData.postId ? bestScores[diagData.postId] ?? null : null

  // Agrupar modulos por semana
  const semanas = []
  const semanaMap = {}
  modulos.forEach((modulo, index) => {
    const sem = modulo.semana
    if (!semanaMap[sem]) {
      semanaMap[sem] = { semana: sem, modulos: [] }
      semanas.push(semanaMap[sem])
    }
    semanaMap[sem].modulos.push({ modulo, index })
  })

  // Inicializar semana activa una sola vez
  if (openWeeks === null && semanas.length > 0) {
    const activeWeek = semanas.find(s =>
      s.modulos.some(({ modulo, index }) => getModuleStatus(modulo, index) === 'disponible')
    )?.semana ?? semanas[0]?.semana
    setOpenWeeks(new Set(activeWeek != null ? [activeWeek] : []))
  }

  const toggleWeek = (sem) => {
    setOpenWeeks(prev => {
      const next = new Set(prev)
      next.has(sem) ? next.delete(sem) : next.add(sem)
      return next
    })
  }

  const allDone = completedModulos === totalModulos && diagData.preCompleted && diagData.postCompleted
  const allModulesComplete = completedModulos === totalModulos
  const canDoDiagPost = allModulesComplete && !diagData.postCompleted

  return (
    <div className="space-y-8">
      {/* Header con progreso */}
      <div className="bg-white rounded-2xl shadow-sm border border-slate-200 p-6">
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 mb-4">
          <div>
            <h1 className="text-xl font-bold text-avianca-dark">Tu progreso</h1>
            {avgScore !== null && (
              <p className="text-sm text-slate-500 mt-0.5">Puntaje promedio: <span className="font-semibold text-avianca-dark">{avgScore}%</span></p>
            )}
          </div>
          {diagPreScore !== null && diagPostScore !== null && (
            <div className="flex items-center gap-3 bg-avianca-soft-cyan rounded-xl px-4 py-2.5">
              <div className="text-center">
                <p className="text-xs text-slate-500">Entrada</p>
                <p className="text-lg font-bold text-avianca-dark">{diagPreScore}%</p>
              </div>
              <ArrowRight className="w-4 h-4 text-slate-400" />
              <div className="text-center">
                <p className="text-xs text-slate-500">Salida</p>
                <p className="text-lg font-bold text-avianca-green">{diagPostScore}%</p>
              </div>
              <div className="text-center border-l border-slate-300 pl-3">
                <p className="text-xs text-slate-500">Mejora</p>
                <p className={`text-lg font-bold ${diagPostScore > diagPreScore ? 'text-avianca-green' : 'text-slate-500'}`}>
                  +{diagPostScore - diagPreScore}%
                </p>
              </div>
            </div>
          )}
        </div>
        <ProgressBar value={progressPercent} label="Progreso del taller" />
      </div>

      {/* CTA Diagnostico Pre */}
      {!diagData.preCompleted && diagData.preId && (
        <button
          onClick={() => navigate('/course/diagnostico/pre')}
          className="w-full bg-gradient-to-r from-avianca-cyan to-avianca-blue text-white rounded-2xl p-6 text-left hover:opacity-95 transition-opacity cursor-pointer"
        >
          <div className="flex items-center justify-between">
            <div>
              <p className="font-bold text-lg">Comienza con el diagnostico de entrada</p>
              <p className="text-white/80 text-sm mt-1">Evalua tu nivel actual antes de iniciar los modulos.</p>
            </div>
            <ChevronRight className="w-6 h-6" />
          </div>
        </button>
      )}

      {/* Modulos agrupados por semana */}
      <div className="space-y-3">
        <h2 className="text-lg font-bold text-avianca-dark">Modulos del taller</h2>
        {semanas.map(({ semana, modulos: semModulos }) => {
          const isOpen = openWeeks?.has(semana)
          const completedCount = semModulos.filter(({ modulo, index }) => getModuleStatus(modulo, index) === 'completado').length
          const allComplete = completedCount === semModulos.length

          return (
            <div key={semana} className="bg-white rounded-2xl border border-slate-200 overflow-hidden">
              <button
                onClick={() => toggleWeek(semana)}
                className="w-full flex items-center justify-between px-5 py-4 cursor-pointer hover:bg-slate-50 transition-colors"
              >
                <div className="flex items-center gap-3">
                  <span className="text-sm font-bold text-avianca-dark">Semana {semana}</span>
                  <span className="text-xs text-slate-400">{semModulos.length} modulos</span>
                  {allComplete && <CheckCircle className="w-4 h-4 text-avianca-green" />}
                  {!allComplete && completedCount > 0 && (
                    <span className="text-[11px] px-2 py-0.5 rounded-full bg-avianca-cyan/10 text-avianca-cyan font-medium">{completedCount}/{semModulos.length}</span>
                  )}
                </div>
                <ChevronDown className={`w-4 h-4 text-slate-400 transition-transform ${isOpen ? 'rotate-180' : ''}`} />
              </button>

              {isOpen && (
                <div className="px-5 pb-5 grid grid-cols-1 md:grid-cols-2 gap-3">
                  {semModulos.map(({ modulo, index }) => {
                    const status = getModuleStatus(modulo, index)
                    const Icon = MODULE_ICONS[index] || Sparkles
                    const color = MODULE_COLORS[index] || MODULE_COLORS[0]
                    const prueba = modulo.pruebas?.find(p => p.tipo === 'modular')
                    const score = prueba ? bestScores[prueba.id] : null

                    return (
                      <button
                        key={modulo.id}
                        onClick={() => status !== 'bloqueado' && status !== 'proximamente' && navigate(`/course/modulo/${modulo.id}`)}
                        disabled={status === 'bloqueado' || status === 'proximamente'}
                        className={`relative text-left rounded-xl p-4 border transition-all cursor-pointer ${
                          status === 'completado'
                            ? 'bg-white border-avianca-green/30 hover:shadow-md'
                            : status === 'disponible'
                            ? 'bg-white border-avianca-cyan/30 hover:shadow-md hover:border-avianca-cyan'
                            : 'bg-slate-50 border-slate-200 opacity-60 cursor-not-allowed'
                        }`}
                      >
                        <div className="flex items-start gap-3">
                          <div
                            className={`p-2 rounded-xl ${status === 'bloqueado' ? 'bg-slate-200' : ''}`}
                            style={status !== 'bloqueado' ? { backgroundColor: `${color}15` } : undefined}
                          >
                            <Icon
                              className={`w-5 h-5 ${status === 'bloqueado' ? 'text-slate-400' : ''}`}
                              style={status !== 'bloqueado' ? { color } : undefined}
                            />
                          </div>
                          <div className="flex-1 min-w-0">
                            <h3 className="font-semibold text-avianca-dark text-sm leading-tight">{modulo.titulo}</h3>
                            <p className="text-xs text-slate-500 mt-1 line-clamp-2">{modulo.descripcion}</p>
                          </div>
                        </div>

                        <div className="mt-3 flex items-center justify-between">
                          <span className="text-xs text-slate-400">{modulo.duracion_minutos} min</span>
                          {status === 'completado' && (
                            <div className="flex items-center gap-1.5">
                              {score !== null && <span className="text-xs font-semibold text-avianca-green">{score}%</span>}
                              <CheckCircle className="w-4 h-4 text-avianca-green" />
                            </div>
                          )}
                          {status === 'disponible' && <ChevronRight className="w-4 h-4 text-avianca-cyan" />}
                          {status === 'bloqueado' && <Lock className="w-4 h-4 text-slate-400" />}
                          {status === 'proximamente' && (
                            <span className="flex items-center gap-1 text-xs text-slate-400">
                              <Clock className="w-3.5 h-3.5" /> Disponible proximamente
                            </span>
                          )}
                        </div>
                      </button>
                    )
                  })}
                </div>
              )}
            </div>
          )
        })}
      </div>

      {/* CTA Diagnostico Post */}
      {canDoDiagPost && (
        <button
          onClick={() => navigate('/course/diagnostico/post')}
          className="w-full bg-gradient-to-r from-avianca-magenta to-avianca-red text-white rounded-2xl p-6 text-left hover:opacity-95 transition-opacity cursor-pointer"
        >
          <div className="flex items-center justify-between">
            <div>
              <ClipboardCheck className="w-5 h-5 mb-2" />
              <p className="font-bold text-lg">Diagnostico de salida</p>
              <p className="text-white/80 text-sm mt-1">Completaste todos los modulos. Evalua cuanto aprendiste.</p>
            </div>
            <ChevronRight className="w-6 h-6" />
          </div>
        </button>
      )}



      {/* CTA Certificado */}
      {allDone && (
        <button
          onClick={() => navigate('/course/certificado')}
          className="w-full bg-gradient-to-r from-avianca-green to-avianca-cyan text-white rounded-2xl p-6 text-left hover:opacity-95 transition-opacity cursor-pointer"
        >
          <div className="flex items-center justify-between">
            <div>
              <Award className="w-5 h-5 mb-2" />
              <p className="font-bold text-lg">Descarga tu certificado</p>
              <p className="text-white/80 text-sm mt-1">Completaste el taller. Genera y descarga tu certificado.</p>
            </div>
            <ChevronRight className="w-6 h-6" />
          </div>
        </button>
      )}
    </div>
  )
}
