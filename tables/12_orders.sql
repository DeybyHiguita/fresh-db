-- =============================================
-- Tabla: orders
-- Descripción: Cabecera de los pedidos/ventas de los clientes
-- =============================================
CREATE TABLE IF NOT EXISTS orders (
    id              SERIAL PRIMARY KEY,
    
    -- Relación con el empleado que registró la orden
    user_id         INTEGER         NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
    
    -- Datos de quien compra (el cliente)
    customer_name   VARCHAR(150)    NULL, -- Puede ser nulo si es una venta rápida de mostrador
    customer_phone  VARCHAR(20)     NULL, -- Clave para los domicilios
    
    -- Detalles financieros de la orden
    subtotal        NUMERIC(10, 2)  NOT NULL DEFAULT 0.00,
    discount        NUMERIC(10, 2)  NOT NULL DEFAULT 0.00,
    total           NUMERIC(10, 2)  NOT NULL DEFAULT 0.00, -- (subtotal - discount)
    
    -- Clasificación y estado
    order_type      VARCHAR(50)     NOT NULL DEFAULT 'Local', -- Ej: 'Local', 'Llevar', 'Domicilio'
    payment_method  VARCHAR(50)     NOT NULL DEFAULT 'Efectivo', -- Ej: 'Efectivo', 'Nequi', 'Tarjeta'
    status          VARCHAR(50)     NOT NULL DEFAULT 'Pendiente', -- Ej: 'Pendiente', 'Completada', 'Cancelada'
    
    -- Notas adicionales (ej: "Sin azúcar", "Dirección del domicilio")
    notes           TEXT            NULL,
    
    -- Auditoría
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

-- Índices para reportes y búsquedas rápidas
CREATE INDEX IF NOT EXISTS ix_orders_user_id ON orders (user_id);
CREATE INDEX IF NOT EXISTS ix_orders_created_at ON orders (created_at);
CREATE INDEX IF NOT EXISTS ix_orders_status ON orders (status);