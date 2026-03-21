-- =============================================
-- Tabla: expense_types
-- Descripción: Catálogo de gastos fijos y recurrentes (Arriendo, Suscripciones, etc.)
-- =============================================
CREATE TABLE IF NOT EXISTS expense_types (
    id              SERIAL PRIMARY KEY,
    name            VARCHAR(150)    NOT NULL, -- Ej: 'Arriendo Local', 'Internet Comfama'
    description     TEXT            NULL,     -- Detalle de qué trata el gasto
    expected_amount NUMERIC(10, 2)  NOT NULL DEFAULT 0.00, -- Valor estimado o fijo a pagar
    frequency       VARCHAR(50)     NOT NULL DEFAULT 'Mensual', -- Ej: 'Diario', 'Semanal', 'Mensual', 'Anual', 'Ocasional'
    is_active       BOOLEAN         NOT NULL DEFAULT TRUE, -- Para ocultar gastos que ya no se usan
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

-- Índice para búsquedas rápidas por nombre en el catálogo
CREATE INDEX IF NOT EXISTS ix_expense_types_name ON expense_types (name);