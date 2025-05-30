# Write your MySQL query statement below
WITH unbanned AS (
    SELECT users_id
    FROM Users
    WHERE banned = 'No'
    AND role IN ('client', 'driver')
)
SELECT
    t.request_at AS 'Day',
    ROUND(COUNT(CASE WHEN t.status != 'completed' THEN False ELSE NULL END) /
          COUNT(t.status),
          2) AS 'Cancellation Rate'
FROM Trips AS t
INNER JOIN unbanned uc
    ON t.client_id = uc.users_id
INNER JOIN unbanned ud
    ON t.driver_id = ud.users_id
WHERE t.request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY 1
ORDER BY 1 ASC