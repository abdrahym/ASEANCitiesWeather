/*
precipitation (Hujan & Awan)
- datetime, city_id
- precipitation, rain, snowfall, snow_depth
- cloud_cover, cloud_cover_low, cloud_cover_mid, cloud_cover_high
*/


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

    ROUND(SUM(precipitation),2)                                     AS total_precipitation,
    ROUND(SUM(rain),2)                                              AS total_rain, 
    ROUND(SUM(snowfall),2)                                          AS total_snowfall,
    ROUND(AVG(snow_depth),2)                                        AS avg_snow_depth,
    ROUND(AVG(cloud_cover),2)                                       AS avg_cloud_cover,
    ROUND(AVG(cloud_cover_low),2)                                   AS avg_cloud_cover_low,
    ROUND(AVG(cloud_cover_mid),2)                                   AS avg_cloud_cover_mid,
    ROUND(AVG(cloud_cover_high),2)                                  AS avg_cloud_cover_high

FROM {{ ref('hourly_data') }} 

GROUP BY 1,2,3,4,5
ORDER BY 1,2,3
