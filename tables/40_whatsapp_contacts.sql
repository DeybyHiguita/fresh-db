-- =============================================
-- Tabla: whatsapp_contacts
-- Descripción: Contactos de WhatsApp Business con los que se ha tenido
--              alguna conversación. Un contacto = un número de teléfono.
-- =============================================
CREATE TABLE IF NOT EXISTS whatsapp_contacts (
    id              SERIAL          PRIMARY KEY,
    wa_id           VARCHAR(30)     NOT NULL UNIQUE, -- número de teléfono en formato Meta (sin +)
    name            VARCHAR(150)    NULL,            -- nombre indicado por el usuario en WhatsApp
    unread_count    INTEGER         NOT NULL DEFAULT 0,
    last_message_at TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS ix_whatsapp_contacts_wa_id
    ON whatsapp_contacts (wa_id);
