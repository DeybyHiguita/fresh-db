-- =============================================
-- Tabla: purchase_details
-- Descripción: Detalle de los productos comprados en cada lote/semana
-- =============================================
CREATE TABLE IF NOT EXISTS purchase_details (
    id              SERIAL PRIMARY KEY,
    batch_id        INTEGER         NOT NULL REFERENCES purchase_batches(id) ON DELETE CASCADE,
    product_id      INTEGER         NOT NULL REFERENCES products(id) ON DELETE RESTRICT,
    quantity        NUMERIC(10, 2)  NOT NULL,
    total_value     NUMERIC(12, 2)  NOT NULL,
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

-- Índices para las llaves foráneas (mejora el rendimiento en joins)
CREATE INDEX IF NOT EXISTS ix_purchase_details_batch_id ON purchase_details (batch_id);
CREATE INDEX IF NOT EXISTS ix_purchase_details_product_id ON purchase_details (product_id);