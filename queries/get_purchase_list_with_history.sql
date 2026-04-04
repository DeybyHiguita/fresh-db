-- =============================================
-- Query: Obtener lista de compra con histórico de precios
-- Parámetro: batch_id (ID de la lista de compra)
-- Descripción: Trae todos los productos de una lista de compra 
--              y si existe una compra anterior del mismo producto,
--              muestra el valor al que se compró
-- =============================================

SELECT 
    pd.id as purchase_detail_id,
    pd.product_id,
    p.name as product_name,
    p.unit_measure,
    pd.quantity as current_quantity,
    pd.total_value as current_total_value,
    ROUND((pd.total_value / pd.quantity)::NUMERIC, 2) as current_unit_value,
    prev_pd.total_value as previous_total_value,
    ROUND((prev_pd.total_value / prev_pd.quantity)::NUMERIC, 2) as previous_unit_value,
    prev_pb.batch_name as previous_batch_name,
    prev_pb.start_date as previous_purchase_date,
    ROUND(
        ((pd.total_value / pd.quantity) - (prev_pd.total_value / prev_pd.quantity))::NUMERIC, 
        2
    ) as price_difference
FROM purchase_details pd
INNER JOIN purchase_batches pb ON pd.batch_id = pb.id
INNER JOIN products p ON pd.product_id = p.id
LEFT JOIN LATERAL (
    SELECT pd2.id, pd2.quantity, pd2.total_value, pb2.id as batch_id, pb2.batch_name, pb2.start_date
    FROM purchase_details pd2
    INNER JOIN purchase_batches pb2 ON pd2.batch_id = pb2.id
    WHERE pd2.product_id = pd.product_id
      AND pb2.start_date < pb.start_date
    ORDER BY pb2.start_date DESC
    LIMIT 1
) prev_pd ON TRUE
LEFT JOIN purchase_batches prev_pb ON prev_pd.batch_id = prev_pb.id
-- Reemplaza :batch_id con el ID de la lista de compra que deseas consultar
WHERE pd.batch_id = :batch_id
ORDER BY p.name ASC;
