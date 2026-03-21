-- =============================================
-- Tabla: break_times
-- Descripción: Registro de los tiempos de descanso dentro de una jornada
-- =============================================
CREATE TABLE IF NOT EXISTS break_times (
    id              SERIAL PRIMARY KEY,
    shift_id        INTEGER         NOT NULL REFERENCES work_shifts(id) ON DELETE CASCADE,
    start_time      TIMESTAMPTZ     NOT NULL,
    end_time        TIMESTAMPTZ,    -- Permite NULL porque el descanso puede estar en curso
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

-- Índice para optimizar la búsqueda de descansos por jornada
CREATE INDEX IF NOT EXISTS ix_break_times_shift_id ON break_times (shift_id);