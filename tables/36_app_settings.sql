CREATE TABLE IF NOT EXISTS app_settings (
    id          SERIAL PRIMARY KEY,
    key         VARCHAR(100) NOT NULL UNIQUE,
    value       VARCHAR(500) NOT NULL DEFAULT '',
    description VARCHAR(500) NOT NULL DEFAULT '',
    updated_at  TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);

-- Semilla: configuraciones por defecto
INSERT INTO app_settings (key, value, description)
VALUES
  ('whatsapp_notifications_enabled', 'false', 'Enviar notificación por WhatsApp al administrador cuando se crea una orden')
ON CONFLICT (key) DO NOTHING;
