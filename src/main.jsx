import { StrictMode, lazy, Suspense } from 'react'
import { createRoot } from 'react-dom/client'
import { createBrowserRouter, RouterProvider } from 'react-router'
import './index.css'
import App from './App.jsx'
import { AuthProvider } from './context/auth-context'
import ProtectedRoute from './components/protected-route'

const Login = lazy(() => import('./course/login'))
const CourseLayout = lazy(() => import('./course/layout'))
const Dashboard = lazy(() => import('./course/dashboard'))
const Modulo = lazy(() => import('./course/modulo'))
const Prueba = lazy(() => import('./course/prueba'))
const Diagnostico = lazy(() => import('./course/diagnostico'))
const Reto = lazy(() => import('./course/reto'))
const Certificado = lazy(() => import('./course/certificado'))
const Admin = lazy(() => import('./course/admin'))
const AdminModulos = lazy(() => import('./course/admin/admin-modulos'))
const AdminPruebas = lazy(() => import('./course/admin/admin-pruebas'))
const AdminRetos = lazy(() => import('./course/admin/admin-retos'))

const Loading = () => (
  <div className="min-h-screen flex items-center justify-center bg-avianca-dark">
    <div className="animate-spin rounded-full h-8 w-8 border-t-2 border-avianca-cyan" />
  </div>
)

const router = createBrowserRouter([
  {
    path: '/',
    element: <App />,
  },
  {
    path: '/course/login',
    element: (
      <Suspense fallback={<Loading />}>
        <Login />
      </Suspense>
    ),
  },
  {
    element: <ProtectedRoute />,
    children: [
      {
        path: '/course',
        element: (
          <Suspense fallback={<Loading />}>
            <CourseLayout />
          </Suspense>
        ),
        children: [
          { index: true, element: <Suspense fallback={<Loading />}><Dashboard /></Suspense> },
          { path: 'modulo/:id', element: <Suspense fallback={<Loading />}><Modulo /></Suspense> },
          { path: 'modulo/:id/prueba', element: <Suspense fallback={<Loading />}><Prueba /></Suspense> },
          { path: 'diagnostico/:tipo', element: <Suspense fallback={<Loading />}><Diagnostico /></Suspense> },
          { path: 'reto', element: <Suspense fallback={<Loading />}><Reto /></Suspense> },
          { path: 'certificado', element: <Suspense fallback={<Loading />}><Certificado /></Suspense> },
        ],
      },
    ],
  },
  {
    element: <ProtectedRoute adminOnly />,
    children: [
      {
        element: (
          <Suspense fallback={<Loading />}>
            <CourseLayout />
          </Suspense>
        ),
        children: [
          { path: '/course/admin', element: <Suspense fallback={<Loading />}><Admin /></Suspense> },
          { path: '/course/admin/modulos', element: <Suspense fallback={<Loading />}><AdminModulos /></Suspense> },
          { path: '/course/admin/modulos/:id', element: <Suspense fallback={<Loading />}><AdminModulos /></Suspense> },
          { path: '/course/admin/pruebas', element: <Suspense fallback={<Loading />}><AdminPruebas /></Suspense> },
          { path: '/course/admin/pruebas/:id', element: <Suspense fallback={<Loading />}><AdminPruebas /></Suspense> },
          { path: '/course/admin/retos', element: <Suspense fallback={<Loading />}><AdminRetos /></Suspense> },
        ],
      },
    ],
  },
])

createRoot(document.getElementById('root')).render(
  <StrictMode>
    <AuthProvider>
      <RouterProvider router={router} />
    </AuthProvider>
  </StrictMode>,
)
