/*
fact_solar_radiation (Radiasi Matahari)
- datetime, city_id
- shortwave_radiation, direct_radiation, diffuse_radiation
- direct_normal_irradiance, global_tilted_irradiance, terrestrial_radiation
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
        ELSE                                                         '5. Night (20-24)'
    END                                                             AS phase,
    ((date_part('year', datetime) / 10)::INT * 10)::VARCHAR || 's'  AS decade,

    ROUND(AVG(shortwave_radiation),2)                               AS avg_shortwave_radiation,
    ROUND(AVG(direct_radiation),2)                                  AS avg_direct_radiation,
    ROUND(AVG(diffuse_radiation),2)                                 AS avg_diffuse_rad,
    ROUND(AVG(direct_normal_irradiance),2)                          AS avg_direct_normal_irradiance,
    ROUND(AVG(terrestrial_radiation),2)                             AS avg_terrestrial_radiation

FROM {{ ref('hourly_data') }}                        

GROUP BY 1,2,3,4,5
ORDER BY 1,2,3