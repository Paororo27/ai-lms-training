import { corsHeaders } from '../_shared/cors.ts'
import { createClient } from 'npm:@supabase/supabase-js@2'

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  const supabaseAdmin = createClient(
    Deno.env.get('SUPABASE_URL')!,
    Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
  )

  try {
    // 1. Validar JWT
    const authHeader = req.headers.get('Authorization')
    if (!authHeader) {
      return error('No autorizado', 401)
    }

    const token = authHeader.replace('Bearer ', '')
    const { data: { user }, error: authError } = await supabaseAdmin.auth.getUser(token)
    if (authError || !user) {
      return error('Token invalido', 401)
    }

    const userId = user.id

    // 2. Parsear body
    const { prueba_id, respuestas } = await req.json() as {
      prueba_id: number
      respuestas: { pregunta_id: number; opcion_seleccionada: number }[]
    }

    if (!prueba_id || !respuestas || !Array.isArray(respuestas)) {
      return error('Datos invalidos: se requiere prueba_id y respuestas[]', 400)
    }

    // 3. Obtener prueba
    const { data: prueba, error: pruebaErr } = await supabaseAdmin
      .from('pruebas')
      .select('id, tipo, puntaje_aprobatorio, modulo_id, orden')
      .eq('id', prueba_id)
      .single()

    if (pruebaErr || !prueba) {
      return error('Prueba no encontrada', 404)
    }

    // 4. Contar intentos previos
    const { count: intentosPrevios } = await supabaseAdmin
      .from('intentos_prueba')
      .select('id', { count: 'exact', head: true })
      .eq('usuario_id', userId)
      .eq('prueba_id', prueba_id)

    const maxIntentos = prueba.tipo === 'modular' ? 2 : 1
    if ((intentosPrevios ?? 0) >= maxIntentos) {
      return error(`Maximo de ${maxIntentos} intento(s) alcanzado`, 400)
    }

    const numeroIntento = (intentosPrevios ?? 0) + 1

    // 5. Validar prerequisitos (solo para pruebas modulares)
    if (prueba.tipo === 'modular' && prueba.orden > 1) {
      // Verificar que la prueba anterior esta aprobada
      const { data: pruebaAnterior } = await supabaseAdmin
        .from('pruebas')
        .select('id')
        .eq('orden', prueba.orden - 1)
        .single()

      if (pruebaAnterior) {
        const { data: intentoAnterior } = await supabaseAdmin
          .from('intentos_prueba')
          .select('aprobado')
          .eq('usuario_id', userId)
          .eq('prueba_id', pruebaAnterior.id)
          .eq('aprobado', true)
          .limit(1)

        // Si la prueba anterior es el diagnostico pre, solo necesita existir (no aprobar)
        const { data: pruebaAnteriorInfo } = await supabaseAdmin
          .from('pruebas')
          .select('tipo')
          .eq('id', pruebaAnterior.id)
          .single()

        const requiereAprobacion = pruebaAnteriorInfo?.tipo === 'modular'

        if (requiereAprobacion && (!intentoAnterior || intentoAnterior.length === 0)) {
          return error('Debes aprobar la prueba anterior primero', 403)
        }

        if (!requiereAprobacion) {
          // Solo verificar que existe un intento (diagnostico)
          const { count } = await supabaseAdmin
            .from('intentos_prueba')
            .select('id', { count: 'exact', head: true })
            .eq('usuario_id', userId)
            .eq('prueba_id', pruebaAnterior.id)

          if (!count || count === 0) {
            return error('Debes completar el diagnostico previo', 403)
          }
        }
      }
    }

    // 6. Obtener preguntas con respuestas correctas (service_role bypassa RLS)
    const preguntaIds = respuestas.map(r => r.pregunta_id)
    const { data: preguntas, error: pregErr } = await supabaseAdmin
      .from('preguntas')
      .select('id, opciones, explicacion, texto')
      .in('id', preguntaIds)
      .eq('prueba_id', prueba_id)

    if (pregErr || !preguntas || preguntas.length === 0) {
      return error('Preguntas no encontradas', 404)
    }

    // 7. Calificar
    const correctasMap = new Map<number, { correctIdx: number; explicacion: string; texto: string }>()
    for (const p of preguntas) {
      const opciones = p.opciones as { texto: string; es_correcta: boolean }[]
      const correctIdx = opciones.findIndex(o => o.es_correcta)
      correctasMap.set(p.id, { correctIdx, explicacion: p.explicacion, texto: p.texto })
    }

    let correctas = 0
    const detalle: {
      pregunta_id: number
      pregunta_texto: string
      acerto: boolean
      explicacion: string
    }[] = []

    for (const r of respuestas) {
      const info = correctasMap.get(r.pregunta_id)
      if (!info) continue

      const acerto = r.opcion_seleccionada === info.correctIdx
      if (acerto) correctas++

      detalle.push({
        pregunta_id: r.pregunta_id,
        pregunta_texto: info.texto,
        acerto,
        explicacion: info.explicacion,
      })
    }

    const totalPreguntas = respuestas.length
    const puntaje = totalPreguntas > 0 ? Math.round((correctas / totalPreguntas) * 100) : 0
    const aprobado = puntaje >= prueba.puntaje_aprobatorio

    // 8. Guardar intento
    const { error: insertErr } = await supabaseAdmin
      .from('intentos_prueba')
      .insert({
        usuario_id: userId,
        prueba_id: prueba_id,
        numero_intento: numeroIntento,
        puntaje,
        respuestas: detalle.map(d => ({
          pregunta_id: d.pregunta_id,
          seleccionada: d.seleccionada,
          correcta: d.acerto,
        })),
        preguntas_usadas: preguntaIds,
        aprobado,
      })

    if (insertErr) {
      return error(`Error guardando intento: ${insertErr.message}`, 500)
    }

    // 9. Retornar resultado
    return new Response(
      JSON.stringify({
        puntaje,
        aprobado,
        correctas,
        total: totalPreguntas,
        numero_intento: numeroIntento,
        max_intentos: maxIntentos,
        detalle,
      }),
      { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    )

  } catch (e) {
    return error((e as Error).message, 400)
  }
})

function error(message: string, status: number) {
  return new Response(
    JSON.stringify({ error: message }),
    { status, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
  )
}
