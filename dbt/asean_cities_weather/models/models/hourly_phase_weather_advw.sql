SELECT
    city_name                                                                AS city,
    DATE(datetime)                                                           AS date,
    CAST(EXTRACT(YEAR FROM datetime) AS VARCHAR)                             AS year,
    CASE 
        WHEN HOUR(datetime) BETWEEN 0 AND 5 THEN                            '1. Early Morning (0-5)'
        WHEN HOUR(datetime) BETWEEN 6 AND 10 THEN                           '2. Morning (6-10)'
        WHEN HOUR(datetime) BETWEEN 11 AND 15 THEN                          '3. Afternoon (11-15)'
        WHEN HOUR(datetime) BETWEEN 16 AND 19 THEN                          '4. Evening (16-19)'
        ELSE                                                                '5. Night (20-24)'
    END                                                                     AS phase,
    ((date_part('year', datetime) / 10)::INT * 10)::VARCHAR || 's'          AS decade,

    -- 1. Metric temperature
    ROUND(AVG(temperature_2m),2)                                            AS avg_temp_2m,
    MIN(temperature_2m)                                                     AS min_temp_2m,
    MAX(temperature_2m)                                                     AS max_temp_2m,
    ROUND(MAX(temperature_2m) - MIN(temperature_2m),2)                      AS range_temp_2m,
    SUM(CASE WHEN temperature_2m >= 35 THEN 1 ELSE 0 END)                   AS hot_hours,
    ROUND(percentile_cont(0.95) WITHIN GROUP (ORDER BY temperature_2m), 2)  AS p95_temp,

    -- 2. Metric humidity 
    ROUND(AVG(relative_humidity_2m),2)                                      AS avg_relv_humidity_2m,
    MIN(relative_humidity_2m)                                               AS min_relv_humidity_2m,
    MAX(relative_humidity_2m)                                               AS max_relv_humidity_2m,
    SUM(CASE WHEN relative_humidity_2m > 90 THEN 1 ELSE 0 END)              AS high_humidity_hours,
    SUM(CASE WHEN temperature_2m >= 30 
            AND relative_humidity_2m >= 70 THEN 1 ELSE 0 END)               AS humid_heat_hours,
    SUM(CASE WHEN temperature_2m >= 32 
        AND relative_humidity_2m >= 80 THEN 1 ELSE 0 END)                   AS extreme_heat_stress_hours,

    -- 3. Metric precipitation
    MAX(precipitation)                                                      AS max_precip_mm,
    ROUND(SUM(precipitation),2)                                             AS total_precip_mm,
    SUM(CASE WHEN precipitation >= 1 THEN 1 ELSE 0 END)                     AS rain_hours,

    -- 4. Metric wind
    SUM(CASE WHEN wind_gusts_10m >= 30 THEN 1 ELSE 0 END)                   AS strong_wind_gust_10m,
    MAX(wind_gusts_10m)                                                     AS max_wind_gust_10m,
    ROUND(percentile_cont(0.95) WITHIN GROUP (ORDER BY wind_gusts_10m), 2)  AS p95_wind_gust_10m,

    -- 5. Metric weaher
    mode() WITHIN GROUP (ORDER BY weather_code)                             AS weather_code_dominant

FROM {{ ref('hourly_data') }}

GROUP BY 1,2,3,4,5
ORDER BY 1,2,3

