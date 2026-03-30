import { corsHeaders } from '../_shared/cors.ts'
import { createClient } from 'npm:@supabase/supabase-js@2'

const CHARSET = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789' // sin 0/O, 1/I/l
const CODE_LENGTH = 4
const PREFIX = 'AVN'

function generateCode(): string {
  let code = ''
  for (let i = 0; i < CODE_LENGTH; i++) {
    code += CHARSET[Math.floor(Math.random() * CHARSET.length)]
  }
  return `${PREFIX}-${code}`
}

function generatePassword(length = 12): string {
  const chars = 'abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789!@#$'
  let password = ''
  for (let i = 0; i < length; i++) {
    password += chars[Math.floor(Math.random() * chars.length)]
  }
  return password
}

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    const supabaseAdmin = createClient(
      Deno.env.get('SUPABASE_URL')!,
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
    )

    // Validar que el caller es admin (denegar por defecto)
    const authHeader = req.headers.get('Authorization')
    if (!authHeader) {
      return new Response(
        JSON.stringify({ error: 'No autorizado' }),
        { status: 401, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    const token = authHeader.replace('Bearer ', '')
    const { data: { user }, error: authError } = await supabaseAdmin.auth.getUser(token)
    if (authError || user?.app_metadata?.role !== 'admin') {
      return new Response(
        JSON.stringify({ error: 'Solo administradores pueden generar codigos' }),
        { status: 403, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    const { count = 10 } = await req.json()

    if (count < 1 || count > 500) {
      return new Response(
        JSON.stringify({ error: 'count debe estar entre 1 y 500' }),
        { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    const results: { code: string; password: string; success: boolean; error?: string }[] = []
    const usedCodes = new Set<string>()

    for (let i = 0; i < count; i++) {
      let code = generateCode()
      while (usedCodes.has(code)) {
        code = generateCode()
      }
      usedCodes.add(code)

      const password = generatePassword()
      const email = `${code}@copilot.internal`

      const { error } = await supabaseAdmin.auth.admin.createUser({
        email,
        password,
        email_confirm: true,
        app_metadata: { role: 'participante', code },
      })

      results.push({
        code,
        password,
        success: !error,
        ...(error && { error: error.message }),
      })
    }

    const successful = results.filter(r => r.success).length
    const failed = results.filter(r => !r.success).length

    return new Response(
      JSON.stringify({
        summary: { total: count, successful, failed },
        users: results,
      }),
      { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    )

  } catch (error) {
    return new Response(
      JSON.stringify({ error: (error as Error).message }),
      { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    )
  }
})
