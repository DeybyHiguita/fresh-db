-- Agrega FK opcionales a safe_transactions para relacionar con lote de compra o gasto
ALTER TABLE safe_transactions
  ADD COLUMN IF NOT EXISTS purchase_batch_id INT NULL REFERENCES purchase_batches(id) ON DELETE SET NULL,
  ADD COLUMN IF NOT EXISTS expense_id        INT NULL REFERENCES expenses(id)         ON DELETE SET NULL;
