-- =============================================
-- Variantes de ítem del menú
-- Ejemplo: "Jugo de Mango" → En leche / En agua
-- =============================================
CREATE TABLE IF NOT EXISTS menu_item_variants (
    id                  SERIAL PRIMARY KEY,
    menu_item_id        INTEGER         NOT NULL REFERENCES menu_items(id) ON DELETE CASCADE,
    variant_name        VARCHAR(100)    NOT NULL,       -- "En leche", "En agua", "Grande", etc.
    sale_price          NUMERIC(10, 2)  NOT NULL,
    preparation_cost    NUMERIC(10, 2)  NOT NULL DEFAULT 0,
    is_available        BOOLEAN         NOT NULL DEFAULT TRUE,
    sort_order          INTEGER         NOT NULL DEFAULT 0,
    created_at          TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS ix_menu_item_variants_menu_item_id ON menu_item_variants (menu_item_id);
