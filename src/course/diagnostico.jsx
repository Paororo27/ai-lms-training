import { useEffect, useState } from 'react'
import { useParams, useNavigate } from 'react-router'
import { supabase } from '../lib/supabase'
import { useAuth } from '../context/auth-context'
import QuizQuestion from '../components/quiz-question'
import { ChevronLeft, CheckCircle, ArrowRight } from 'lucide-react'
import confetti from 'canvas-confetti'

export default function Diagnostico() {
  const { tipo } = useParams()
  const { user } = useAuth()
  const navigate = useNavigate()

  const [prueba, setPrueba] = useState(null)
  const [preguntas, setPreguntas] = useState([])
  const [respuestas, setRespuestas] = useState({})
  const [resultado, setResultado] = useState(null)
  const [loading, setLoading] = useState(true)
  const [submitting, setSubmitting] = useState(false)
  const [error, setError] = useState('')
  const [yaCompletado, setYaCompletado] = useState(false)

  const tipoPrueba = tipo === 'pre' ? 'diagnostico_pre' : 'diagnostico_post'

  useEffect(() => {
    if (resultado && !yaCompletado && tipoPrueba === 'diagnostico_post') {
      const end = Date.now() + 3000
      const interval = setInterval(() => {
        if (Date.now() > end) return clearInterval(interval)
        confetti({
          particleCount: 30,
          startVelocity: 30,
          spread: 360,
          origin: { x: Math.random(), y: Math.random() * 0.4 },
        })
      }, 200)
      return () => clearInterval(interval)
    }
  }, [resultado])
  const label = tipo === 'pre' ? 'Diagnostico de entrada' : 'Diagnostico de salida'

  useEffect(() => {
    if (!user || !tipo) return
    loadDiag()
  }, [user, tipo])

  const loadDiag = async () => {
    const { data: pruebaData } = await supabase
      .from('pruebas')
      .select('*')
      .eq('tipo', tipoPrueba)
      .single()

    if (!pruebaData) {
      setError('Diagnostico no encontrado')
      setLoading(false)
      return
    }

    setPrueba(pruebaData)

    // Verificar si ya lo completo
    const { count } = await supabase
      .from('intentos_prueba')
      .select('id', { count: 'exact', head: true })
      .eq('usuario_id', user.id)
      .eq('prueba_id', pruebaData.id)

    if ((count ?? 0) > 0) {
      const { data: intento } = await supabase
        .from('intentos_prueba')
        .select('puntaje')
        .eq('usuario_id', user.id)
        .eq('prueba_id', pruebaData.id)
        .single()

      setYaCompletado(true)
      setResultado({ puntaje: intento?.puntaje ?? 0 })
      setLoading(false)
      return
    }

    // Cargar preguntas
    const { data: preguntasData, error: pregErr } = await supabase
      .rpc('get_quiz_questions', { p_prueba_id: pruebaData.id, p_usuario_id: user.id })

    if (pregErr) {
      setError(`Error cargando preguntas: ${pregErr.message}`)
    } else {
      setPreguntas(preguntasData || [])
    }

    setLoading(false)
  }

  const handleSelect = (preguntaId, opcionIdx) => {
    setRespuestas(prev => ({ ...prev, [preguntaId]: opcionIdx }))
  }

  const handleSubmit = async () => {
    if (!prueba) return

    const todasRespondidas = preguntas.every(p => respuestas[p.id] !== undefined)
    if (!todasRespondidas) {
      setError('Responde todas las preguntas antes de enviar')
      return
    }

    setSubmitting(true)
    setError('')

    const { data, error: submitErr } = await supabase.functions.invoke('submit-quiz', {
      body: {
        prueba_id: prueba.id,
        respuestas: preguntas.map(p => ({
          pregunta_id: p.id,
          opcion_seleccionada: respuestas[p.id],
        })),
      },
    })

    if (submitErr) {
      setError('Error al enviar respuestas. Intenta de nuevo.')
      setSubmitting(false)
      return
    }

    setResultado(data)
    setSubmitting(false)
  }

  if (loading) {
    return (
      <div className="flex justify-center py-20">
        <div className="animate-spin rounded-full h-8 w-8 border-t-2 border-avianca-cyan" />
      </div>
    )
  }

  if (error && !resultado) {
    return (
      <div className="text-center py-16">
        <p className="text-red-500 mb-4">{error}</p>
        <button onClick={() => navigate('/course')} className="text-avianca-cyan hover:underline cursor-pointer">
          Volver al dashboard
        </button>
      </div>
    )
  }

  // Resultado (ya completado o recien enviado)
  if (resultado) {
    return (
      <div className="max-w-2xl mx-auto space-y-6">
        <button onClick={() => navigate('/course')} className="text-sm text-slate-500 hover:text-avianca-dark flex items-center gap-1 cursor-pointer">
          <ChevronLeft className="w-4 h-4" /> Dashboard
        </button>

        <div className="rounded-2xl p-8 text-center bg-avianca-cyan/10 border border-avianca-cyan/30">
          <CheckCircle className="w-12 h-12 text-avianca-cyan mx-auto mb-3" />
          <h2 className="text-2xl font-bold text-avianca-dark">{label}</h2>
          <p className="text-lg font-semibold text-avianca-dark mt-2">{resultado.puntaje}%</p>
          <p className="text-sm text-slate-500 mt-1">
            {yaCompletado ? 'Ya completaste este diagnostico' : 'Diagnostico completado'}
          </p>
          <p className="text-xs text-slate-400 mt-2">
            Este resultado se usara para medir tu mejora al final del taller.
          </p>
        </div>

        {/* Detalle si recien enviado */}
        {resultado.detalle && resultado.detalle.length > 0 && (
          <div className="space-y-3">
            <h3 className="font-semibold text-avianca-dark">Detalle</h3>
            {resultado.detalle.map((d) => (
              <div key={d.pregunta_id} className={`rounded-xl border p-4 ${d.acerto ? 'border-avianca-green/30 bg-avianca-green/5' : 'border-amber-200 bg-amber-50'}`}>
                <p className="text-sm font-medium text-avianca-dark">{d.pregunta_texto}</p>
                <p className="text-xs text-slate-500 mt-1">{d.explicacion}</p>
              </div>
            ))}
          </div>
        )}

        <div className="flex justify-center">
          <button
            onClick={() => navigate('/course')}
            className="px-6 py-3 bg-gradient-to-r from-avianca-red to-avianca-magenta text-white font-semibold rounded-xl hover:opacity-90 flex items-center gap-2 cursor-pointer"
          >
            Continuar al taller <ArrowRight className="w-4 h-4" />
          </button>
        </div>
      </div>
    )
  }

  // Quiz activo
  const todasRespondidas = preguntas.every(p => respuestas[p.id] !== undefined)

  return (
    <div className="max-w-2xl mx-auto space-y-6">
      <div>
        <button onClick={() => navigate('/course')} className="text-sm text-slate-500 hover:text-avianca-dark flex items-center gap-1 mb-1 cursor-pointer">
          <ChevronLeft className="w-4 h-4" /> Dashboard
        </button>
        <h1 className="text-xl font-bold text-avianca-dark">{label}</h1>
        <p className="text-sm text-slate-500 mt-0.5">
          {preguntas.length} preguntas &middot; Sin puntaje minimo &middot; 1 intento
        </p>
        <p className="text-xs text-slate-400 mt-1">
          Este examen evalua tu nivel actual. No hay respuestas incorrectas que te bloqueen.
        </p>
      </div>

      <div className="space-y-4">
        {preguntas.map((pregunta, index) => (
          <QuizQuestion
            key={pregunta.id}
            pregunta={pregunta}
            index={index}
            selected={respuestas[pregunta.id]}
            onSelect={(opIdx) => handleSelect(pregunta.id, opIdx)}
          />
        ))}
      </div>

      {error && (
        <p className="text-red-500 text-sm text-center bg-red-50 rounded-lg py-2">{error}</p>
      )}

      <div className="flex justify-end">
        <button
          onClick={handleSubmit}
          disabled={!todasRespondidas || submitting}
          className="px-8 py-3 bg-gradient-to-r from-avianca-cyan to-avianca-blue text-white font-semibold rounded-xl hover:opacity-90 disabled:opacity-40 transition-all cursor-pointer disabled:cursor-not-allowed"
        >
          {submitting ? 'Enviando...' : 'Enviar diagnostico'}
        </button>
      </div>
    </div>
  )
}
