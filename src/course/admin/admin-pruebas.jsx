import { useEffect, useState } from 'react'
import { useParams, useNavigate } from 'react-router'
import { supabase } from '../../lib/supabase'
import { ChevronLeft, Plus, Trash2, Pencil, Save, X, ChevronDown, ChevronUp } from 'lucide-react'
import { toast } from '../../components/toast'
import ConfirmModal from '../../components/confirm-modal'

const TIPOS_PRUEBA = [
  { value: 'modular', label: 'Modular' },
  { value: 'diagnostico_pre', label: 'Diagnostico entrada' },
  { value: 'diagnostico_post', label: 'Diagnostico salida' },
]

function PreguntaEditor({ pregunta, onChange, onSave, onCancel, onDelete, saving }) {
  const opciones = pregunta.opciones || []

  const setOpcion = (idx, campo, valor) => {
    const newOpciones = opciones.map((o, i) =>
      i === idx ? { ...o, [campo]: valor } : campo === 'es_correcta' && valor ? { ...o, es_correcta: false } : o
    )
    onChange({ ...pregunta, opciones: newOpciones })
  }

  const addOpcion = () => {
    onChange({ ...pregunta, opciones: [...opciones, { texto: '', es_correcta: false }] })
  }

  const removeOpcion = (idx) => {
    if (opciones.length <= 2) return
    onChange({ ...pregunta, opciones: opciones.filter((_, i) => i !== idx) })
  }

  return (
    <div className="bg-avianca-cyan/5 rounded-lg p-4 space-y-3">
      <textarea value={pregunta.texto} onChange={e => onChange({ ...pregunta, texto: e.target.value })} rows={2} className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm" placeholder="Texto de la pregunta" />

      <div className="space-y-2">
        <span className="text-xs font-semibold text-slate-500">Opciones (marca la correcta)</span>
        {opciones.map((opcion, idx) => (
          <div key={idx} className="flex items-center gap-2">
            <input
              type="radio"
              name={`correcta-${pregunta.id || 'new'}`}
              checked={opcion.es_correcta}
              onChange={() => setOpcion(idx, 'es_correcta', true)}
              className="w-4 h-4 accent-avianca-green"
            />
            <input
              value={opcion.texto}
              onChange={e => setOpcion(idx, 'texto', e.target.value)}
              className={`flex-1 px-3 py-1.5 border rounded-lg text-sm ${opcion.es_correcta ? 'border-avianca-green bg-avianca-green/5' : 'border-slate-200'}`}
              placeholder={`Opcion ${idx + 1}`}
            />
            <button onClick={() => removeOpcion(idx)} disabled={opciones.length <= 2} className="p-1 text-slate-400 hover:text-red-500 disabled:opacity-20 cursor-pointer disabled:cursor-not-allowed">
              <X className="w-3.5 h-3.5" />
            </button>
          </div>
        ))}
        <button onClick={addOpcion} className="text-xs text-avianca-cyan hover:text-avianca-dark cursor-pointer">+ Agregar opcion</button>
      </div>

      <textarea value={pregunta.explicacion || ''} onChange={e => onChange({ ...pregunta, explicacion: e.target.value })} rows={2} className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm" placeholder="Explicacion (se muestra al revisar respuestas)" />

      <div className="flex gap-2">
        <button onClick={onSave} disabled={saving} className="px-3 py-1.5 bg-avianca-green text-white text-xs rounded-lg hover:opacity-90 flex items-center gap-1 cursor-pointer">
          <Save className="w-3 h-3" /> {saving ? 'Guardando...' : 'Guardar'}
        </button>
        <button onClick={onCancel} className="px-3 py-1.5 text-slate-500 text-xs cursor-pointer">Cancelar</button>
        {pregunta.id && <button onClick={onDelete} className="px-3 py-1.5 text-red-400 text-xs hover:text-red-600 ml-auto cursor-pointer">Eliminar</button>}
      </div>
    </div>
  )
}

export default function AdminPruebas() {
  const { id } = useParams()
  const navigate = useNavigate()
  const [pruebas, setPruebas] = useState([])
  const [modulos, setModulos] = useState([])
  const [expandedId, setExpandedId] = useState(id ? Number(id) : null)
  const [preguntas, setPreguntas] = useState([])
  const [editingPrueba, setEditingPrueba] = useState(null)
  const [editingPregunta, setEditingPregunta] = useState(null)
  const [loading, setLoading] = useState(true)
  const [saving, setSaving] = useState(false)
  const [confirmState, setConfirmState] = useState({ open: false, action: null, message: '' })

  useEffect(() => { loadData() }, [])
  useEffect(() => { if (expandedId) loadPreguntas(expandedId) }, [expandedId])

  const loadData = async () => {
    const [pruebasRes, modulosRes] = await Promise.all([
      supabase.from('pruebas').select('*').order('orden'),
      supabase.from('modulos').select('id, titulo').order('orden'),
    ])
    if (pruebasRes.error || modulosRes.error) toast('Error cargando datos', 'error')
    setPruebas(pruebasRes.data || [])
    setModulos(modulosRes.data || [])
    setLoading(false)
  }

  const loadPreguntas = async (pruebaId) => {
    const { data, error } = await supabase.from('preguntas').select('*').eq('prueba_id', pruebaId)
    if (error) toast('Error cargando preguntas', 'error')
    setPreguntas(data || [])
  }

  const createPrueba = async () => {
    const orden = pruebas.length > 0 ? Math.max(...pruebas.map(p => p.orden)) + 1 : 1
    const { data, error } = await supabase.from('pruebas').insert({
      tipo: 'modular', titulo: 'Nueva prueba', modulo_id: modulos[0]?.id || null,
      preguntas_por_intento: 5, puntaje_aprobatorio: 80, orden,
    }).select().single()
    if (error) { toast('Error creando prueba', 'error'); return }
    if (data) {
      setPruebas([...pruebas, data])
      setExpandedId(data.id)
      setEditingPrueba(data)
      toast('Prueba creada')
    }
  }

  const savePrueba = async () => {
    if (!editingPrueba) return
    setSaving(true)
    const { tipo } = editingPrueba
    const modulo_id = tipo === 'modular' ? editingPrueba.modulo_id : null
    const { data: updated, error } = await supabase.from('pruebas').update({
      titulo: editingPrueba.titulo, tipo, modulo_id,
      preguntas_por_intento: editingPrueba.preguntas_por_intento,
      puntaje_aprobatorio: editingPrueba.puntaje_aprobatorio,
    }).eq('id', editingPrueba.id).select()
    if (error || !updated?.length) { toast(error?.message || 'No se pudo guardar', 'error'); setSaving(false); return }
    setPruebas(pruebas.map(p => p.id === editingPrueba.id ? { ...p, ...editingPrueba, modulo_id } : p))
    setEditingPrueba(null)
    setSaving(false)
    toast('Prueba actualizada')
  }

  const deletePrueba = async (id) => {
    const { error } = await supabase.from('pruebas').delete().eq('id', id)
    if (error) { toast('Error eliminando prueba', 'error'); return }
    setPruebas(pruebas.filter(p => p.id !== id))
    if (expandedId === id) { setExpandedId(null); setPreguntas([]) }
    toast('Prueba eliminada')
  }

  // Preguntas CRUD
  const newPregunta = () => {
    setEditingPregunta({
      prueba_id: expandedId, texto: '',
      opciones: [{ texto: '', es_correcta: true }, { texto: '', es_correcta: false }, { texto: '', es_correcta: false }, { texto: '', es_correcta: false }],
      explicacion: '',
    })
  }

  const savePregunta = async () => {
    if (!editingPregunta) return
    setSaving(true)
    if (editingPregunta.id) {
      const { data: updated, error } = await supabase.from('preguntas').update({
        texto: editingPregunta.texto, opciones: editingPregunta.opciones,
        explicacion: editingPregunta.explicacion,
      }).eq('id', editingPregunta.id).select()
      if (error || !updated?.length) { toast(error?.message || 'No se pudo guardar', 'error'); setSaving(false); return }
      setPreguntas(preguntas.map(p => p.id === editingPregunta.id ? { ...p, ...editingPregunta } : p))
      toast('Pregunta actualizada')
    } else {
      const { data, error } = await supabase.from('preguntas').insert({
        prueba_id: editingPregunta.prueba_id, texto: editingPregunta.texto,
        opciones: editingPregunta.opciones, explicacion: editingPregunta.explicacion,
      }).select().single()
      if (error) { toast('Error creando pregunta', 'error'); setSaving(false); return }
      if (data) { setPreguntas([...preguntas, data]); toast('Pregunta creada') }
    }
    setEditingPregunta(null)
    setSaving(false)
  }

  const deletePregunta = async () => {
    if (!editingPregunta?.id) return
    const { error } = await supabase.from('preguntas').delete().eq('id', editingPregunta.id)
    if (error) { toast('Error eliminando pregunta', 'error'); return }
    setPreguntas(preguntas.filter(p => p.id !== editingPregunta.id))
    setEditingPregunta(null)
    toast('Pregunta eliminada')
  }

  if (loading) return <div className="flex justify-center py-20"><div className="animate-spin rounded-full h-8 w-8 border-t-2 border-avianca-cyan" /></div>

  const expandedPrueba = pruebas.find(p => p.id === expandedId)

  return (
    <div className="max-w-4xl mx-auto space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <button onClick={() => navigate('/course/admin')} className="text-sm text-slate-500 hover:text-avianca-dark flex items-center gap-1 mb-1 cursor-pointer">
            <ChevronLeft className="w-4 h-4" /> Admin
          </button>
          <h1 className="text-xl font-bold text-avianca-dark">Gestion de Pruebas</h1>
        </div>
        <button onClick={createPrueba} className="flex items-center gap-1.5 px-4 py-2 bg-avianca-cyan text-white text-sm font-medium rounded-lg hover:opacity-90 cursor-pointer">
          <Plus className="w-4 h-4" /> Crear prueba
        </button>
      </div>

      <div className="space-y-3">
        {pruebas.map((prueba) => {
          const moduloNombre = modulos.find(m => m.id === prueba.modulo_id)?.titulo
          return (
            <div key={prueba.id} className="bg-white rounded-xl border border-slate-200 overflow-hidden">
              <div className="px-5 py-4 flex items-center gap-3">
                <div className="flex-1">
                  <div className="flex items-center gap-2">
                    <span className={`text-[10px] px-2 py-0.5 rounded-full font-medium ${
                      prueba.tipo === 'modular' ? 'bg-avianca-cyan/10 text-avianca-cyan' : 'bg-avianca-magenta/10 text-avianca-magenta'
                    }`}>{TIPOS_PRUEBA.find(t => t.value === prueba.tipo)?.label}</span>
                    {moduloNombre && <span className="text-xs text-slate-400">→ {moduloNombre}</span>}
                  </div>
                  <h3 className="font-semibold text-avianca-dark mt-1">{prueba.titulo}</h3>
                  <span className="text-xs text-slate-500">{prueba.preguntas_por_intento} preguntas/intento &middot; Aprobacion: {prueba.puntaje_aprobatorio}%</span>
                </div>
                <button onClick={() => setExpandedId(expandedId === prueba.id ? null : prueba.id)} className="flex items-center gap-1 px-3 py-1.5 text-xs font-medium rounded-lg bg-avianca-dark/5 text-avianca-dark hover:bg-avianca-dark/10 cursor-pointer">{expandedId === prueba.id ? <X className="w-3.5 h-3.5" /> : <ChevronDown className="w-3.5 h-3.5" />} Preguntas</button>
                <button onClick={() => setEditingPrueba(editingPrueba?.id === prueba.id ? null : { ...prueba })} className="flex items-center gap-1 px-3 py-1.5 text-xs font-medium rounded-lg bg-avianca-cyan/10 text-avianca-cyan hover:bg-avianca-cyan/20 cursor-pointer"><Pencil className="w-3.5 h-3.5" /> Editar</button>
                <button onClick={() => setConfirmState({ open: true, action: () => deletePrueba(prueba.id), message: 'Se eliminara esta prueba y todas sus preguntas.' })} className="flex items-center gap-1 px-3 py-1.5 text-xs font-medium rounded-lg text-red-400 hover:bg-red-50 cursor-pointer"><Trash2 className="w-3.5 h-3.5" /></button>
              </div>

              {/* Editar prueba */}
              {editingPrueba?.id === prueba.id && (
                <div className="px-5 py-4 border-t border-slate-100 bg-slate-50 space-y-3">
                  <input value={editingPrueba.titulo} onChange={e => setEditingPrueba({ ...editingPrueba, titulo: e.target.value })} className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm" placeholder="Titulo" />
                  <div className="flex gap-3 flex-wrap">
                    <select value={editingPrueba.tipo} onChange={e => setEditingPrueba({ ...editingPrueba, tipo: e.target.value })} className="px-3 py-2 border border-slate-200 rounded-lg text-sm">
                      {TIPOS_PRUEBA.map(t => <option key={t.value} value={t.value}>{t.label}</option>)}
                    </select>
                    {editingPrueba.tipo === 'modular' && (
                      <select value={editingPrueba.modulo_id || ''} onChange={e => setEditingPrueba({ ...editingPrueba, modulo_id: Number(e.target.value) })} className="px-3 py-2 border border-slate-200 rounded-lg text-sm">
                        <option value="">Sin modulo</option>
                        {modulos.map(m => <option key={m.id} value={m.id}>{m.titulo}</option>)}
                      </select>
                    )}
                    <label className="text-sm text-slate-600 flex items-center gap-1">
                      Preguntas/intento: <input type="number" min={1} value={editingPrueba.preguntas_por_intento} onChange={e => setEditingPrueba({ ...editingPrueba, preguntas_por_intento: Number(e.target.value) })} className="w-16 px-2 py-1 border border-slate-200 rounded text-sm" />
                    </label>
                    <label className="text-sm text-slate-600 flex items-center gap-1">
                      Aprobacion %: <input type="number" min={0} max={100} value={editingPrueba.puntaje_aprobatorio} onChange={e => setEditingPrueba({ ...editingPrueba, puntaje_aprobatorio: Number(e.target.value) })} className="w-16 px-2 py-1 border border-slate-200 rounded text-sm" />
                    </label>
                  </div>
                  <div className="flex gap-2">
                    <button onClick={savePrueba} disabled={saving} className="px-4 py-2 bg-avianca-green text-white text-sm rounded-lg hover:opacity-90 flex items-center gap-1 cursor-pointer"><Save className="w-3.5 h-3.5" /> {saving ? 'Guardando...' : 'Guardar'}</button>
                    <button onClick={() => setEditingPrueba(null)} className="px-4 py-2 text-slate-500 text-sm cursor-pointer">Cancelar</button>
                  </div>
                </div>
              )}

              {/* Preguntas */}
              {expandedId === prueba.id && (
                <div className="border-t border-slate-100">
                  <div className="px-5 py-3 bg-slate-50 flex items-center justify-between">
                    <span className="text-xs font-semibold text-slate-500 uppercase">
                      Banco de preguntas ({preguntas.length})
                      {expandedPrueba && <span className="normal-case font-normal text-slate-400"> &middot; se muestran {expandedPrueba.preguntas_por_intento} por intento</span>}
                    </span>
                    <button onClick={newPregunta} className="flex items-center gap-1 text-xs text-avianca-cyan hover:text-avianca-dark cursor-pointer"><Plus className="w-3.5 h-3.5" /> Agregar</button>
                  </div>
                  <div className="divide-y divide-slate-100 px-5 py-2 space-y-2">
                    {/* Pregunta nueva */}
                    {editingPregunta && !editingPregunta.id && (
                      <PreguntaEditor pregunta={editingPregunta} onChange={setEditingPregunta} onSave={savePregunta} onCancel={() => setEditingPregunta(null)} onDelete={() => {}} saving={saving} />
                    )}
                    {preguntas.map((pregunta) => (
                      <div key={pregunta.id}>
                        {editingPregunta?.id === pregunta.id ? (
                          <PreguntaEditor pregunta={editingPregunta} onChange={setEditingPregunta} onSave={savePregunta} onCancel={() => setEditingPregunta(null)} onDelete={() => setConfirmState({ open: true, action: deletePregunta, message: 'Se eliminara esta pregunta.' })} saving={saving} />
                        ) : (
                          <div className="py-2 flex items-start gap-3 group">
                            <div className="flex-1 min-w-0">
                              <p className="text-sm text-slate-700">{pregunta.texto}</p>
                              <div className="flex gap-2 mt-1 flex-wrap">
                                {pregunta.opciones?.map((o, i) => (
                                  <span key={i} className={`text-[11px] px-2 py-0.5 rounded ${o.es_correcta ? 'bg-avianca-green/10 text-avianca-green font-medium' : 'bg-slate-100 text-slate-500'}`}>
                                    {o.texto}
                                  </span>
                                ))}
                              </div>
                            </div>
                            <button onClick={() => setEditingPregunta({ ...pregunta })} className="flex items-center gap-1 px-2.5 py-1 text-[11px] font-medium rounded-md bg-avianca-cyan/10 text-avianca-cyan hover:bg-avianca-cyan/20 shrink-0 cursor-pointer"><Pencil className="w-3 h-3" /> Editar</button>
                          </div>
                        )}
                      </div>
                    ))}
                    {preguntas.length === 0 && !editingPregunta && (
                      <p className="py-4 text-sm text-slate-400 text-center">Sin preguntas. Agrega al menos {expandedPrueba?.preguntas_por_intento || 5} para esta prueba.</p>
                    )}
                  </div>
                </div>
              )}
            </div>
          )
        })}
      </div>

      <ConfirmModal
        open={confirmState.open}
        title="Eliminar"
        message={confirmState.message}
        confirmLabel="Eliminar"
        variant="danger"
        onConfirm={() => {
          confirmState.action?.()
          setConfirmState({ open: false, action: null, message: '' })
        }}
        onCancel={() => setConfirmState({ open: false, action: null, message: '' })}
      />
    </div>
  )
}
