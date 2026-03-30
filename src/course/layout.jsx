import { Outlet, NavLink, useNavigate } from 'react-router'
import { useAuth } from '../context/auth-context'
import { LogOut, BookOpen, Shield } from 'lucide-react'
import aviancaLogo from '../assets/avianca-logo.png'
import { ToastContainer } from '../components/toast'

export default function CourseLayout() {
  const { userCode, role, signOut } = useAuth()
  const navigate = useNavigate()

  const handleLogout = async () => {
    await signOut()
    navigate('/course/login', { replace: true })
  }

  return (
    <div className="min-h-screen bg-slate-50">
      <header className="bg-avianca-dark text-white sticky top-0 z-50">
        <div className="max-w-7xl mx-auto px-4 h-14 flex items-center justify-between">
          <div className="flex items-center gap-3">
            <img src={aviancaLogo} alt="Avianca" className="h-6" />
            <NavLink to="/course" className="font-semibold text-sm hover:text-avianca-cyan transition-colors">
              Taller Copilot
            </NavLink>
          </div>

          <div className="flex items-center gap-4">
            {role === 'admin' && (
              <NavLink
                to="/course/admin"
                className={({ isActive }) =>
                  `flex items-center gap-1.5 text-xs px-3 py-1.5 rounded-lg transition-colors ${
                    isActive ? 'bg-avianca-cyan/20 text-avianca-cyan' : 'text-slate-400 hover:text-white'
                  }`
                }
              >
                <Shield className="w-3.5 h-3.5" />
                Admin
              </NavLink>
            )}

            <div className="flex items-center gap-3 text-sm">
              <span className="text-slate-400 hidden sm:inline">
                <BookOpen className="w-3.5 h-3.5 inline mr-1" />
                {userCode}
              </span>
              <button
                onClick={handleLogout}
                className="flex items-center gap-1 text-slate-400 hover:text-white transition-colors cursor-pointer"
              >
                <LogOut className="w-4 h-4" />
                <span className="hidden sm:inline text-xs">Salir</span>
              </button>
            </div>
          </div>
        </div>
      </header>

      <main className="max-w-5xl mx-auto px-4 py-8">
        <Outlet />
      </main>
      <ToastContainer />
    </div>
  )
}
