-- =============================================
-- Tabla: invoices
-- Descripción: Facturas o tirillas POS generadas para las órdenes
-- =============================================
CREATE TABLE IF NOT EXISTS invoices (
    id                  SERIAL PRIMARY KEY,
    
    -- Relación 1 a 1 con la Orden
    order_id            INTEGER         NOT NULL UNIQUE REFERENCES orders(id) ON DELETE RESTRICT,
    
    -- Datos legales de la factura
    invoice_number      VARCHAR(50)     NOT NULL UNIQUE, -- Ej: 'POS-00001'
    customer_document   VARCHAR(20)     NULL,            -- Cédula o NIT (Opcional en tirillas rápidas)
    customer_name       VARCHAR(150)    NULL,            -- Se puede heredar de la orden
    
    -- Desglose financiero final para impresión
    subtotal            NUMERIC(10, 2)  NOT NULL,
    tax_amount          NUMERIC(10, 2)  NOT NULL DEFAULT 0.00, -- Impuestos (Ej: 8% Impoconsumo)
    discount_amount     NUMERIC(10, 2)  NOT NULL DEFAULT 0.00,
    total_amount        NUMERIC(10, 2)  NOT NULL,
    
    -- Control de caja (Súper importante para la tirilla impresa)
    payment_method      VARCHAR(50)     NOT NULL,              -- Efectivo, Nequi, Tarjeta
    cash_tendered       NUMERIC(10, 2)  NOT NULL DEFAULT 0.00, -- ¿Con cuánto billete pagó el cliente?
    change_amount       NUMERIC(10, 2)  NOT NULL DEFAULT 0.00, -- ¿Cuánto se le devolvió?
    
    -- Auditoría
    issued_at           TIMESTAMPTZ     NOT NULL DEFAULT NOW() -- Fecha y hora exacta de impresión
);

-- Índices para búsquedas rápidas por número de factura o fecha
CREATE INDEX IF NOT EXISTS ix_invoices_invoice_number ON invoices (invoice_number);
CREATE INDEX IF NOT EXISTS ix_invoices_issued_at ON invoices (issued_at);