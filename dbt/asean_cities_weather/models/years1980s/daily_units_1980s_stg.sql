{{ config(materialized='ephemeral') }}

SELECT *
FROM {{ source('y1980s', 'tbl_daily_units') }} 