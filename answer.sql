-- TYPE YOUR SQL QUERY BELOW

-- PART 1: Create a SQL query that maps out the daily average users before and after the feature change

WITH user_activity_before AS (
  SELECT
    DATE(timestamp) AS date,
    COUNT(DISTINCT user_id) AS users_before
  FROM
    user_activity
  WHERE
    timestamp < feature_change_date
  GROUP BY
    DATE(timestamp)
),
user_activity_after AS (
  SELECT
    DATE(timestamp) AS date,
    COUNT(DISTINCT user_id) AS users_after
  FROM
    user_activity
  WHERE
    timestamp >= feature_change_date
  GROUP BY
    DATE(timestamp)
)
SELECT
  COALESCE(ua_before.date, ua_after.date) AS date,
  COALESCE(users_before, 0) AS users_before,
  COALESCE(users_after, 0) AS users_after
FROM
  user_activity_before ua_before
FULL OUTER JOIN
  user_activity_after ua_after
ON
  ua_before.date = ua_after.date
ORDER BY
  date;




-- PART 2: Create a SQL query that indicates the number of status changes by card

SELECT
  card_id,
  status,
  COUNT(*) AS status_changes
FROM
  cards
GROUP BY
  card_id, status;





