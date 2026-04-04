-- =============================================
-- Migración: 2026-04-04 (b)
-- Descripción: Habilita pg_trgm y agrega índice GIN
--              para búsqueda rápida por nombre de lote.
-- =============================================

-- Extensión de trigramas (solo si no existe)
CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- Índice GIN sobre lower(batch_name) — soporta ILIKE '%texto%' rápido
CREATE INDEX CONCURRENTLY IF NOT EXISTS ix_purchase_batches_name_trgm
  ON purchase_batches
  USING gin (lower(batch_name) gin_trgm_ops);
