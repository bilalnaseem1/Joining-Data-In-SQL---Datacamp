/*
Fill in the code based on the instructions in the code comments to complete the inner join.
Note how many records are in the result of the join in the query result.
*/

-- Select the city name (with alias), the country code,
-- the country name (with alias), the region,
-- and the city proper population
SELECT c1.name AS city, code, c2.name AS country,
       region, city_proper_pop
-- From left table (with alias)
FROM cities AS c1
  -- Join to right table (with alias)
  INNER JOIN countries AS c2
    -- Match on country code
    ON c2.code = c1.country_code
-- Order by descending country code
ORDER BY code DESC;

/*
Change the code to perform a LEFT JOIN instead of an INNER JOIN.
After executing this query, note how many records the query result contains.
*/

SELECT c1.name AS city, code, c2.name AS country,
       region, city_proper_pop
-- From left table (with alias)
FROM cities AS c1
  -- Join to right table (with alias)
  LEFT JOIN countries AS c2
    -- Match on country code
    ON c2.code = c1.country_code
-- Order by descending country code
ORDER BY code DESC;

/*
Perform an inner join and alias the name of the country field as country and the name of the language field as language.
Sort based on descending country name.
*/
select c.name as country, local_name, l.name as language, percent from countries as c
inner join languages as l
on l.code = c.code
order by country desc;

/*
Perform a left join instead of an inner join. Observe the result, and also note the change in the number of records in the result.
Carefully review which records appear in the left join result, but not in the inner join result.
*/
select c.name as country, local_name, l.name as language, percent from countries as c
left join languages as l
on l.code = c.code
order by country desc;

/*
Begin with a left join with the countries table on the left and the economies table on the right.
Focus only on records with 2010 as the year.
*/
select name, region, e.gdp_percapita from countries as c
left join economies as e
on e.code = c.code
where year = 2010;

/*
Modify your code to calculate the average GDP per capita AS avg_gdp for each region in 2010.
Select the region and avg_gdp fields.
*/
select region, AVG(gdp_percapita) as avg_gdp from countries as c
left join economies as e
on e.code = c.code
where year = 2010
group by region;

/*
Arrange this data on average GDP per capita for each region in 2010 from highest to lowest average GDP per capita.
*/
select region, AVG(gdp_percapita) as avg_gdp from countries as c
left join economies as e
on e.code = c.code
where year = 2010
group by region
order by avg_gdp desc;

-- convert this code to use RIGHT JOINs instead of LEFT JOINs
/*
SELECT cities.name AS city, urbanarea_pop, countries.name AS country,
       indep_year, languages.name AS language, percent
FROM cities
  LEFT JOIN countries
    ON cities.country_code = countries.code
  LEFT JOIN languages
    ON countries.code = languages.code
ORDER BY city, language;
*/

SELECT cities.name AS city, urbanarea_pop, countries.name AS country,
       indep_year, languages.name AS language, percent
FROM languages
  RIGHT JOIN countries
    ON countries.code = languages.code
  RIGHT JOIN cities
    ON cities.country_code = countries.code
ORDER BY city, language;

------FULL JOIN------

/*
Choose records in which region corresponds to North America or is NULL.
*/

SELECT name AS country, code, region, basic_unit
-- From countries
FROM countries
  -- Join to currencies
  FULL JOIN currencies
    -- Match on code
    USING (code)
-- Where region is North America or null
WHERE region = 'North America' OR region IS NULL
-- Order by region
ORDER BY region;

/*
Repeat the same query as before, using a LEFT JOIN instead of a FULL JOIN. Note what has changed compared to the FULL JOIN result!
*/
SELECT name AS country, code, region, basic_unit
-- From countries
FROM countries
  -- Join to currencies
  left JOIN currencies
    -- Match on code
    USING (code)
-- Where region is North America or null
WHERE region = 'North America' OR region IS NULL
-- Order by region
ORDER BY region;

/*
Repeat the same query again but use an INNER JOIN instead of a FULL JOIN. Note what has changed compared to the FULL JOIN and LEFT JOIN results!
*/

SELECT name AS country, code, region, basic_unit
-- From countries
FROM countries
  -- Join to currencies
  INNER JOIN currencies
    -- Match on code
    USING (code)
-- Where region is North America or null
WHERE region = 'North America' OR region IS NULL
-- Order by region
ORDER BY region;

/*
Choose records in which countries.name starts with the capital letter 'V' or is NULL.
Arrange by countries.name in ascending order to more clearly see the results.
*/

SELECT countries.name, code, languages.name AS language
-- From languages
FROM languages
  -- Join to countries
  FULL JOIN countries
    -- Match on code
    USING (code)
-- Where countries.name starts with V or is null
WHERE countries.name LIKE 'V%' OR countries.name IS NULL
-- Order by ascending countries.name
ORDER BY countries.name;

/*
Repeat the same query as before, using a LEFT JOIN instead of a FULL JOIN. Note what has changed compared to the FULL JOIN result!
*/

SELECT countries.name, code, languages.name AS language
-- From languages
FROM languages
  -- Join to countries
  left JOIN countries
    -- Match on code
    USING (code)
-- Where countries.name starts with V or is null
WHERE countries.name LIKE 'V%' OR countries.name IS NULL
-- Order by ascending countries.name
ORDER BY countries.name;

/*
Repeat once more, but use an INNER JOIN instead of a LEFT JOIN. Note what has changed compared to the FULL JOIN and LEFT JOIN results.
*/

SELECT countries.name, code, languages.name AS language
-- From languages
FROM languages
  -- Join to countries
  inner JOIN countries
    -- Match on code
    USING (code)
-- Where countries.name starts with V or is null
WHERE countries.name LIKE 'V%' OR countries.name IS NULL
-- Order by ascending countries.name
ORDER BY countries.name;

/*
Complete a full join with countries on the left and languages on the right.
Next, full join this result with currencies on the right.
Use LIKE to choose the Melanesia and Micronesia regions (Hint: 'M%esia').
Select the fields corresponding to the country name AS country, region, language name AS language, and basic and fractional units of currency.
*/

-- Select fields (with aliases)
SELECT c1.name AS country, region, l.name AS language,
       basic_unit, frac_unit
-- From countries (alias as c1)
FROM countries AS c1
  -- Join with languages (alias as l)
  FULL JOIN languages AS l
    -- Match on code
    USING (code)
  -- Join with currencies (alias as c2)
  FULL JOIN currencies AS c2
    -- Match on code
    USING (code)
-- Where region like Melanesia and Micronesia
WHERE region LIKE 'M%esia';

------CROSS jOIN------

/*
Create a CROSS JOIN with cities AS c on the left and languages AS l on the right.
Make use of LIKE and Hyder% to choose Hyderabad in both countries.
Select only the city name AS city and language name AS language.
*/

select c.name as city, l.name as language from cities as c
cross join languages as l
where c.name like 'Hyder%';

/*
Use an INNER JOIN instead of a CROSS JOIN.
Think about what the difference will be in the results for this INNER JOIN result and the one for the CROSS JOIN.
*/

select c.name as city, l.name as language from cities as c
inner join languages as l
on l.code = c.country_code
where c.name like 'Hyder%';


------OUTER CHALLENGE------
/*
Select country name AS country, region, and life expectancy AS life_exp.
Make sure to use LEFT JOIN, WHERE, ORDER BY, and LIMIT.
*/
-- Select fields
select c.name as country, c.region, p.life_expectancy as life_exp
-- From countries (alias as c)
from countries as c
  -- Join to populations (alias as p)
  left join populations as p
    -- Match on country code
    on c.code = p.country_code
-- Focus on 2010
where year =2010
-- Order by life_exp
Order by life_exp
-- Limit to 5 records
limit 5;
