-- ============================================================
-- Agrega la página WhatsApp Chat al catálogo de app_pages
-- para que pueda asignarse en permisos por usuario.
-- ============================================================

INSERT INTO app_pages (name, route, icon, description)
VALUES ('WhatsApp Chat', '/whatsapp', 'whatsapp', 'Chat de WhatsApp Business con clientes')
ON CONFLICT (route) DO NOTHING;
