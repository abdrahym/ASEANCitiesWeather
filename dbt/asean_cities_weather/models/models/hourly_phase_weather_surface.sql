/*
weather surface (Kondisi Atmosfer Dasar)
Tabel ini berisi data yang paling sering diakses.

- datetime, city_id
- temperature_2m, apparent_temperature, dew_point_2m
- relative_humidity_2m, pressure_msl, surface_pressure
- weather_code
*/

SELECT 
    city_name                                                            AS city,
    DATE(datetime)                                                       AS date,
    CAST(EXTRACT(YEAR FROM datetime) AS VARCHAR)                         AS year,
    CASE 
        WHEN HOUR(datetime) BETWEEN 0 AND 5 THEN                         '1. Early Morning (0-5)'
        WHEN HOUR(datetime) BETWEEN 6 AND 10 THEN                        '2. Morning (6-10)'
        WHEN HOUR(datetime) BETWEEN 11 AND 15 THEN                       '3. Afternoon (11-15)'
        WHEN HOUR(datetime) BETWEEN 16 AND 19 THEN                       '4. Evening (16-19)'
        ELSE                                                             '5. Night (20-24)'
    END                                                                  AS phase,
    ((date_part('year', datetime) / 10)::INT * 10)::VARCHAR || 's'       AS decade,

    MIN(temperature_2m)                                                  AS min_temp_2m,
    ROUND(AVG(temperature_2m),2)                                         AS avg_temp_2m,
    MAX(temperature_2m)                                                  AS max_temp_2m,
    ROUND(MAX(temperature_2m) - MIN(temperature_2m),2)                   AS range_temp_2m,

    MIN(apparent_temperature)                                            AS min_apparent_tempr,
    ROUND(AVG(apparent_temperature),2)                                   AS avg_apparent_tempr,
    MAX(apparent_temperature)                                            AS max_apparent_tempr,
    ROUND(MAX(apparent_temperature) - MIN(apparent_temperature),2)       AS range_apparent_tempr,

    MIN(dew_point_2m)                                                    AS min_dew_point_2m,
    ROUND(AVG(dew_point_2m),2)                                           AS avg_dew_point_2m,
    MAX(dew_point_2m)                                                    AS max_dew_point_2m,
    ROUND(MAX(dew_point_2m) - MIN(dew_point_2m),2)                       AS range_dew_point_2m,

    MIN(relative_humidity_2m)                                            AS min_relative_humidity_2m,
    ROUND(AVG(relative_humidity_2m),2)                                   AS avg_relative_humidity_2m,
    MAX(relative_humidity_2m)                                            AS max_relative_humidity_2m,
    ROUND(MAX(relative_humidity_2m) - MIN(relative_humidity_2m),2)       AS range_relative_humidity_2m,

    MIN(pressure_msl)                                                    AS min_pressure_msl,
    ROUND(AVG(pressure_msl),2)                                           AS avg_pressure_msl,
    MAX(pressure_msl)                                                    AS max_pressure_msl,
    ROUND(MAX(pressure_msl) - MIN(pressure_msl),2)                       AS range_pressure_msl,

    MIN(surface_pressure)                                                AS min_surface_pressure,
    ROUND(AVG(surface_pressure) ,2)                                      AS avg_surface_pressure,
    MAX(surface_pressure)                                                AS max_surface_pressure,
    ROUND(MAX(surface_pressure) - MIN(surface_pressure),2)               AS range_surface_pressure,
    
    mode() WITHIN GROUP (ORDER BY weather_code)                          AS weather_code_dominant

FROM {{ ref('hourly_data') }}

GROUP BY 1,2,3,4,5
ORDER BY 1,2,3