-- =============================================
-- Tabla: recipes
-- Descripción: Recetas de bebidas
-- =============================================

CREATE TABLE IF NOT EXISTS recipes (
    id              SERIAL PRIMARY KEY,
    name            VARCHAR(100)    NOT NULL,
    description     VARCHAR(500),
    instructions    TEXT,
    category_id     INTEGER         NOT NULL,
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_recipes_categories
        FOREIGN KEY (category_id)
        REFERENCES categories (id)
        ON DELETE CASCADE
);

-- Índice para búsquedas por categoría
CREATE INDEX IF NOT EXISTS ix_recipes_category_id ON recipes (category_id);
