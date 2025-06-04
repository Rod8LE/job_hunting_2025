WITH RECURSIVE base_level(employee_id, employee_name, manager_id, salary, managers, level) AS (
    SELECT
        e.employee_id,
        e.employee_name,
        e.manager_id,
        e.salary,
        ARRAY [e.employee_id],
        1
    FROM Employees AS e
    WHERE e.manager_id IS NULL
    UNION ALL
    SELECT
        e.employee_id,
        e.employee_name,
        e.manager_id,
        e.salary,
        ARRAY_APPEND(b.managers, e.employee_id),
        b.level + 1
    FROM base_level AS b,
        Employees AS e
    WHERE e.manager_id = b.employee_id
)
,
unnested_team AS ( -- rows are by employee_id, unnest explodes all higher ups
    SELECT unnest(managers) AS manager_id__unnested,
        SUM(salary) AS budget,
        COUNT(employee_id) - 1 AS team_size -- "team" does not include self
    FROM base_level
    GROUP BY 1
)
SELECT b.employee_id,
    b.employee_name,
    b.level,
    u.team_size,
    u.budget
FROM base_level AS b
LEFT JOIN unnested_team AS u
    ON b.employee_id = u.manager_id__unnested
ORDER BY b.level ASC, u.budget DESC, b.employee_name ASC
