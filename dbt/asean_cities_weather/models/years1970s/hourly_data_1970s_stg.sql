{{ config(materialized='ephemeral') }}

SELECT *
FROM {{ source('y1970s', 'tbl_hourly_data') }} 



