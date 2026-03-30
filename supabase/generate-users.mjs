/**
 * Genera 200 usuarios en Supabase Auth con códigos AVN-XXXX
 *
 * Uso:
 *   node supabase/generate-users.mjs
 *
 * Requiere SUPABASE_URL y SUPABASE_SERVICE_ROLE_KEY en .env
 * (el service role key se encuentra en Supabase Dashboard > Settings > API)
 *
 * Genera: supabase/usuarios-generados.csv con los códigos y contraseñas
 */

import { createClient } from '@supabase/supabase-js'
import { writeFileSync } from 'fs'
import { config } from 'dotenv'

config()

const SUPABASE_URL = process.env.VITE_SUPABASE_URL
const SERVICE_ROLE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY

if (!SUPABASE_URL || !SERVICE_ROLE_KEY) {
  console.error('Faltan variables de entorno.')
  console.error('Agrega SUPABASE_SERVICE_ROLE_KEY a tu .env')
  console.error('(Lo encuentras en Supabase Dashboard > Settings > API > service_role)')
  process.exit(1)
}

const supabase = createClient(SUPABASE_URL, SERVICE_ROLE_KEY)

const CHARSET = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789'
const PASS_CHARS = 'abcdefghijkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789'
const TOTAL = 200

function randomString(chars, len) {
  let s = ''
  for (let i = 0; i < len; i++) s += chars[Math.floor(Math.random() * chars.length)]
  return s
}

function generateCode(usedCodes) {
  let code
  do {
    code = `AVN-${randomString(CHARSET, 4)}`
  } while (usedCodes.has(code))
  usedCodes.add(code)
  return code
}

async function main() {
  console.log(`Generando ${TOTAL} usuarios...\n`)

  const usedCodes = new Set()
  const rows = [['codigo', 'contraseña', 'estado']]
  let ok = 0, fail = 0

  for (let i = 0; i < TOTAL; i++) {
    const code = generateCode(usedCodes)
    const password = randomString(PASS_CHARS, 10)
    const email = `${code}@copilot.internal`

    const { error } = await supabase.auth.admin.createUser({
      email,
      password,
      email_confirm: true,
      app_metadata: { role: 'participante', code },
    })

    if (error) {
      rows.push([code, password, `ERROR: ${error.message}`])
      fail++
    } else {
      rows.push([code, password, 'OK'])
      ok++
    }

    if ((i + 1) % 20 === 0) process.stdout.write(`  ${i + 1}/${TOTAL}\n`)
  }

  // Crear admin
  const adminCode = generateCode(usedCodes)
  const adminPass = randomString(PASS_CHARS, 12)
  const { error: adminErr } = await supabase.auth.admin.createUser({
    email: `${adminCode}@copilot.internal`,
    password: adminPass,
    email_confirm: true,
    app_metadata: { role: 'admin', code: adminCode },
  })

  rows.push([`${adminCode} (ADMIN)`, adminPass, adminErr ? `ERROR: ${adminErr.message}` : 'OK'])
  if (!adminErr) ok++; else fail++

  // Escribir CSV
  const csv = rows.map(r => r.join(',')).join('\n')
  const outPath = new URL('./usuarios-generados.csv', import.meta.url).pathname
  writeFileSync(outPath, csv, 'utf-8')

  console.log(`\nResultado: ${ok} creados, ${fail} errores`)
  console.log(`CSV guardado en: ${outPath}`)
  console.log(`\nAdmin: ${adminCode} / ${adminPass}`)
}

main().catch(console.error)
