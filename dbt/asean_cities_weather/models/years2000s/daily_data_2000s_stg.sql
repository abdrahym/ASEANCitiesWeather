{{ config(materialized='ephemeral') }}

SELECT *
FROM {{ source('y2000s', 'tbl_daily_data') }} 
WHERE YEAR(datetime) != 2010