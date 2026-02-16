{{ config(materialized='view') }}

SELECT *
FROM {{ ref('hourly_data_cte') }},
ORDER BY
    city_name,
    datetime