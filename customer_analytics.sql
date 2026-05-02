select * from customer

-- business questions

-- 1.What is total revenue geenrate by male and female cutsomer:
SELECT 
    gender,
    SUM("purchase_amount_(usd)") AS total_revenue
FROM customer
GROUP BY gender;

--Q2. Which customers used a discount but still spent more than the average purchase amount? 
SELECT 
    customer_id,
    gender,
    "purchase_amount_(usd)"
FROM customer
WHERE discount_applied = 'Yes'
  AND "purchase_amount_(usd)" >= (
      SELECT AVG("purchase_amount_(usd)")
      FROM customer
  );

 -- Q3. Which are the top 5 products with the highest average review rating?
 SELECT 
    item_purchased,
    AVG(review_rating) AS average_product_rating
FROM customer
GROUP BY item_purchased
ORDER BY average_product_rating DESC
LIMIT 5;

--Q4. Compare the average Purchase Amounts between Standard and Express Shipping. 
SELECT shipping_type,
AVG("purchase_amount_(usd)")
from customer
where shipping_type in ('Standard', 'Express')
group by shipping_type

--Q5. Do subscribed customers spend more? Compare average spend and total revenue 
--between subscribers and non-subscribers.
SELECT 
    subscription_status,
    COUNT(*) AS total_customers,
    AVG("purchase_amount_(usd)") AS avg_spend,
    SUM("purchase_amount_(usd)") AS total_revenue
FROM customer
GROUP BY subscription_status
ORDER BY total_revenue DESC;

--Q6. Which 5 products have the highest percentage of purchases with discounts applied?
SELECT 
    item_purchased,
    SUM(CASE WHEN discount_applied = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS discount_rate
FROM customer
GROUP BY item_purchased
ORDER BY discount_rate DESC
LIMIT 5;

--Q7. Segment customers into New, Returning, and Loyal based on their total 
-- number of previous purchases, and show the count of each segment. 
WITH customer_type AS (
    SELECT 
        customer_id,
        previous_purchases,
        CASE 
            WHEN previous_purchases = 1 THEN 'New'
            WHEN previous_purchases BETWEEN 2 AND 10 THEN 'Returning'
            ELSE 'Loyal'
        END AS customer_segment
    FROM customer
)
SELECT 
    customer_segment,
    COUNT(*) AS "Number of customers"
FROM customer_type
GROUP BY customer_segment
ORDER BY "Number of customers" DESC;

--Q8. What are the top 3 most purchased products within each category? 
WITH item_counts AS (
    SELECT 
        category,
        item_purchased,
        COUNT(customer) AS total_orders
    FROM customer
    GROUP BY category, item_purchased
),
ranked_products AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY category 
               ORDER BY total_orders DESC
           ) AS rn
    FROM item_counts
)
SELECT 
    category,
    item_purchased,
    total_orders
FROM ranked_products
WHERE rn <= 3
ORDER BY category, total_orders DESC;

--Q9. Are customers who are repeat buyers (more than 5 previous purchases) also likely to subscribe?
select subscription_status,
count(customer_id) as repeat_buyers
from customer
where previous_purchases > 5
group by subscription_status

--Q10. What is the revenue contribution of each age group? 
select age_group,
sum("purchase_amount_(usd)") as total_revenue
from customer
group by age_group
order by total_revenue desc;
