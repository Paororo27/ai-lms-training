function slug(s) {
  return s
    .toLowerCase()
    .normalize('NFD')
    .replace(/\p{Diacritic}/gu, '')
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-|-$/g, '')
}

export async function generateCertificatePDF({ nombre, code, scores }) {
  const displayName = String(nombre || code || 'Participante')
  const { jsPDF } = await import('jspdf')
  const doc = new jsPDF({ orientation: 'landscape', unit: 'mm', format: 'a4' })

  const w = doc.internal.pageSize.getWidth()
  const h = doc.internal.pageSize.getHeight()

  doc.setFillColor(30, 41, 59)
  doc.rect(0, 0, w, h, 'F')

  doc.setDrawColor(137, 212, 225)
  doc.setLineWidth(1.5)
  doc.rect(12, 12, w - 24, h - 24)

  doc.setFillColor(255, 0, 0)
  doc.rect(12, 12, (w - 24) / 2, 3, 'F')
  doc.setFillColor(181, 0, 128)
  doc.rect(12 + (w - 24) / 2, 12, (w - 24) / 2, 3, 'F')

  doc.setFont('helvetica', 'normal')
  doc.setFontSize(12)
  doc.setTextColor(137, 212, 225)
  doc.text('AVIANCA', w / 2, 35, { align: 'center' })

  doc.setFontSize(28)
  doc.setFont('helvetica', 'bold')
  doc.setTextColor(255, 255, 255)
  doc.text('Certificado de Completacion', w / 2, 52, { align: 'center' })

  doc.setDrawColor(137, 212, 225)
  doc.setLineWidth(0.5)
  doc.line(w / 2 - 50, 58, w / 2 + 50, 58)

  doc.setFontSize(14)
  doc.setFont('helvetica', 'normal')
  doc.setTextColor(200, 200, 200)
  doc.text('Taller de Capacitacion en Inteligencia Artificial', w / 2, 70, { align: 'center' })
  doc.text('Copilot Chat para Recursos Humanos', w / 2, 78, { align: 'center' })

  const maxNombreWidth = w - 60
  let nombreFontSize = 26
  doc.setFont('helvetica', 'bold')
  doc.setTextColor(137, 212, 225)
  doc.setFontSize(nombreFontSize)
  while (doc.getTextWidth(displayName) > maxNombreWidth && nombreFontSize > 14) {
    nombreFontSize -= 1
    doc.setFontSize(nombreFontSize)
  }
  doc.text(displayName, w / 2, 100, { align: 'center' })

  doc.setFontSize(10)
  doc.setFont('helvetica', 'normal')
  doc.setTextColor(160, 160, 160)
  doc.text('Participante', w / 2, 107, { align: 'center' })

  const colY = 125
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

  const mejora = scores.diagnostico_post - scores.diagnostico_pre
  if (mejora > 0) {
    doc.setFontSize(10)
    doc.setTextColor(35, 200, 71)
    doc.text(`Mejora: +${mejora} puntos`, w / 2, colY + 18, { align: 'center' })
  }

  const fecha = new Date().toLocaleDateString('es-CO', {
    day: 'numeric', month: 'long', year: 'numeric'
  })

  doc.setFontSize(10)
  doc.setFont('helvetica', 'normal')
  doc.setTextColor(160, 160, 160)
  doc.text(`Expedido el ${fecha}`, w / 2, h - 32, { align: 'center' })

  doc.setFontSize(8)
  doc.setTextColor(120, 120, 120)
  doc.text('Programa de 4 semanas  |  4 horas de formacion  |  6 modulos + reto final', w / 2, h - 25, { align: 'center' })

  doc.save(`certificado-copilot-${slug(displayName) || 'participante'}.pdf`)
}
