# Write your MySQL query statement below
with ordering AS (
    SELECT
        name AS Employee,
        salary AS Salary,
        departmentId,
        DENSE_RANK() OVER (PARTITION BY departmentId ORDER BY salary DESC) AS salary_order
    FROM Employee AS e
)
SELECT d.name AS Department, o.Employee, o.Salary
FROM ordering AS o
LEFT JOIN Department AS d
    ON o.departmentId = d.id
WHERE salary_order < 4