import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router'
import { supabase } from '../lib/supabase'
import { useAuth } from '../context/auth-context'
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
    checkReady()
  }, [user])

  const checkReady = async () => {
    const { data: result, error: rpcErr } = await supabase
      .rpc('check_certificate_ready', { p_usuario_id: user.id })

    if (rpcErr) {
      setError(`Error verificando requisitos: ${rpcErr.message}`)
    } else {
      setData(result)
    }
    setLoading(false)
  }

  const generatePDF = async () => {
    setGenerating(true)
    try {
      const { jsPDF } = await import('jspdf')
      const doc = new jsPDF({ orientation: 'landscape', unit: 'mm', format: 'a4' })

      const w = doc.internal.pageSize.getWidth()
      const h = doc.internal.pageSize.getHeight()
      const scores = data.scores

      // Fondo
      doc.setFillColor(30, 41, 59) // avianca-dark
      doc.rect(0, 0, w, h, 'F')

      // Borde decorativo
      doc.setDrawColor(137, 212, 225) // avianca-cyan
      doc.setLineWidth(1.5)
      doc.rect(12, 12, w - 24, h - 24)

      // Linea decorativa superior
      doc.setFillColor(255, 0, 0) // avianca-red
      doc.rect(12, 12, (w - 24) / 2, 3, 'F')
      doc.setFillColor(181, 0, 128) // avianca-magenta
      doc.rect(12 + (w - 24) / 2, 12, (w - 24) / 2, 3, 'F')

      // Titulo
      doc.setFont('helvetica', 'normal')
      doc.setFontSize(12)
      doc.setTextColor(137, 212, 225)
      doc.text('AVIANCA', w / 2, 35, { align: 'center' })

      doc.setFontSize(28)
      doc.setFont('helvetica', 'bold')
      doc.setTextColor(255, 255, 255)
      doc.text('Certificado de Completacion', w / 2, 52, { align: 'center' })

      // Linea separadora
      doc.setDrawColor(137, 212, 225)
      doc.setLineWidth(0.5)
      doc.line(w / 2 - 50, 58, w / 2 + 50, 58)

      // Subtitulo taller
      doc.setFontSize(14)
      doc.setFont('helvetica', 'normal')
      doc.setTextColor(200, 200, 200)
      doc.text('Taller de Capacitacion en Inteligencia Artificial', w / 2, 70, { align: 'center' })
      doc.text('Copilot Chat para Recursos Humanos', w / 2, 78, { align: 'center' })

      // Codigo participante
      doc.setFontSize(20)
      doc.setFont('helvetica', 'bold')
      doc.setTextColor(137, 212, 225)
      doc.text(userCode, w / 2, 98, { align: 'center' })

      doc.setFontSize(10)
      doc.setFont('helvetica', 'normal')
      doc.setTextColor(160, 160, 160)
      doc.text('Participante', w / 2, 105, { align: 'center' })

      // Puntajes en 3 columnas
      const colY = 120
      const colWidth = 60
      const startX = w / 2 - (colWidth * 3) / 2

      const cols = [
        { label: 'Puntaje Promedio', value: `${scores.promedio_modular}%`, color: [255, 255, 255] },
        { label: 'Diagnostico Entrada', value: `${scores.diagnostico_pre}%`, color: [200, 200, 200] },
        { label: 'Diagnostico Salida', value: `${scores.diagnostico_post}%`, color: [35, 200, 71] },
      ]

      cols.forEach((col, i) => {
        const cx = startX + colWidth * i + colWidth / 2
        doc.setFontSize(22)
        doc.setFont('helvetica', 'bold')
        doc.setTextColor(...col.color)
        doc.text(col.value, cx, colY, { align: 'center' })

        doc.setFontSize(8)
        doc.setFont('helvetica', 'normal')
        doc.setTextColor(140, 140, 140)
        doc.text(col.label, cx, colY + 7, { align: 'center' })
      })

      // Mejora diagnostica
      const mejora = scores.diagnostico_post - scores.diagnostico_pre
      if (mejora > 0) {
        doc.setFontSize(10)
        doc.setTextColor(35, 200, 71)
        doc.text(`Mejora: +${mejora} puntos`, w / 2, colY + 18, { align: 'center' })
      }

      // Fecha
      const fecha = new Date().toLocaleDateString('es-CO', {
        day: 'numeric', month: 'long', year: 'numeric'
      })

      doc.setFontSize(10)
      doc.setFont('helvetica', 'normal')
      doc.setTextColor(160, 160, 160)
      doc.text(`Expedido el ${fecha}`, w / 2, h - 32, { align: 'center' })

      // Duracion
      doc.setFontSize(8)
      doc.setTextColor(120, 120, 120)
      doc.text('Programa de 4 semanas  |  4 horas de formacion  |  6 modulos + reto final', w / 2, h - 25, { align: 'center' })

      doc.save(`certificado-copilot-${userCode}.pdf`)
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
