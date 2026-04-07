-- ============================================================
-- Agrega la columna reply_to_wa_message_id a whatsapp_messages
-- para soportar respuestas contextuales de WhatsApp Business API.
-- ============================================================

ALTER TABLE whatsapp_messages
    ADD COLUMN IF NOT EXISTS reply_to_wa_message_id VARCHAR(200) NULL;

COMMENT ON COLUMN whatsapp_messages.reply_to_wa_message_id
    IS 'WAMID del mensaje al que se responde (Context Reply de Meta). NULL si no es respuesta.';
