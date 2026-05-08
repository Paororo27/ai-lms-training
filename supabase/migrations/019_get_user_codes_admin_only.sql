-- 019_get_user_codes_admin_only.sql
-- Restringe get_user_codes a admins. La version anterior (SECURITY DEFINER sin guard)
-- permitia que cualquier usuario authenticated dump los codigos+nombres
-- pasando un array de UUIDs. Esta migration agrega un check de rol.

DROP FUNCTION IF EXISTS get_user_codes(UUID[]);

CREATE FUNCTION get_user_codes(p_user_ids UUID[])
RETURNS TABLE (id UUID, code TEXT, nombre TEXT)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
BEGIN
  IF COALESCE((SELECT auth.jwt()->'app_metadata'->>'role'), '') != 'admin' THEN
    RAISE EXCEPTION 'No autorizado';
  END IF;

  RETURN QUERY
    SELECT u.id,
           split_part(u.email, '@', 1) AS code,
           u.raw_app_meta_data->>'nombre' AS nombre
    FROM auth.users u
    WHERE u.id = ANY(p_user_ids);
END;
$$;
