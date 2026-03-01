{{ config(materialized='ephemeral') }}

SELECT * FROM {{ ref('asean_cities_1970s_stg') }}
UNION ALL
SELECT * FROM {{ ref('asean_cities_1980s_stg') }}
UNION ALL
SELECT * FROM {{ ref('asean_cities_1990s_stg') }}
UNION ALL
SELECT * FROM {{ ref('asean_cities_2000s_stg') }}
UNION ALL
SELECT * FROM {{ ref('asean_cities_2010s_stg') }}