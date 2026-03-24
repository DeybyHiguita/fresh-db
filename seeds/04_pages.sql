INSERT INTO app_pages (name, route, icon, description) VALUES 
-- Principal
('Inicio', '/loading', 'home', 'Pantalla inicial de redirección y carga'),
('Perfil', '/user-sessions', 'person', 'Monitoreo de sesiones y perfil del usuario'),
('Usuarios', '/users', 'group', 'Gestión de empleados y cajeros'),
('Dashboard', '/dashboard', 'dashboard', 'Métricas y resumen general del negocio'),
('Recetas', '/recipes', 'menu_book', 'Creación y gestión de recetas de productos'),
('Ingredientes', '/ingredients', 'science', 'Catálogo base de insumos para las recetas'),
('Inventario', '/inventory', 'inventory_2', 'Control de stock y lotes de compra'),

-- En tienda
('Órdenes', '/orders', 'receipt_long', 'Módulo de ventas, facturación y comandas'),
('Menú', '/menu-items', 'restaurant_menu', 'Catálogo de productos disponibles para la venta'),
('Caja', '/cash-registers', 'point_of_sale', 'Apertura, cuadre y cierre de caja diario'),
('Jornadas', '/work-shifts', 'schedule', 'Control de turnos y descansos de los muchachos'),

-- Extra
('Clientes', '/customers', 'people', 'Directorio de clientes, historial y fiados (crédito)'),
('Gastos', '/expenses', 'money_off', 'Registro de pagos y salidas de dinero de la caja'),
('Equipos', '/equipments', 'precision_manufacturing', 'Inventario de activos fijos, mantenimiento y maquinaria'),

-- Admin
('Permisos', '/permissions', 'admin_panel_settings', 'Configuración de accesos y seguridad por usuario');