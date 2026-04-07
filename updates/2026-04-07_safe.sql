-- Migración: 2026-04-07
-- Caja fuerte: registros de ingresos y gastos propios

-- Tabla principal de la caja fuerte (balance acumulado)
CREATE TABLE IF NOT EXISTS safe (
    id            SERIAL PRIMARY KEY,
    balance       DECIMAL(12,2) NOT NULL DEFAULT 0,
    created_at    TIMESTAMPTZ   NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMPTZ   NOT NULL DEFAULT NOW()
);

-- Insertar registro único si no existe
INSERT INTO safe (balance) SELECT 0 WHERE NOT EXISTS (SELECT 1 FROM safe);

-- Movimientos de la caja fuerte
CREATE TABLE IF NOT EXISTS safe_transactions (
    id              SERIAL PRIMARY KEY,
    type            VARCHAR(20)   NOT NULL, -- 'Ingreso' | 'Gasto'
    amount          DECIMAL(12,2) NOT NULL,
    description     TEXT          NOT NULL,
    balance_before  DECIMAL(12,2) NOT NULL,
    balance_after   DECIMAL(12,2) NOT NULL,
    cash_register_id INT          REFERENCES cash_registers(id) ON DELETE SET NULL,
    created_by_id   INT           REFERENCES users(id) ON DELETE SET NULL,
    created_at      TIMESTAMPTZ   NOT NULL DEFAULT NOW()
);

-- Campo en cash_registers para preguntar cuánto va a caja fuerte al cerrar
ALTER TABLE cash_registers
    ADD COLUMN IF NOT EXISTS amount_to_safe DECIMAL(12,2) NOT NULL DEFAULT 0;

CREATE INDEX IF NOT EXISTS idx_safe_transactions_type       ON safe_transactions(type);
CREATE INDEX IF NOT EXISTS idx_safe_transactions_created_at ON safe_transactions(created_at);
