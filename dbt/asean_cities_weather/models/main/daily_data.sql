{{ config(materialized='view') }}

SELECT *
FROM {{ ref('daily_data_cte') }},
ORDER BY
    city_name,
    datetime