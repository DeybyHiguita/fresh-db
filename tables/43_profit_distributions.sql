-- ============================================================
-- Tabla: profit_distributions
-- Historial de distribuciones de ganancias aprobadas
-- ============================================================
CREATE TABLE IF NOT EXISTS profit_distributions (
  id            SERIAL PRIMARY KEY,
  total_profit  DECIMAL(14, 2) NOT NULL,
  notes         TEXT,
  created_by_id INTEGER       NOT NULL REFERENCES users(id),
  created_at    TIMESTAMPTZ   NOT NULL DEFAULT NOW()
);

-- ============================================================
-- Tabla: profit_distribution_shares
-- Detalle por inversionista de cada distribución
-- ============================================================
CREATE TABLE IF NOT EXISTS profit_distribution_shares (
  id                SERIAL PRIMARY KEY,
  distribution_id   INTEGER       NOT NULL REFERENCES profit_distributions(id) ON DELETE CASCADE,
  investor_id       INTEGER       NOT NULL REFERENCES users(id),
  investor_name     VARCHAR(200)  NOT NULL,
  invested_capital  DECIMAL(14, 2) NOT NULL,
  participation_pct DECIMAL(8, 4)  NOT NULL,
  share_amount      DECIMAL(14, 2) NOT NULL,
  created_at        TIMESTAMPTZ   NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_profit_distributions_created_by ON profit_distributions(created_by_id);
CREATE INDEX IF NOT EXISTS idx_profit_distribution_shares_dist ON profit_distribution_shares(distribution_id);
CREATE INDEX IF NOT EXISTS idx_profit_distribution_shares_inv  ON profit_distribution_shares(investor_id);
