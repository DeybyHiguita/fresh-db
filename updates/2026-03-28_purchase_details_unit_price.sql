-- =============================================
-- Migración: Agregar columna unit_price a purchase_details
-- Fecha: 2026-03-28
-- Descripción: Almacena el precio por unidad de medida para cada
--              detalle de compra. Se calcula retroactivamente para
--              los registros existentes que tengan quantity > 0.
-- =============================================

ALTER TABLE purchase_details
    ADD COLUMN IF NOT EXISTS unit_price NUMERIC(12, 4) NOT NULL DEFAULT 0;

-- Calcular el precio por unidad en los registros existentes
UPDATE purchase_details
SET unit_price = ROUND(total_value / quantity, 4)
WHERE quantity > 0 AND total_value > 0;

-- Comentario de columna
COMMENT ON COLUMN purchase_details.unit_price IS 'Precio por unidad de medida (total_value / quantity)';
