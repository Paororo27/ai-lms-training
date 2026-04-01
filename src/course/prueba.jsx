import { useEffect, useState } from 'react'
import { useParams, useNavigate } from 'react-router'
import { supabase } from '../lib/supabase'
import { useAuth } from '../context/auth-context'
import QuizQuestion from '../components/quiz-question'
import { ChevronLeft, CheckCircle, XCircle, RotateCcw, ArrowRight } from 'lucide-react'
import confetti from 'canvas-confetti'

export default function Prueba() {
  const { id } = useParams()
  const { user } = useAuth()
  const navigate = useNavigate()

  const [prueba, setPrueba] = useState(null)
  const [preguntas, setPreguntas] = useState([])
  const [respuestas, setRespuestas] = useState({})
  const [resultado, setResultado] = useState(null)
  const [loading, setLoading] = useState(true)
  const [submitting, setSubmitting] = useState(false)
  const [error, setError] = useState('')
  const [intentosPrevios, setIntentosPrevios] = useState(0)

  useEffect(() => {
    if (resultado?.aprobado) {
      confetti({ particleCount: 150, spread: 70, origin: { y: 0.6 } })
    }
  }, [resultado])

  useEffect(() => {
    if (!user || !id) return
    loadQuiz()
  }, [user, id])

  const loadQuiz = async () => {
    // Obtener prueba del modulo
    const { data: pruebaData } = await supabase
      .from('pruebas')
      .select('*')
      .eq('modulo_id', id)
      .eq('tipo', 'modular')
      .single()

    if (!pruebaData) {
      setError('Prueba no encontrada para este modulo')
      setLoading(false)
      return
    }

    setPrueba(pruebaData)

    // Contar intentos previos
    const { count } = await supabase
      .from('intentos_prueba')
      .select('id', { count: 'exact', head: true })
      .eq('usuario_id', user.id)
      .eq('prueba_id', pruebaData.id)

    setIntentosPrevios(count ?? 0)

    if ((count ?? 0) >= 2) {
      // Cargar ultimo resultado
      const { data: ultimoIntento } = await supabase
        .from('intentos_prueba')
        .select('*')
        .eq('usuario_id', user.id)
        .eq('prueba_id', pruebaData.id)
        .order('numero_intento', { ascending: false })
        .limit(1)
        .single()

      if (ultimoIntento) {
        setResultado({
          puntaje: ultimoIntento.puntaje,
          aprobado: ultimoIntento.aprobado,
          numero_intento: ultimoIntento.numero_intento,
          max_intentos: 2,
          detalle: [],
          bloqueado: true,
        })
      }
      setLoading(false)
      return
    }

    // Cargar preguntas via RPC
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

  const handleRetry = () => {
    setResultado(null)
    setRespuestas({})
    setPreguntas([])
    setLoading(true)
    loadQuiz()
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

  // Vista de resultado
  if (resultado) {
    const detalleMap = {}
    ;(resultado.detalle || []).forEach(d => {
      detalleMap[d.pregunta_id] = d
    })

    return (
      <div className="max-w-2xl mx-auto space-y-6">
        <button onClick={() => navigate('/course')} className="text-sm text-slate-500 hover:text-avianca-dark flex items-center gap-1 cursor-pointer">
          <ChevronLeft className="w-4 h-4" /> Dashboard
        </button>

        {/* Resultado principal */}
        <div className={`rounded-2xl p-8 text-center ${
          resultado.aprobado ? 'bg-avianca-green/10 border border-avianca-green/30' : 'bg-red-50 border border-red-200'
        }`}>
          {resultado.aprobado ? (
            <CheckCircle className="w-12 h-12 text-avianca-green mx-auto mb-3" />
          ) : (
            <XCircle className="w-12 h-12 text-red-400 mx-auto mb-3" />
          )}
          <h2 className="text-2xl font-bold text-avianca-dark">{resultado.puntaje}%</h2>
          <p className={`text-sm mt-1 ${resultado.aprobado ? 'text-avianca-green' : 'text-red-500'}`}>
            {resultado.aprobado ? 'Aprobado' : 'No aprobado'}
            {prueba && ` (minimo ${prueba.puntaje_aprobatorio}%)`}
          </p>

          {resultado.correctas !== undefined && (
            <p className="text-sm text-slate-500 mt-2">
              {resultado.correctas} de {resultado.total} correctas
            </p>
          )}
        </div>

        {/* Acciones */}
        <div className="flex justify-center gap-3">
          {resultado.aprobado && (
            <button
              onClick={() => navigate('/course')}
              className="px-6 py-3 bg-gradient-to-r from-avianca-red to-avianca-magenta text-white font-semibold rounded-xl hover:opacity-90 flex items-center gap-2 cursor-pointer"
            >
              Siguiente modulo <ArrowRight className="w-4 h-4" />
            </button>
          )}
          {!resultado.aprobado && !resultado.bloqueado && resultado.numero_intento < resultado.max_intentos && (
            <button
              onClick={handleRetry}
              className="px-6 py-3 bg-avianca-cyan text-white font-semibold rounded-xl hover:opacity-90 flex items-center gap-2 cursor-pointer"
            >
              <RotateCcw className="w-4 h-4" /> Reintentar (intento {resultado.numero_intento + 1} de {resultado.max_intentos})
            </button>
          )}
          {!resultado.aprobado && (resultado.bloqueado || resultado.numero_intento >= resultado.max_intentos) && (
            <div className="text-center">
              <p className="text-sm text-red-500 mb-3">Has agotado tus 2 intentos. Contacta al administrador.</p>
              <button
                onClick={() => navigate('/course')}
                className="px-6 py-3 bg-slate-200 text-slate-700 font-medium rounded-xl hover:bg-slate-300 cursor-pointer"
              >
                Volver al dashboard
              </button>
            </div>
          )}
        </div>

        {/* Detalle por pregunta */}
        {resultado.detalle && resultado.detalle.length > 0 && (
          <div className="space-y-3">
            <h3 className="font-semibold text-avianca-dark">Detalle de respuestas</h3>
            {resultado.detalle.map((d, i) => (
              <div key={d.pregunta_id} className={`rounded-xl border p-4 ${d.acerto ? 'border-avianca-green/30 bg-avianca-green/5' : 'border-red-200 bg-red-50'}`}>
                <div className="flex items-start gap-2">
                  {d.acerto ? <CheckCircle className="w-4 h-4 text-avianca-green mt-0.5 shrink-0" /> : <XCircle className="w-4 h-4 text-red-400 mt-0.5 shrink-0" />}
                  <div>
                    <p className="text-sm font-medium text-avianca-dark">{d.pregunta_texto}</p>
                    <p className="text-xs text-slate-500 mt-1">{d.explicacion}</p>
                  </div>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    )
  }

  // Vista de quiz activo
  const todasRespondidas = preguntas.every(p => respuestas[p.id] !== undefined)

  return (
    <div className="max-w-2xl mx-auto space-y-6">
      <div>
        <button onClick={() => navigate(`/course/modulo/${id}`)} className="text-sm text-slate-500 hover:text-avianca-dark flex items-center gap-1 mb-1 cursor-pointer">
          <ChevronLeft className="w-4 h-4" /> Volver al modulo
        </button>
        <h1 className="text-xl font-bold text-avianca-dark">{prueba?.titulo}</h1>
        <p className="text-sm text-slate-500 mt-0.5">
          {preguntas.length} preguntas &middot; Intento {intentosPrevios + 1} de 2 &middot; Minimo {prueba?.puntaje_aprobatorio}%
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
          className="px-8 py-3 bg-gradient-to-r from-avianca-red to-avianca-magenta text-white font-semibold rounded-xl hover:opacity-90 disabled:opacity-40 transition-all cursor-pointer disabled:cursor-not-allowed"
        >
          {submitting ? 'Calificando...' : 'Enviar respuestas'}
        </button>
      </div>
    </div>
  )
}
