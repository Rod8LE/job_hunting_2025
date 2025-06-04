-- Write your PostgreSQL query statement below
WITH cat1 AS (
    SELECT
        p.user_id,
        i.category,
        DENSE_RANK() OVER (ORDER BY i.category ASC) AS cat_order
    FROM ProductPurchases AS p
    LEFT JOIN ProductInfo AS i
        ON p.product_id = i.product_id
    GROUP BY 1, 2
)
SELECT l.category AS category1,
    r.category AS category2,
    COUNT(l.user_id) AS customer_count
FROM cat1 AS l
INNER JOIN cat1 AS r
    ON l.user_id = r.user_id
    AND l.category != r.category
    AND l.cat_order < r.cat_order
GROUP BY 1, 2
HAVING COUNT(l.user_id) > 2
ORDER BY customer_count DESC, category1 ASC, category2 ASC
