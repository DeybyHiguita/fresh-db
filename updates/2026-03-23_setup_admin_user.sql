-- Activar y elevar a admin el usuario admin@admin.com (id = 5)
UPDATE users
SET role      = 'admin',
    is_active = TRUE,
    updated_at = NOW()
WHERE email = 'admin@admin.com';

-- Inicializar todos los permisos en true para ese usuario
-- ON CONFLICT: si ya existen filas, actualizar a true
INSERT INTO user_permissions (user_id, page, can_access, updated_at)
SELECT u.id, p.page, true, NOW()
FROM users u
CROSS JOIN (VALUES
    ('dashboard'), ('recipes'), ('ingredients'), ('inventory'),
    ('orders'), ('menu-items'), ('cash-registers'), ('work-shifts'),
    ('customers'), ('expenses'), ('equipments')
) AS p(page)
WHERE u.email = 'admin@admin.com'
ON CONFLICT (user_id, page) DO UPDATE
    SET can_access = true,
        updated_at = NOW();
