use Retail
select * from [ Retail transactions]
/* SQL queries to get the insights from Retail data */
/* 1) Get an output with a total order amount month wise
sorted by months in a descending order */
SELECT month(transaction_date) as mnth, cast(sum(Order_amt) as int)
total_orderamt from [ Retail transactions] group by month(transaction_date)
order by 1 desc

/* 2) Get an output with a total order amount month wise sorted by 
ordered amount highest to lowest */
SELECT month(transaction_date) as mnth, cast(sum(Order_amt) as int)
total_orderamt from [ Retail transactions] group by month(transaction_date)
order by 2 desc

/* 3) Get an output which represents maximum ordered amount */
select Max(order_amt) Maximum_orderedamt from [ Retail transactions]

/* 4) Get the minimum order amount(Method: View) */
create View min_orderamt as
(select month(transaction_date) mnth,sum(order_amt) total_orderamt
from [ Retail transactions] group by month(transaction_date))
select cast(min(total_orderamt) as int) as minimum_Orderamnt 
from min_orderamt

/* 5) Get the min order amount(Method: Subquery) */
select Top 1 * from 
(select month(transaction_date) as mnth,cast(sum(order_amt) as int)
Total_orderamt from [ Retail transactions] 
group by month(transaction_date)) as min_orderamt 

/* 6) Get an output presenting total order amount for each city
from high to low */
select location_city,cast(sum(order_amt) as int) Total_orderamt
from [ Retail transactions] group by location_city
order by Total_orderamt desc

/* 7) Get an output presenting total order amount
for each state from high to low */
select location_state,cast(sum(order_amt) as int) Total_orderamt
from [ Retail transactions] group by location_state
order by Total_orderamt desc

/* 8) Get an output presenting total order amount for 
each made by company in every hour */
 select Left(transaction_hour,2) as time_hour,cast(sum(order_amt) as int)
 total_orderamt from [ Retail transactions]
 group by Left(transaction_hour,2) order by total_orderamt
 
 /* 9) Get an output presenting count of rewards which were genuine */
 select count(rewards_number) Reward_count
 from [ Retail transactions] where rewards_member = 'true' 

 /* 10)	Get an output presenting count of rewards which were fake */
  select count(rewards_number) Reward_count
  from [ Retail transactions] where rewards_member = 'false' 

/* 11) Give an output which represents total, max, min, 
average discount given to customers in each city */
 select location_city,
 sum(cast(right(left(discount_amt,5),2) as int)) total_discount_amt,
 Max(cast(right(left(discount_amt,5),2) as int)) Max_discount_amt,
 Min(cast(right(left(discount_amt,5),2) as int)) Min_discount_amt, 
 AVG(cast(right(left(discount_amt,5),2) as int)) avg_discount_amt 
 from [ Retail transactions]
 group by location_city

 /* 12) Calculate the discount % given to customers in each city.*/
 select location_city,
 Round(sum(cast(right(left(discount_amt,5),2)as int))/(sum(order_amt))*100,2)
 as discount_percentage from [ Retail transactions] 
 group by location_city order by discount_percentage

 /* 13) Give an output which represents total, max, min, average ordered 
 amount by customers in each city */
 select location_city,cast(sum(order_amt) as int) total_discount_amt,
 Round(Max(order_amt),2) Max_discount_amt,
 Round(Min(order_amt),2) Min_discount_amt, 
 Round(AVG(order_amt),2) avg_discount_amt from [ Retail transactions]
 group by location_city

 /* 14)Give an output which represents total, max, min, 
 average no: of orders by customers in each city */
 select location_city,sum(num_of_items) as total_orders,
 max(num_of_items) max_orders,min(num_of_items) min_orders,
 avg(num_of_items) avg_orders from [ Retail transactions]
 group by location_city

 /* 15)Give an output for the total sales of a state 
 and city with maximum sales */
 select location_city,location_state,cast(sum(order_amt) as int) as total_Salesamt
 from [ Retail transactions] group by location_city,location_state
 order by 3 desc
 
 

 