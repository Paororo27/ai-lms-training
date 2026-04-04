import { useNavigate } from 'react-router'
import { ArrowLeft } from 'lucide-react'

export default function NotFound() {
  const navigate = useNavigate()

  return (
    <div className="min-h-screen flex items-center justify-center bg-slate-50 p-4">
      <div className="text-center max-w-sm">
        <p className="text-6xl font-extrabold text-avianca-dark">404</p>
        <p className="text-slate-500 mt-3 mb-6">Esta pagina no existe o fue movida.</p>
        <button
          onClick={() => navigate('/course', { replace: true })}
          className="inline-flex items-center gap-2 px-5 py-2.5 bg-avianca-dark text-white text-sm font-medium rounded-xl hover:opacity-90 cursor-pointer"
        >
          <ArrowLeft className="w-4 h-4" /> Volver al taller
        </button>
      </div>
    </div>
  )
}
