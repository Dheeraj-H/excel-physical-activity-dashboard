-- User Activity & Retention Analysis

-- 1. Classify users as Active or Inactive (last 30 days)
SELECT
    user_id,
    last_active_date,
    CASE
        WHEN last_active_date >= DATEADD(day, -30, GETDATE()) THEN 'Active'
        ELSE 'Inactive'
    END AS user_status
FROM user_activity;

-- 2. Active vs Inactive user count
SELECT
    user_status,
    COUNT(*) AS total_users
FROM (
    SELECT
        user_id,
        CASE
            WHEN last_active_date >= DATEADD(day, -30, GETDATE()) THEN 'Active'
            ELSE 'Inactive'
        END AS user_status
    FROM user_activity
) t
GROUP BY user_status;

-- 3. Retention percentage
SELECT
    CAST(
        100.0 * SUM(CASE WHEN last_active_date >= DATEADD(day, -30, GETDATE()) THEN 1 ELSE 0 END)
        / COUNT(*) AS DECIMAL(5,2)
    ) AS retention_percentage
FROM user_activity;
