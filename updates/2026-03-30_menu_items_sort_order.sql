-- =============================================
-- Migración: Agregar columna sort_order a menu_items
-- Fecha: 2026-03-30
-- =============================================

ALTER TABLE menu_items
  ADD COLUMN IF NOT EXISTS sort_order INTEGER NOT NULL DEFAULT 0;

CREATE INDEX IF NOT EXISTS ix_menu_items_sort_order
  ON menu_items (sort_order);

COMMENT ON COLUMN menu_items.sort_order IS
  'Orden de visualización del item en el menú (menor número = aparece primero)';
