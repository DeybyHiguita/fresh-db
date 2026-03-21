INSERT INTO users (name, email, password, role, is_active, created_at, updated_at)
VALUES
  ('Jhon Deyby Higuita', 'davehiguitapro@gmail.com', '', 'admin', TRUE, NOW(), NOW())
ON CONFLICT DO NOTHING;
