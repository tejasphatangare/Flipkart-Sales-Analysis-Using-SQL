create database Walmart_Sales;
use Walmart_Sales;

-- INSTED OF CREATING TABLE I HAVE UPLOADED DATA FILE DIRCETLY.

-- FEATURE ENGINEERING --

#time_of_day
select time,
( CASE
		when `time` between '00:00:00' and '12:00:00' then 'Morning'
        when `time` between '12:01:00' and '16:00:00' then 'AfterNoon'
        else 'Evening'
END) as 'time_of_day' from sales;

alter table sales 
add column time_of_day varchar(30);

update sales
set time_of_day=
(
CASE
		when `time` between '00:00:00' and '12:00:00' then 'Morning'
        when `time` between '12:01:00' and '16:00:00' then 'AfterNoon'
        else 'Evening'
END);


#day_name
alter table sales
add column day_name varchar(20);

select date,dayname(date) as 'day_name' from sales;

update sales 
set day_name= dayname(date); 


#month_name
alter table sales
add column month_name varchar(30);

select date,monthname(date)as 'month_name' from sales;

update sales
set month_name=monthname(date);


-- FEATURE ENGINEERING END HERE



-- ****************************************************EXPLORATORY DATA ANALYSIS************************************************

#Business Questions To Answer-


-- 1-GENERIC QUESTION

-- 1. How many unique cities does the data have?
select count(distinct(city)) as 'Unique City' from sales;

-- 2. In which city is each branch?
select distinct(branch),city from sales;


-- 2-PRODUCT QUESTION

-- 1.How many unique product lines does the data have?
select count(distinct(`Product line`))as 'Unique Product Lines Counts' from sales;

-- 2. What is the most common payment method?
select payment,count(Payment) as 'No Of Times Payment' from sales
group by Payment
order by 'No Of Times Payment' desc;

-- 3.What is the most selling product line?
select `Product line`,count(`Product line`)as 'Product'
from sales
group by `Product line`
order by `Product` desc;

-- 4. What is the total revenue by month?
select month_name,round(sum(`total`),2)'Total_Revenue' from sales
group by month_name;


-- 5. What month had the largest COGS?
select month_name,max(cogs) as 'Highest_Cogs' from sales
group by month_name
order by `Highest_Cogs` desc;

-- 6. What product line had the largest revenue?
select `product line` ,round(sum(`total`),2)'Max_Revenue' from sales
group by `product line`
order by `Max_Revenue` desc;

-- 5. What is the city with the largest revenue?
select city,branch,round(sum(`total`),2)as 'Highest Revenue City' from sales
group by city,branch
order by `Highest Revenue City` desc;

-- 6. What product line had the largest VAT?
select `product line`,round(Avg(`TAX 5%`),2)as 'Highest Tax' from sales
group by `product line`
order by `Highest Tax` desc;

-- 7. Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
select `product line`,round(avg(`total`),2)as 'Avg Sale' from sales
group by `product line`
order by 'count' desc;




-- 8. Which branch sold more products than average product sold?
select branch,`product line`,sum(`quantity`)'count' from sales
group by `branch`;

-- 9. What is the most common product line by gender?
select `gender`,`product line`,count(gender)as 'Common Product Line' from sales
group by `product line`,`gender`
order by `common product line` desc;

-- 10. What is the average rating of each product line?
select `product line`,round(avg(`Rating`),2) as 'Average rating' from sales
group by `product line`
order by `Average rating` desc;


-- 3-SALES QUESTION

-- 1.Number of sales made in each time of the day per weekday


-- 2. Which of the customer types brings the most revenue?
select `Customer type`,round(sum(total),1)as 'High Revenue' from Sales
group by `Customer type`
order by `High Revenue` desc
limit 1;

-- 3. Which city has the largest tax percent/ VAT (**Value Added Tax**)?
select city,max(`Tax 5%`)as 'HTax' from Sales
group by city
order by `HTax` desc
limit 1;

-- 4. Which customer type pays the most in VAT?
select `Customer type`,max(`Tax 5%`)as 'T' from Sales
group by `customer type`
order by `T` desc
limit 1;


-- 4-CUSTOMER QUESTION

-- 1. How many unique customer types does the data have?
select count(distinct(`Customer type`))as 'Unique Customer' from sales;


-- 2. How many unique payment methods does the data have?
select count(distinct(`Payment`))as 'Payment Method Count' from Sales;


-- 3. What is the most common customer type?


-- 4. Which customer type buys the most?
select `Customer type`,count(quantity)as 'Most Buys' from sales
group by `Customer type`
order by `Most Buys` desc;


-- 5. What is the gender of most of the customers?
select Gender,count(gender)'Gender Count' from Sales
group by gender
order by `Gender Count` desc
limit 1;


-- 6. What is the gender distribution per branch?
select branch,gender,count(*) as 'Gender Count' from sales
group by branch,Gender;


-- 7. Which time of the day do customers give most ratings?


-- 8. Which time of the day do customers give most ratings per branch?


-- 9. Which day fo the week has the best avg ratings?


-- 10. Which day of the week has the best average ratings per branch?


