{{ config(materialized='ephemeral') }}

SELECT *
FROM {{ source('y1990s', 'tbl_hourly_data') }} 