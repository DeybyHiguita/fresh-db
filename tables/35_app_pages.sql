-- ============================================================
-- Tabla: app_pages
-- Descripción: Catálogo de todas las pantallas/módulos del sistema
-- ============================================================
CREATE TABLE IF NOT EXISTS app_pages (
    id          SERIAL       PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,            -- Nombre visible (Ej: 'Inventario', 'Cajas')
    route       VARCHAR(100) NOT NULL UNIQUE,     -- Ruta en Angular (Ej: '/inventory', '/cash-registers')
    icon        VARCHAR(50)  NULL,                -- Ícono de Material (Ej: 'inventory_2', 'point_of_sale')
    description TEXT         NULL,                -- Para qué sirve la página
    is_active   BOOLEAN      NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);