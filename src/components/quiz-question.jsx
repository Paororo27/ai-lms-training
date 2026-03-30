export default function QuizQuestion({ pregunta, index, selected, onSelect, disabled = false, resultado = null }) {
  const opciones = pregunta.opciones || []

  return (
    <div className="bg-white rounded-xl border border-slate-200 p-5">
      <p className="text-sm font-semibold text-slate-500 mb-2">Pregunta {index + 1}</p>
      <p className="text-avianca-dark font-medium mb-4">{pregunta.texto}</p>

      <div className="space-y-2">
        {opciones.map((opcion, idx) => {
          const opIdx = opcion.indice ?? idx
          const isSelected = selected === opIdx
          const showResult = resultado !== null

          let borderColor = 'border-slate-200'
          let bgColor = 'bg-white'
          let textColor = 'text-slate-700'

          if (showResult && isSelected) {
            if (resultado.acerto) {
              borderColor = 'border-avianca-green'
              bgColor = 'bg-avianca-green/5'
              textColor = 'text-avianca-green'
            } else {
              borderColor = 'border-red-400'
              bgColor = 'bg-red-50'
              textColor = 'text-red-600'
            }
          } else if (!showResult && isSelected) {
            borderColor = 'border-avianca-cyan'
            bgColor = 'bg-avianca-cyan/5'
            textColor = 'text-avianca-dark'
          }

          return (
            <label
              key={opIdx}
              className={`flex items-center gap-3 p-3 rounded-lg border ${borderColor} ${bgColor} transition-all ${
                !disabled ? 'cursor-pointer hover:border-avianca-cyan/50' : 'cursor-default'
              }`}
            >
              <input
                type="radio"
                name={`q-${pregunta.id}`}
                checked={isSelected}
                onChange={() => !disabled && onSelect(opIdx)}
                disabled={disabled}
                className="w-4 h-4 accent-avianca-cyan"
              />
              <span className={`text-sm ${textColor}`}>{opcion.texto}</span>
            </label>
          )
        })}
      </div>

      {resultado && resultado.explicacion && (
        <div className={`mt-3 p-3 rounded-lg text-sm ${
          resultado.acerto ? 'bg-avianca-green/5 text-avianca-green' : 'bg-amber-50 text-amber-700'
        }`}>
          {resultado.explicacion}
        </div>
      )}
    </div>
  )
}
