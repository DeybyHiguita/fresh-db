-- =============================================
-- Update: menu_items - agregar columna img_url
-- Fecha: 2026-03-26
-- Descripción: Permite guardar la URL de una imagen pública del producto
--              (Google Images, Unsplash, Pexels, etc.)
-- =============================================
ALTER TABLE menu_items
    ADD COLUMN IF NOT EXISTS img_url TEXT NULL;

COMMENT ON COLUMN menu_items.img_url IS 'URL pública de la imagen del producto (Google Images, Unsplash, Pexels, etc.)';
