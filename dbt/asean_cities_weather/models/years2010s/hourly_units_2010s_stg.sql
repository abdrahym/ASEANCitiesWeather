{{ config(materialized='ephemeral') }}

SELECT *
FROM {{ source('y2010s', 'tbl_hourly_units') }} 