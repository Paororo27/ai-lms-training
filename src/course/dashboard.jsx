import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router'
import { supabase } from '../lib/supabase'
import { useAuth } from '../context/auth-context'
import ProgressBar from '../components/progress-bar'
import { Lock, CheckCircle, ChevronRight, Sparkles, Brain, Copy, Layout, FileSearch, Database, Globe, Heart, Trophy, ClipboardCheck, Award, ArrowRight } from 'lucide-react'

const MODULE_ICONS = [Sparkles, Brain, Copy, Layout, FileSearch, Database, Globe, Heart]
const MODULE_COLORS = ['#89D4E1', '#F98013', '#FF3093', '#1D9BF0', '#23C847', '#FF0000', '#B50080', '#FF0000']

export default function Dashboard() {
  const { user, role } = useAuth()
  const navigate = useNavigate()
  const [modulos, setModulos] = useState([])
  const [progreso, setProgreso] = useState({ lecciones: [], intentos: [], entrega: null })
  const [diagData, setDiagData] = useState({ preId: null, postId: null, preCompleted: false, postCompleted: false })
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    if (!user) return
    loadData()
  }, [user])

  const loadData = async () => {
    const [modulosRes, leccionesRes, intentosRes, entregaRes, diagsRes] = await Promise.all([
      supabase.from('modulos').select('*, lecciones(id), pruebas(id, tipo, puntaje_aprobatorio)').order('orden'),
      supabase.from('progreso_usuario').select('leccion_id, completado').eq('usuario_id', user.id),
      supabase.from('intentos_prueba').select('prueba_id, puntaje, aprobado, numero_intento').eq('usuario_id', user.id),
      supabase.from('entregas_reto').select('estado').eq('usuario_id', user.id).maybeSingle(),
      supabase.from('pruebas').select('id, tipo').in('tipo', ['diagnostico_pre', 'diagnostico_post']),
    ])

    const intentos = intentosRes.data || []
    const diags = diagsRes.data || []
    const pre = diags.find(d => d.tipo === 'diagnostico_pre')
    const post = diags.find(d => d.tipo === 'diagnostico_post')

    setModulos(modulosRes.data || [])
    setProgreso({
      lecciones: leccionesRes.data || [],
      intentos,
      entrega: entregaRes.data,
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

    if (allLessonsComplete && pruebaAprobada) return 'completado'
    if (isAdmin) return 'disponible'
    if (index === 0) return diagData.preCompleted ? 'disponible' : 'bloqueado'

    const prevModulo = modulos[index - 1]
    const prevLessons = prevModulo?.lecciones?.map(l => l.id) || []
    const prevAllComplete = prevLessons.length > 0 && prevLessons.every(id => completedLessons.has(id))
    const prevPrueba = prevModulo?.pruebas?.find(p => p.tipo === 'modular')
    const prevAprobada = prevPrueba ? approvedTests.has(prevPrueba.id) : false

    return (prevAllComplete && prevAprobada) ? 'disponible' : 'bloqueado'
  }

  const totalModulos = modulos.length
  const completedModulos = modulos.filter((m, i) => getModuleStatus(m, i) === 'completado').length
  const totalSteps = totalModulos + 3
  let completedSteps = completedModulos
  if (diagData.preCompleted) completedSteps++
  if (diagData.postCompleted) completedSteps++
  if (progreso.entrega?.estado === 'enviado') completedSteps++
  const progressPercent = totalSteps > 0 ? (completedSteps / totalSteps) * 100 : 0

  const modularScores = Object.values(bestScores).filter((_, i) => i < totalModulos)
  const avgScore = modularScores.length > 0
    ? Math.round(modularScores.reduce((a, b) => a + b, 0) / modularScores.length)
    : null

  const diagPreScore = diagData.preId ? bestScores[diagData.preId] : null
  const diagPostScore = diagData.postId ? bestScores[diagData.postId] : null

  const allDone = completedModulos === totalModulos && diagData.preCompleted && diagData.postCompleted && progreso.entrega?.estado === 'enviado'
  const allModulesComplete = completedModulos === totalModulos
  const canDoDiagPost = allModulesComplete && !diagData.postCompleted
  const canDoReto = diagData.postCompleted && (!progreso.entrega || progreso.entrega.estado === 'borrador')

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

      {/* Grid de Modulos */}
      <div>
        <h2 className="text-lg font-bold text-avianca-dark mb-4">Modulos del taller</h2>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {modulos.map((modulo, index) => {
            const status = getModuleStatus(modulo, index)
            const Icon = MODULE_ICONS[index] || Sparkles
            const color = MODULE_COLORS[index] || MODULE_COLORS[0]
            const prueba = modulo.pruebas?.find(p => p.tipo === 'modular')
            const score = prueba ? bestScores[prueba.id] : null

            return (
              <button
                key={modulo.id}
                onClick={() => status !== 'bloqueado' && navigate(`/course/modulo/${modulo.id}`)}
                disabled={status === 'bloqueado'}
                className={`relative text-left rounded-2xl p-5 border transition-all cursor-pointer ${
                  status === 'completado'
                    ? 'bg-white border-avianca-green/30 hover:shadow-md'
                    : status === 'disponible'
                    ? 'bg-white border-avianca-cyan/30 hover:shadow-md hover:border-avianca-cyan'
                    : 'bg-slate-100 border-slate-200 opacity-60 cursor-not-allowed'
                }`}
              >
                <span className="text-[10px] uppercase tracking-wider font-semibold text-slate-400">
                  Semana {modulo.semana}
                </span>

                <div className="flex items-start gap-3 mt-2">
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
                </div>
              </button>
            )
          })}
        </div>
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

      {/* CTA Reto */}
      {canDoReto && (
        <button
          onClick={() => navigate('/course/reto')}
          className="w-full bg-gradient-to-r from-avianca-orange to-avianca-red text-white rounded-2xl p-6 text-left hover:opacity-95 transition-opacity cursor-pointer"
        >
          <div className="flex items-center justify-between">
            <div>
              <Trophy className="w-5 h-5 mb-2" />
              <p className="font-bold text-lg">Reto final</p>
              <p className="text-white/80 text-sm mt-1">
                {progreso.entrega?.estado === 'borrador'
                  ? 'Tienes un borrador en progreso. Continua tu reto.'
                  : 'Pon a prueba todo lo que aprendiste con un caso practico.'}
              </p>
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
