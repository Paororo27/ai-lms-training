import React from 'react';
import { Calendar, Clock, MapPin, Sparkles, Brain, Layout, BarChart, Users, Trophy, Zap, ChevronRight } from 'lucide-react';

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
      title: "Fundamentos de Copilot",
      desc: "Tus primeros pasos con seguridad y confianza.",
      icon: <Sparkles className="w-6 h-6" />,
      color: colors.cyan
    },
    {
      id: 2,
      title: "El arte de los Prompts",
      desc: "Cómo pedir para recibir resultados sorprendentes.",
      icon: <Brain className="w-6 h-6" />,
      color: colors.orange
    },
    {
      id: 3,
      title: "Productividad Real",
      desc: "Potenciando Word, PowerPoint y colaboración.",
      icon: <Layout className="w-6 h-6" />,
      color: colors.pink
    },
    {
      id: 4,
      title: "Inteligencia en Datos",
      desc: "Análisis avanzado en Excel con IA.",
      icon: <BarChart className="w-6 h-6" />,
      color: colors.blue
    },
    {
      id: 5,
      title: "Gestión del Talento (RRHH)",
      desc: "Herramientas exclusivas para liderar personas.",
      icon: <Users className="w-6 h-6" />,
      color: colors.green
    },
    {
      id: 6,
      title: "Reto Final",
      desc: "De la teoría a la práctica real en tu día a día.",
      icon: <Trophy className="w-6 h-6" />,
      color: colors.primaryMagenta
    }
  ];

  return (
    <div className="min-h-screen bg-slate-50 font-sans text-slate-900 selection:bg-cyan-100">
      <header
        style={{ backgroundColor: colors.cyan }}
        className="relative overflow-hidden pt-20 pb-32 px-6 text-center"
      >
        <div className="absolute top-0 left-0 w-full h-full overflow-hidden pointer-events-none opacity-40">
          <div className="absolute -top-24 -left-24 w-96 h-96 rounded-full bg-white/40 blur-3xl"></div>
          <div className="absolute top-1/2 -right-24 w-64 h-64 rounded-full bg-blue-400/20 blur-3xl"></div>
        </div>

        <div className="max-w-4xl mx-auto relative z-10">
          <div
            className="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-white/60 backdrop-blur-sm border border-white/40 text-[10px] font-bold tracking-[0.2em] mb-8 uppercase text-slate-700"
          >
            <Zap className="w-3 h-3 fill-slate-700" />
            <span>Lanzamiento Estratégico</span>
          </div>

          <h1 className="text-4xl md:text-6xl font-black tracking-tight mb-6 leading-tight text-slate-900">
            Lideremos el futuro, <span style={{ color: colors.primaryMagenta }}>juntos.</span>
          </h1>

          <p className="text-lg md:text-xl text-slate-700 max-w-2xl mx-auto mb-10 leading-relaxed font-medium">
            Nuestro talento nos trajo hasta acá, pero la tecnología nos permitirá llegar más lejos. Iniciamos este camino para potenciar nuestra visión.
          </p>
        </div>
      </header>

      <section className="max-w-6xl mx-auto px-6 -mt-16 relative z-20">
        <div className="bg-white rounded-[2.5rem] shadow-2xl shadow-slate-200/60 p-8 md:p-14 border border-white">
          <div className="grid lg:grid-cols-12 gap-12 items-center">
            <div className="lg:col-span-7">
              <div
                className="w-12 h-1.5 rounded-full mb-8"
                style={{ background: colors.gradient }}
              ></div>
              <h2 className="text-3xl font-extrabold mb-6 text-slate-900 leading-tight">
                Evolucionamos nuestra <br/>forma de trabajar.
              </h2>
              <p className="text-slate-600 mb-10 leading-relaxed text-lg">
                Este programa ha sido diseñado para que la Inteligencia Artificial sea tu mejor apoyo estratégico. A través de un formato flexible, descubriremos cómo simplificar lo rutinario para enfocarnos en lo que realmente aporta valor.
              </p>

              <div className="flex flex-wrap gap-8">
                <div className="flex items-center gap-4">
                  <div className="w-12 h-12 rounded-2xl bg-slate-50 flex items-center justify-center text-blue-500">
                    <Clock className="w-6 h-6" />
                  </div>
                  <div>
                    <p className="text-sm font-bold text-slate-800">1 Hora Semanal</p>
                    <p className="text-xs text-slate-400">Formato flexible</p>
                  </div>
                </div>
                <div className="flex items-center gap-4">
                  <div className="w-12 h-12 rounded-2xl bg-slate-50 flex items-center justify-center text-green-500">
                    <Calendar className="w-6 h-6" />
                  </div>
                  <div>
                    <p className="text-sm font-bold text-slate-800">Un mes de duración</p>
                    <p className="text-xs text-slate-400">Abril 2024</p>
                  </div>
                </div>
              </div>
            </div>

            <div className="lg:col-span-5">
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
                    <p className="font-bold text-base">2:00 PM</p>
                  </div>
                  <div className="flex items-center gap-4 group">
                    <div className="w-10 h-10 rounded-xl bg-white/20 backdrop-blur-md flex items-center justify-center border border-white/20">
                      <MapPin className="w-5 h-5" />
                    </div>
                    <p className="font-bold text-base">CAV</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <section className="max-w-6xl mx-auto px-6 py-28">
        <div className="flex flex-col md:flex-row md:items-end justify-between mb-16 gap-6">
          <div className="max-w-xl">
            <h2 className="text-3xl font-black text-slate-900 mb-4 uppercase tracking-tight">Hoja de Ruta</h2>
            <p className="text-slate-500 text-lg">Un mes de transformación diseñado para tu día a día profesional.</p>
          </div>
          <div className="hidden md:block h-[2px] flex-grow mx-12 bg-slate-200 rounded-full"></div>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          {modules.map((m) => (
            <div
              key={m.id}
              className="bg-white p-10 rounded-[2rem] border border-slate-100 shadow-sm hover:shadow-xl hover:-translate-y-1 transition-all duration-300 relative group"
            >
              <div
                className="w-14 h-14 rounded-2xl flex items-center justify-center mb-8 text-white shadow-lg rotate-3 group-hover:rotate-0 transition-transform"
                style={{ backgroundColor: m.color }}
              >
                {m.icon}
              </div>
              <h4 className="font-black text-xl mb-3 text-slate-800">{m.title}</h4>
              <p className="text-sm text-slate-500 leading-relaxed font-medium">{m.desc}</p>

              <div className="mt-8 flex items-center gap-2 text-[10px] font-bold uppercase tracking-widest" style={{ color: m.color }}>
                <span>Ver detalles</span>
                <ChevronRight className="w-3 h-3" />
              </div>
            </div>
          ))}
        </div>
      </section>

      <footer className="max-w-6xl mx-auto px-6 pb-32 text-center">
        <div
          className="rounded-[3.5rem] p-12 md:p-24 relative overflow-hidden"
          style={{ backgroundColor: colors.softCyan }}
        >
          <div className="absolute top-0 right-0 w-64 h-64 bg-white/40 rounded-full blur-3xl -mr-32 -mt-32"></div>

          <h2 className="text-3xl md:text-5xl font-black text-slate-900 mb-8 leading-tight">
            El futuro de nuestro trabajo <br/>empieza ahora.
          </h2>
          <p className="text-slate-600 mb-12 max-w-2xl mx-auto text-lg font-medium leading-relaxed">
            Prepárate para integrar la IA en tu día a día y seguir marcando la diferencia como equipo.
            Nos encontramos el 8 de abril para dar este gran paso juntos.
          </p>

          <div className="flex justify-center items-center gap-4">
            <div className="h-[2px] w-16 bg-slate-300"></div>
            <div className="w-3 h-3 rounded-full" style={{ backgroundColor: colors.primaryRed }}></div>
            <div className="w-3 h-3 rounded-full" style={{ backgroundColor: colors.primaryMagenta }}></div>
            <div className="h-[2px] w-16 bg-slate-300"></div>
          </div>
        </div>
      </footer>
    </div>
  );
};

export default App;
