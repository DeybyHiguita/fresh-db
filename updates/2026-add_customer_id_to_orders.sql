-- Migration: Add customer_id FK to orders table
-- Purpose: Link an order to a registered customer (optional)

ALTER TABLE orders
  ADD COLUMN IF NOT EXISTS customer_id INTEGER NULL REFERENCES customers(id) ON DELETE SET NULL;

CREATE INDEX IF NOT EXISTS ix_orders_customer_id ON orders (customer_id);
