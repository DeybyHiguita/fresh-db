-- =============================================
-- Query: Lista de compra simplificada (solo lo esencial)
-- Parámetro: batch_id (ID de la lista de compra)
-- =============================================

SELECT 
    p.id as product_id,
    p.name as product_name,
    p.unit_measure,
    pd.quantity,
    pd.total_value,
    ROUND((pd.total_value / pd.quantity)::NUMERIC, 2) as unit_price,
    prev_pd.total_value as last_purchase_value,
    ROUND((prev_pd.total_value / prev_pd.quantity)::NUMERIC, 2) as last_unit_price
    
FROM purchase_details pd
INNER JOIN purchase_batches pb ON pd.batch_id = pb.id
INNER JOIN products p ON pd.product_id = p.id
LEFT JOIN LATERAL (
    SELECT pd2.quantity, pd2.total_value
    FROM purchase_details pd2
    INNER JOIN purchase_batches pb2 ON pd2.batch_id = pb2.id
    WHERE pd2.product_id = pd.product_id
      AND pb2.start_date < pb.start_date
    ORDER BY pb2.start_date DESC
    LIMIT 1
) prev_pd ON TRUE

WHERE pd.batch_id = $1

ORDER BY p.name ASC;
