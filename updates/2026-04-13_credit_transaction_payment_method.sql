-- Agrega método de pago a los abonos de crédito
-- Necesario para saber cómo entran los pagos de crédito a la caja (efectivo o transferencia)

ALTER TABLE credit_transactions
  ADD COLUMN IF NOT EXISTS payment_method VARCHAR(50) NULL;

-- Los registros existentes de tipo "Abono" se marcan como Efectivo por defecto
UPDATE credit_transactions
SET payment_method = 'Efectivo'
WHERE type = 'Abono' AND payment_method IS NULL;
