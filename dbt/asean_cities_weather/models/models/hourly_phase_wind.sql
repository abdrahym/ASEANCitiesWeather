/*
wind (Data Angin)
- datetime, city_id
- wind_speed_10m, wind_speed_100m
- wind_direction_10m, wind_direction_100m
- wind_gusts_10m
*/

SELECT 
    city_name                                                                AS city,
    DATE(datetime)                                                           AS date,
    CAST(EXTRACT(YEAR FROM datetime) AS VARCHAR)                             AS year,
    CASE 
        WHEN HOUR(datetime) BETWEEN 0 AND 5 THEN                             '1. Early Morning (0-5)'
        WHEN HOUR(datetime) BETWEEN 6 AND 10 THEN                            '2. Morning (6-10)'
        WHEN HOUR(datetime) BETWEEN 11 AND 15 THEN                           '3. Afternoon (11-15)'
        WHEN HOUR(datetime) BETWEEN 16 AND 19 THEN                           '4. Evening (16-19)'
        ELSE                                                                 '5. Night (20-24)'
    END                                                                      AS phase,
    ((date_part('year', datetime) / 10)::INT * 10)::VARCHAR || 's'           AS decade,
    
    ROUND(AVG(wind_speed_10m),2)                                             AS avg_wind_speed_10m, 
    ROUND(((degrees(
        atan2(
            avg(sin(radians(wind_direction_10m))), -- 1. Rata-rata Sinus (Komponen U)
            avg(cos(radians(wind_direction_10m)))  -- 2. Rata-rata Kosinus (Komponen V)
        )
    ) + 360) % 360),1)                                                         AS mean_wind_direction_10m,
    ROUND(AVG(wind_speed_100m),2)                                              AS avg_wind_speed_100m,
    ROUND(((degrees(
        atan2(
            avg(sin(radians(wind_direction_100m))), -- 1. Rata-rata Sinus (Komponen U)
            avg(cos(radians(wind_direction_100m)))  -- 2. Rata-rata Kosinus (Komponen V)
        )
    ) + 360) % 360),1)                                                          AS mean_wind_direction_100m,
    MAX(wind_gusts_10m)                                                         AS max_wind_gusts_10m    

FROM {{ ref('hourly_data') }}                                                   AS hd
LEFT JOIN  {{ ref('asean_cities') }}                                            AS ac
ON city_name = ac.city

GROUP BY 1,2,3,4,5
ORDER BY 1,2,3
