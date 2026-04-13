-- Agrega soporte de media (imágenes, documentos, audio) a los mensajes de WhatsApp
ALTER TABLE whatsapp_messages
    ADD COLUMN IF NOT EXISTS media_type VARCHAR(20)  NULL,  -- image | document | audio | video
    ADD COLUMN IF NOT EXISTS media_id   VARCHAR(200) NULL,  -- ID de media en Meta (para obtener URL)
    ADD COLUMN IF NOT EXISTS media_name VARCHAR(255) NULL;  -- nombre del archivo (documentos)
