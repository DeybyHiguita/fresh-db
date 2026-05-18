
--Consultar las ordenes desde una fecha inicio y fecha fin

SELECT * FROM orders as o
INNER JOIN order_items as oi ON o.id = oi.order_id
WHERE o.created_at >= '2026-04-01' AND o.created_at <= '2026-04-30'

delete from order_item where created_at <= '2026-04-01'
delete from orders where created_at <= '2026-04-01'

-- =============================================
-- Órdenes, ítems y facturas creadas antes o el 02/04/2026
-- =============================================
SELECT
    -- Orden
    o.id                AS orden_id,
    o.created_at        AS orden_fecha,
    o.customer_name,
    o.customer_phone,
    o.order_type,
    o.payment_method,
    o.status,
    o.subtotal          AS orden_subtotal,
    o.discount          AS orden_descuento,
    o.total             AS orden_total,
    o.notes             AS orden_notas,

    -- Ítem de la orden
    oi.id               AS item_id,
    oi.menu_item_id,
    oi.quantity,
    oi.unit_price,
    oi.subtotal         AS item_subtotal,
    oi.item_notes,

    -- Factura (NULL si la orden no tiene factura)
    inv.id              AS factura_id,
    inv.invoice_number,
    inv.customer_document,
    inv.tax_amount,
    inv.discount_amount,
    inv.total_amount    AS factura_total,
    inv.cash_tendered,
    inv.change_amount,
    inv.issued_at       AS factura_fecha

FROM orders o
INNER JOIN order_items oi ON oi.order_id = o.id
LEFT  JOIN invoices    inv ON inv.order_id = o.id

WHERE o.created_at <= '2026-04-02 23:59:59.999999+00'

ORDER BY o.created_at DESC, o.id, oi.id;

-- =============================================
-- ELIMINAR órdenes, ítems y facturas <= 02/04/2026
-- Orden de borrado:
--   1. invoices    (RESTRICT → hay que borrar primero)
--   2. orders      (CASCADE → borra order_items automáticamente)
-- =============================================
BEGIN;

    -- 1. Facturas de esas órdenes
    DELETE FROM invoices
    WHERE order_id IN (
        SELECT id FROM orders
        WHERE created_at <= '2026-04-02 23:59:59.999999+00'
    );

    -- 2. Órdenes (order_items se elimina en cascada)
    DELETE FROM orders
    WHERE created_at <= '2026-04-02 23:59:59.999999+00';

COMMIT;
-- Si algo sale mal, ejecuta ROLLBACK; en lugar de COMMIT;

-- =============================================
-- Cierres de caja con su descuadre
-- =============================================
SELECT
    cr.id                                                                   AS caja_id,
    cp.name                                                                 AS periodo,
    u_open.name                                                             AS abierta_por,
    u_close.name                                                            AS cerrada_por,
    cr.opening_time,
    cr.closing_time,
    cr.status,

    -- Lo que reportó el cajero
    cr.reported_cash,
    cr.reported_transfer,
    cr.reported_card,

    -- Lo que calculó el sistema
    cr.system_cash,
    cr.system_transfer,
    cr.system_card,

    -- Descuadre por método de pago (reportado - sistema)
    (cr.reported_cash     - cr.system_cash)                                 AS descuadre_efectivo,
    (cr.reported_transfer - cr.system_transfer)                             AS descuadre_transferencia,
    (cr.reported_card     - cr.system_card)                                 AS descuadre_tarjeta,

    -- Descuadre total
    (
        (cr.reported_cash     - cr.system_cash)
      + (cr.reported_transfer - cr.system_transfer)
      + (cr.reported_card     - cr.system_card)
    )                                                                       AS descuadre_total

FROM cash_registers cr
INNER JOIN cash_periods  cp      ON cp.id = cr.period_id
INNER JOIN users         u_open  ON u_open.id  = cr.opened_by
LEFT  JOIN users         u_close ON u_close.id = cr.closed_by

WHERE cr.status IN ('Cerrada', 'Descuadrada')

ORDER BY cr.closing_time DESC;

