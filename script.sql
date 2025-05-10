-- return data about the total weight per product ordered by the customer with customerId = 32 delivered on February 13, 2024
WITH base AS (
	SELECT 
		p.product_id, 
		p.weight, 
		op.order_id, 
		op.quantity,
		o.customer_id,
		r.segment_end_time
	FROM products p
	JOIN orders_products op
	ON op.product_id = p.product_id
	JOIN orders o
	ON o.order_id = op.order_id
	JOIN route_segments r
	ON r.order_id = op.order_id
	WHERE o.customer_id = 32
		AND DATE(r.segment_end_time) = '2024-02-13'
)

SELECT
	product_id AS productId,
	SUM(base.quantity * base.weight) AS totalWeight
FROM base
GROUP BY base.product_id
ORDER BY totalWeight;
