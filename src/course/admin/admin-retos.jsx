import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router'
import { supabase } from '../../lib/supabase'
import { ChevronLeft, Plus, Trash2, Pencil, Save, X } from 'lucide-react'
import { toast } from '../../components/toast'

export default function AdminRetos() {
  const navigate = useNavigate()
  const [retos, setRetos] = useState([])
  const [editing, setEditing] = useState(null)
  const [loading, setLoading] = useState(true)
  const [saving, setSaving] = useState(false)

  useEffect(() => { loadRetos() }, [])

  const loadRetos = async () => {
    const { data, error } = await supabase.from('retos').select('*').order('id')
    if (error) toast('Error cargando retos', 'error')
    setRetos(data || [])
    setLoading(false)
  }

  const createReto = async () => {
    const { data, error } = await supabase.from('retos').insert({
      titulo: 'Nuevo reto', escenario: '', criterios_evaluacion: [],
    }).select().single()
    if (error) { toast('Error creando reto', 'error'); return }
    if (data) {
      setRetos([...retos, data])
      setEditing(data)
      toast('Reto creado')
    }
  }

  const saveReto = async () => {
    if (!editing) return
    setSaving(true)
    const { data: updated, error } = await supabase.from('retos').update({
      titulo: editing.titulo, escenario: editing.escenario,
      criterios_evaluacion: editing.criterios_evaluacion,
    }).eq('id', editing.id).select()
    if (error || !updated?.length) { toast(error?.message || 'No se pudo guardar', 'error'); setSaving(false); return }
    setRetos(retos.map(r => r.id === editing.id ? { ...r, ...editing } : r))
    setEditing(null)
    setSaving(false)
    toast('Reto actualizado')
  }

  const deleteReto = async (id) => {
    if (!confirm('Eliminar este reto?')) return
    const { error } = await supabase.from('retos').delete().eq('id', id)
    if (error) { toast('Error eliminando reto', 'error'); return }
    setRetos(retos.filter(r => r.id !== id))
    toast('Reto eliminado')
  }

  // Criterios dinamicos
  const addCriterio = () => {
    if (!editing) return
    setEditing({ ...editing, criterios_evaluacion: [...(editing.criterios_evaluacion || []), ''] })
  }

  const updateCriterio = (idx, value) => {
    if (!editing) return
    const newCriterios = [...editing.criterios_evaluacion]
    newCriterios[idx] = value
    setEditing({ ...editing, criterios_evaluacion: newCriterios })
  }

  const removeCriterio = (idx) => {
    if (!editing) return
    setEditing({ ...editing, criterios_evaluacion: editing.criterios_evaluacion.filter((_, i) => i !== idx) })
  }

  if (loading) return <div className="flex justify-center py-20"><div className="animate-spin rounded-full h-8 w-8 border-t-2 border-avianca-cyan" /></div>

  return (
    <div className="max-w-4xl mx-auto space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <button onClick={() => navigate('/course/admin')} className="text-sm text-slate-500 hover:text-avianca-dark flex items-center gap-1 mb-1 cursor-pointer">
            <ChevronLeft className="w-4 h-4" /> Admin
          </button>
          <h1 className="text-xl font-bold text-avianca-dark">Gestion de Retos</h1>
          <p className="text-sm text-slate-500">{retos.length} retos en el pool</p>
        </div>
        <button onClick={createReto} className="flex items-center gap-1.5 px-4 py-2 bg-avianca-cyan text-white text-sm font-medium rounded-lg hover:opacity-90 cursor-pointer">
          <Plus className="w-4 h-4" /> Crear reto
        </button>
      </div>

      <div className="space-y-3">
        {retos.map((reto) => (
          <div key={reto.id} className="bg-white rounded-xl border border-slate-200 overflow-hidden">
            {editing?.id === reto.id ? (
              <div className="p-5 space-y-3">
                <input value={editing.titulo} onChange={e => setEditing({ ...editing, titulo: e.target.value })} className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm font-medium" placeholder="Titulo del reto" />

                <div>
                  <label className="text-xs font-semibold text-slate-500 block mb-1">Escenario</label>
                  <textarea value={editing.escenario} onChange={e => setEditing({ ...editing, escenario: e.target.value })} rows={6} className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm" placeholder="Describe el caso practico que el participante debe resolver..." />
                </div>

                <div>
                  <div className="flex items-center justify-between mb-2">
                    <label className="text-xs font-semibold text-slate-500">Criterios de evaluacion</label>
                    <button onClick={addCriterio} className="text-xs text-avianca-cyan hover:text-avianca-dark cursor-pointer">+ Agregar criterio</button>
                  </div>
                  <div className="space-y-2">
                    {(editing.criterios_evaluacion || []).map((criterio, idx) => (
                      <div key={idx} className="flex items-center gap-2">
                        <span className="w-1.5 h-1.5 bg-avianca-orange rounded-full shrink-0" />
                        <input value={criterio} onChange={e => updateCriterio(idx, e.target.value)} className="flex-1 px-3 py-1.5 border border-slate-200 rounded-lg text-sm" placeholder="Criterio..." />
                        <button onClick={() => removeCriterio(idx)} className="p-1 text-slate-400 hover:text-red-500 cursor-pointer"><X className="w-3.5 h-3.5" /></button>
                      </div>
                    ))}
                  </div>
                </div>

                <div className="flex gap-2 pt-2">
                  <button onClick={saveReto} disabled={saving} className="px-4 py-2 bg-avianca-green text-white text-sm rounded-lg hover:opacity-90 flex items-center gap-1 cursor-pointer"><Save className="w-3.5 h-3.5" /> {saving ? 'Guardando...' : 'Guardar'}</button>
                  <button onClick={() => setEditing(null)} className="px-4 py-2 text-slate-500 text-sm cursor-pointer">Cancelar</button>
                </div>
              </div>
            ) : (
              <div className="p-5">
                <div className="flex items-start justify-between gap-3">
                  <div className="flex-1 min-w-0">
                    <h3 className="font-semibold text-avianca-dark">{reto.titulo}</h3>
                    <p className="text-sm text-slate-500 mt-1 line-clamp-3">{reto.escenario}</p>
                    {reto.criterios_evaluacion?.length > 0 && (
                      <div className="flex gap-2 mt-2 flex-wrap">
                        {reto.criterios_evaluacion.map((c, i) => (
                          <span key={i} className="text-[11px] px-2 py-0.5 rounded bg-avianca-orange/10 text-avianca-orange">{c}</span>
                        ))}
                      </div>
                    )}
                  </div>
                  <div className="flex items-center gap-1 shrink-0">
                    <button onClick={() => setEditing({ ...reto })} className="p-2 text-slate-400 hover:text-avianca-cyan cursor-pointer"><Pencil className="w-4 h-4" /></button>
                    <button onClick={() => deleteReto(reto.id)} className="p-2 text-slate-400 hover:text-red-500 cursor-pointer"><Trash2 className="w-4 h-4" /></button>
                  </div>
                </div>
              </div>
            )}
          </div>
        ))}

        {retos.length === 0 && (
          <div className="text-center py-12 text-slate-400">
            <p>No hay retos. Crea uno para empezar.</p>
          </div>
        )}
      </div>
    </div>
  )
}
