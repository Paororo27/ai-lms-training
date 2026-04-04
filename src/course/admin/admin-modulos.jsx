import { useEffect, useState } from 'react'
import { useParams, useNavigate } from 'react-router'
import { supabase } from '../../lib/supabase'
import { ChevronLeft, Plus, Trash2, ChevronUp, ChevronDown, Pencil, Save, X, Video, FileText, Wrench, Gamepad2 } from 'lucide-react'
import { toast } from '../../components/toast'
import ConfirmModal from '../../components/confirm-modal'

const TIPOS_LECCION = [
  { value: 'video', label: 'Video', icon: Video },
  { value: 'texto', label: 'Texto', icon: FileText },
  { value: 'ejercicio', label: 'Ejercicio', icon: Wrench },
  { value: 'recurso_externo', label: 'Recurso externo', icon: Gamepad2 },
]

function extractEmbedUrl(input) {
  const trimmed = (input || '').trim()
  if (!trimmed) return null
  const match = trimmed.match(/src=["']([^"']+)["']/)
  const url = match ? match[1] : trimmed
  if (!/^https?:\/\//.test(url)) return null
  return url
}

export default function AdminModulos() {
  const { id } = useParams()
  const navigate = useNavigate()
  const [modulos, setModulos] = useState([])
  const [editingModulo, setEditingModulo] = useState(null)
  const [expandedId, setExpandedId] = useState(id ? Number(id) : null)
  const [lecciones, setLecciones] = useState([])
  const [editingLeccion, setEditingLeccion] = useState(null)
  const [loading, setLoading] = useState(true)
  const [saving, setSaving] = useState(false)
  const [confirmState, setConfirmState] = useState({ open: false, action: null, message: '' })

  useEffect(() => { loadModulos() }, [])
  useEffect(() => { if (expandedId) loadLecciones(expandedId) }, [expandedId])

  const loadModulos = async () => {
    const { data, error } = await supabase.from('modulos').select('*, lecciones(id)').order('orden')
    if (error) toast('Error cargando modulos', 'error')
    setModulos(data || [])
    setLoading(false)
  }

  const loadLecciones = async (moduloId) => {
    const { data, error } = await supabase.from('lecciones').select('*').eq('modulo_id', moduloId).order('orden')
    if (error) toast('Error cargando lecciones', 'error')
    setLecciones(data || [])
  }

  // Reorder modulos
  const moveModulo = async (index, direction) => {
    const swapIdx = index + direction
    if (swapIdx < 0 || swapIdx >= modulos.length) return
    const prev = [...modulos]
    const newModulos = [...modulos]
    ;[newModulos[index], newModulos[swapIdx]] = [newModulos[swapIdx], newModulos[index]]
    setModulos(newModulos)
    try {
      await Promise.all(newModulos.map((m, i) =>
        supabase.from('modulos').update({ orden: i + 1 }).eq('id', m.id)
      ))
    } catch { setModulos(prev); toast('Error reordenando', 'error') }
  }

  // Create modulo
  const createModulo = async () => {
    const orden = modulos.length > 0 ? Math.max(...modulos.map(m => m.orden)) + 1 : 1
    const { data, error } = await supabase.from('modulos').insert({
      orden, semana: Math.min(4, Math.ceil(orden / 2)),
      titulo: 'Nuevo modulo', descripcion: '', contenido: {}, duracion_minutos: 30,
    }).select().single()
    if (error) { toast('Error creando modulo', 'error'); return }
    if (data) {
      setModulos([...modulos, { ...data, lecciones: [] }])
      setExpandedId(data.id)
      setEditingModulo(data)
      toast('Modulo creado')
    }
  }

  // Save modulo
  const saveModulo = async () => {
    if (!editingModulo) return
    setSaving(true)
    const { data: updated, error } = await supabase.from('modulos').update({
      titulo: editingModulo.titulo, descripcion: editingModulo.descripcion,
      semana: editingModulo.semana, duracion_minutos: editingModulo.duracion_minutos,
    }).eq('id', editingModulo.id).select()
    if (error || !updated?.length) { toast('Error guardando modulo', 'error'); setSaving(false); return }
    setModulos(modulos.map(m => m.id === editingModulo.id ? { ...m, ...editingModulo } : m))
    setEditingModulo(null)
    setSaving(false)
    toast('Modulo actualizado')
  }

  // Delete modulo
  const deleteModulo = async (id) => {
    const { error } = await supabase.from('modulos').delete().eq('id', id)
    if (error) { toast('Error eliminando modulo', 'error'); return }
    setModulos(modulos.filter(m => m.id !== id))
    if (expandedId === id) setExpandedId(null)
    toast('Modulo eliminado')
  }

  // Lecciones CRUD
  const moveLeccion = async (index, direction) => {
    const swapIdx = index + direction
    if (swapIdx < 0 || swapIdx >= lecciones.length) return
    const prev = [...lecciones]
    const newLecciones = [...lecciones]
    ;[newLecciones[index], newLecciones[swapIdx]] = [newLecciones[swapIdx], newLecciones[index]]
    setLecciones(newLecciones)
    try {
      await Promise.all(newLecciones.map((l, i) =>
        supabase.from('lecciones').update({ orden: i + 1 }).eq('id', l.id)
      ))
    } catch { setLecciones(prev); toast('Error reordenando', 'error') }
  }

  const createLeccion = async () => {
    if (!expandedId) return
    const orden = lecciones.length > 0 ? Math.max(...lecciones.map(l => l.orden)) + 1 : 1
    const { data, error } = await supabase.from('lecciones').insert({
      modulo_id: expandedId, orden, titulo: 'Nueva leccion',
      tipo: 'texto', contenido: { texto: '' }, duracion_minutos: 10,
    }).select().single()
    if (error) { toast('Error creando leccion', 'error'); return }
    if (data) {
      setLecciones([...lecciones, data])
      setEditingLeccion(data)
      toast('Leccion creada')
    }
  }

  const saveLeccion = async () => {
    if (!editingLeccion) return
    setSaving(true)
    let contenido
    if (editingLeccion.tipo === 'recurso_externo') {
      const url = extractEmbedUrl(editingLeccion.contenido?.embed_input || editingLeccion.contenido?.url || '')
      if (!url) { toast('URL no valida. Pega un iframe o una URL directa.', 'error'); setSaving(false); return }
      const modo = editingLeccion.contenido?.modo || 'embed'
      contenido = { url, modo, texto: editingLeccion.contenido?.texto || '' }
    } else if (editingLeccion.tipo === 'video') {
      contenido = { media_url: editingLeccion.contenido?.media_url || '', texto: editingLeccion.contenido?.texto || '' }
    } else if (editingLeccion.tipo === 'ejercicio') {
      contenido = { instrucciones: editingLeccion.contenido?.instrucciones || '', texto: editingLeccion.contenido?.texto || '' }
    } else {
      contenido = { texto: editingLeccion.contenido?.texto || '' }
    }

    const { data: updated, error } = await supabase.from('lecciones').update({
      titulo: editingLeccion.titulo, tipo: editingLeccion.tipo,
      contenido, duracion_minutos: editingLeccion.duracion_minutos,
    }).eq('id', editingLeccion.id).select()
    if (error || !updated?.length) { toast('Error guardando leccion', 'error'); setSaving(false); return }
    setLecciones(lecciones.map(l => l.id === editingLeccion.id ? { ...l, ...editingLeccion, contenido } : l))
    setEditingLeccion(null)
    setSaving(false)
    toast('Leccion actualizada')
  }

  const deleteLeccion = async (id) => {
    const { error } = await supabase.from('lecciones').delete().eq('id', id)
    if (error) { toast('Error eliminando leccion', 'error'); return }
    setLecciones(lecciones.filter(l => l.id !== id))
    toast('Leccion eliminada')
  }

  if (loading) return <div className="flex justify-center py-20"><div className="animate-spin rounded-full h-8 w-8 border-t-2 border-avianca-cyan" /></div>

  return (
    <div className="max-w-4xl mx-auto space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <button onClick={() => navigate('/course/admin')} className="text-sm text-slate-500 hover:text-avianca-dark flex items-center gap-1 mb-1 cursor-pointer">
            <ChevronLeft className="w-4 h-4" /> Admin
          </button>
          <h1 className="text-xl font-bold text-avianca-dark">Gestion de Modulos</h1>
        </div>
        <button onClick={createModulo} className="flex items-center gap-1.5 px-4 py-2 bg-avianca-cyan text-white text-sm font-medium rounded-lg hover:opacity-90 cursor-pointer">
          <Plus className="w-4 h-4" /> Crear modulo
        </button>
      </div>

      <div className="space-y-3">
        {modulos.map((modulo, index) => (
          <div key={modulo.id} className="bg-white rounded-xl border border-slate-200 overflow-hidden">
            {/* Modulo header */}
            <div className="px-5 py-4 flex items-center gap-3">
              <div className="flex flex-col">
                <button onClick={() => moveModulo(index, -1)} disabled={index === 0} className="text-slate-400 hover:text-avianca-dark disabled:opacity-20 cursor-pointer disabled:cursor-not-allowed"><ChevronUp className="w-4 h-4" /></button>
                <button onClick={() => moveModulo(index, 1)} disabled={index === modulos.length - 1} className="text-slate-400 hover:text-avianca-dark disabled:opacity-20 cursor-pointer disabled:cursor-not-allowed"><ChevronDown className="w-4 h-4" /></button>
              </div>

              <button onClick={() => setExpandedId(expandedId === modulo.id ? null : modulo.id)} className="flex-1 text-left cursor-pointer">
                <span className="text-xs text-slate-400 font-medium">Sem. {modulo.semana} &middot; Orden {modulo.orden}</span>
                <h3 className="font-semibold text-avianca-dark">{modulo.titulo}</h3>
                <span className="text-xs text-slate-500">{modulo.lecciones?.length || 0} lecciones &middot; {modulo.duracion_minutos} min</span>
              </button>

              <div className="flex items-center gap-2">
                <button onClick={() => setEditingModulo(editingModulo?.id === modulo.id ? null : { ...modulo })} className="flex items-center gap-1 px-3 py-1.5 text-xs font-medium rounded-lg bg-avianca-cyan/10 text-avianca-cyan hover:bg-avianca-cyan/20 cursor-pointer"><Pencil className="w-3.5 h-3.5" /> Editar</button>
                <button onClick={() => setExpandedId(expandedId === modulo.id ? null : modulo.id)} className="flex items-center gap-1 px-3 py-1.5 text-xs font-medium rounded-lg bg-avianca-dark/5 text-avianca-dark hover:bg-avianca-dark/10 cursor-pointer">{expandedId === modulo.id ? <X className="w-3.5 h-3.5" /> : <ChevronDown className="w-3.5 h-3.5" />} Lecciones</button>
                <button onClick={() => setConfirmState({ open: true, action: () => deleteModulo(modulo.id), message: 'Se eliminara este modulo y todo su contenido.' })} className="flex items-center gap-1 px-3 py-1.5 text-xs font-medium rounded-lg text-red-400 hover:bg-red-50 cursor-pointer"><Trash2 className="w-3.5 h-3.5" /></button>
              </div>
            </div>

            {/* Editar modulo */}
            {editingModulo?.id === modulo.id && (
              <div className="px-5 py-4 border-t border-slate-100 bg-slate-50 space-y-3">
                <input value={editingModulo.titulo} onChange={e => setEditingModulo({ ...editingModulo, titulo: e.target.value })} className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm" placeholder="Titulo" />
                <textarea value={editingModulo.descripcion || ''} onChange={e => setEditingModulo({ ...editingModulo, descripcion: e.target.value })} rows={2} className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm" placeholder="Descripcion" />
                <div className="flex gap-3">
                  <label className="text-sm text-slate-600">
                    Semana: <input type="number" min={1} max={4} value={editingModulo.semana} onChange={e => setEditingModulo({ ...editingModulo, semana: Number(e.target.value) })} className="w-16 px-2 py-1 border border-slate-200 rounded text-sm ml-1" />
                  </label>
                  <label className="text-sm text-slate-600">
                    Duracion (min): <input type="number" min={1} value={editingModulo.duracion_minutos} onChange={e => setEditingModulo({ ...editingModulo, duracion_minutos: Number(e.target.value) })} className="w-16 px-2 py-1 border border-slate-200 rounded text-sm ml-1" />
                  </label>
                </div>
                <div className="flex gap-2">
                  <button onClick={saveModulo} disabled={saving} className="px-4 py-2 bg-avianca-green text-white text-sm rounded-lg hover:opacity-90 flex items-center gap-1 cursor-pointer"><Save className="w-3.5 h-3.5" /> {saving ? 'Guardando...' : 'Guardar'}</button>
                  <button onClick={() => setEditingModulo(null)} className="px-4 py-2 text-slate-500 text-sm hover:text-avianca-dark cursor-pointer"><X className="w-3.5 h-3.5 inline" /> Cancelar</button>
                </div>
              </div>
            )}

            {/* Lecciones */}
            {expandedId === modulo.id && (
              <div className="border-t border-slate-100">
                <div className="px-5 py-3 bg-slate-50 flex items-center justify-between">
                  <span className="text-xs font-semibold text-slate-500 uppercase">Lecciones</span>
                  <button onClick={createLeccion} className="flex items-center gap-1 text-xs text-avianca-cyan hover:text-avianca-dark cursor-pointer"><Plus className="w-3.5 h-3.5" /> Agregar</button>
                </div>
                <div className="divide-y divide-slate-100">
                  {lecciones.map((leccion, lIdx) => {
                    const TipoIcon = TIPOS_LECCION.find(t => t.value === leccion.tipo)?.icon || FileText
                    const isEditing = editingLeccion?.id === leccion.id

                    return (
                      <div key={leccion.id} className="px-5 py-3">
                        {!isEditing ? (
                          <div className="flex items-center gap-3">
                            <div className="flex flex-col">
                              <button onClick={() => moveLeccion(lIdx, -1)} disabled={lIdx === 0} className="text-slate-300 hover:text-avianca-dark disabled:opacity-20 cursor-pointer disabled:cursor-not-allowed"><ChevronUp className="w-3 h-3" /></button>
                              <button onClick={() => moveLeccion(lIdx, 1)} disabled={lIdx === lecciones.length - 1} className="text-slate-300 hover:text-avianca-dark disabled:opacity-20 cursor-pointer disabled:cursor-not-allowed"><ChevronDown className="w-3 h-3" /></button>
                            </div>
                            <TipoIcon className="w-4 h-4 text-slate-400 shrink-0" />
                            <div className="flex-1 min-w-0">
                              <p className="text-sm font-medium text-slate-700 truncate">{leccion.titulo}</p>
                              <p className="text-xs text-slate-400">{leccion.tipo} &middot; {leccion.duracion_minutos} min</p>
                            </div>
                            <button onClick={() => setEditingLeccion({ ...leccion })} className="flex items-center gap-1 px-2.5 py-1 text-[11px] font-medium rounded-md bg-avianca-cyan/10 text-avianca-cyan hover:bg-avianca-cyan/20 cursor-pointer"><Pencil className="w-3 h-3" /> Editar</button>
                            <button onClick={() => setConfirmState({ open: true, action: () => deleteLeccion(leccion.id), message: 'Se eliminara esta leccion.' })} className="p-1.5 text-slate-300 hover:text-red-500 cursor-pointer"><Trash2 className="w-3.5 h-3.5" /></button>
                          </div>
                        ) : (
                          <div className="space-y-3 bg-avianca-cyan/5 rounded-lg p-4 -mx-1">
                            <input value={editingLeccion.titulo} onChange={e => setEditingLeccion({ ...editingLeccion, titulo: e.target.value })} className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm" placeholder="Titulo" />
                            <div className="flex gap-3">
                              <select value={editingLeccion.tipo} onChange={e => setEditingLeccion({ ...editingLeccion, tipo: e.target.value })} className="px-3 py-2 border border-slate-200 rounded-lg text-sm">
                                {TIPOS_LECCION.map(t => <option key={t.value} value={t.value}>{t.label}</option>)}
                              </select>
                              <label className="text-sm text-slate-600 flex items-center gap-1">
                                Min: <input type="number" min={1} value={editingLeccion.duracion_minutos} onChange={e => setEditingLeccion({ ...editingLeccion, duracion_minutos: Number(e.target.value) })} className="w-16 px-2 py-1 border border-slate-200 rounded text-sm" />
                              </label>
                            </div>
                            {editingLeccion.tipo === 'video' && (
                              <input value={editingLeccion.contenido?.media_url || ''} onChange={e => setEditingLeccion({ ...editingLeccion, contenido: { ...editingLeccion.contenido, media_url: e.target.value } })} className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm" placeholder="YouTube Video ID (ej: dQw4w9WgXcQ)" />
                            )}
                            {editingLeccion.tipo === 'recurso_externo' && (
                              <>
                                <select value={editingLeccion.contenido?.modo || 'embed'} onChange={e => setEditingLeccion({ ...editingLeccion, contenido: { ...editingLeccion.contenido, modo: e.target.value } })} className="px-3 py-2 border border-slate-200 rounded-lg text-sm">
                                  <option value="embed">Embed (iframe)</option>
                                  <option value="redireccion">Redireccion (boton externo)</option>
                                </select>
                                <textarea value={editingLeccion.contenido?.embed_input || editingLeccion.contenido?.url || ''} onChange={e => setEditingLeccion({ ...editingLeccion, contenido: { ...editingLeccion.contenido, embed_input: e.target.value } })} rows={editingLeccion.contenido?.modo === 'redireccion' ? 1 : 3} className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm font-mono" placeholder={editingLeccion.contenido?.modo === 'redireccion' ? 'URL del recurso (ej: https://ubitslearning.com/...)' : 'Pega el iframe o la URL directa del recurso (Educaplay, Genially, etc.)'} />
                              </>
                            )}
                            {editingLeccion.tipo !== 'recurso_externo' && (
                              <textarea value={editingLeccion.tipo === 'ejercicio' ? (editingLeccion.contenido?.instrucciones || '') : (editingLeccion.contenido?.texto || '')} onChange={e => {
                                const key = editingLeccion.tipo === 'ejercicio' ? 'instrucciones' : 'texto'
                                setEditingLeccion({ ...editingLeccion, contenido: { ...editingLeccion.contenido, [key]: e.target.value } })
                              }} rows={4} className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm font-mono" placeholder={editingLeccion.tipo === 'ejercicio' ? 'Instrucciones del ejercicio (Markdown)' : 'Contenido (Markdown)'} />
                            )}
                            {(editingLeccion.tipo === 'ejercicio' || editingLeccion.tipo === 'recurso_externo') && (
                              <textarea value={editingLeccion.contenido?.texto || ''} onChange={e => setEditingLeccion({ ...editingLeccion, contenido: { ...editingLeccion.contenido, texto: e.target.value } })} rows={2} className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm font-mono" placeholder="Texto complementario (Markdown)" />
                            )}
                            <div className="flex gap-2">
                              <button onClick={saveLeccion} disabled={saving} className="px-3 py-1.5 bg-avianca-green text-white text-xs rounded-lg hover:opacity-90 flex items-center gap-1 cursor-pointer"><Save className="w-3 h-3" /> {saving ? 'Guardando...' : 'Guardar'}</button>
                              <button onClick={() => setEditingLeccion(null)} className="px-3 py-1.5 text-slate-500 text-xs cursor-pointer">Cancelar</button>
                            </div>
                          </div>
                        )}
                      </div>
                    )
                  })}
                  {lecciones.length === 0 && (
                    <p className="px-5 py-4 text-sm text-slate-400 text-center">Sin lecciones. Agrega una para comenzar.</p>
                  )}
                </div>
              </div>
            )}
          </div>
        ))}
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
