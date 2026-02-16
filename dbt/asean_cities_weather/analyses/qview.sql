SELECT DISTINCT
    rain
FROM {{ ref('hourly_data') }}