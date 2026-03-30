import { Navigate, Outlet } from 'react-router'
import { useAuth } from '../context/auth-context'

export default function ProtectedRoute({ adminOnly = false }) {
  const { user, loading, role } = useAuth()

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-avianca-dark">
        <div className="animate-spin rounded-full h-8 w-8 border-t-2 border-avianca-cyan" />
      </div>
    )
  }

  if (!user) return <Navigate to="/course/login" replace />
  if (adminOnly && role !== 'admin') return <Navigate to="/course" replace />

  return <Outlet />
}
