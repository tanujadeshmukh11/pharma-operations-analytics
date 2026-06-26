--Basic
--1. Show all records
SELECT * FROM medical_store;


--2. Show first 10 records
SELECT * FROM medical_store
LIMIT 10;


--3. Count total rows
SELECT COUNT(*) AS total_records
FROM medical_store;


--4. Show selected columns
SELECT "Invoice_ID", "Date", "Medicine_Name", "Total_Sale"
FROM medical_store;


--5. Find unique categories
SELECT DISTINCT "Category"
FROM medical_store;



--SALES ANALYSIS 


--6. Total sales
SELECT MAX("Total_Sale") AS max_sale
FROM medical_store;

--7. Average sales
SELECT AVG("Total_Sale") AS avg_sales
FROM medical_store;


--8. Maximum sale
SELECT MAX("Total_Sale") AS max_sale
FROM medical_store;


--9. Minimum sale
SELECT MIN("Total_Sale") AS min_sale
FROM medical_store;


--10. Sales by category
SELECT "Category", SUM("Total_Sale") AS total_sales
FROM medical_store
GROUP BY "Category";

--11. Top 5 medicines by sales
SELECT "Medicine_Name", SUM("Total_Sale") AS total_sales
FROM medical_store
GROUP BY "Medicine_Name"
ORDER BY total_sales DESC
LIMIT 5;


--12. Count transactions per category
SELECT "Category", COUNT(*) AS total_transactions
FROM medical_store
GROUP BY "Category";


--CUSTOMER ANALYSIS
--13. Sales by gender
SELECT "Gender", SUM("Total_Sale") AS total_sales
FROM medical_store
GROUP BY "Gender";


--14. Sales by age group
SELECT "Age_Group", SUM("Total_Sale") AS total_sales
FROM medical_store
GROUP BY "Age_Group";



--15. Number of customers per gender
SELECT "Gender", COUNT(DISTINCT "Customer_ID") AS customers
FROM medical_store
GROUP BY "Gender";


--16. Average sales per age group
SELECT "Age_Group", AVG("Total_Sale") AS avg_sales
FROM medical_store
GROUP BY "Age_Group";


--LOCATION ANALYSIS


--17. Sales by location
SELECT "Store_Location", SUM("Total_Sale") AS total_sales
FROM medical_store
GROUP BY "Store_Location";


--18. Top location by sales
SELECT "Store_Location", SUM("Total_Sale") AS total_sales
FROM medical_store
GROUP BY "Store_Location"
ORDER BY "total_sales" DESC
LIMIT 1;


--19. Transactions per location
SELECT "Store_Location", COUNT(*) AS transactions
FROM medical_store
GROUP BY "Store_Location";



--20. Compare Pune vs Mumbai sales
SELECT "Store_Location", SUM("Total_Sale")
FROM medical_store
WHERE "Store_Location" IN ('Pune', 'Mumbai')
GROUP BY "Store_Location";


--TIME ANALYSIS 


--21. Monthly sales trend
SELECT DATE_TRUNC('month', "Date") AS month,
       SUM("Total_Sale") AS total_sales
FROM medical_store
GROUP BY month
ORDER BY month;


--22. Yearly sales
SELECT EXTRACT(YEAR FROM "Date") AS year,
       SUM("Total_Sale") AS total_sales
FROM medical_store
GROUP BY year
ORDER BY year;

--23. Highest sales month
SELECT DATE_TRUNC('month', "Date") AS month,
       SUM("Total_Sale") AS total_sales
FROM medical_store
GROUP BY month
ORDER BY total_sales DESC
LIMIT 1;


--INVENTORY 


--24. Low stock medicines
SELECT "Medicine_Name", "Stock_Available"
FROM medical_store
ORDER BY "Stock_Available" ASC
LIMIT 10;


--25. Expiring medicines (6 months)
SELECT "Medicine_Name", "Expiry_Date"
FROM medical_store
WHERE "Expiry_Date" <= CURRENT_DATE + INTERVAL '6 months';


--26. Category-wise stock
SELECT "Category", SUM("Stock_Available") AS total_stock
FROM medical_store
GROUP BY "Category";


--PAYMENT ANALYSIS 


--27. Sales by payment mode
SELECT "Payment_Mode", SUM("Total_Sale") AS total_sales
FROM medical_store
GROUP BY "Payment_Mode";


--28. Most used payment mode
SELECT "Payment_Mode", COUNT(*) AS transactions
FROM medical_store
GROUP BY "Payment_Mode"
ORDER BY transactions DESC
LIMIT 1;


--ADVANCED 


--29. Most frequently sold medicine
SELECT "Medicine_Name", COUNT(*) AS times_sold
FROM medical_store
GROUP BY "Medicine_Name"
ORDER BY times_sold DESC;


--30. Category contribution to total sales (%)
SELECT "Category",
       SUM("Total_Sale") AS category_sales,
       ROUND(
           (SUM("Total_Sale") * 100.0 /
           (SELECT SUM("Total_Sale") FROM medical_store))::numeric,
           2
       ) AS percentage_contribution
FROM medical_store
GROUP BY "Category"
ORDER BY category_sales DESC;