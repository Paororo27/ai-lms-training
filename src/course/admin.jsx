import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router'
import { supabase } from '../lib/supabase'
import { ChevronLeft, Users, TrendingUp, AlertTriangle, CheckCircle, Clock, BarChart } from 'lucide-react'
import ProgressBar from '../components/progress-bar'

export default function Admin() {
  const navigate = useNavigate()
  const [stats, setStats] = useState(null)
  const [usuarios, setUsuarios] = useState([])
  const [loading, setLoading] = useState(true)
  const [filter, setFilter] = useState('todos')

  useEffect(() => {
    loadAdmin()
  }, [])

  const loadAdmin = async () => {
    const [modulosRes, pruebasRes, intentosRes, progresoRes, entregasRes] = await Promise.all([
      supabase.from('modulos').select('id, titulo, orden, lecciones(id)').order('orden'),
      supabase.from('pruebas').select('id, tipo, titulo, modulo_id, puntaje_aprobatorio'),
      supabase.from('intentos_prueba').select('usuario_id, prueba_id, puntaje, aprobado, numero_intento'),
      supabase.from('progreso_usuario').select('usuario_id, leccion_id, completado'),
      supabase.from('entregas_reto').select('usuario_id, estado'),
    ])

    const modulos = modulosRes.data || []
    const pruebas = pruebasRes.data || []
    const intentos = intentosRes.data || []
    const progreso = progresoRes.data || []
    const entregas = entregasRes.data || []

    const pruebasModulares = pruebas.filter(p => p.tipo === 'modular')
    const diagPre = pruebas.find(p => p.tipo === 'diagnostico_pre')
    const diagPost = pruebas.find(p => p.tipo === 'diagnostico_post')

    // Agrupar por usuario
    const userIds = [...new Set([
      ...intentos.map(i => i.usuario_id),
      ...progreso.map(p => p.usuario_id),
      ...entregas.map(e => e.usuario_id),
    ])]

    const userMap = {}
    userIds.forEach(uid => {
      const userIntentos = intentos.filter(i => i.usuario_id === uid)
      const userProgreso = progreso.filter(p => p.usuario_id === uid && p.completado)
      const userEntrega = entregas.find(e => e.usuario_id === uid)

      // Mejores puntajes por prueba
      const bestScores = {}
      userIntentos.forEach(i => {
        if (!bestScores[i.prueba_id] || i.puntaje > bestScores[i.prueba_id]) {
          bestScores[i.prueba_id] = i.puntaje
        }
      })

      // Pruebas modulares aprobadas
      const aprobadas = pruebasModulares.filter(p =>
        userIntentos.some(i => i.prueba_id === p.id && i.aprobado)
      ).length

      // Bloqueado: fallo 2 intentos en alguna prueba
      const bloqueado = pruebasModulares.some(p => {
        const intentosPrueba = userIntentos.filter(i => i.prueba_id === p.id)
        return intentosPrueba.length >= 2 && !intentosPrueba.some(i => i.aprobado)
      })

      // Total lecciones del taller
      const totalLecciones = modulos.reduce((sum, m) => sum + (m.lecciones?.length || 0), 0)
      const leccionesCompletadas = userProgreso.length

      // Diagnosticos
      const diagPreScore = diagPre ? bestScores[diagPre.id] : null
      const diagPostScore = diagPost ? bestScores[diagPost.id] : null

      // Puntaje promedio modular
      const modularScores = pruebasModulares.map(p => bestScores[p.id]).filter(s => s !== undefined)
      const avgScore = modularScores.length > 0
        ? Math.round(modularScores.reduce((a, b) => a + b, 0) / modularScores.length)
        : null

      // Estado general
      let estado = 'activo'
      if (aprobadas === pruebasModulares.length && userEntrega?.estado === 'enviado') {
        estado = 'completado'
      } else if (bloqueado) {
        estado = 'bloqueado'
      } else if (leccionesCompletadas === 0 && userIntentos.length === 0) {
        estado = 'sin_iniciar'
      }

      // Progreso %
      const totalSteps = pruebasModulares.length + 3 // modulos + diag pre + diag post + reto
      let completedSteps = aprobadas
      if (diagPreScore !== null) completedSteps++
      if (diagPostScore !== null) completedSteps++
      if (userEntrega?.estado === 'enviado') completedSteps++
      const progressPct = Math.round((completedSteps / totalSteps) * 100)

      userMap[uid] = {
        id: uid,
        estado,
        bloqueado,
        progressPct,
        aprobadas,
        totalModulos: pruebasModulares.length,
        avgScore,
        diagPreScore,
        diagPostScore,
        mejora: diagPreScore !== null && diagPostScore !== null ? diagPostScore - diagPreScore : null,
        leccionesCompletadas,
        totalLecciones,
        retoEstado: userEntrega?.estado || null,
      }
    })

    const userList = Object.values(userMap)

    // Stats generales
    const totalUsuarios = userList.length
    const completados = userList.filter(u => u.estado === 'completado').length
    const bloqueados = userList.filter(u => u.estado === 'bloqueado').length
    const sinIniciar = userList.filter(u => u.estado === 'sin_iniciar').length
    const activos = totalUsuarios - completados - bloqueados - sinIniciar
    const avgProgress = totalUsuarios > 0
      ? Math.round(userList.reduce((sum, u) => sum + u.progressPct, 0) / totalUsuarios)
      : 0

    // Promedio diagnosticos
    const conDiagPre = userList.filter(u => u.diagPreScore !== null)
    const conDiagPost = userList.filter(u => u.diagPostScore !== null)
    const avgDiagPre = conDiagPre.length > 0
      ? Math.round(conDiagPre.reduce((s, u) => s + u.diagPreScore, 0) / conDiagPre.length)
      : null
    const avgDiagPost = conDiagPost.length > 0
      ? Math.round(conDiagPost.reduce((s, u) => s + u.diagPostScore, 0) / conDiagPost.length)
      : null

    // Tasa aprobacion por prueba modular
    const tasaAprobacion = pruebasModulares.map(p => {
      const intentosPrueba = intentos.filter(i => i.prueba_id === p.id)
      const usuariosQueTomaron = new Set(intentosPrueba.map(i => i.usuario_id)).size
      const aprobaron = new Set(
        intentosPrueba.filter(i => i.aprobado).map(i => i.usuario_id)
      ).size
      return {
        titulo: p.titulo,
        tasa: usuariosQueTomaron > 0 ? Math.round((aprobaron / usuariosQueTomaron) * 100) : 0,
        tomaron: usuariosQueTomaron,
        aprobaron,
      }
    })

    setStats({
      totalUsuarios, completados, bloqueados, sinIniciar, activos,
      avgProgress, avgDiagPre, avgDiagPost, tasaAprobacion,
    })
    setUsuarios(userList)
    setLoading(false)
  }

  if (loading) {
    return (
      <div className="flex justify-center py-20">
        <div className="animate-spin rounded-full h-8 w-8 border-t-2 border-avianca-cyan" />
      </div>
    )
  }

  const filteredUsers = filter === 'todos'
    ? usuarios
    : usuarios.filter(u => u.estado === filter)

  const sorted = [...filteredUsers].sort((a, b) => b.progressPct - a.progressPct)

  return (
    <div className="max-w-6xl mx-auto space-y-6">
      <button onClick={() => navigate('/course')} className="text-sm text-slate-500 hover:text-avianca-dark flex items-center gap-1 cursor-pointer">
        <ChevronLeft className="w-4 h-4" /> Dashboard
      </button>

      <h1 className="text-xl font-bold text-avianca-dark">Panel de Administracion</h1>

      {/* Metricas generales */}
      <div className="grid grid-cols-2 md:grid-cols-5 gap-3">
        {[
          { label: 'Registrados', value: stats.totalUsuarios, icon: Users, color: 'text-avianca-dark' },
          { label: 'Activos', value: stats.activos, icon: Clock, color: 'text-avianca-cyan' },
          { label: 'Completados', value: stats.completados, icon: CheckCircle, color: 'text-avianca-green' },
          { label: 'Bloqueados', value: stats.bloqueados, icon: AlertTriangle, color: 'text-red-500' },
          { label: 'Sin iniciar', value: stats.sinIniciar, icon: Users, color: 'text-slate-400' },
        ].map(({ label, value, icon: Icon, color }) => (
          <div key={label} className="bg-white rounded-xl border border-slate-200 p-4">
            <Icon className={`w-5 h-5 ${color} mb-2`} />
            <p className="text-2xl font-bold text-avianca-dark">{value}</p>
            <p className="text-xs text-slate-500">{label}</p>
          </div>
        ))}
      </div>

      {/* Progreso promedio + Diagnosticos */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <div className="bg-white rounded-xl border border-slate-200 p-5">
          <h3 className="font-semibold text-avianca-dark mb-3">Progreso promedio</h3>
          <ProgressBar value={stats.avgProgress} label="Todos los participantes" />
        </div>

        {stats.avgDiagPre !== null && (
          <div className="bg-white rounded-xl border border-slate-200 p-5">
            <h3 className="font-semibold text-avianca-dark mb-3">Comparacion diagnostica</h3>
            <div className="flex items-center gap-6">
              <div className="text-center">
                <p className="text-2xl font-bold text-slate-500">{stats.avgDiagPre}%</p>
                <p className="text-xs text-slate-400">Promedio entrada</p>
              </div>
              <TrendingUp className="w-5 h-5 text-avianca-green" />
              <div className="text-center">
                <p className="text-2xl font-bold text-avianca-green">{stats.avgDiagPost ?? '—'}%</p>
                <p className="text-xs text-slate-400">Promedio salida</p>
              </div>
              {stats.avgDiagPost !== null && (
                <div className="text-center border-l border-slate-200 pl-4">
                  <p className={`text-2xl font-bold ${stats.avgDiagPost > stats.avgDiagPre ? 'text-avianca-green' : 'text-slate-500'}`}>
                    +{stats.avgDiagPost - stats.avgDiagPre}
                  </p>
                  <p className="text-xs text-slate-400">Mejora prom.</p>
                </div>
              )}
            </div>
          </div>
        )}
      </div>

      {/* Tasa aprobacion por modulo */}
      <div className="bg-white rounded-xl border border-slate-200 p-5">
        <h3 className="font-semibold text-avianca-dark mb-3 flex items-center gap-2">
          <BarChart className="w-4 h-4" /> Aprobacion por modulo
        </h3>
        <div className="space-y-3">
          {stats.tasaAprobacion.map((p) => (
            <div key={p.titulo}>
              <div className="flex justify-between text-sm mb-1">
                <span className="text-slate-600 truncate">{p.titulo}</span>
                <span className="text-slate-500 shrink-0 ml-2">{p.aprobaron}/{p.tomaron} ({p.tasa}%)</span>
              </div>
              <div className="h-2 bg-slate-100 rounded-full overflow-hidden">
                <div
                  className={`h-full rounded-full transition-all ${p.tasa >= 80 ? 'bg-avianca-green' : p.tasa >= 50 ? 'bg-avianca-orange' : 'bg-red-400'}`}
                  style={{ width: `${p.tasa}%` }}
                />
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Tabla de usuarios */}
      <div className="bg-white rounded-xl border border-slate-200 overflow-hidden">
        <div className="px-5 py-4 border-b border-slate-100 flex items-center justify-between">
          <h3 className="font-semibold text-avianca-dark">Participantes</h3>
          <div className="flex gap-1">
            {['todos', 'activo', 'completado', 'bloqueado', 'sin_iniciar'].map(f => (
              <button
                key={f}
                onClick={() => setFilter(f)}
                className={`px-3 py-1 text-xs rounded-lg cursor-pointer transition-colors ${
                  filter === f ? 'bg-avianca-dark text-white' : 'text-slate-500 hover:bg-slate-100'
                }`}
              >
                {f === 'sin_iniciar' ? 'Sin iniciar' : f.charAt(0).toUpperCase() + f.slice(1)}
              </button>
            ))}
          </div>
        </div>

        <div className="overflow-x-auto">
          <table className="w-full text-sm">
            <thead>
              <tr className="border-b border-slate-100 text-left">
                <th className="px-5 py-3 font-medium text-slate-500">Usuario</th>
                <th className="px-5 py-3 font-medium text-slate-500">Estado</th>
                <th className="px-5 py-3 font-medium text-slate-500">Progreso</th>
                <th className="px-5 py-3 font-medium text-slate-500">Modulos</th>
                <th className="px-5 py-3 font-medium text-slate-500">Puntaje</th>
                <th className="px-5 py-3 font-medium text-slate-500">Mejora</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-100">
              {sorted.map(u => (
                <tr key={u.id} className={u.bloqueado ? 'bg-red-50' : ''}>
                  <td className="px-5 py-3 font-mono text-xs text-slate-600">{u.id.slice(0, 8)}...</td>
                  <td className="px-5 py-3">
                    <span className={`inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-xs font-medium ${
                      u.estado === 'completado' ? 'bg-avianca-green/10 text-avianca-green' :
                      u.estado === 'bloqueado' ? 'bg-red-100 text-red-600' :
                      u.estado === 'sin_iniciar' ? 'bg-slate-100 text-slate-500' :
                      'bg-avianca-cyan/10 text-avianca-cyan'
                    }`}>
                      {u.estado === 'completado' && <CheckCircle className="w-3 h-3" />}
                      {u.estado === 'bloqueado' && <AlertTriangle className="w-3 h-3" />}
                      {u.estado}
                    </span>
                  </td>
                  <td className="px-5 py-3">
                    <div className="flex items-center gap-2">
                      <div className="w-16 h-1.5 bg-slate-100 rounded-full overflow-hidden">
                        <div className="h-full bg-avianca-cyan rounded-full" style={{ width: `${u.progressPct}%` }} />
                      </div>
                      <span className="text-xs text-slate-500">{u.progressPct}%</span>
                    </div>
                  </td>
                  <td className="px-5 py-3 text-xs text-slate-600">{u.aprobadas}/{u.totalModulos}</td>
                  <td className="px-5 py-3 text-xs font-medium text-avianca-dark">{u.avgScore ?? '—'}%</td>
                  <td className="px-5 py-3 text-xs">
                    {u.mejora !== null ? (
                      <span className={u.mejora > 0 ? 'text-avianca-green' : 'text-slate-500'}>
                        {u.mejora > 0 ? '+' : ''}{u.mejora}
                      </span>
                    ) : '—'}
                  </td>
                </tr>
              ))}
              {sorted.length === 0 && (
                <tr>
                  <td colSpan={6} className="px-5 py-8 text-center text-slate-400">
                    No hay participantes con este filtro.
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  )
}
