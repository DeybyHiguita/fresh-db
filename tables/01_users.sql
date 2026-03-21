-- =============================================
-- Tabla: users
-- Descripción: Empleados y usuarios del sistema
-- =============================================

CREATE TABLE IF NOT EXISTS users (
    id              SERIAL PRIMARY KEY,
    name            VARCHAR(100)    NOT NULL,
    email           VARCHAR(150)    NOT NULL,
    password        TEXT            NOT NULL,
    role            VARCHAR(20)     NOT NULL DEFAULT 'employee',
    is_active       BOOLEAN         NOT NULL DEFAULT TRUE,
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

-- Índice único para email
CREATE UNIQUE INDEX IF NOT EXISTS ix_users_email ON users (email);
