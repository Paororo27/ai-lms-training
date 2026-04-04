-- Funcion para obtener codigos de usuario desde auth.users
-- Extrae el prefijo del email (CODE@copilot.internal -> CODE)
CREATE OR REPLACE FUNCTION get_user_codes(p_user_ids UUID[])
RETURNS TABLE (id UUID, code TEXT)
LANGUAGE sql
SECURITY DEFINER
SET search_path = ''
AS $$
  SELECT u.id, split_part(u.email, '@', 1) AS code
  FROM auth.users u
  WHERE u.id = ANY(p_user_ids);
$$;
