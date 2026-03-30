export default function ProgressBar({ value = 0, label, className = '' }) {
  const clamped = Math.min(100, Math.max(0, Math.round(value)))

  return (
    <div className={className}>
      {label && (
        <div className="flex justify-between items-center mb-1.5">
          <span className="text-sm font-medium text-slate-600">{label}</span>
          <span className="text-sm font-bold text-avianca-dark">{clamped}%</span>
        </div>
      )}
      <div className="h-2.5 bg-slate-200 rounded-full overflow-hidden">
        <div
          className="h-full rounded-full bg-gradient-to-r from-avianca-red to-avianca-magenta transition-all duration-700 ease-out"
          style={{ width: `${clamped}%` }}
        />
      </div>
    </div>
  )
}
