-- Agregamos la columna product_id a la tabla de ingredientes
ALTER TABLE ingredients 
ADD COLUMN IF NOT EXISTS product_id INTEGER NULL;

-- Creamos la llave foránea
ALTER TABLE ingredients
ADD CONSTRAINT fk_ingredients_products
FOREIGN KEY (product_id) REFERENCES products (id)
ON DELETE SET NULL;

-- Índice para mejorar el rendimiento de las consultas de inventario
CREATE INDEX IF NOT EXISTS ix_ingredients_product_id ON ingredients (product_id);