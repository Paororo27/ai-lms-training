/**
 * Carga masiva de nombres de participantes desde un CSV a app_metadata.nombre.
 *
 * Uso:
 *   node supabase/import-participant-names.mjs "<ruta-al-csv>"
 *
 * El CSV debe tener encabezado y al menos las columnas:
 *   columna 1: Usuario (ej. AVN-7C2N)
 *   columna 3: Estatus (en este archivo es el nombre completo del participante)
 *
 * Idempotente: re-ejecutar no genera duplicados ni borra metadata existente.
 */

import { readFileSync } from 'fs'
import { createClient } from '@supabase/supabase-js'
import { config } from 'dotenv'

config()

const SUPABASE_URL = process.env.VITE_SUPABASE_URL
const SERVICE_ROLE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY
const CSV_PATH = process.argv[2]

if (!SUPABASE_URL || !SERVICE_ROLE_KEY) {
  console.error('Faltan VITE_SUPABASE_URL y/o SUPABASE_SERVICE_ROLE_KEY en .env')
  process.exit(1)
}
if (!CSV_PATH) {
  console.error('Uso: node supabase/import-participant-names.mjs "<ruta-csv>"')
  process.exit(1)
}

const supabase = createClient(SUPABASE_URL, SERVICE_ROLE_KEY)

function titleCase(s) {
  return s.trim().toLowerCase().replace(/(^|\s)\p{L}/gu, c => c.toUpperCase())
}

function parseCsv(text) {
  return text.split(/\r?\n/)
    .map(l => l.trim())
    .filter(Boolean)
    .slice(1)
    .map(l => l.split(','))
}

async function main() {
  const rows = parseCsv(readFileSync(CSV_PATH, 'utf-8'))
    .filter(cols => cols[0]?.startsWith('AVN-') && cols[2])

  if (rows.length === 0) {
    console.error('No se encontraron filas con codigo AVN- y nombre.')
    process.exit(1)
  }

  console.log(`Procesando ${rows.length} filas del CSV...\n`)

  const { data, error: listErr } = await supabase.auth.admin.listUsers({ perPage: 1000 })
  if (listErr) {
    console.error(`Error listando usuarios: ${listErr.message}`)
    process.exit(1)
  }

  const byEmail = new Map(data.users.map(u => [u.email, u]))

  let ok = 0
  let missing = 0
  let unchanged = 0
  let errors = 0

  for (const cols of rows) {
    const code = cols[0].trim()
    const nombre = titleCase(cols[2])
    const email = `${code.toLowerCase()}@copilot.internal`
    const user = byEmail.get(email)

    if (!user) {
      console.warn(`MISS  ${code}: usuario no existe en la DB`)
      missing++
      continue
    }

    if (user.app_metadata?.nombre === nombre) {
      unchanged++
      continue
    }

    const { error } = await supabase.auth.admin.updateUserById(user.id, {
      app_metadata: { ...user.app_metadata, nombre },
    })

    if (error) {
      console.error(`ERR   ${code}: ${error.message}`)
      errors++
    } else {
      console.log(`OK    ${code} -> ${nombre}`)
      ok++
    }
  }

  console.log(`\nResumen: ${ok} actualizados, ${unchanged} sin cambios, ${missing} sin match, ${errors} errores`)
}

main().catch(e => {
  console.error(e)
  process.exit(1)
})
