import { useEffect, useState } from 'react'
import { CheckCircle, AlertCircle, X } from 'lucide-react'

let toastId = 0
let addToastExternal = null

export function toast(message, type = 'success') {
  if (addToastExternal) addToastExternal({ id: ++toastId, message, type })
}

export function ToastContainer() {
  const [toasts, setToasts] = useState([])

  addToastExternal = (t) => setToasts(prev => [...prev, t])

  const remove = (id) => setToasts(prev => prev.filter(t => t.id !== id))

  return (
    <div className="fixed bottom-4 right-4 z-50 flex flex-col gap-2 max-w-sm">
      {toasts.map(t => (
        <Toast key={t.id} {...t} onClose={() => remove(t.id)} />
      ))}
    </div>
  )
}

function Toast({ message, type, onClose }) {
  useEffect(() => {
    const timer = setTimeout(onClose, 3000)
    return () => clearTimeout(timer)
  }, [onClose])

  return (
    <div className={`flex items-center gap-2.5 px-4 py-3 rounded-xl shadow-lg text-sm font-medium animate-[slideIn_0.2s_ease-out] ${
      type === 'success' ? 'bg-avianca-dark text-white' :
      type === 'error' ? 'bg-red-600 text-white' :
      'bg-avianca-cyan text-avianca-dark'
    }`}>
      {type === 'success' ? <CheckCircle className="w-4 h-4 shrink-0" /> : <AlertCircle className="w-4 h-4 shrink-0" />}
      <span className="flex-1">{message}</span>
      <button onClick={onClose} className="p-0.5 hover:opacity-70 cursor-pointer"><X className="w-3.5 h-3.5" /></button>
    </div>
  )
}
