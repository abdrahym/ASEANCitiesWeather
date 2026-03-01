SELECT *
FROM {{ ref('daily_data_cte') }}
WHERE datetime = '2010-01-01'
          AND city_name = 'Samraong'
ORDER BY 1,2




SELECT
    city_name,
    datetime,
    COUNT(*) AS total_duplikat
FROM {{ ref('daily_data_cte') }}
GROUP BY 1,2
HAVING COUNT(*) > 1
ORDER BY total_duplikat DESC, datetime;


SELECT DISTINCT 
        YEAR(datetime) AS year,
        COUNT(*) AS total_duplikat
FROM {{ ref('daily_data_2000s_stg') }}
WHERE year = 2010
ORDER BY 1


SELECT 
    YEAR(datetime) AS year,
    COUNT(*) AS total_baris
FROM {{ ref('daily_data_2000s_stg') }}
WHERE YEAR(datetime) = 2010  -- Gunakan fungsi asli di sini
GROUP BY 1                   -- Grouping berdasarkan kolom pertama (year)
ORDER BY 1


SELECT 
    YEAR(datetime) AS year,
    COUNT(*) AS total_baris
FROM {{ ref('hourly_data_2000s_stg') }}
WHERE YEAR(datetime) = 2010  
GROUP BY 1                   
ORDER BY 1



SELECT 
    YEAR(datetime) AS year,
    COUNT(*) AS total_baris
FROM {{ ref('hourly_data_2010s_stg') }}
WHERE YEAR(datetime) = 2010  -- Gunakan fungsi asli di sini
GROUP BY 1                   -- Grouping berdasarkan kolom pertama (year)
ORDER BY 1


daily_data