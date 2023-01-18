#1. Create a database called house_price_regression.
create database house_price_regression;

use house_price_regression;

#2. Create a table house_price_data with the same columns as given in the csv file. Please make sure you use the correct data types for the columns.
drop table if exists house_price_data;

#show create table house_price_data2;

CREATE TABLE `house_price_data` (
  `id` bigint DEFAULT NULL,
  `date` text,
  `bedrooms` int DEFAULT NULL,
  `bathrooms` double DEFAULT NULL,
  `sqft_living` int DEFAULT NULL,
  `sqft_lot` int DEFAULT NULL,
  `floors` int DEFAULT NULL,
  `waterfront` int DEFAULT NULL,
  `view-` int DEFAULT NULL,
  `condition_` int DEFAULT NULL,
  `grade` int DEFAULT NULL,
  `sqft_above` int DEFAULT NULL,
  `sqft_basement` int DEFAULT NULL,
  `yr_built` int DEFAULT NULL,
  `yr_renovated` int DEFAULT NULL,
  `zipcode` int DEFAULT NULL,
  `lat` double DEFAULT NULL,
  `long_` double DEFAULT NULL,
  `sqft_living15` int DEFAULT NULL,
  `sqft_lot15` int DEFAULT NULL,
  `price` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

#3. Import the data from the csv file into the table.
select * from house_price_data;

#4. Select all the data from table house_price_data to check if the data was imported correctly
select count(*) from house_price_data;

#5. Use the alter table command to drop the column date from the database, as we would not use it in the analysis with SQL. Select all the data from the table to verify if the command worked. Limit your returned results to 10.
alter table house_price_data drop column `date`;
select * from house_price_data
limit 10;

#6. Use sql query to find how many rows of data you have.
select count(*) from house_price_data;

#7. Now we will try to find the unique values in some of the categorical columns:
 #What are the unique values in the column bedrooms?
select distinct bedrooms from house_price_data;

 #What are the unique values in the column bathrooms?
select distinct bathrooms from house_price_data;

 #What are the unique values in the column floors?
select distinct floors from house_price_data;

 #What are the unique values in the column condition?
select distinct condition_ from house_price_data;

 #What are the unique values in the column grade?
select distinct grade from house_price_data;

#8. Arrange the data in a decreasing order by the price of the house. Return only the IDs of the top 10 most expensive houses in your data.
select id from house_price_data
order by price desc 
limit 10;

#9. What is the average price of all the properties in your data?
select avg(price) from house_price_data;

#10. In this exercise we will use simple group by to check the properties of some of the categorical variables in our data
 #What is the average price of the houses grouped by bedrooms? The returned result should have only two columns, bedrooms and Average of the prices. Use an alias to change the name of the second column.
select bedrooms, avg(price) as avg from house_price_data
group by bedrooms;

 #What is the average sqft_living of the houses grouped by bedrooms? The returned result should have only two columns, bedrooms and Average of the sqft_living. Use an alias to change the name of the second column.
select bedrooms, avg(sqft_living) as avg from house_price_data
group by bedrooms;

 #What is the average price of the houses with a waterfront and without a waterfront? The returned result should have only two columns, waterfront and Average of the prices. Use an alias to change the name of the second column.
select waterfront, avg(price) as avg from house_price_data
group by waterfront;

 #Is there any correlation between the columns condition and grade? You can analyse this by grouping the data by one of the variables and then aggregating the results of the other column. Visually check if there is a positive correlation or negative correlation or no correlation between the variables.
select condition_, avg(grade) as avg from house_price_data
group by condition_;

select grade, avg(condition_) as avg from house_price_data
group by grade;
###There is no correlation between these variables.###

#11. One of the customers is only interested in the following houses:
--  Number of bedrooms either 3 or 4
-- Bathrooms more than 3
-- One Floor
-- No waterfront
-- Condition should be 3 at least
-- Grade should be 5 at least
-- Price less than 300000
select * from house_price_data
where (bedrooms = 3 or bedrooms = 4) 
and bathrooms > 3
and floors = 1
and waterfront = 0
and condition_ >= 3
and grade >= 5
and price < 300000;
###There is no options available for them###

#12. Your manager wants to find out the list of properties whose prices are twice more than the average of all the properties in the database. Write a query to show them the list of such properties. You might need to use a sub query for this problem.
select * from house_price_data
where price > (select avg(price) as avg from house_price_data)/2;

#13. Since this is something that the senior management is regularly interested in, create a view of the same query.
create view management_view as
select * from house_price_data
where price > (select avg(price) as avg from house_price_data)/2;

#.14. Most customers are interested in properties with three or four bedrooms. What is the difference in average prices of the properties with three and four bedrooms?
select bedrooms, price, price - lag(price) over(order by bedrooms) as X
from (select bedrooms, avg(price) as price
      from house_price_data
      group by bedrooms) as price_Bedrooms 
where bedrooms = 3 or bedrooms = 4;

#15. What are the different locations where properties are available in your database? (distinct zip codes)
select distinct zipcode from house_price_data;

#16. Show the list of all the properties that were renovated.
select * from house_price_data
where yr_renovated != 0;

#17. Provide the details of the property that is the 11th most expensive property in your database.
Select * from house_price_data
order by price desc
limit 10,1;


 