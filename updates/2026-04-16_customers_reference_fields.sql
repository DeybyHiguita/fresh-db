-- Agrega columnas de referencia al cliente (nombre y teléfono de referencia)
ALTER TABLE customers
  ADD COLUMN IF NOT EXISTS reference_name  VARCHAR(150) NULL,
  ADD COLUMN IF NOT EXISTS reference_phone VARCHAR(20)  NULL;

-- Agrega método de pago a credit_transactions (se omitió en el script original)
ALTER TABLE credit_transactions
  ADD COLUMN IF NOT EXISTS payment_method VARCHAR(50) NULL;
