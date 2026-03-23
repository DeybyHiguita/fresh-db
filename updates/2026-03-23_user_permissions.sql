-- ============================================================
-- Tabla: user_permissions
-- Controla qué pantallas puede ver cada usuario
-- ============================================================
CREATE TABLE IF NOT EXISTS user_permissions (
    id          SERIAL      PRIMARY KEY,
    user_id     INT         NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    page        VARCHAR(50) NOT NULL,
    can_access  BOOLEAN     NOT NULL DEFAULT false,
    updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT ux_user_permissions_user_page UNIQUE (user_id, page)
);

CREATE INDEX IF NOT EXISTS ix_user_permissions_user_id ON user_permissions (user_id);

-- Inicializar permisos completos para usuarios con rol 'admin'
INSERT INTO user_permissions (user_id, page, can_access)
SELECT u.id, p.page, true
FROM users u
CROSS JOIN (VALUES
    ('dashboard'), ('recipes'), ('ingredients'), ('inventory'),
    ('orders'), ('menu-items'), ('cash-registers'), ('work-shifts'),
    ('customers'), ('expenses'), ('equipments')
) AS p(page)
WHERE u.role = 'admin'
ON CONFLICT (user_id, page) DO NOTHING;
