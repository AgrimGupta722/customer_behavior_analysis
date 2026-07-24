select * from customer limit 5
--ans1
select gender,sum(purchase_amount) as revenue from customer group by gender
--ans2
select customer_id,purchase_amount from customer where discount_applied='Yes' and purchase_amount>=(select avg(purchase_amount) from customer)
--ans3
select item_purchased,round(cast(avg(review_rating) as numeric),2) as AVERAGE_PRODUCT_RATING from customer group by item_purchased order by avg(review_rating) desc limit 5
--ans4
select shipping_type,round(avg(purchase_amount),2) from customer where shipping_type in('Standard','Express')
group by shipping_type
--ans5
select subscription_status,count(customer_id )as total_customers,round(avg(purchase_amount),2) as avg_spend,round(sum(purchase_amount),2) as total_revenue
from customer
group by subscription_status
order by total_revenue,avg_spend desc;
--ans6
select item_purchased,round(100*sum(case when discount_applied ='yes' then 1 else 0 end)/count(*),2) as discount_rate from customer group by item_purchased order by discount_rate desc limit 5;
--ans7
with customer_type as(
select previous_purchases,
case when previous_purchases=1 then 'new'
when previous_purchases between 2 and 10 then 'returning'
else 'loyal'
end as cust_segment
from customer)
select cust_segment,count(*) as "no of customers"
from customer_type
group by cust_segment
--ans8
with item_counts as(
select category,item_purchased,count(customer_id) as total_orders ,row_number() over(partition by category order by count(customer_id)desc) as item_rank
from customer
group by category,item_purchased)
select item_rank,category,item_purchased,total_orders from item_counts where
item_rank<=3;
--ans9
select subscription_status,count(customer_id) as repeat_buyers from customer where previous_purchases >5 group by subscription_status
--ans10
select age_group,sum(purchase_amount) as total_revenue from customer group by age_group order by total_revenue desc;