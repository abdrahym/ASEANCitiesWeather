{{ config(materialized='ephemeral') }}

SELECT *
FROM {{ source('y2010s', 'tbl_asean_cities') }} 