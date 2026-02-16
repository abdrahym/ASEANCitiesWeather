{{ config(materialized='ephemeral') }}

SELECT * FROM {{ ref('daily_data_1970s_stg') }}
UNION ALL
SELECT * FROM {{ ref('daily_data_1980s_stg') }}
UNION ALL
SELECT * FROM {{ ref('daily_data_1990s_stg') }}
UNION ALL
SELECT * FROM {{ ref('daily_data_2000s_stg') }}
UNION ALL
SELECT * FROM {{ ref('daily_data_2010s_stg') }}