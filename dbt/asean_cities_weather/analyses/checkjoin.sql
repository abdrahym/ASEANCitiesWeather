SELECT COUNT(*)
FROM {{ ref('hourly_phase_weather_advw') }}



SELECT COUNT(*)
FROM {{ ref('asean_cities') }} AS ac
INNER JOIN {{ ref('hourly_phase_weather_advw') }} AS hp
ON hp.city = ac.city



SELECT *
FROM {{ ref('asean_cities') }} 