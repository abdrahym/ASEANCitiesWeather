-- avg_temperature, max_wind_speed, total_precipitation
SELECT 
    city_name                                                       AS city,
    DATE(datetime)                                                  AS date,
    CAST(EXTRACT(YEAR FROM datetime) AS VARCHAR)                    AS year,
    CASE                
        WHEN HOUR(datetime) BETWEEN 0 AND 5 THEN                    '1. Early Morning (0-5)'
        WHEN HOUR(datetime) BETWEEN 6 AND 10 THEN                   '2. Morning (6-10)'
        WHEN HOUR(datetime) BETWEEN 11 AND 15 THEN                  '3. Afternoon (11-15)'
        WHEN HOUR(datetime) BETWEEN 16 AND 19 THEN                  '4. Evening (16-19)'
        ELSE                                                        '5. Night (20-24)'
    END                                                             AS phase,
    ((date_part('year', datetime) / 10)::INT * 10)::VARCHAR || 's'  AS decade,

    ROUND(AVG(temperature_2m),2)                                    AS avg_temp,
    ROUND(AVG(apparent_temperature),2)                              AS avg_apparent_temp,
    MAX(wind_speed_10m)                                             AS max_wind_speed_10m, 
    MAX(wind_speed_100m)                                            AS max_wind_speed_100m,
    MAX(wind_gusts_10m)                                             AS max_wind_gusts_10m 

FROM {{ ref('hourly_data') }}
GROUP BY 1,2,3,4,5
ORDER BY 1,2,3



