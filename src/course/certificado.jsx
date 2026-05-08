import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router'
import { supabase } from '../lib/supabase'
import { useAuth } from '../context/auth-context'
import { generateCertificatePDF } from '../lib/certificate-pdf'
import { ChevronLeft, Award, Download, AlertCircle, CheckCircle } from 'lucide-react'

export default function Certificado() {
  const { user, userCode } = useAuth()
  const navigate = useNavigate()

  const [data, setData] = useState(null)
  const [loading, setLoading] = useState(true)
  const [generating, setGenerating] = useState(false)
  const [error, setError] = useState('')

  useEffect(() => {
    if (!user) return
    let active = true
    supabase
      .rpc('check_certificate_ready', { p_usuario_id: user.id })
      .then(({ data: result, error: rpcErr }) => {
        if (!active) return
        if (rpcErr) setError(`Error verificando requisitos: ${rpcErr.message}`)
        else setData(result)
        setLoading(false)
      })
    return () => { active = false }
  }, [user])

  const generatePDF = async () => {
    setGenerating(true)
    try {
      await generateCertificatePDF({
        nombre: data.nombre || userCode,
        scores: data.scores,
      })
    } catch (e) {
      setError(`Error generando PDF: ${e.message}`)
    }
    setGenerating(false)
  }

  if (loading) {
    return (
      <div className="flex justify-center py-20">
        <div className="animate-spin rounded-full h-8 w-8 border-t-2 border-avianca-cyan" />
      </div>
    )
  }

  const ready = data?.ready
  const missing = data?.missing || []
  const scores = data?.scores

  return (
    <div className="max-w-2xl mx-auto space-y-6">
      <button onClick={() => navigate('/course')} className="text-sm text-slate-500 hover:text-avianca-dark flex items-center gap-1 cursor-pointer">
        <ChevronLeft className="w-4 h-4" /> Dashboard
      </button>

      <div className="flex items-start gap-4">
        <div className="p-3 bg-avianca-green/10 rounded-xl">
          <Award className="w-6 h-6 text-avianca-green" />
        </div>
        <div>
          <h1 className="text-xl font-bold text-avianca-dark">Certificado</h1>
          <p className="text-sm text-slate-500">Taller Copilot Chat para Recursos Humanos</p>
        </div>
      </div>

      {ready ? (
        <div className="space-y-4">
          {/* Preview de puntajes */}
          <div className="bg-white rounded-2xl border border-slate-200 p-6">
            <div className="grid grid-cols-3 gap-4 text-center">
              <div>
                <p className="text-2xl font-bold text-avianca-dark">{scores.promedio_modular}%</p>
                <p className="text-xs text-slate-500 mt-1">Puntaje promedio</p>
              </div>
              <div>
                <p className="text-2xl font-bold text-slate-500">{scores.diagnostico_pre}%</p>
                <p className="text-xs text-slate-500 mt-1">Diag. entrada</p>
              </div>
              <div>
                <p className="text-2xl font-bold text-avianca-green">{scores.diagnostico_post}%</p>
                <p className="text-xs text-slate-500 mt-1">Diag. salida</p>
              </div>
            </div>

            {scores.diagnostico_post > scores.diagnostico_pre && (
              <p className="text-center text-sm text-avianca-green mt-3">
                +{scores.diagnostico_post - scores.diagnostico_pre} puntos de mejora
              </p>
            )}
          </div>

          {error && (
            <p className="text-red-500 text-sm text-center bg-red-50 rounded-lg py-2">{error}</p>
          )}

          <button
            onClick={generatePDF}
            disabled={generating}
            className="w-full py-4 bg-gradient-to-r from-avianca-green to-avianca-cyan text-white font-bold rounded-xl hover:opacity-90 disabled:opacity-50 flex items-center justify-center gap-2 text-lg cursor-pointer"
          >
            <Download className="w-5 h-5" />
            {generating ? 'Generando PDF...' : 'Descargar certificado'}
          </button>
        </div>
      ) : (
        <div className="bg-amber-50 border border-amber-200 rounded-2xl p-6">
          <div className="flex items-center gap-2 mb-4">
            <AlertCircle className="w-5 h-5 text-amber-500" />
            <h2 className="font-semibold text-amber-800">Aun no puedes generar tu certificado</h2>
          </div>
          <p className="text-sm text-amber-700 mb-4">Completa los siguientes requisitos:</p>
          <ul className="space-y-2">
            {missing.map((item, i) => (
              <li key={i} className="flex items-center gap-2 text-sm text-amber-700">
                <AlertCircle className="w-4 h-4 text-amber-400 shrink-0" />
                {item}
              </li>
            ))}
          </ul>
        </div>
      )}
    </div>
  )
}
