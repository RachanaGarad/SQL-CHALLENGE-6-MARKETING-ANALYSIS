/*Intro
--You are a Marketing Analyst
--The 'Sustainable Clothing Co.' has been running several marketing campaigns and have asked you to provide your insight into whether they have succeeded.
 --Analyze the following data and answer the questions to form your answer.*/

-- Create the database
CREATE DATABASE Marketing_Analysis;

-- Switch to the newly created database
USE Marketing_Analysis;

select * from marketing_campaigns;
select * from sustainable_clothing;
select * from transactions;

-- Q1.How many transactions were completed during each marketing campaign?

SELECT 
    transaction_id,
    c.campaign_name,
    c.product_id,
    COUNT(quantity) AS transactions_count
FROM
    marketing_campaigns AS c
        INNER JOIN
    transactions AS t USING (product_id)
GROUP BY c.campaign_id , c.campaign_name;

-- Q2.Which product had the highest sales quantity?
SELECT 
    product_id, product_name, SUM(quantity) AS total_quantity
FROM
    sustainable_clothing
        INNER JOIN
    transactions AS t USING (product_id)
GROUP BY product_name
ORDER BY total_quantity DESC
LIMIT 1;

-- Q3 What is the total revenue generated from each marketing campaign?

SELECT 
    m.campaign_id,
    m.campaign_name,
    round(sum(s.price * t.quantity),3) AS revenue
FROM
    sustainable_clothing AS s
        INNER JOIN
    transactions AS t USING (product_id)
        INNER JOIN
    marketing_campaigns AS m USING (product_id)
GROUP BY m.campaign_name;

-- Q4.4. What is the top-selling product category based on the total revenue generated?
SELECT 
    ROUND(SUM(s.price * t.quantity), 3) AS revenue, s.category
FROM
    sustainable_clothing AS s
        INNER JOIN
    transactions AS t USING (product_id)
GROUP BY s.category
ORDER BY revenue DESC
LIMIT 1;

