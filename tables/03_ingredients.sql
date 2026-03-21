-- =============================================
-- Tabla: ingredients
-- Descripción: Ingredientes disponibles
-- =============================================

CREATE TABLE IF NOT EXISTS ingredients (
    id              SERIAL PRIMARY KEY,
    name            VARCHAR(100)    NOT NULL,
    unit            VARCHAR(20)     NOT NULL,
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);
