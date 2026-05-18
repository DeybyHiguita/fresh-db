-- =============================================
-- Tabla: investments
-- Descripción: Registro de inversiones realizadas por inversionistas
-- =============================================
CREATE TABLE IF NOT EXISTS investments (
    id                  SERIAL PRIMARY KEY,
    investor_id         INTEGER         NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
    
    -- Datos de la inversión
    amount              NUMERIC(14, 2)  NOT NULL,           -- Monto total invertido
    investment_date     DATE            NOT NULL,           -- Fecha de la inversión
    description         TEXT            NULL,               -- Descripción/notas de la inversión
    
    -- Estado
    status              VARCHAR(50)     NOT NULL DEFAULT 'Activo', -- Activo, Cerrado, etc.
    
    -- Auditoría
    created_at          TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

-- Índices
CREATE INDEX IF NOT EXISTS ix_investments_investor_id ON investments (investor_id);
CREATE INDEX IF NOT EXISTS ix_investments_status ON investments (status);
CREATE INDEX IF NOT EXISTS ix_investments_date ON investments (investment_date);

-- =============================================
-- Tabla: investment_items
-- Descripción: Items que justifican una inversión (equipos, lotes de compra, otros)
-- =============================================
CREATE TABLE IF NOT EXISTS investment_items (
    id                  SERIAL PRIMARY KEY,
    investment_id       INTEGER         NOT NULL REFERENCES investments(id) ON DELETE CASCADE,
    
    -- Tipo de ítem
    item_type           VARCHAR(50)     NOT NULL,           -- 'equipment', 'purchase_batch', 'product', 'other'
    
    -- Referencias opcionales (solo una aplica según el tipo)
    equipment_id        INTEGER         NULL REFERENCES equipments(id) ON DELETE SET NULL,
    purchase_batch_id   INTEGER         NULL REFERENCES purchase_batches(id) ON DELETE SET NULL,
    product_id          INTEGER         NULL REFERENCES products(id) ON DELETE SET NULL,
    
    -- Para tipo 'other' o descripción adicional
    description         VARCHAR(255)    NULL,
    
    -- Valor que justifica la inversión
    amount              NUMERIC(12, 2)  NOT NULL,
    
    -- Auditoría
    created_at          TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

-- Índices
CREATE INDEX IF NOT EXISTS ix_investment_items_investment_id ON investment_items (investment_id);
CREATE INDEX IF NOT EXISTS ix_investment_items_equipment_id ON investment_items (equipment_id);
CREATE INDEX IF NOT EXISTS ix_investment_items_purchase_batch_id ON investment_items (purchase_batch_id);
CREATE INDEX IF NOT EXISTS ix_investment_items_product_id ON investment_items (product_id);
