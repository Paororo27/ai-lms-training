import { createClient, FunctionsHttpError } from '@supabase/supabase-js'

export const supabase = createClient(
  import.meta.env.VITE_SUPABASE_URL,
  import.meta.env.VITE_SUPABASE_ANON_KEY
)

// Extrae el mensaje real que devuelve una Edge Function en errores HTTP.
// supabase.functions.invoke entrega el cuerpo de respuesta en error.context.
export async function getFunctionErrorMessage(err, fallback) {
  if (err instanceof FunctionsHttpError) {
    try {
      const body = await err.context.json()
      if (body?.error) return body.error
    } catch {
      // cuerpo no-JSON: usar fallback
    }
  }
  return fallback
}
