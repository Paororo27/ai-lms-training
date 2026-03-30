import { useEffect, useState, useRef } from 'react'
import { useNavigate } from 'react-router'
import { supabase } from '../lib/supabase'
import { useAuth } from '../context/auth-context'
import { ChevronLeft, Trophy, Send, CheckCircle, AlertTriangle } from 'lucide-react'

const LOCALSTORAGE_KEY = 'reto_borrador'

export default function Reto() {
  const { user } = useAuth()
  const navigate = useNavigate()

  const [reto, setReto] = useState(null)
  const [entrega, setEntrega] = useState(null)
  const [contenido, setContenido] = useState('')
  const [loading, setLoading] = useState(true)
  const [saving, setSaving] = useState(false)
  const [showConfirm, setShowConfirm] = useState(false)
  const [error, setError] = useState('')
  const textareaRef = useRef(null)

  useEffect(() => {
    if (!user) return
    loadReto()
  }, [user])

  // Proteccion beforeunload
  useEffect(() => {
    const handler = (e) => {
      if (contenido && entrega?.estado !== 'enviado') {
        e.preventDefault()
        e.returnValue = ''
      }
    }
    window.addEventListener('beforeunload', handler)
    return () => window.removeEventListener('beforeunload', handler)
  }, [contenido, entrega?.estado])

  const loadReto = async () => {
    // Asignar reto (idempotente)
    const { data: retoData, error: retoErr } = await supabase
      .rpc('assign_challenge', { p_usuario_id: user.id })

    if (retoErr) {
      setError(`Error asignando reto: ${retoErr.message}`)
      setLoading(false)
      return
    }

    if (retoData && retoData.length > 0) {
      setReto(retoData[0])
    }

    // Cargar entrega existente
    const { data: entregaData } = await supabase
      .from('entregas_reto')
      .select('*')
      .eq('usuario_id', user.id)
      .single()

    if (entregaData) {
      setEntrega(entregaData)
      // Priorizar contenido de DB sobre localStorage
      const saved = localStorage.getItem(LOCALSTORAGE_KEY)
      setContenido(entregaData.contenido || saved || '')
    }

    setLoading(false)
  }

  const handleChange = (value) => {
    setContenido(value)
    localStorage.setItem(LOCALSTORAGE_KEY, value)
  }

  const handleSaveDraft = async () => {
    if (!entrega) return
    setSaving(true)
    await supabase
      .from('entregas_reto')
      .update({ contenido, updated_at: new Date().toISOString() })
      .eq('id', entrega.id)
    setSaving(false)
  }

  const handleSubmit = async () => {
    if (!entrega || !contenido.trim()) return
    setSaving(true)
    setError('')

    const { error: updateErr } = await supabase
      .from('entregas_reto')
      .update({ contenido, estado: 'enviado' })
      .eq('id', entrega.id)

    if (updateErr) {
      setError(`Error al enviar: ${updateErr.message}`)
      setSaving(false)
      return
    }

    localStorage.removeItem(LOCALSTORAGE_KEY)
    setEntrega(prev => ({ ...prev, estado: 'enviado', contenido }))
    setShowConfirm(false)
    setSaving(false)
  }

  if (loading) {
    return (
      <div className="flex justify-center py-20">
        <div className="animate-spin rounded-full h-8 w-8 border-t-2 border-avianca-cyan" />
      </div>
    )
  }

  if (error && !reto) {
    return (
      <div className="text-center py-16">
        <p className="text-red-500 mb-4">{error}</p>
        <button onClick={() => navigate('/course')} className="text-avianca-cyan hover:underline cursor-pointer">
          Volver al dashboard
        </button>
      </div>
    )
  }

  const enviado = entrega?.estado === 'enviado'

  return (
    <div className="max-w-3xl mx-auto space-y-6">
      <button onClick={() => navigate('/course')} className="text-sm text-slate-500 hover:text-avianca-dark flex items-center gap-1 cursor-pointer">
        <ChevronLeft className="w-4 h-4" /> Dashboard
      </button>

      {/* Header */}
      <div className="flex items-start gap-4">
        <div className="p-3 bg-avianca-orange/10 rounded-xl">
          <Trophy className="w-6 h-6 text-avianca-orange" />
        </div>
        <div>
          <h1 className="text-xl font-bold text-avianca-dark">Reto Final</h1>
          <p className="text-sm text-slate-500">{reto?.titulo}</p>
        </div>
      </div>

      {/* Escenario */}
      <div className="bg-white rounded-2xl border border-slate-200 p-6">
        <h2 className="font-semibold text-avianca-dark mb-3">Escenario</h2>
        <p className="text-slate-600 text-sm whitespace-pre-line leading-relaxed">{reto?.escenario}</p>

        {reto?.criterios_evaluacion && (
          <div className="mt-4 pt-4 border-t border-slate-100">
            <h3 className="text-sm font-semibold text-slate-500 mb-2">Criterios de evaluacion</h3>
            <ul className="space-y-1">
              {reto.criterios_evaluacion.map((c, i) => (
                <li key={i} className="text-sm text-slate-500 flex items-center gap-2">
                  <span className="w-1.5 h-1.5 bg-avianca-orange rounded-full shrink-0" />
                  {c}
                </li>
              ))}
            </ul>
          </div>
        )}
      </div>

      {/* Editor o vista solo lectura */}
      {enviado ? (
        <div className="bg-avianca-green/5 border border-avianca-green/30 rounded-2xl p-6">
          <div className="flex items-center gap-2 mb-4">
            <CheckCircle className="w-5 h-5 text-avianca-green" />
            <h2 className="font-semibold text-avianca-green">Entrega enviada</h2>
          </div>
          <p className="text-slate-600 text-sm whitespace-pre-line">{entrega.contenido}</p>

          {entrega.retroalimentacion && (
            <div className="mt-4 pt-4 border-t border-avianca-green/20">
              <h3 className="text-sm font-semibold text-avianca-dark mb-1">Retroalimentacion</h3>
              <p className="text-sm text-slate-600">{entrega.retroalimentacion}</p>
            </div>
          )}
        </div>
      ) : (
        <div className="bg-white rounded-2xl border border-slate-200 p-6">
          <div className="flex items-center justify-between mb-3">
            <h2 className="font-semibold text-avianca-dark">Tu respuesta</h2>
            <span className="text-xs text-slate-400">
              {contenido.length} caracteres
            </span>
          </div>

          <textarea
            ref={textareaRef}
            value={contenido}
            onChange={(e) => handleChange(e.target.value)}
            placeholder="Describe paso a paso como resolverias este escenario usando Copilot Chat y herramientas de IA..."
            rows={12}
            className="w-full p-4 border border-slate-200 rounded-xl text-sm text-slate-700 placeholder-slate-400 focus:outline-none focus:ring-2 focus:ring-avianca-cyan focus:border-transparent resize-y"
          />

          {error && (
            <p className="text-red-500 text-sm mt-2">{error}</p>
          )}

          <div className="flex items-center justify-between mt-4">
            <button
              onClick={handleSaveDraft}
              disabled={saving}
              className="text-sm text-slate-500 hover:text-avianca-dark disabled:opacity-50 cursor-pointer"
            >
              {saving ? 'Guardando...' : 'Guardar borrador'}
            </button>

            <button
              onClick={() => setShowConfirm(true)}
              disabled={!contenido.trim() || saving}
              className="px-6 py-3 bg-gradient-to-r from-avianca-red to-avianca-magenta text-white font-semibold rounded-xl hover:opacity-90 disabled:opacity-40 flex items-center gap-2 cursor-pointer disabled:cursor-not-allowed"
            >
              <Send className="w-4 h-4" /> Enviar entrega final
            </button>
          </div>
        </div>
      )}

      {/* Modal de confirmacion */}
      {showConfirm && (
        <div className="fixed inset-0 bg-black/50 backdrop-blur-sm z-50 flex items-center justify-center p-4">
          <div className="bg-white rounded-2xl p-6 max-w-md w-full shadow-2xl">
            <div className="flex items-center gap-3 mb-4">
              <AlertTriangle className="w-6 h-6 text-avianca-orange" />
              <h3 className="font-bold text-avianca-dark text-lg">Confirmar envio</h3>
            </div>
            <p className="text-sm text-slate-600 mb-6">
              Esta accion es definitiva. Una vez enviada, no podras modificar tu respuesta. ¿Estas seguro?
            </p>
            <div className="flex justify-end gap-3">
              <button
                onClick={() => setShowConfirm(false)}
                className="px-4 py-2 text-sm text-slate-500 hover:text-avianca-dark cursor-pointer"
              >
                Cancelar
              </button>
              <button
                onClick={handleSubmit}
                disabled={saving}
                className="px-6 py-2.5 bg-gradient-to-r from-avianca-red to-avianca-magenta text-white font-semibold rounded-xl hover:opacity-90 disabled:opacity-50 cursor-pointer"
              >
                {saving ? 'Enviando...' : 'Si, enviar'}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
