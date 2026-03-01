{{ config(materialized='view') }}

SELECT DISTINCT
    country,
    city,
    latitude,
    longitude,
    population
FROM {{ ref('asean_cities_cte') }}
ORDER BY
    country,
    city