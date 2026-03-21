-- =============================================
-- Seed: Categorías iniciales
-- Descripción: Tipos de bebidas del negocio
-- =============================================

INSERT INTO categories (id, name, description)
VALUES
    (1, 'Jugos',       'Jugos naturales de frutas'),
    (2, 'Sodas',       'Sodas y bebidas carbonatadas'),
    (3, 'Micheladas',  'Micheladas y preparados'),
    (4, 'Malteadas',   'Malteadas y batidos')
ON CONFLICT (id) DO NOTHING;
