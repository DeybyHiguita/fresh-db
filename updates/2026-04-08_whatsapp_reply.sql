-- Migración: 2026-04-08
-- Agrega columna reply_to_wa_message_id a whatsapp_messages

ALTER TABLE whatsapp_messages
    ADD COLUMN IF NOT EXISTS reply_to_wa_message_id VARCHAR(200) NULL;
