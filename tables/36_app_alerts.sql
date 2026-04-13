-- ============================================================
-- Tabla: app_alerts
-- Alertas que el administrador puede crear y enviar a empleados
-- ============================================================

CREATE TABLE IF NOT EXISTS app_alerts (
    id                  SERIAL PRIMARY KEY,
    title               VARCHAR(200)    NOT NULL,
    message             TEXT            NOT NULL,
    alert_type          VARCHAR(20)     NOT NULL DEFAULT 'info',   -- info | warning | urgent
    created_by_user_id  INT             NOT NULL,
    created_at          TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    last_sent_at        TIMESTAMPTZ,
    send_count          INT             NOT NULL DEFAULT 0
);

COMMENT ON TABLE  app_alerts                     IS 'Alertas creadas por admin para notificar a empleados en tiempo real';
COMMENT ON COLUMN app_alerts.alert_type          IS 'info | warning | urgent';
COMMENT ON COLUMN app_alerts.send_count          IS 'Cuántas veces ha sido enviada la alerta';
COMMENT ON COLUMN app_alerts.last_sent_at        IS 'Última vez que fue enviada por SignalR';
