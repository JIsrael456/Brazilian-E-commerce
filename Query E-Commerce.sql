-- View 1: Total de pedidos por status
CREATE OR ALTER VIEW vw_pedidos_por_status AS
SELECT 
    order_status,
    COUNT(*) AS total_pedidos
FROM dbo.olist_orders_dataset
GROUP BY order_status;
GO

-- View 2: Vendas por estado do cliente
CREATE OR ALTER VIEW vw_vendas_por_estado AS
SELECT 
    c.customer_state,
    SUM(i.price) AS total_vendido
FROM dbo.olist_orders_dataset o
JOIN dbo.olist_order_items_dataset i ON o.order_id = i.order_id
JOIN dbo.olist_customers_dataset c ON o.customer_id = c.customer_id
GROUP BY c.customer_state;
GO

-- View 3: Produtos mais vendidos (removido ORDER BY)
CREATE OR ALTER VIEW vw_top_produtos_vendidos AS
SELECT 
    p.product_category_name,
    COUNT(*) AS total_vendas
FROM dbo.olist_order_items_dataset i
JOIN dbo.olist_products_dataset p ON i.product_id = p.product_id
GROUP BY p.product_category_name;
GO

-- View 4: Tempo médio de entrega
CREATE OR ALTER VIEW vw_tempo_medio_entrega AS
SELECT 
    AVG(DATEDIFF(DAY, order_purchase_timestamp, order_delivered_customer_date)) AS media_dias_entrega
FROM dbo.olist_orders_dataset
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL;
GO

-- View 5: Valor por tipo de pagamento
CREATE OR ALTER VIEW vw_valor_por_tipo_pagamento AS
SELECT 
    payment_type,
    SUM(payment_value) AS total_pago
FROM dbo.olist_order_payments_dataset
GROUP BY payment_type;
GO

SELECT * FROM vw_pedidos_por_status;
SELECT * FROM vw_vendas_por_estado;
SELECT * FROM vw_top_produtos_vendidos;
SELECT * FROM vw_tempo_medio_entrega;
SELECT * FROM vw_valor_por_tipo_pagamento;

