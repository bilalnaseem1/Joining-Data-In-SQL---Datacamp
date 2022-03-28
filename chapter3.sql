------CHAPTER 3: SET THEORY CLAUSES------

-- Combine the two new tables into one table containing all of the fields in economies2010.
-- Sort this resulting single table by country code and then by year, both in ascending order.

select * from economies2010
UNION
select * from economies2015
order by code, year

-- Determine all (non-duplicated) country codes in either the cities or the currencies table.
-- The result should be a table with only one field called country_code.
-- Sort by country_code in alphabetical order.

select distinct(country_code) from cities
UNION
select distinct(code) from currencies
order by country_code

-- Determine all combinations (include duplicates) of country code and year that exist in either the economies or the populations tables. Order by code then year.
-- The result of the query should only have two columns/fields. Think about how many records this query should result in.
-- You'll use code very similar to this in your next exercise after the video. Make note of this code after completing it.

select code, year from economies
union all
select country_code, year from populations
order by code, year

-- Use INTERSECT to determine the records in common for country code and year for the economies and populations tables.
-- Again, order by code and then by year, both in ascending order.

select code, year from economies
intersect
select country_code, year from populations
order by code, year

-- As you think about major world cities and their corresponding country, you may ask which countries also have a city with the same name as their country name?
-- Use INTERSECT to answer this question with countries and cities!

select name from countries
intersect
select name from cities

-- Get the names of cities in cities which are not noted as capital cities in countries as a single field result.
-- Order the resulting field in ascending order.
-- Can you spot the city/cities that are actually capital cities which this query misses?

select name from cities
except
select capital from countries
order by name

-- Determine the names of capital cities that are not listed in the cities table.
-- Order by capital in ascending order.
-- The cities table contains information about 236 of the world's most populous cities.
-- The result of your query may surprise you in terms of the number of capital cities that do not appear in this list!

select capital from countries
except
select name from cities
order by capital

------SEMI JOIN------

-- Begin by selecting all country codes in the Middle East as a single field result using SELECT, FROM, and WHERE.

select code from countries
where region = 'Middle East'

-- select only unique languages by name appearing in the languages table.
-- Order the resulting single field table by name in ascending order.

select distinct(name) from languages
order by name asc

-- **EXAMPLE OF SEMI JOIN**
-- Combine the previous two queries into one query by adding a WHERE IN statement
-- to the SELECT DISTINCT query to determine the unique languages spoken in the Middle East.
-- Order the result by name in ascending order.
select distinct(name) from languages
WHERE code IN(
select code from countries
where region = 'Middle East'
)
order by name


------ANTI JOIN------

-- Begin by determining the number of countries in countries that are listed in Oceania using SELECT, FROM, and WHERE.

select count(*) from countries
where continent = 'Oceania'

-- Complete an inner join with countries AS c1 on the left and currencies AS c2 on the right to get the different currencies used in the countries of Oceania.
-- Match ON the code field in the two tables.
-- Include the country code, country name, and basic_unit AS currency.
-- Observe the query result and make note of how many different countries are listed here.

select c1.code, c1.name, basic_unit AS currency from countries as c1
inner join currencies as c2
using(code)
where continent = 'Oceania'

--**Anti-Join Example**
-- Note that not all countries in Oceania were listed in the resulting inner join with currencies. 

-- Use an anti-join to determine which countries were not included!

-- Use NOT IN and (SELECT code FROM currencies) as a subquery to 
-- get the country code and country name for the Oceanian countries that are not included in the currencies table.

select code, name from countries
where continent = 'Oceania' and code not in (select code from currencies)


------SET THEORY CHALLENGE------

-- Identify the country codes that are included in either economies or currencies but not in populations.
-- Use that result to determine the names of cities in the countries that match the specification in the previous instruction.

select name from cities where country_code in (
select code from economies as e
union
select code from currencies as c
except
select country_code from populations
)

