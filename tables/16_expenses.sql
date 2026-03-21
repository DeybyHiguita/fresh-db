-- =============================================
-- Tabla: expenses
-- Descripción: Registro de los pagos realizados (salidas de caja)
-- =============================================
CREATE TABLE IF NOT EXISTS expenses (
    id                  SERIAL PRIMARY KEY,
    
    -- Relaciones (Escoger de la lista y saber quién pagó)
    expense_type_id     INTEGER         NOT NULL REFERENCES expense_types(id) ON DELETE RESTRICT,
    user_id             INTEGER         NOT NULL REFERENCES users(id) ON DELETE RESTRICT, 
    
    -- Detalles del pago real
    amount_paid         NUMERIC(10, 2)  NOT NULL, -- Cuánto se pagó realmente ese día
    payment_date        DATE            NOT NULL, -- Cuándo se pagó
    payment_method      VARCHAR(50)     NOT NULL DEFAULT 'Efectivo', -- De dónde salió la plata (Efectivo de caja, Bancolombia, etc.)
    
    -- Notas (Ej: "Se pagó la factura de EPM de Febrero con recargo")
    notes               TEXT            NULL,
    
    -- Auditoría
    created_at          TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

-- Índices para reportes (Ej: "Quiero ver todos los gastos de este mes")
CREATE INDEX IF NOT EXISTS ix_expenses_expense_type_id ON expenses (expense_type_id);
CREATE INDEX IF NOT EXISTS ix_expenses_user_id ON expenses (user_id);
CREATE INDEX IF NOT EXISTS ix_expenses_payment_date ON expenses (payment_date);