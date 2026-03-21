-- =============================================
-- Tabla: recipe_ingredients
-- Descripción: Ingredientes por receta (relación N:M)
-- =============================================

CREATE TABLE IF NOT EXISTS recipe_ingredients (
    id              SERIAL PRIMARY KEY,
    recipe_id       INTEGER         NOT NULL,
    ingredient_id   INTEGER         NOT NULL,
    quantity        NUMERIC(10,2)   NOT NULL,
    unit            VARCHAR(20)     NOT NULL,

    CONSTRAINT fk_recipe_ingredients_recipes
        FOREIGN KEY (recipe_id)
        REFERENCES recipes (id)
        ON DELETE CASCADE,

    CONSTRAINT fk_recipe_ingredients_ingredients
        FOREIGN KEY (ingredient_id)
        REFERENCES ingredients (id)
        ON DELETE CASCADE
);

-- Índices para las foreign keys
CREATE INDEX IF NOT EXISTS ix_recipe_ingredients_recipe_id ON recipe_ingredients (recipe_id);
CREATE INDEX IF NOT EXISTS ix_recipe_ingredients_ingredient_id ON recipe_ingredients (ingredient_id);
