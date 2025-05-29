# Write your MySQL query statement below
WITH stacks AS (
    SELECT
        id,
        visit_date,
        id - ROW_NUMBER() OVER (ORDER BY id ASC) as gap,
        people
    FROM Stadium
    WHERE people >= 100
),
consecutive_stacks AS (
    SELECT
        id,
        visit_date,
        people,
        COUNT(gap) OVER (PARTITION BY gap) AS consecutives
    FROM stacks
)
SELECT id, visit_date, people
FROM consecutive_stacks
WHERE consecutives >= 3
ORDER BY visit_date ASC