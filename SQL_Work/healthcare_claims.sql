-- 1.Data Check
-- 2 inpatient, 7 pharmacy records gone
-- fixed by changing cpt code type to text rather than number
SELECT *
FROM claims
; 

SELECT *
FROM members
;

-- Identify claims where paid amount is 0 
SELECT COUNT(claim_id)
FROM claims
WHERE paid_amount = 0
;

-- Identify claims where paid amount is higher than billed amount
SELECT COUNT(claim_id)
FROM claims
WHERE paid_amount > billed_amount
;

-- Identify low volume cpt_codes 
SELECT cpt_code
FROM claims
WHERE cpt_code < 2
;

-- 2. Healthcare analysis

-- Create a view summarizing claim level cost by claim type
-- Includes total_paid, total_billed,claim_count aggregations.
CREATE VIEW claim_type_summary AS
SELECT SUM(billed_amount) AS total_billed,
ROUND(SUM(paid_amount),2) AS total_paid,
COUNT(claim_id) AS claim_count,
ROUND(SUM(paid_amount)/SUM(billed_amount),2) AS paid_ratio
FROM claims
;

-- Create a view looking at icd cost drivers.
-- Includes total_paid,claim_count,avg_per_claim aggregations.
CREATE VIEW top_cpt_cost_drivers AS 
SELECT cpt_code, 
ROUND(SUM(paid_amount),2) AS total_paid,
COUNT(claim_id) AS claim_count,
ROUND(AVG(paid_amount),2) AS avg_paid_per_claim
FROM claims
GROUP BY cpt_code
;

-- Create a view summarizing claim level cost by claim type
-- Includes total_paid, total_billed,claim_count aggregations.
CREATE VIEW top_icd_cost_drivers AS
SELECT icd_code, 
ROUND(SUM(paid_amount),2) AS total_paid,
COUNT(claim_id) AS claim_count,
ROUND(AVG(paid_amount),2) AS avg_paid_per_claim
FROM claims
GROUP BY icd_code
;

-- Create a view summarizing member costs by claim type
-- Includes total_paid, avg_paid_per_claim,claim_count aggregations.
-- Left Joins members table to claims table
CREATE VIEW member_cost_summary_why AS
SELECT DISTINCT(c.member_id), 
claim_type,
ROUND(SUM(paid_amount),2) AS total_paid,
COUNT(claim_id) AS claim_count,
AVG(paid_amount) AS avg_paid_per_claim
FROM claims c
JOIN members m
ON c.member_id = m.member_id
GROUP BY c.member_id, claim_type
;

-- Same as member_cost_summary_why
-- Except includes paid_ratio, member age, member gender, plan type, provider id 
CREATE VIEW member_cost_summary_who AS
SELECT DISTINCT(c.member_id), 
ROUND(SUM(paid_amount),2) AS total_paid,
COUNT(claim_id) AS claim_count,
ROUND(AVG(paid_amount),2) AS avg_paid_per_claim,
ROUND(SUM(paid_amount)/SUM(billed_amount),2) AS paid_ratio,
m.member_age,
m.member_gender,
m.plan_type,
c.provider_id,
c.claim_type
FROM claims c
JOIN members m
ON c.member_id = m.member_id
GROUP BY c.member_id, m.member_age, m.member_gender, m.plan_type, c.provider_id, c.claim_type
;

-- Summarizes how much is billed vs. paid by claim_type
-- Extracts month, year, and day from claim_date
-- Includes total billed, total paid, paid ratio, different between paid and billed, claim count
CREATE VIEW billed_vs_paid_claim_type AS
SELECT 
claim_type,
DATE_FORMAT(STR_TO_DATE(claim_date, '%c/%e/%Y'),'%b') AS month,
YEAR(STR_TO_DATE(claim_date, '%c/%e/%Y')) AS year,
DAY(STR_TO_DATE(claim_date, '%c/%e/%y')) AS day_number,
SUM(billed_amount) AS total_billed,
ROUND(SUM(paid_amount),2) AS total_paid,
SUM(paid_amount) - SUM(billed_amount) AS difference_between_paid_billed,
ROUND(SUM(paid_amount)/SUM(billed_amount),2) AS paid_ratio,
COUNT(claim_id) AS claim_count
FROM claims c
GROUP BY claim_type, month, year, day_number
;

-- Summarizes by cpt code
CREATE VIEW billed_vs_paid_cpt_code AS
SELECT 
cpt_code,
SUM(billed_amount) AS total_billed,
ROUND(SUM(paid_amount),2) AS total_paid,
SUM(paid_amount) - SUM(billed_amount) AS difference_between_paid_billed,
ROUND(SUM(paid_amount)/SUM(billed_amount),2) AS paid_ratio,
COUNT(claim_id) AS claim_count
FROM claims c
GROUP BY cpt_code
;

-- Summarizes by icd code
CREATE VIEW billed_vs_paid_icd_code AS
SELECT 
icd_code,
SUM(billed_amount) AS total_billed,
ROUND(SUM(paid_amount),2) AS total_paid,
SUM(paid_amount) - SUM(billed_amount) AS difference_between_paid_billed,
ROUND(SUM(paid_amount)/SUM(billed_amount),2) AS paid_ratio,
COUNT(claim_id) AS claim_count
FROM claims c
GROUP BY icd_code
;
-- Summarizes by provider
CREATE VIEW billed_vs_paid_provider AS
SELECT 
provider_id,
SUM(billed_amount) AS total_billed,
ROUND(SUM(paid_amount),2) AS total_paid,
SUM(paid_amount) - SUM(billed_amount) AS difference_between_paid_billed,
ROUND(SUM(paid_amount)/SUM(billed_amount),2) AS paid_ratio,
COUNT(claim_id) AS claim_count
FROM claims c
GROUP BY provider_id
;

-- Summarizes by month and year
CREATE VIEW paid_billed_ratio_month_year AS 
SELECT 
DATE_FORMAT(STR_TO_DATE(claim_date, '%c/%e/%Y'), '%b') AS month,
YEAR(STR_TO_DATE(claim_date, '%c/%e/%Y')) AS year,
SUM(billed_amount) AS total_billed,
ROUND(SUM(paid_amount),2) AS total_paid,
SUM(paid_amount) - SUM(billed_amount) AS difference_between_paid_billed,
ROUND(SUM(paid_amount)/SUM(billed_amount),2) AS paid_ratio,
COUNT(claim_id) AS claim_count
FROM claims c
GROUP BY month, year
;



