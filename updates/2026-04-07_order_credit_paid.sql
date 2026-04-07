-- Migración: 2026-04-07
-- Agrega columna is_credit_paid a orders
-- Permite rastrear qué órdenes de crédito ya han sido canceladas individualmente

ALTER TABLE orders
  ADD COLUMN IF NOT EXISTS is_credit_paid BOOLEAN NOT NULL DEFAULT FALSE;

-- Índice para consultas de órdenes pendientes de crédito por cliente
CREATE INDEX IF NOT EXISTS idx_orders_credit_pending
  ON orders (customer_id, payment_method, is_credit_paid)
  WHERE payment_method = 'Crédito';
