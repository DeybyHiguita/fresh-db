-- ══════════════════════════════════════════════════════════════════════════════
-- Tabla: investment_needs  (solicitudes de inversión colectiva)
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS investment_needs (
    id                  SERIAL          PRIMARY KEY,
    title               VARCHAR(200)    NOT NULL,
    description         TEXT,
    item_type           VARCHAR(50),
    equipment_id        INTEGER         REFERENCES equipments(id)       ON DELETE SET NULL,
    purchase_batch_id   INTEGER         REFERENCES purchase_batches(id) ON DELETE SET NULL,
    product_id          INTEGER         REFERENCES products(id)         ON DELETE SET NULL,
    total_needed        DECIMAL(14,2)   NOT NULL,
    status              VARCHAR(20)     NOT NULL DEFAULT 'Pendiente',
    created_by_id       INTEGER         NOT NULL REFERENCES users(id)   ON DELETE RESTRICT,
    created_at          TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS ix_investment_needs_status        ON investment_needs (status);
CREATE INDEX IF NOT EXISTS ix_investment_needs_created_by_id ON investment_needs (created_by_id);

-- ══════════════════════════════════════════════════════════════════════════════
-- Tabla: investment_need_assignments (asignación de cuánto pone cada inversionista)
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS investment_need_assignments (
    id                  SERIAL          PRIMARY KEY,
    need_id             INTEGER         NOT NULL REFERENCES investment_needs(id) ON DELETE CASCADE,
    investor_id         INTEGER         NOT NULL REFERENCES users(id)            ON DELETE RESTRICT,
    suggested_amount    DECIMAL(14,2)   NOT NULL,
    status              VARCHAR(20)     NOT NULL DEFAULT 'Pendiente',
    notes               TEXT,
    investment_id       INTEGER         REFERENCES investments(id) ON DELETE SET NULL,
    created_at          TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS ix_inv_need_assignments_need_id     ON investment_need_assignments (need_id);
CREATE INDEX IF NOT EXISTS ix_inv_need_assignments_investor_id ON investment_need_assignments (investor_id);
CREATE INDEX IF NOT EXISTS ix_inv_need_assignments_status      ON investment_need_assignments (status);
