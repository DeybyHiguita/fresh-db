-- =============================================
-- Tabla: menu_items
-- Descripción: Catálogo de productos finales para la venta al cliente
-- =============================================
CREATE TABLE IF NOT EXISTS menu_items (
    id                  SERIAL PRIMARY KEY,
    name                VARCHAR(150)    NOT NULL, -- Ej: 'Soda de Frutos Rojos', 'Malteada de Oreo'
    description         TEXT            NULL,     -- Útil para mostrar en tu página web
    category            VARCHAR(50)     NOT NULL, -- Ej: 'Sodas', 'Jugos', 'Mecatos', 'Raspados'
    preparation_cost    NUMERIC(10, 2)  NOT NULL, -- Cuánto te cuesta hacerlo (Costo de venta)
    sale_price          NUMERIC(10, 2)  NOT NULL, -- A cuánto lo vendes al público
    is_available        BOOLEAN         NOT NULL DEFAULT TRUE, -- Para ocultarlo si te quedas sin insumos
    created_at          TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

-- Índice para filtrar rápidamente por categoría (muy útil para la vista del menú o el POS)
CREATE INDEX IF NOT EXISTS ix_menu_items_category ON menu_items (category);