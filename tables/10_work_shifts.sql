-- =============================================
-- Tabla: work_shifts
-- Descripción: Registro de jornadas laborales diarias por usuario
-- =============================================
CREATE TABLE IF NOT EXISTS work_shifts (
    id              SERIAL PRIMARY KEY,
    user_id         INTEGER         NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    shift_date      DATE            NOT NULL DEFAULT CURRENT_DATE,
    start_time      TIMESTAMPTZ     NOT NULL,
    end_time        TIMESTAMPTZ,    -- Permite NULL porque la jornada puede estar en curso
    total_hours     NUMERIC(5, 2)   DEFAULT 0.00, -- Campo opcional para guardar el total al final del día
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

-- Índices para búsquedas rápidas por usuario y por fecha
CREATE INDEX IF NOT EXISTS ix_work_shifts_user_id ON work_shifts (user_id);
CREATE INDEX IF NOT EXISTS ix_work_shifts_date ON work_shifts (shift_date);