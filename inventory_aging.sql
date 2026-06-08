-- Inventory Aging Analysis


WITH left_inv AS (
    SELECT
        onhandquantity        AS left_inv_count,
        onhandquantitydelta,
        event_datetime        AS day1time
    FROM inventoryage
    LIMIT 1
),

days AS (
    SELECT
        day1time,
        day1time - INTERVAL '90 day'  AS "90_days_old_date",
        day1time - INTERVAL '180 day' AS "180_days_old_date",
        day1time - INTERVAL '270 day' AS "270_days_old_date",
        day1time - INTERVAL '365 day' AS "365_days_old_date"
    FROM left_inv
),

"90_days_inv_count" AS (
    SELECT SUM(onhandquantitydelta) AS "90_inv_count"
    FROM inventoryage, days
    WHERE event_type = 'InBound'
      AND event_datetime > "90_days_old_date"
),

"91_180_days_inv_count" AS (
    SELECT SUM(onhandquantitydelta) AS "90_180_inv_count"
    FROM inventoryage, days
    WHERE event_type = 'InBound'
      AND event_datetime < "90_days_old_date"
      AND event_datetime > "180_days_old_date"
),

"181_270_days_inv_count" AS (
    SELECT SUM(onhandquantitydelta) AS "181_270_inv_count"
    FROM inventoryage, days
    WHERE event_type = 'InBound'
      AND event_datetime < "180_days_old_date"
      AND event_datetime > "270_days_old_date"
),

"271_365_days_inv_count" AS (
    SELECT SUM(onhandquantitydelta) AS "271_365_inv_count"
    FROM inventoryage, days
    WHERE event_type = 'InBound'
      AND event_datetime < "270_days_old_date"
      AND event_datetime > "365_days_old_date"
)

SELECT

    -- 0-90 DAYS OLD INVENTORY COUNT
    CASE
        WHEN left_inv_count > "90_inv_count"
            THEN "90_inv_count"
        ELSE left_inv_count
    END AS "0-90 days",

    -- 91-180 DAYS OLD INVENTORY COUNT
    CASE
        WHEN (left_inv_count - "90_inv_count") > "90_180_inv_count"
            THEN "90_180_inv_count"
        WHEN (left_inv_count - "90_inv_count") > 0
            THEN (left_inv_count - "90_inv_count")
        ELSE 0
    END AS "91-180 days",

    -- 181-270 DAYS OLD INVENTORY COUNT
    CASE
        WHEN (left_inv_count - "90_inv_count" - "90_180_inv_count") > "181_270_inv_count"
            THEN "181_270_inv_count"
        WHEN (left_inv_count - "90_inv_count" - "90_180_inv_count") > 0
            THEN (left_inv_count - "90_inv_count" - "90_180_inv_count")
        ELSE 0
    END AS "181-270 days",

    -- 271-365 DAYS OLD INVENTORY COUNT
    CASE
        WHEN (left_inv_count - "90_inv_count" - "90_180_inv_count" - "181_270_inv_count") > "271_365_inv_count"
            THEN "271_365_inv_count"
        WHEN (left_inv_count - "90_inv_count" - "90_180_inv_count" - "181_270_inv_count") > 0
            THEN (left_inv_count - "90_inv_count" - "90_180_inv_count" - "181_270_inv_count")
        ELSE 0
    END AS "271-365 days"

FROM
    left_inv,
    "90_days_inv_count",
    "91_180_days_inv_count",
    "181_270_days_inv_count",
    "271_365_days_inv_count",
    days;
