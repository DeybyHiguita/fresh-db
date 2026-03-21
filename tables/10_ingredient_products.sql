-- =============================================
-- Tabla: ingredient_products
-- Descripción: Productos consumidos por cada ingrediente
-- =============================================

CREATE TABLE IF NOT EXISTS ingredient_products (
    id              SERIAL PRIMARY KEY,
    ingredient_id   INTEGER         NOT NULL REFERENCES ingredients(id) ON DELETE CASCADE,
    product_id      INTEGER         NOT NULL REFERENCES products(id) ON DELETE RESTRICT,
    quantity        NUMERIC(10,2)   NOT NULL CHECK (quantity > 0),
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    CONSTRAINT ux_ingredient_products_ingredient_product UNIQUE (ingredient_id, product_id)
);

CREATE INDEX IF NOT EXISTS ix_ingredient_products_ingredient_id ON ingredient_products (ingredient_id);
CREATE INDEX IF NOT EXISTS ix_ingredient_products_product_id ON ingredient_products (product_id);