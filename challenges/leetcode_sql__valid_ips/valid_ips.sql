-- Write your PostgreSQL query statement below
WITH base AS (
    SELECT  ip, log_id, UNNEST(STRING_TO_ARRAY(ip, '.')) as splits
    FROM logs
),
computations AS (
    SELECT ip,
        COUNT(splits) != 4 AS octet,
        BOOL_OR(LEFT(splits, 1) = '0') AS zeros,
        BOOL_OR((splits :: INT) NOT BETWEEN 0 AND 255) AS overbound
    FROM base
    GROUP BY ip, log_id
)
SELECT ip, COUNT(ip) AS invalid_count
FROM computations
WHERE octet OR zeros OR overbound
GROUP BY ip
ORDER BY invalid_count DESC, ip DESC