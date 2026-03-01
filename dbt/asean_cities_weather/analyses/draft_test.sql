SELECT *,
    '1970s' AS years
FROM {{ source('y1970s', 'tbl_asean_cities') }} 