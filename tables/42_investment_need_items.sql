-- ══════════════════════════════════════════════════════════════════════════════
-- Tabla: investment_need_items  (ítems vinculados a una solicitud de inversión)
--   Permite asociar múltiples ítems (equipos, lotes, productos u otros) a
--   una misma solicitud colectiva.
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS investment_need_items (
    id                  SERIAL          PRIMARY KEY,
    need_id             INTEGER         NOT NULL REFERENCES investment_needs(id) ON DELETE CASCADE,
    item_type           VARCHAR(50),                                               -- 'equipment' | 'purchase_batch' | 'product' | 'other'
    equipment_id        INTEGER         REFERENCES equipments(id)       ON DELETE SET NULL,
    purchase_batch_id   INTEGER         REFERENCES purchase_batches(id) ON DELETE SET NULL,
    product_id          INTEGER         REFERENCES products(id)         ON DELETE SET NULL,
    description         VARCHAR(300),                                              -- texto libre cuando item_type = 'other'
    created_at          TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS ix_investment_need_items_need_id ON investment_need_items (need_id);
