{{ config(materialized='view') }}

SELECT DISTINCT *
FROM (
    SELECT * FROM {{ source('y1970s', 'tbl_daily_units') }} 
    UNION ALL
    SELECT * FROM {{ source('y1980s', 'tbl_daily_units') }} 
    UNION ALL
    SELECT * FROM {{ source('y1990s', 'tbl_daily_units') }} 
    UNION ALL
    SELECT * FROM {{ source('y2000s', 'tbl_daily_units') }} 
    UNION ALL
    SELECT * FROM {{ source('y2010s', 'tbl_daily_units') }}
)