{{ config(materialized='ephemeral') }}

SELECT *
FROM {{ source('y1990s', 'tbl_asean_cities') }} 