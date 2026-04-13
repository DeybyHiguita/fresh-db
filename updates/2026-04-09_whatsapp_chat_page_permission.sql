-- ============================================================
-- Migración: 2026-04-09
-- Asegura que la página /whatsapp-chat esté en app_pages
-- y que los admins tengan el permiso actualizado.
-- ============================================================

-- 1. Si la página existía como /whatsapp Y no existe ya /whatsapp-chat, renombrarla
UPDATE app_pages
   SET route = '/whatsapp-chat',
       name  = 'WhatsApp Chat'
 WHERE route = '/whatsapp'
   AND NOT EXISTS (SELECT 1 FROM app_pages WHERE route = '/whatsapp-chat');

-- 1b. Si ambas existían, eliminar la entrada /whatsapp duplicada
DELETE FROM app_pages
 WHERE route = '/whatsapp'
   AND EXISTS (SELECT 1 FROM app_pages WHERE route = '/whatsapp-chat');

-- 2. Si no existía con ninguna de las dos rutas, insertarla
INSERT INTO app_pages (name, route, icon, description)
SELECT 'WhatsApp Chat', '/whatsapp-chat', 'whatsapp', 'Chat en tiempo real con clientes de WhatsApp'
 WHERE NOT EXISTS (
   SELECT 1 FROM app_pages WHERE route = '/whatsapp-chat'
 );

-- 3. Otorgar el permiso /whatsapp-chat a todos los admins que aún no lo tengan
INSERT INTO user_permissions (user_id, page_id, can_access, updated_at)
SELECT u.id, p.id, true, NOW()
  FROM users u
  JOIN app_pages p ON p.route = '/whatsapp-chat'
 WHERE u.role = 'admin'
   AND NOT EXISTS (
     SELECT 1 FROM user_permissions up2
      WHERE up2.user_id = u.id AND up2.page_id = p.id
   );
