DROP 
  VIEW IF EXISTS forestation;
CREATE VIEW forestation AS 
SELECT 
  f.country_code code, 
  f.country_name country, 
  f.year "year", 
  f.forest_area_sqkm forest_sqkm, 
  l.total_area_sq_mi area_sqmi, 
  r.region region, 
  r.income_group ig, 
  100.0 *(
    f.forest_area_sqkm / (l.total_area_sq_mi * 2.59)
  ) AS percentage 
FROM 
  forest_area f, 
  land_area l, 
  regions r 
WHERE 
  (
    f.country_code = l.country_code 
    AND f.year = l.year 
    AND r.country_code = l.country_code
  );

SELECT 
  * 
FROM 
  forestation;
  
  SELECT 
  * 
FROM 
  forest_area 
WHERE 
  country_name = 'World';
  
SELECT 
  * 
FROM 
  forest_area 
WHERE 
  country_name = 'World' 
  AND (
    year = 2016 
    OR year = 1990
  );
  
  
SELECT 
  crt.forest_area_sqkm - prv.forest_area_sqkm AS difference 
FROM 
  forest_area AS crt 
  JOIN forest_area AS prv ON (
    crt.year = '2016' 
    AND prv.year = '1990' 
    AND crt.country_name = 'World' 
    AND prv.country_name = 'World'
  );
  
  
SELECT 
  100.0 *(
    crt.forest_area_sqkm - prv.forest_area_sqkm
  ) / prv.forest_area_sqkm AS percentage 
FROM 
  forest_area AS crt 
  JOIN forest_area AS prv ON (
    crt.year = '2016' 
    AND prv.year = '1990' 
    AND crt.country_name = 'World' 
    AND prv.country_name = 'World'
  );
  
SELECT 
  country, 
  (area_sqmi * 2.59) AS total_area_sqkm 
FROM 
  forestation 
WHERE 
  year = 2016 
ORDER BY 
  total_area_sqkm DESC;
  
  
SELECT 
  ROUND(percentage :: NUMERIC, 2) world 
FROM 
  forestation 
WHERE 
  year = 2016 
  AND country = 'World';

SELECT 
  ROUND(
    CAST(
      (
        region_forest_1990 / region_area_1990
      ) * 100 AS NUMERIC
    ), 
    2
  ) AS forest_percent_1990, 
  ROUND(
    CAST(
      (
        region_forest_2016 / region_area_2016
      ) * 100 AS NUMERIC
    ), 
    2
  ) AS forest_percent_2016, 
  region 
FROM 
  (
    SELECT 
      SUM(a.forest_sqkm) region_forest_1990, 
      SUM(a.area_sqmi * 2.59) region_area_1990, 
      a.region, 
      SUM(b.forest_sqkm) region_forest_2016, 
      SUM(a.area_sqmi * 2.59) region_area_2016 
    FROM 
      forestation a, 
      forestation b 
    WHERE 
      a.year = '1990' 
      AND a.country != 'World' 
      AND b.year = '2016' 
      AND b.country != 'World' 
      AND a.region = b.region 
    GROUP BY 
      a.region
  ) region_percent 
ORDER BY 
  forest_percent_1990 DESC;
  
SELECT 
  ROUND(percentage :: NUMERIC, 2) world 
FROM 
  forestation 
WHERE 
  year = 1990 
  AND country = 'World';
  
  
SELECT 
  crt.country_name, 
  crt.forest_area_sqkm - prv.forest_area_sqkm AS difference 
FROM 
  forest_area AS crt 
  JOIN forest_area AS prv ON (
    crt.year = '2016' 
    AND prv.year = '1990'
  ) 
  AND crt.country_name = prv.country_name 
ORDER BY 
  difference DESC;
  
  
SELECT 
  crt.country_name, 
  100.0 *(
    crt.forest_area_sqkm - prv.forest_area_sqkm
  ) / prv.forest_area_sqkm AS percentage 
FROM 
  forest_area AS crt 
  JOIN forest_area AS prv ON (
    crt.year = '2016' 
    AND prv.year = '1990'
  ) 
  AND crt.country_name = prv.country_name 
ORDER BY 
  percentage DESC;

SELECT 
  crt.country_name, 
  crt.forest_area_sqkm - prv.forest_area_sqkm AS difference 
FROM 
  forest_area AS crt 
  JOIN forest_area AS prv ON (
    crt.year = '2016' 
    AND prv.year = '1990'
  ) 
  AND crt.country_name = prv.country_name 
ORDER BY 
  difference;
  
  
SELECT 
  country_name, 
  region 
FROM 
  regions 
WHERE 
  country_name IN (
    'Brazil', 'Indonesia', 'Myanmar', 
    'Nigeria', 'Tanzania'
  ) 
  
  
SELECT 
  crt.country_name, 
  100.0 *(
    crt.forest_area_sqkm - prv.forest_area_sqkm
  ) / prv.forest_area_sqkm AS percentage 
FROM 
  forest_area AS crt 
  JOIN forest_area AS prv ON (
    crt.year = '2016' 
    AND prv.year = '1990'
  ) 
  AND crt.country_name = prv.country_name 
ORDER BY 
  percentage;

SELECT 
  country_name, 
  region 
FROM 
  regions 
WHERE 
  country_name IN (
    'Togo', 'Nigeria', 'Uganda', 'Mauritania', 
    'Honduras'
  ); 
  
  
SELECT 
  DISTINCT(quartiles), 
  COUNT(country) OVER (PARTITION BY quartiles) 
FROM 
  (
    SELECT 
      country, 
      CASE WHEN percentage <= 25 THEN '0-25%' WHEN percentage > 50 
      AND percentage <= 75 THEN '50-75%' WHEN percentage > 25 
      AND percentage <= 50 THEN '25-50%' ELSE '75-100%' END AS quartiles 
    FROM 
      forestation 
    WHERE 
      percentage IS NOT NULL 
      AND year = 2016 
      AND country != 'World'
  ) quart;
SELECT 
  country, 
  region, 
  ROUND(percentage :: NUMERIC, 2) 
FROM 
  forestation 
WHERE 
  percentage > 75 
  AND year = 2016 
ORDER BY 
  percentage DESC;