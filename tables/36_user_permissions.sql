-- 1. Borramos la tabla vieja que tiene la columna "page" de texto
DROP TABLE IF EXISTS user_permissions;

-- 2. Creamos la nueva tabla enlazada a app_pages
CREATE TABLE user_permissions (
    id          SERIAL      PRIMARY KEY,
    user_id     INT         NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    page_id     INT         NOT NULL REFERENCES app_pages(id) ON DELETE CASCADE,
    can_access  BOOLEAN     NOT NULL DEFAULT false,
    updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    
    -- Restricción para que un usuario no tenga la misma página duplicada
    CONSTRAINT ux_user_permissions_user_page UNIQUE (user_id, page_id)
);

-- 3. Creamos los índices para que las consultas sean rápidas
CREATE INDEX IF NOT EXISTS ix_user_permissions_user_id ON user_permissions (user_id);
CREATE INDEX IF NOT EXISTS ix_user_permissions_page_id ON user_permissions (page_id);