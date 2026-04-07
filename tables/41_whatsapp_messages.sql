-- =============================================
-- Tabla: whatsapp_messages
-- Descripción: Mensajes individuales de una conversación de WhatsApp.
--              Incluye mensajes entrantes (in) y salientes (out).
-- =============================================
CREATE TABLE IF NOT EXISTS whatsapp_messages (
    id                    SERIAL          PRIMARY KEY,
    contact_id            INTEGER         NOT NULL REFERENCES whatsapp_contacts(id) ON DELETE CASCADE,
    direction             VARCHAR(3)      NOT NULL CHECK (direction IN ('in', 'out')),
    body                  TEXT            NOT NULL DEFAULT '',
    wa_message_id         VARCHAR(200)    NULL UNIQUE,  -- WAMID asignado por Meta
    status                VARCHAR(20)     NOT NULL DEFAULT 'sent',
                                                        -- sent | delivered | read | failed
    media_type            VARCHAR(20)     NULL,         -- image | document | audio | video | sticker
    media_id              VARCHAR(200)    NULL,         -- Media ID de Meta
    media_name            VARCHAR(255)    NULL,         -- nombre del archivo (documentos)
    reply_to_wa_message_id VARCHAR(200)   NULL,         -- WAMID del mensaje al que responde (respuestas contextuales)
    created_at            TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS ix_whatsapp_messages_contact_id
    ON whatsapp_messages (contact_id);

CREATE INDEX IF NOT EXISTS ix_whatsapp_messages_wa_message_id
    ON whatsapp_messages (wa_message_id);
