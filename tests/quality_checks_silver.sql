--CHECK FOR NULLS & DUPLICATES IN PRIMARY KEY
--EXPECTATION : NO RESULT

SELECT 
cst_id,
COUNT (*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT (*) > 1 OR cst_id IS NULL

--CHECK FOR UNWANTED SPACES
--EXPECTATIO: NO RESULTS
SELECT cst_firstname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)

--DATA STANDARDIZATION & CONSISTENCY
SELECT DISTINCT cst_gndr
FROM silver.crm_cust_info

SELECT *
FROM silver.crm_cust_info

--CHECK FOR NULLS OR DUPLICATES
--EXPECTATIONS: NO RESULT
SELECT 
prd_id,
COUNT (*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL

--CHECK FOR UNWANTED SPACES
--EXPECTATION : NO RESULTS
SELECT
prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)

--CHECK FOR NULLS OR NEGATIVE NUMBERS
--EXPECTATION: NO RESULTS
SELECT
prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL

--DATA STANDARDIZATION & CONSISTENCY
SELECT DISTINCT prd_line
FROM silver.crm_prd_info

--CHECK FOR INVALID DATE ORDERS
SELECT
*
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt

SELECT 
*
FROM silver.crm_prd_info

--CHECK FOR INVALID DATES
SELECT 
--NULLIF(sls_order_dt, 0) sls_order_dt 
--NULLIF(sls_ship_dt, 0) sls_order_dt
NULLIF(sls_ship_dt, 0) sls_order_dt
FROM silver.crm_sales_details
--WHERE sls_order_dt   <= 0
--OR LEN(sls_order_dt ) != 8
--OR sls_order_dt > 20500101
--OR sls_order_dt < 19000101
--WHERE  sls_ship_dt  <= 0
--OR LEN(sls_ship_dt ) != 8
--OR sls_ship_dt > 20500101
--OR sls_ship_dt < 19000101
WHERE  sls_due_dt <= 0
OR LEN( sls_due_dt) != 8
OR sls_due_dt > 20500101
OR sls_due_dt < 19000101

--CHECK FOR INVALID DATE ORDERS
SELECT 
*
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt

--CHECK DATA CONSISTENCY : BETWEEN SALES, QUANTITY AND PRICE 
-- > > SALES = QUANTITY * PRICE 
-- > > VALUES MUST NOT BE NULL, ZERO,OR NEGATIVE.
SELECT DISTINCT
sls_sales AS old_sls_sales,
sls_quantity,
sls_price AS old_sls_price,
CASE WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price)
     THEN sls_quantity * ABS(sls_price)
     ELSE sls_sales
END sls_sales,
CASE WHEN sls_price IS NULL OR sls_price <= 0 
     THEN sls_sales / NULLIF(sls_quantity,0)
     ELSE sls_price
END sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <=0
ORDER BY sls_sales, sls_quantity,sls_price

SELECT *
FROM silver.crm_sales_details

--IDENTIFY  OUT OF RANGE
SELECT
bdate AS DATE
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01' or bdate > GETDATE()

--DATA STANDARDIZATION & CONSISTENCY
SELECT DISTINCT 
gen
FROM silver.erp_cust_az12

SELECT
* 
FROM silver.erp_cust_az12

--DATA STANDARDIZATION & CONSISTENCY
SELECT DISTINCT
cntry
FROM bronze.erp_loc_a101

