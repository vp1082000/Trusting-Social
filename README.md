
# Trusting Social - Data Analytic SQL Test

Assuming that your company is running a loan marketplace where people who want to borrow money are matched with appropriate loan products provided by different banks, the data schemas are shown below:

__Banks__

Column name|Data type|Notes
---|---|---
bank_id|int|Primary key
bank_name|string|Examples: “HSBC”, “Ocean Bank”,...

__Products__

Column name|Data type|Notes
---|---|---
product_id |int |Primary key
loan_amount |int |The currency unit is USD. Example value: 1000
interest_rate |float ||
accepted_risk_level |string |“low” / “medium” / “high”
bank_id |int |The bank that provides this product
created_date |DateTime | |

__Customers__

Column name	|Data type |Notes
---|---|---
customer_id	|int |Primary key
customer_name |string |Example value: “Morgan Freeman”
customer_age |int| Example value: 65
estimated_risk_level |string |“low” / “medium” / “high”
source |string |The source that brings this customer to the marketplace
created_date |DateTime | |	

__Leads__

Column name	|Data type |Notes
---|---|---
customer_id	|int ||	
product_id	|int ||	
apply_date	|DateTime ||	

A customer with an estimated risk level X will only be matched with a product that accepts risk level X.
Based on the above data tables, please write SQL queries to:
1. Show the number of products available for each accepted risk level.

2. Show the average interest rates of products provided by HSBC and Techcombank banks.

3. Show 2 banks that have the most high-risk products.

4. Show which source brings to the marketplace more low-risk customers.

5. Show all months of the year 2018 that the number of customers applying for loans is 20% higher than the monthly average number of customers of the year.

6. Show the names of all leads who applied in 2019 and are older than 95% of all leads who applied in 2017.






