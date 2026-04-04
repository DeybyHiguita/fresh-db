-- =============================================
-- Migración: 2026-04-04
-- Descripción: Agrega columna purchase_batch_id a expenses
--              para vincular un gasto directamente con un lote de compra.
-- =============================================

ALTER TABLE expenses
  ADD COLUMN IF NOT EXISTS purchase_batch_id INTEGER NULL
    REFERENCES purchase_batches(id) ON DELETE SET NULL;

CREATE INDEX IF NOT EXISTS ix_expenses_purchase_batch_id
  ON expenses (purchase_batch_id);
