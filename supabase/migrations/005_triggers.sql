-- ============================================================
-- Triggers de integridad de datos
-- ============================================================

-- 1. Prevenir reversion de estado enviado → borrador
CREATE OR REPLACE FUNCTION prevent_entrega_state_regression()
RETURNS TRIGGER AS $$
BEGIN
  IF OLD.estado = 'enviado' AND NEW.estado = 'borrador' THEN
    RAISE EXCEPTION 'No se puede revertir una entrega de "enviado" a "borrador"';
  END IF;

  IF OLD.submitted_at IS NOT NULL AND NEW.submitted_at IS NULL THEN
    RAISE EXCEPTION 'No se puede eliminar la fecha de envio';
  END IF;

  IF NEW.estado = 'enviado' AND OLD.estado = 'borrador' THEN
    NEW.submitted_at = now();
  END IF;

  NEW.updated_at = now();

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_entrega_state_guard
  BEFORE UPDATE ON entregas_reto
  FOR EACH ROW EXECUTE FUNCTION prevent_entrega_state_regression();

-- 2. Validar que intento 2 tiene intento 1
CREATE OR REPLACE FUNCTION validate_intento_secuencial()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.numero_intento = 2 THEN
    IF NOT EXISTS (
      SELECT 1 FROM intentos_prueba
      WHERE usuario_id = NEW.usuario_id
      AND prueba_id = NEW.prueba_id
      AND numero_intento = 1
    ) THEN
      RAISE EXCEPTION 'No se puede registrar intento 2 sin intento 1';
    END IF;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_intento_secuencial
  BEFORE INSERT ON intentos_prueba
  FOR EACH ROW EXECUTE FUNCTION validate_intento_secuencial();

-- 3. Validar coherencia aprobado/puntaje vs umbral
CREATE OR REPLACE FUNCTION validate_aprobado_coherencia()
RETURNS TRIGGER AS $$
DECLARE
  umbral SMALLINT;
BEGIN
  SELECT puntaje_aprobatorio INTO umbral
  FROM pruebas WHERE id = NEW.prueba_id;

  IF (NEW.puntaje >= umbral AND NEW.aprobado = false)
    OR (NEW.puntaje < umbral AND NEW.aprobado = true) THEN
    RAISE EXCEPTION 'Incoherencia: puntaje=% vs aprobado=% (umbral=%)',
      NEW.puntaje, NEW.aprobado, umbral;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_aprobado_coherencia
  BEFORE INSERT OR UPDATE ON intentos_prueba
  FOR EACH ROW EXECUTE FUNCTION validate_aprobado_coherencia();
