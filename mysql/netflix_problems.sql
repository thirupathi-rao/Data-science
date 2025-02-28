create database netflix_data;
use netflix_data;
select * from netflix;
-- count the total number of records in the netflix_data table
select count(*) from netflix; -- 97
-- count the number of TV shows and movies separately
select count(*),type from netflix  group by type;
-- the top director with the most content on Netflix
select director,count(*) from netflix group by director order by count(*) desc;
-- the most recently added title
select title,date_added from netflix order by str_to_date(date_added , "%M %d,%y") desc;
select title,date_added from netflix order by date_added desc;
-- the Minimum release year for TV shows and movies
select min(release_year),type from netflix group by type;
-- the top country with the most content on Netflix
select count(*),country from netflix group by country order by count(*) desc;
-- the longest duration movie

select * from netflix where duration =concat((select SUBSTRING_INDEX(duration,' ',1) AS firstname
  from netflix  order by convert(firstname,UNSIGNED INTEGER) desc limit 1),' ','min');
  
