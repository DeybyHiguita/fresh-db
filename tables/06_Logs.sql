-- =============================================
-- Tabla: logs
-- Descripción: Auditoría de transacciones y eventos
-- =============================================

CREATE TABLE IF NOT EXISTS logs (
    id                  BIGSERIAL PRIMARY KEY,
    transaction_id      VARCHAR(100)    NOT NULL,
    correlation_id      VARCHAR(100),
    log_date            TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    log_level           VARCHAR(20)     NOT NULL,
    operation           VARCHAR(100),
    entity_name         VARCHAR(100),
    entity_id           VARCHAR(100),
    user_id             VARCHAR(100),
    transaction_status  VARCHAR(30),
    duration_ms         INTEGER,
    logger              VARCHAR(255),
    message             TEXT,
    exception           TEXT,
    transaction_data    TEXT,
    created_at          TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS ix_logs_log_date ON logs (log_date);
CREATE INDEX IF NOT EXISTS ix_logs_log_level ON logs (log_level);
CREATE INDEX IF NOT EXISTS ix_logs_transaction_id ON logs (transaction_id);
CREATE INDEX IF NOT EXISTS ix_logs_entity_name ON logs (entity_name);
CREATE INDEX IF NOT EXISTS ix_logs_user_id ON logs (user_id);
CREATE INDEX IF NOT EXISTS ix_logs_transaction_status ON logs (transaction_status);