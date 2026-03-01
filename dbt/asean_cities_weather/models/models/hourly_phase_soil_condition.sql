/*
soil_condition (Kondisi Tanah)
Data ini biasanya berubah lebih lambat dibanding suhu udara, sehingga sering dipisahkan.
- datetime, city_id
- soil_temperature_0_to_7cm s/d 100_to_255cm
- soil_moisture_0_to_7cm s/d 100_to_255cm
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

    ROUND(AVG(soil_temperature_0_to_7cm),2)                         AS avg_soil_temp_0_7cm,
    ROUND(AVG(soil_temperature_7_to_28cm),2)                        AS avg_soil_temp_7_28cm,
    ROUND(AVG(soil_temperature_28_to_100cm),2)                      AS avg_soil_temp_28_100cm,
    ROUND(AVG(soil_temperature_100_to_255cm),2)                     AS avg_soil_temp_100_255cm,
    ROUND(AVG(soil_moisture_0_to_7cm),3)                            AS avg_soil_moist_0_7cm,
    ROUND(AVG(soil_moisture_7_to_28cm),3)                           AS avg_soil_moist_7_28cm,
    ROUND(AVG(soil_moisture_28_to_100cm),3)                         AS avg_soil_moist_28_100cm,
    ROUND(AVG(soil_moisture_100_to_255cm),3)                        AS avg_soil_moist_100_255cm

FROM {{ ref('hourly_data') }} 

GROUP BY 1,2,3,4,5
ORDER BY 1,2,3
