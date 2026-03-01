{{ config(materialized='ephemeral') }}

SELECT *
FROM {{ source('y2000s', 'tbl_asean_cities') }} 