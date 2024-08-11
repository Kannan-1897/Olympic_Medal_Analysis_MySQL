CREATE DATABASE Olympics;
Use Olympics;

-- 1. List all records from the dataset:
   
   SELECT * FROM olympic_medals;
   

-- 2. List all records where the year is 2000:
   
   SELECT * FROM olympic_medals WHERE year = 2000;
   

-- 3. List all countries that won gold medals in 2016:
   
   SELECT country FROM olympic_medals WHERE year = 2016 AND gold > 0;
   

-- 4. Count the number of editions in the dataset:
   
   SELECT COUNT(DISTINCT edition_id) FROM olympic_medals;
   

-- 5. List all editions and the total number of medals awarded:
   
   SELECT edition_id, SUM(total) AS total_medals FROM olympic_medals GROUP BY edition_id order by total_medals desc;
   

-- 6. Total gold medals won by each country:
   
   SELECT country, SUM(gold) AS total_gold FROM olympic_medals GROUP BY country;
   

-- 7. Total medals won by the United States (USA) across all years:
   
   SELECT SUM(total) AS total_medals FROM olympic_medals WHERE country_noc = 'USA';
   

-- 8. Average number of silver medals won by all countries:
   
   SELECT AVG(silver) AS average_silver FROM olympic_medals;
   

-- 9. Total medals won in the 2008 edition:
   
   SELECT SUM(total) AS total_medals FROM olympic_medals WHERE year = 2008;
   

-- 10. List countries with more than 100 gold medals:
    
    SELECT country FROM olympic_medals GROUP BY country HAVING SUM(gold) > 100;
    

-- 11. List the top 5 countries by total medals won:
    
    SELECT country, SUM(total) AS total_medals FROM olympic_medals GROUP BY country ORDER BY total_medals DESC LIMIT 5;
    

-- 12. List the top 5 countries in the 2020 edition by gold medals:
    
    SELECT country, gold FROM olympic_medals WHERE year = 2020 ORDER BY gold DESC LIMIT 5;
    

-- 13. Countries with no medals in the 2012 edition:
    
    SELECT country FROM olympic_medals WHERE year = 2012 AND total = 0;
    

-- 14. All records where a country won more silver than gold medals:
    
    SELECT * FROM olympic_medals WHERE silver > gold;
    

-- 15. All records where a country won at least one medal in all three categories (gold, silver, bronze):
    
    SELECT * FROM olympic_medals WHERE gold > 0 AND silver > 0 AND bronze > 0;
    

-- 16. Total number of medals won by year:
    
    SELECT year, SUM(total) AS total_medals FROM olympic_medals GROUP BY year;
    

-- 17. Number of countries that participated in each edition:
    
    SELECT edition_id, COUNT(DISTINCT country) AS num_countries FROM olympic_medals GROUP BY edition_id;
    

-- 18. Country with the most medals in each edition:
    
    SELECT edition_id, country, MAX(total) AS max_medals FROM olympic_medals GROUP BY edition_id, country;
    

-- 19. The year with the highest total number of medals awarded:
    
    SELECT year FROM olympic_medals GROUP BY year ORDER BY SUM(total) DESC LIMIT 1;
    

-- 20. Top 3 countries by total medals in the 2016 edition:
    
    SELECT country, total FROM olympic_medals WHERE year = 2016 ORDER BY total DESC LIMIT 3;
    

-- 21. Countries that won the highest number of gold medals in a single edition:
    
    SELECT country, year, gold FROM olympic_medals WHERE gold = (SELECT MAX(gold) FROM olympic_medals);
    

-- 22. Total number of medals won by each country in the 21st century (2000 and later):
    
    SELECT country, SUM(total) AS total_medals FROM olympic_medals WHERE year >= 2000 GROUP BY country;
    

-- 23. List of all countries that won more than 50 medals in at least one edition:
    
    SELECT DISTINCT country FROM olympic_medals WHERE total > 50;
    

-- 24. Edition with the fewest total medals awarded:
    
    SELECT edition_id FROM olympic_medals GROUP BY edition_id ORDER BY SUM(total) ASC LIMIT 1;
    

-- 25. Countries that won no gold medals but won silver and bronze in 2012:
    
    SELECT country FROM olympic_medals WHERE year = 2012 AND gold = 0 AND silver > 0 AND bronze > 0;
    

-- 26. Total medals won by each country, along with its rank:
    
    SELECT country, SUM(total) AS total_medals, RANK() OVER (ORDER BY SUM(total) DESC) AS rank FROM olympic_medals GROUP BY country;
    

-- 27. Moving average of total medals won by the USA over each edition:
    
    SELECT year, AVG(SUM(total)) OVER (ORDER BY year ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS moving_avg FROM olympic_medals WHERE country_noc = 'USA' GROUP BY year;
    

-- 28. Cumulative total of medals won by each country up to each edition:
    
    SELECT year, country, SUM(SUM(total)) OVER (PARTITION BY country ORDER BY year) AS cumulative_medals FROM olympic_medals GROUP BY year, country;
    

-- 29. Percentage of total medals won by each country in each edition:
    
    SELECT year, country, (total * 100.0 / SUM(total) OVER (PARTITION BY year)) AS percentage_medals FROM olympic_medals;
    

-- 30. Countries with a growing number of gold medals across consecutive editions:
    
    SELECT country, year, gold FROM (SELECT country, year, gold, LAG(gold) OVER (PARTITION BY country ORDER BY year) AS prev_gold FROM olympic_medals) AS subquery WHERE gold > prev_gold;
    

-- 31. Trends in total medals won by USA from 1896 to 2022:
    
    SELECT year, total FROM olympic_medals WHERE country_noc = 'USA' ORDER BY year;
    

-- 32. Which country won the most medals in the Summer Olympics versus the Winter Olympics:
    
    SELECT country, SUM(total) AS total_medals FROM olympic_medals WHERE edition = 'Summer' GROUP BY country ORDER BY total_medals DESC LIMIT 1;
    

-- 33. Countries that consistently won at least one gold medal in every edition since 2000:
    
    SELECT country FROM olympic_medals WHERE year >= 2000 GROUP BY country HAVING MIN(gold) > 0;
    

-- 34. Changes in the number of participating countries over time:
    
    SELECT year, COUNT(DISTINCT country) AS num_countries FROM olympic_medals GROUP BY year ORDER BY year;
    

-- 35. Most improved country by total medal count between 2000 and 2020:
    
    SELECT country, SUM(total) - LAG(SUM(total)) OVER (PARTITION BY country ORDER BY year) AS improvement FROM olympic_medals WHERE year BETWEEN 2000 AND 2020 GROUP BY country;
    

-- 36. Countries that never won a bronze medal:
    
    SELECT DISTINCT country FROM olympic_medals GROUP BY country HAVING SUM(bronze) = 0;
    

-- 37. Countries that won exactly 1 gold medal in the 2012 edition:
    
    SELECT country FROM olympic_medals WHERE year = 2012 AND gold = 1;
    

-- 38. Find the first year in which the USA won a gold medal:
    
    SELECT MIN(year) AS first_gold_year FROM olympic_medals WHERE country_noc = 'USA' AND gold > 0;
    

-- 39. Countries that have won more than 500 total medals:
    
    SELECT country FROM olympic_medals GROUP BY country HAVING SUM(total) > 500;
    

-- 40. List the number of medals won by each country in the last edition (2022):
    
    SELECT country, total FROM olympic_medals WHERE year = 2022 ORDER BY total DESC;
    
