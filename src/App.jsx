import React, { useEffect, useRef, useState } from 'react';
import { Calendar, Clock, MapPin, Sparkles, Brain, Layout, BarChart, Users, Trophy, Zap, Mail, X, Copy, FileSearch, Database, Globe, Heart } from 'lucide-react';
import './App.css';
import aviancaLogo from './assets/avianca-logo.png';
import aiCloud from './assets/ai-cloud.png';

// Hook para revelar elementos al hacer scroll
const useScrollReveal = (options = {}) => {
  const ref = useRef(null);
  const [isVisible, setIsVisible] = useState(false);

  useEffect(() => {
    const observer = new IntersectionObserver(
      ([entry]) => {
        if (entry.isIntersecting) {
          setIsVisible(true);
          observer.unobserve(entry.target);
        }
      },
      { threshold: 0.15, ...options }
    );

    if (ref.current) observer.observe(ref.current);
    return () => observer.disconnect();
  }, []);

  return [ref, isVisible];
};

// Componente wrapper para scroll reveal con delay escalonado
const Reveal = ({ children, delay = 0, className = '', direction = 'up' }) => {
  const [ref, isVisible] = useScrollReveal();

  const directions = {
    up: 'translate-y-12',
    down: '-translate-y-12',
    left: 'translate-x-12',
    right: '-translate-x-12',
  };

  return (
    <div
      ref={ref}
      className={`transition-all duration-700 ease-out ${className} ${
        isVisible ? 'opacity-100 translate-x-0 translate-y-0' : `opacity-0 ${directions[direction]}`
      }`}
      style={{ transitionDelay: `${delay}ms` }}
    >
      {children}
    </div>
  );
};

// Avión de papel blanco con rojo
const PaperPlane = ({ flying }) => {
  return (
    <svg
      viewBox="0 0 256 256"
      className={`absolute w-12 h-12 md:w-16 md:h-16 drop-shadow-lg ${
        flying ? 'plane-loop' : 'opacity-0'
      }`}
      style={{ top: 0, left: 0 }}
    >
      <g transform="translate(1.4 1.4) scale(2.81 2.81)">
        <path d="M 89.981 6.2 C 90 6.057 90.001 5.915 89.979 5.775 c -0.003 -0.021 -0.001 -0.041 -0.005 -0.062 c -0.033 -0.163 -0.098 -0.317 -0.183 -0.462 c -0.009 -0.016 -0.01 -0.033 -0.019 -0.049 c -0.015 -0.024 -0.039 -0.036 -0.055 -0.059 c -0.034 -0.048 -0.06 -0.102 -0.101 -0.146 c -0.051 -0.056 -0.113 -0.097 -0.17 -0.144 c -0.031 -0.025 -0.058 -0.054 -0.09 -0.076 c -0.134 -0.093 -0.28 -0.164 -0.436 -0.209 c -0.028 -0.008 -0.056 -0.009 -0.084 -0.015 c -0.132 -0.03 -0.267 -0.041 -0.404 -0.034 c -0.046 0.002 -0.089 0.006 -0.135 0.012 c -0.039 0.006 -0.079 0.002 -0.118 0.01 l -87 19.456 c -0.611 0.137 -1.073 0.639 -1.159 1.259 c -0.085 0.62 0.224 1.229 0.775 1.525 l 23.523 12.661 l 7.327 23.36 c 0.008 0.025 0.025 0.043 0.034 0.067 c 0.021 0.056 0.052 0.106 0.08 0.16 c 0.059 0.114 0.127 0.218 0.211 0.312 c 0.022 0.025 0.03 0.057 0.054 0.08 c 0.022 0.021 0.05 0.028 0.073 0.048 c 0.099 0.086 0.207 0.155 0.325 0.213 c 0.047 0.023 0.088 0.053 0.136 0.07 c 0.164 0.061 0.336 0.1 0.517 0.1 c 0.011 0 0.022 0 0.033 0 c 0.179 -0.004 0.349 -0.044 0.509 -0.107 c 0.041 -0.016 0.075 -0.044 0.114 -0.063 c 0.127 -0.063 0.244 -0.139 0.349 -0.235 c 0.02 -0.018 0.046 -0.024 0.065 -0.044 l 12.009 -12.209 l 23.18 12.477 c 0.221 0.119 0.466 0.18 0.711 0.18 c 0.188 0 0.378 -0.035 0.557 -0.107 c 0.412 -0.164 0.73 -0.504 0.869 -0.926 L 89.93 6.473 c 0.014 -0.044 0.015 -0.09 0.025 -0.135 C 89.966 6.292 89.975 6.247 89.981 6.2 z M 77.435 10.018 L 25.58 36.717 L 5.758 26.047 L 77.435 10.018 z M 74.32 14.997 L 36.813 43.768 c -0.003 0.002 -0.005 0.006 -0.007 0.008 c -0.112 0.087 -0.209 0.194 -0.294 0.314 c -0.018 0.025 -0.035 0.05 -0.051 0.076 c -0.017 0.028 -0.039 0.052 -0.055 0.081 c -0.054 0.1 -0.093 0.204 -0.122 0.309 c -0.001 0.005 -0.005 0.009 -0.006 0.014 L 32.96 56.977 l -5.586 -17.809 L 74.32 14.997 z M 35.992 57.249 l 2.693 -10.072 l 4.717 2.539 L 35.992 57.249 z M 69.177 60.184 L 40.479 44.737 l 45.09 -34.588 L 69.177 60.184 z"
          fill="#FF0000" stroke="none" />
        <path d="M 77.435 10.018 L 25.58 36.717 L 5.758 26.047 Z" fill="white" stroke="none" />
        <path d="M 74.32 14.997 L 27.374 39.168 L 32.96 56.977 L 36.278 44.57 Z" fill="white" stroke="none" />
        <path d="M 35.992 57.249 l 2.693 -10.072 l 4.717 2.539 Z" fill="#fff0f0" stroke="none" />
        <path d="M 69.177 60.184 L 40.479 44.737 l 45.09 -34.588 Z" fill="white" stroke="none" />
      </g>
    </svg>
  );
};

const App = () => {
  const colors = {
    primaryRed: '#FF0000',
    primaryMagenta: '#B50080',
    cyan: '#89D4E1',
    pink: '#FF3093',
    orange: '#F98013',
    blue: '#1D9BF0',
    green: '#23C847',
    dark: '#1e293b',
    gradient: 'linear-gradient(135deg, #FF0000 0%, #B50080 100%)',
    softCyan: 'rgba(137, 212, 225, 0.15)',
  };

  const modules = [
    {
      id: 1,
      week: "Semana 1",
      title: "Nuevos Horizontes: El Despertar Digital",
      desc: "Descubre el potencial de la IA y los fundamentos de los modelos de lenguaje.",
      preview: "Identificar el potencial de escala de la IA, comprender los LLM e implementar protocolos de anonimización de datos sensibles.",
      date: "9 – 15 de abril",
      icon: <Sparkles className="w-6 h-6" />,
      color: colors.cyan
    },
    {
      id: 2,
      week: "Semana 1",
      title: "Ingeniería del Diálogo: El Arte del Prompt",
      desc: "Domina el framework profesional de arquitectura de instrucciones.",
      preview: "Aplicar restricciones para guiar a la IA, perfeccionar entregables complejos mediante la iteración.",
      date: "9 – 15 de abril",
      icon: <Brain className="w-6 h-6" />,
      color: colors.orange
    },
    {
      id: 3,
      week: "Semana 2",
      title: "ADN Digital: Clonación y Lógica",
      desc: "Clona el tono de voz de la empresa y estandariza la excelencia.",
      preview: "Evitar sesgos y errores en análisis complejos, estandarizar la calidad en todo el departamento.",
      date: "16 – 22 de abril",
      icon: <Copy className="w-6 h-6" />,
      color: colors.pink
    },
    {
      id: 4,
      week: "Semana 2",
      title: "Arquitectos de Copilotos: Tu Yo Aumentado",
      desc: "Diseña flujos de trabajo y configura tu Instrucción Maestra.",
      preview: "Diseñar flujos secuenciales para proyectos largos, automatizar tareas diarias y delegar operaciones efectivamente.",
      date: "16 – 22 de abril",
      icon: <Layout className="w-6 h-6" />,
      color: colors.blue
    },
    {
      id: 5,
      week: "Semana 3",
      title: "Minería de Valor: Documentos Inteligentes",
      desc: "Procesa archivos extensos y genera visualizaciones rápidas.",
      preview: "Sintetizar documentos detectando puntos clave, ejecutar limpieza de datos y generar visualizaciones.",
      date: "23 – 29 de abril",
      icon: <FileSearch className="w-6 h-6" />,
      color: colors.green
    },
    {
      id: 6,
      week: "Semana 3",
      title: "Alquimia de Datos: Historias que Deciden",
      desc: "Cruza bases de datos y construye narrativas de impacto.",
      preview: "Realizar cruces relacionales sin fórmulas complejas, diseñar presentaciones ejecutivas que traduzcan datos en decisiones.",
      date: "23 – 29 de abril",
      icon: <Database className="w-6 h-6" />,
      color: colors.primaryRed
    },
    {
      id: 7,
      week: "Semana 4",
      title: "Exploradores del Ecosistema: Más allá del Texto",
      desc: "Potencia la comunicación con generadores visuales y tendencias globales.",
      preview: "Utilizar generadores visuales, identificar tendencias de IA aplicadas al bienestar e integrar herramientas creativas.",
      date: "30 abr – 6 de mayo",
      icon: <Globe className="w-6 h-6" />,
      color: colors.primaryMagenta
    },
    {
      id: 8,
      week: "Semana 4",
      title: "Conexión Aumentada: IA con Propósito",
      desc: "Aplica la IA en retos cotidianos y lidera la cultura de innovación.",
      preview: "Aplicar IA para ganar calidad de vida, liderar dinámicas innovadoras y viralizar la cultura de innovación.",
      date: "30 abr – 6 de mayo",
      icon: <Heart className="w-6 h-6" />,
      color: colors.primaryRed
    }
  ];

  const [letterOpen, setLetterOpen] = useState(false);

  // Estado para la animación de aviones en el footer
  const footerRef = useRef(null);
  const [planesFlying, setPlanesFlying] = useState(false);

  useEffect(() => {
    const observer = new IntersectionObserver(
      ([entry]) => {
        if (entry.isIntersecting) {
          setTimeout(() => setPlanesFlying(true), 400);
          observer.unobserve(entry.target);
        }
      },
      { threshold: 0.4 }
    );

    if (footerRef.current) observer.observe(footerRef.current);
    return () => observer.disconnect();
  }, []);

  return (
    <div className="min-h-screen bg-slate-50 font-sans text-slate-900 selection:bg-cyan-100 overflow-x-clip">
      {/* Hero */}
      <header
        style={{ backgroundColor: colors.cyan }}
        className="relative overflow-hidden pt-20 pb-32 px-6 text-center"
      >
        <div className="absolute top-0 left-0 w-full h-full overflow-hidden pointer-events-none opacity-40">
          <div className="absolute -top-24 -left-24 w-96 h-96 rounded-full bg-white/40 blur-3xl"></div>
          <div className="absolute top-1/2 -right-24 w-64 h-64 rounded-full bg-blue-400/20 blur-3xl"></div>
        </div>

        {/* Logo Avianca esquina superior derecha */}
        <div className="absolute top-6 right-6 md:top-8 md:right-10 z-20">
          <img src={aviancaLogo} alt="Avianca" className="h-20 md:h-28 object-contain" />
        </div>

        {/* Nube AI a la misma altura que el logo Avianca, lado izquierdo */}
        <img src={aiCloud} alt="AI" className="absolute left-4 top-6 h-16 sm:left-6 sm:h-20 md:left-[8%] md:top-8 md:h-28 lg:h-36 object-contain animate-float z-20 pointer-events-none" />

        <div className="max-w-4xl mx-auto relative z-10">
          <div className="pt-16 md:pt-20"></div>

          <Reveal delay={100}>
            <h1 className="text-4xl md:text-6xl font-black tracking-tight mb-6 leading-tight text-slate-900">
              Lideremos el futuro, <span style={{ color: colors.primaryMagenta }}>juntos.</span>
            </h1>
          </Reveal>

          <Reveal delay={350}>
            <p className="text-lg md:text-xl text-slate-700 max-w-2xl mx-auto mb-10 leading-relaxed font-medium">
              Nuestro talento nos trajo hasta acá, pero la tecnología nos permitirá llegar más lejos. Iniciamos este camino para potenciar nuestra visión.
            </p>
          </Reveal>
        </div>
      </header>

      {/* Tarjeta principal */}
      <section className="max-w-6xl mx-auto px-6 -mt-16 relative z-20">
        <Reveal>
          <div className="bg-white rounded-[2.5rem] shadow-2xl shadow-slate-200/60 p-8 md:p-14 border border-white">
            <div className="grid lg:grid-cols-12 gap-12 items-center">
              <div className="lg:col-span-7">
                <Reveal delay={100}>
                  <div
                    className="w-12 h-1.5 rounded-full mb-8"
                    style={{ background: colors.gradient }}
                  ></div>
                  <h2 className="text-3xl font-extrabold mb-6 text-slate-900 leading-tight">
                    Evolucionamos nuestra <br/>forma de trabajar.
                  </h2>
                </Reveal>

                <Reveal delay={200}>
                  <p className="text-slate-600 mb-10 leading-relaxed text-lg">
                    Diseñamos este programa para convertir a la Inteligencia Artificial en tu principal aliado estratégico. Con una metodología flexible, aprenderemos a automatizar lo rutinario para enfocar nuestra energía en lo que verdaderamente genera valor.
                  </p>
                </Reveal>

                <Reveal delay={300}>
                  <div className="flex flex-wrap gap-8">
                    <div className="flex items-center gap-4">
                      <div className="w-12 h-12 rounded-2xl bg-slate-50 flex items-center justify-center text-blue-500">
                        <Clock className="w-6 h-6" />
                      </div>
                      <div>
                        <p className="text-sm font-bold text-slate-800">1.5 Horas Semanales</p>
                        <p className="text-xs text-slate-400">Formato flexible</p>
                      </div>
                    </div>
                    <div className="flex items-center gap-4">
                      <div className="w-12 h-12 rounded-2xl bg-slate-50 flex items-center justify-center text-green-500">
                        <Calendar className="w-6 h-6" />
                      </div>
                      <div>
                        <p className="text-sm font-bold text-slate-800">Un mes de duración</p>
                        <p className="text-xs text-slate-400">Abril 2026</p>
                      </div>
                    </div>
                  </div>
                </Reveal>
              </div>

              <div className="lg:col-span-5">
                <Reveal delay={400} direction="right">
                  <div
                    className="rounded-3xl p-10 text-white relative overflow-hidden flex flex-col justify-center shadow-xl transform lg:rotate-2 hover:rotate-0 transition-all duration-500"
                    style={{ background: colors.gradient }}
                  >
                    <div className="absolute top-0 right-0 p-4 opacity-10">
                      <Zap className="w-32 h-32 rotate-12" />
                    </div>

                    <span className="text-[10px] font-bold tracking-[0.3em] uppercase mb-4 opacity-80">Encuentro inicial</span>
                    <h3 className="text-2xl font-black mb-8 leading-tight">📍 Kick-off Presencial</h3>

                    <div className="space-y-6">
                      <div className="flex items-center gap-4 group">
                        <div className="w-10 h-10 rounded-xl bg-white/20 backdrop-blur-md flex items-center justify-center border border-white/20">
                          <Calendar className="w-5 h-5" />
                        </div>
                        <p className="font-bold text-base">Miércoles, 8 de Abril</p>
                      </div>
                      <div className="flex items-center gap-4 group">
                        <div className="w-10 h-10 rounded-xl bg-white/20 backdrop-blur-md flex items-center justify-center border border-white/20">
                          <Clock className="w-5 h-5" />
                        </div>
                        <p className="font-bold text-base">9:00 - 10:00 AM</p>
                      </div>
                      <div className="flex items-center gap-4 group">
                        <div className="w-10 h-10 rounded-xl bg-white/20 backdrop-blur-md flex items-center justify-center border border-white/20">
                          <MapPin className="w-5 h-5" />
                        </div>
                        <div>
                          <p className="font-bold text-base">CAV, Segundo Piso</p>
                          <p className="text-xs text-white/70">Si no estás en Bogotá, lo transmitiremos</p>
                        </div>
                      </div>
                    </div>

                    <a
                      href="https://forms.cloud.microsoft/Pages/ResponsePage.aspx?id=Pt2topeDeUW6MHo4gD_DvyLw7GkZYmJEqS2vAfaKbxFUMDFOT1dLTVhTSzlZSE9JMUFVTE5MT1pMSi4u"
                      target="_blank"
                      rel="noopener noreferrer"
                      className="mt-8 inline-block w-full text-center py-3.5 px-6 rounded-2xl font-bold text-base bg-white text-red-600 hover:bg-red-50 transition-all duration-300 shadow-lg hover:shadow-xl hover:scale-[1.02]"
                    >
                      Inscribirme
                    </a>
                  </div>
                </Reveal>
              </div>
            </div>
          </div>
        </Reveal>
      </section>

      {/* Hoja de Ruta con timeline */}
      <section className="max-w-6xl mx-auto px-6 py-28">
        <Reveal>
          <div className="mb-16">
            <h2 className="text-3xl font-black text-slate-900 mb-4 uppercase tracking-tight">Hoja de Ruta</h2>
            <p className="text-slate-500 text-lg">Un mes de transformación diseñado para tu día a día profesional. 8 cursos en 4 semanas, 2 cursos por semana. Organiza tu tiempo de estudio acorde a tu agenda.</p>
          </div>
        </Reveal>

        <div className="space-y-12">
          {[1, 2, 3, 4].map((weekNum) => {
            const weekModules = modules.filter(m => m.week === `Semana ${weekNum}`);
            const weekDate = weekModules[0]?.date;
            return (
              <Reveal key={weekNum} delay={weekNum * 100}>
                <div className="flex flex-col md:flex-row gap-5 md:gap-8">
                  {/* Etiqueta de semana */}
                  <div className="md:w-36 shrink-0 flex md:flex-col items-center md:items-start gap-2 md:pt-4">
                    <div className="px-4 py-2 rounded-xl bg-avianca-dark text-white text-sm font-bold">
                      Semana {weekNum}
                    </div>
                    <span className="text-xs text-slate-400 font-medium">{weekDate}</span>
                  </div>

                  {/* 2 cursos por fila */}
                  <div className="flex-1 grid grid-cols-1 sm:grid-cols-2 gap-5">
                    {weekModules.map((m) => (
                      <div
                        key={m.id}
                        className="bg-white p-7 rounded-[2rem] border border-slate-100 shadow-sm hover:shadow-xl hover:-translate-y-1 transition-all duration-300 group"
                      >
                        <div
                          className="w-12 h-12 rounded-2xl flex items-center justify-center mb-5 text-white shadow-lg rotate-3 group-hover:rotate-0 transition-transform"
                          style={{ backgroundColor: m.color }}
                        >
                          {m.icon}
                        </div>
                        <h4 className="font-black text-lg mb-2 text-slate-800">{m.title}</h4>
                        <p className="text-sm text-slate-500 leading-relaxed font-medium mb-4">{m.desc}</p>

                        <div className="bg-slate-50 rounded-xl p-4 border border-slate-100">
                          <p className="text-xs text-slate-400 font-bold uppercase tracking-wider mb-1">En este curso</p>
                          <p className="text-sm text-slate-600 leading-relaxed">{m.preview}</p>
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
              </Reveal>
            );
          })}
        </div>
      </section>

      {/* Carta de Fabian — sobre animado */}
      <section className="max-w-6xl mx-auto px-6 py-16">
        <Reveal>
          <div className="flex flex-col items-center">
            <button
              onClick={() => setLetterOpen(true)}
              className="envelope-container group relative cursor-pointer focus:outline-none"
              aria-label="Abrir carta de Fabian"
            >
              <div className="envelope-wrapper">
                {/* Sobre */}
                <div className="relative w-48 h-32 md:w-56 md:h-36">
                  {/* Cuerpo del sobre */}
                  <div className="absolute inset-0 bg-gradient-to-br from-red-500 to-red-700 rounded-xl shadow-2xl group-hover:shadow-red-300/50 transition-shadow duration-500"></div>
                  {/* Solapa superior */}
                  <div className="envelope-flap absolute top-0 left-0 right-0 h-1/2 bg-gradient-to-br from-red-600 to-red-800 rounded-t-xl origin-top"
                    style={{ clipPath: 'polygon(0 0, 100% 0, 50% 100%)' }}
                  ></div>
                  {/* Triángulo inferior */}
                  <div className="absolute bottom-0 left-0 right-0 h-1/2 bg-red-800/30"
                    style={{ clipPath: 'polygon(0 100%, 100% 100%, 50% 0)' }}
                  ></div>
                  {/* Icono de correo */}
                  <div className="absolute inset-0 flex items-center justify-center z-10">
                    <Mail className="w-10 h-10 md:w-12 md:h-12 text-white/90 envelope-icon" />
                  </div>
                  {/* Sello decorativo */}
                  <div className="absolute top-2 right-3 w-6 h-6 rounded-full bg-white/20 flex items-center justify-center">
                    <div className="w-4 h-4 rounded-full bg-white/30"></div>
                  </div>
                </div>
              </div>
              <p className="mt-6 text-lg font-bold text-slate-700 group-hover:text-red-600 transition-colors duration-300">
                Carta de Fabian
              </p>
              <p className="text-sm text-slate-400 mt-1 group-hover:text-slate-500 transition-colors">
                Toca para leer
              </p>
            </button>
          </div>
        </Reveal>
      </section>

      {/* Modal carta de Fabian */}
      {letterOpen && (
        <div
          className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-sm animate-fade-in"
          onClick={() => setLetterOpen(false)}
        >
          <div
            className="bg-white rounded-3xl shadow-2xl max-w-2xl w-full max-h-[85vh] overflow-y-auto p-8 md:p-12 relative animate-slide-up"
            onClick={(e) => e.stopPropagation()}
          >
            <button
              onClick={() => setLetterOpen(false)}
              className="absolute top-4 right-4 w-10 h-10 rounded-full bg-slate-100 hover:bg-slate-200 flex items-center justify-center transition-colors"
            >
              <X className="w-5 h-5 text-slate-500" />
            </button>

            <div className="flex items-center gap-3 mb-6">
              <div className="w-10 h-10 rounded-full bg-red-100 flex items-center justify-center">
                <Mail className="w-5 h-5 text-red-600" />
              </div>
              <div>
                <p className="font-bold text-slate-800 text-sm">Fabian Mascaretti</p>
                <p className="text-xs text-slate-400">Vicepresidente de Experiencia del Empleado</p>
              </div>
            </div>

            <h3 className="text-lg font-bold text-slate-800 mb-6 pb-4 border-b border-slate-100">
              Asunto: Invitación oficial: Estrategia de Transformación Digital IA 2026
            </h3>

            <div className="text-slate-600 leading-relaxed space-y-4 text-[15px]">
              <p>Hola equipo:</p>

              <p>Transformar nuestra Vicepresidencia y ser referentes de innovación es un reto que asumimos juntos.</p>

              <p>El contexto actual nos exige evolucionar constantemente. La Inteligencia Artificial ha dejado de ser una tendencia para convertirse en una herramienta indispensable que está redefiniendo nuestra forma de trabajar, de crear y de aportar valor a la organización.</p>

              <p>Tenemos proyectos estratégicos muy ambiciosos por delante. Para hacerlos realidad y llevar nuestra gestión al siguiente nivel, es fundamental que seamos pioneros. Necesitamos que cada uno de nosotros conozca, domine e integre la Inteligencia Artificial en su día a día laboral.</p>

              <p>Por este motivo, los invito formalmente a ser parte de nuestra <strong>Estrategia de Transformación Digital IA</strong>.</p>

              <p>Hemos estructurado este programa como una inversión directa en su desarrollo. Nuestro objetivo es darles el espacio para robustecer su perfil, continuar impulsando su aprendizaje y entregarles competencias que hoy son absolutamente necesarias para su crecimiento profesional en un entorno competitivo.</p>

              <p>Este es un hito clave para nuestra área. Para asegurar el impacto que buscamos, cuento con su compromiso y participación activa a lo largo de toda la ruta de formación.</p>

              <p>Los espero en nuestro <strong>Kick-off este próximo 8 de abril</strong> para compartirles a detalle la dinámica del programa y dar juntos el primer paso de esta gran evolución.</p>

              <p className="mt-6">Saludos,</p>
              <p className="font-bold text-slate-800">Fabian Mascaretti</p>
              <p className="text-sm text-slate-500">Vicepresidente de Experiencia del Empleado</p>
            </div>
          </div>
        </div>
      )}

      {/* Footer con aviones */}
      <footer className="max-w-6xl mx-auto px-6 pb-32 text-center overflow-visible">
        <Reveal>
          <div ref={footerRef} className="relative overflow-visible" style={{ minHeight: '400px' }}>
            {/* Aviones — fuera del container para no ser cortados */}
            <PaperPlane flying={planesFlying} />

            <div
              className="rounded-[3.5rem] p-12 md:p-24 relative overflow-hidden"
              style={{ backgroundColor: colors.softCyan }}
            >
              <div className="absolute top-0 right-0 w-64 h-64 bg-white/40 rounded-full blur-3xl -mr-32 -mt-32"></div>

              <h2 className="text-3xl md:text-5xl font-black text-slate-900 mb-8 leading-tight relative z-10">
                El futuro de nuestro trabajo <br/>empieza ahora.
              </h2>
              <p className="text-slate-600 mb-12 max-w-2xl mx-auto text-lg font-medium leading-relaxed relative z-10">
                Prepárate para integrar la IA en tu día a día y seguir marcando la diferencia como equipo.
                Nos encontramos el 8 de abril para dar este gran paso juntos.
              </p>

              <div className="flex justify-center items-center gap-4 relative z-10">
                <div className="h-[2px] w-16 bg-slate-300"></div>
                <div className="w-3 h-3 rounded-full" style={{ backgroundColor: colors.primaryRed }}></div>
                <div className="w-3 h-3 rounded-full" style={{ backgroundColor: colors.primaryMagenta }}></div>
                <div className="h-[2px] w-16 bg-slate-300"></div>
              </div>
            </div>
          </div>
        </Reveal>
      </footer>
    </div>
  );
};

export default App;
