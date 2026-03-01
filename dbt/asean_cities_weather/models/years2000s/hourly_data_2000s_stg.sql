{{ config(materialized='ephemeral') }}

SELECT *
FROM {{ source('y2000s', 'tbl_hourly_data') }} 
WHERE YEAR(datetime) != 2010