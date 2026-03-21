-- Tabla: products
-- Descripción: Catálogo de insumos y bebidas para control de inventario
-- =============================================
CREATE TABLE IF NOT EXISTS products (
    id              SERIAL PRIMARY KEY,
    name            VARCHAR(150)    NOT NULL,
    unit_measure    VARCHAR(50)     NOT NULL,
    current_stock   NUMERIC(10, 2)  NOT NULL DEFAULT 0.00,
    is_active       BOOLEAN         NOT NULL DEFAULT TRUE,
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);