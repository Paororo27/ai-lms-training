import { useState } from 'react'
import { useNavigate } from 'react-router'
import { useAuth } from '../context/auth-context'
import aviancaLogo from '../assets/avianca-logo.png'

export default function Login() {
  const [code, setCode] = useState('')
  const [password, setPassword] = useState('')
  const [error, setError] = useState('')
  const [loading, setLoading] = useState(false)
  const { signIn } = useAuth()
  const navigate = useNavigate()

  const handleSubmit = async (e) => {
    e.preventDefault()
    setError('')
    setLoading(true)

    try {
      await signIn(code, password)
      navigate('/course', { replace: true })
    } catch {
      setError('Codigo o contraseña incorrectos')
    } finally {
      setLoading(false)
    }
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-avianca-dark to-slate-900 flex items-center justify-center p-4">
      <div className="w-full max-w-md">
        <div className="text-center mb-8">
          <img src={aviancaLogo} alt="Avianca" className="h-10 mx-auto mb-4" />
          <h1 className="text-2xl font-bold text-white">Taller Copilot Chat</h1>
          <p className="text-slate-400 mt-1">Ingresa con tu codigo de acceso</p>
        </div>

        <form onSubmit={handleSubmit} className="bg-white/5 backdrop-blur-sm border border-white/10 rounded-2xl p-8 space-y-5">
          <div>
            <label htmlFor="code" className="block text-sm font-medium text-slate-300 mb-1.5">
              Codigo de acceso
            </label>
            <input
              id="code"
              type="text"
              value={code}
              onChange={(e) => setCode(e.target.value)}
              placeholder="AVN-XXXX"
              required
              autoFocus
              className="w-full px-4 py-3 bg-white/10 border border-white/20 rounded-xl text-white placeholder-slate-500 focus:outline-none focus:ring-2 focus:ring-avianca-cyan focus:border-transparent transition-all"
            />
          </div>

          <div>
            <label htmlFor="password" className="block text-sm font-medium text-slate-300 mb-1.5">
              Contraseña
            </label>
            <input
              id="password"
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              required
              className="w-full px-4 py-3 bg-white/10 border border-white/20 rounded-xl text-white placeholder-slate-500 focus:outline-none focus:ring-2 focus:ring-avianca-cyan focus:border-transparent transition-all"
            />
          </div>

          {error && (
            <p className="text-red-400 text-sm text-center bg-red-400/10 rounded-lg py-2">
              {error}
            </p>
          )}

          <button
            type="submit"
            disabled={loading}
            className="w-full py-3 px-4 bg-gradient-to-r from-avianca-red to-avianca-magenta text-white font-semibold rounded-xl hover:opacity-90 disabled:opacity-50 transition-all cursor-pointer"
          >
            {loading ? 'Ingresando...' : 'Ingresar al taller'}
          </button>
        </form>

        <p className="text-center text-slate-500 text-xs mt-6">
          Si no tienes tu codigo de acceso, contacta al administrador del programa.
        </p>
      </div>
    </div>
  )
}
