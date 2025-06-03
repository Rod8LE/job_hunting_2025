-- Write your PostgreSQL query statement below
WITH base AS(
	SELECT
        content_id,
        content_text,
        unnest(string_to_array(REPLACE(content_text,'-',' - '), ' ')) AS splits
	FROM user_content
)
SELECT
    content_id,
    content_text AS original_text ,
    REPLACE(STRING_AGG(UPPER(SUBSTR(splits, 1, 1)) ||
                       LOWER(SUBSTR(splits, 2, LENGTH(splits) - 1)
                       ), ' '), ' - ', '-')  AS converted_text
FROM base
GROUP BY content_id, content_text
ORDER BY content_id
