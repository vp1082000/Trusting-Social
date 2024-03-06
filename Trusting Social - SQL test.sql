--Q1: Show the number of products available for each accepted risk level.
SELECT
  estimated_risk_level,
  COUNT(*)
FROM Products
GROUP BY accepted_risk_level

--Q2: Show the average interest rates of products provided by HSBC and Techcombank banks.
SELECT
  P.bank_id,
  B.bank_name,
  AVG(P.interest_rate)
FROM Products P
INNER JOIN Banks B
ON B.bank_id = P.bank_id AND B.bank_name IN ('HSBC','Techcombank')
GROUP BY P.bank_id, B.bank_name

--Q3: Show 2 banks that have the most high-risk products.
SELECT
  P.bank_id,
  B.bank_name,
  COUNT(P.product_id) AS No_high_risk_product
FROM Products P
GROUP BY P.bank_id
JOIN Banks B
ON B.bank_id = P.bank_id
HAVING P.accepted_risk_level = 'high'
ORDER BY COUNT(P.product_id) DESC
LIMIT 2

--Q4: Show which source brings to the marketplace more low-risk customers.
SELECT
  DISTINCT source
FROM Customers
WHERE estimated_risk_level = 'low'

--Q5: Show all months of the year 2018 that the number of customers applying for loans is 20% higher than the monthly average number of customers of the year.
WITH STATISTIC AS(
  SELECT
    MONTH(apply_date) AS Month,
    COUNT(customer_id) AS Number_apply
  FROM Leads
  WHERE YEAR(apply_date) = '2018'
  GROUP BY MONTH(apply_date)
)
SELECT
  Month,
  Number_apply
FROM STATISTIC
WHERE Number_apply > (SELECT AVG(Number_apply)*120/100 FROM STATISTIC)

--Q6: Show the names of all leads who applied in 2019 and are older than 95% of all leads who applied in 2017.
WITH RANK_95 AS (
    SELECT
      DISTINCT
      L.customer_name,
      C.customer_age
    FROM Leads L
    LEFT JOIN Customers C
    ON C.customer_id = L.customer_id
    WHERE YEAR(L.apply_date) = '2017'
)
SELECT
  L.customer_id,
  C.customer_name,
  C.customer_age
FROM Leads L
WHERE YEAR(L.apply_date) = '2019'
LEFT JOIN Customers C
ON C.customer_id = L.customer_id
JOIN RANK_95
ON C.customer_age > (SELECT 
                        PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY customer_age) AS percen_95
                    from RANK_95)