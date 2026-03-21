-- =============================================
-- Tabla: purchase_batches
-- Descripción: Control de lotes o semanas de compras
-- =============================================
CREATE TABLE IF NOT EXISTS purchase_batches (
    id              SERIAL PRIMARY KEY,
    batch_name      VARCHAR(100)    NOT NULL,
    start_date      DATE            NOT NULL,
    end_date        DATE            NOT NULL,
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

-- Índice para búsquedas por rango de fechas
CREATE INDEX IF NOT EXISTS ix_purchase_batches_dates ON purchase_batches (start_date, end_date);