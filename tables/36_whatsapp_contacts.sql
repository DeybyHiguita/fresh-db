-- =============================================
-- Tabla: whatsapp_contacts
-- Descripción: Contactos que han enviado mensajes vía WhatsApp
-- =============================================

CREATE TABLE IF NOT EXISTS whatsapp_contacts (
    id              SERIAL          PRIMARY KEY,
    wa_id           VARCHAR(20)     NOT NULL,           -- número de teléfono (ej: 573001234567)
    name            VARCHAR(150)    NOT NULL DEFAULT '', -- nombre del perfil de WhatsApp
    last_message_at TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    unread_count    INT             NOT NULL DEFAULT 0,
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

CREATE UNIQUE INDEX IF NOT EXISTS ix_whatsapp_contacts_wa_id ON whatsapp_contacts (wa_id);
