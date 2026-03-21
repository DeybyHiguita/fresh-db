-- =============================================
-- Tabla: order_items
-- Descripción: Detalle de los productos (MenuItems) dentro de una orden
-- =============================================
CREATE TABLE IF NOT EXISTS order_items (
    id              SERIAL PRIMARY KEY,
    
    -- Relaciones
    order_id        INTEGER         NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    menu_item_id    INTEGER         NOT NULL REFERENCES menu_items(id) ON DELETE RESTRICT,
    
    -- Detalles del producto en el momento de la venta
    quantity        INTEGER         NOT NULL DEFAULT 1,
    unit_price      NUMERIC(10, 2)  NOT NULL, -- El precio de venta en el momento exacto de la compra
    subtotal        NUMERIC(10, 2)  NOT NULL, -- (quantity * unit_price)
    
    -- Notas por producto (ej: "La soda sin hielo")
    item_notes      VARCHAR(255)    NULL,
    
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

-- Índices para mejorar las consultas
CREATE INDEX IF NOT EXISTS ix_order_items_order_id ON order_items (order_id);
CREATE INDEX IF NOT EXISTS ix_order_items_menu_item_id ON order_items (menu_item_id);