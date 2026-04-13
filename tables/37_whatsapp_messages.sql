-- =============================================
-- Tabla: whatsapp_messages
-- Descripción: Mensajes entrantes y salientes de WhatsApp
-- =============================================

CREATE TABLE IF NOT EXISTS whatsapp_messages (
    id              SERIAL          PRIMARY KEY,
    contact_id      INT             NOT NULL REFERENCES whatsapp_contacts(id) ON DELETE CASCADE,
    direction       VARCHAR(3)      NOT NULL CHECK (direction IN ('in', 'out')),
    body            TEXT            NOT NULL,
    wa_message_id   VARCHAR(200)    NULL,   -- ID de Meta (wamid...)
    status          VARCHAR(20)     NOT NULL DEFAULT 'sent',  -- sent | delivered | read | failed
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS ix_whatsapp_messages_contact_id ON whatsapp_messages (contact_id);
CREATE INDEX IF NOT EXISTS ix_whatsapp_messages_wa_message_id ON whatsapp_messages (wa_message_id) WHERE wa_message_id IS NOT NULL;
