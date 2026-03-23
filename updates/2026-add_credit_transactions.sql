-- Migration: Credit transaction ledger
-- Every time a customer uses their cupo or makes a payment, a row is inserted here.
-- This gives a full audit trail and lets the app show "historial de movimientos".

CREATE TABLE IF NOT EXISTS credit_transactions (
  id                  SERIAL PRIMARY KEY,
  customer_credit_id  INTEGER       NOT NULL REFERENCES customer_credits(id) ON DELETE CASCADE,
  order_id            INTEGER       NULL     REFERENCES orders(id)           ON DELETE SET NULL,
  type                VARCHAR(20)   NOT NULL DEFAULT 'Cargo',  -- 'Cargo' | 'Abono'
  amount              DECIMAL(10,2) NOT NULL,
  balance_before      DECIMAL(10,2) NOT NULL,
  balance_after       DECIMAL(10,2) NOT NULL,
  description         VARCHAR(300),
  created_at          TIMESTAMPTZ   NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS ix_credit_tx_credit_id ON credit_transactions (customer_credit_id);
CREATE INDEX IF NOT EXISTS ix_credit_tx_order_id  ON credit_transactions (order_id);
CREATE INDEX IF NOT EXISTS ix_credit_tx_created   ON credit_transactions (created_at DESC);
