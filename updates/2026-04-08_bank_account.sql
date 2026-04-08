-- Migración: 2026-04-08
-- Agrega cuenta bancaria: tipo en safe y safe_transactions, y monto en cash_registers

-- 1. Tipo de caja en la tabla safe
ALTER TABLE safe
    ADD COLUMN IF NOT EXISTS safe_type VARCHAR(20) NOT NULL DEFAULT 'caja_fuerte';

-- 2. Hacer única la combinación para evitar duplicados
ALTER TABLE safe
    DROP CONSTRAINT IF EXISTS uq_safe_type;

ALTER TABLE safe
    ADD CONSTRAINT uq_safe_type UNIQUE (safe_type);

-- 3. Insertar registro de cuenta bancaria si no existe
INSERT INTO safe (balance, safe_type)
SELECT 0, 'cuenta_bancaria'
WHERE NOT EXISTS (SELECT 1 FROM safe WHERE safe_type = 'cuenta_bancaria');

-- 4. Tipo de caja en safe_transactions
ALTER TABLE safe_transactions
    ADD COLUMN IF NOT EXISTS safe_type VARCHAR(20) NOT NULL DEFAULT 'caja_fuerte';

CREATE INDEX IF NOT EXISTS idx_safe_transactions_safe_type ON safe_transactions(safe_type);

-- 5. Monto enviado a cuenta bancaria al cerrar caja
ALTER TABLE cash_registers
    ADD COLUMN IF NOT EXISTS amount_to_bank_account DECIMAL(12,2) NOT NULL DEFAULT 0;
