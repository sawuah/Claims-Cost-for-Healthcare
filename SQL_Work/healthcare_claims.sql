#Data Check
-- 2 inpatient, 7 pharmacy records gone
-- fixed by changing cpt code type to text rather than number
SELECT *
FROM claims
; 

SELECT *
FROM members
;

-- 2 claims where paid amount is 0 
SELECT COUNT(claim_id)
FROM claims
WHERE paid_amount = 0
;

-- No claims where paid amount is greater than billed
SELECT COUNT(claim_id)
FROM claims
WHERE paid_amount > billed_amount
;

-- 1, GPI1234, 0, pher, simples, 0, IRX123 have extremely low volume
-- less than 2 claims
SELECT cpt_code
FROM claims
WHERE cpt_code < 2
;

-- Healthcare analysis

-- summary of claim types
CREATE VIEW claim_type_summary AS
SELECT SUM(billed_amount) AS total_billed,
ROUND(SUM(paid_amount),2) AS total_paid,
COUNT(claim_id) AS claim_count,
ROUND(SUM(paid_amount)/SUM(billed_amount),2) AS paid_ratio
FROM claims
;

-- top cpt cost drivers
CREATE VIEW top_cpt_cost_drivers AS 
SELECT cpt_code, 
ROUND(SUM(paid_amount),2) AS total_paid,
COUNT(claim_id) AS claim_count,
ROUND(AVG(paid_amount),2) AS avg_paid_per_claim
FROM claims
GROUP BY cpt_code
;

-- top icd cost drivers
CREATE VIEW top_icd_cost_drivers AS
SELECT icd_code, 
ROUND(SUM(paid_amount),2) AS total_paid,
COUNT(claim_id) AS claim_count,
ROUND(AVG(paid_amount),2) AS avg_paid_per_claim
FROM claims
GROUP BY icd_code
;

-- why each member cost a certain value
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

-- which members have higher cost
CREATE VIEW member_cost_summary_who AS
SELECT DISTINCT(c.member_id), 
ROUND(SUM(paid_amount),2) AS total_paid,
COUNT(claim_id) AS claim_count,
ROUND(AVG(paid_amount),2) AS avg_paid_per_claim
FROM claims c
JOIN members m
ON c.member_id = m.member_id
GROUP BY c.member_id
;

-- ratio of how much is paid vs billed by claim type
CREATE VIEW billed_vs_paid_claim_type AS
SELECT 
claim_type,
SUM(billed_amount) AS total_billed,
ROUND(SUM(paid_amount),2) AS total_paid,
SUM(paid_amount) - SUM(billed_amount) AS difference_between_paid_billed,
ROUND(SUM(paid_amount)/SUM(billed_amount),2) AS paid_ratio,
COUNT(claim_id) AS claim_count
FROM claims c
GROUP BY claim_type
;

-- by cpt code
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

-- by icd code
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
-- by provider
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

CREATE VIEW paid_billed_ratio_month AS 
SELECT 
MONTH(STR_TO_DATE(claim_date, '%m/%d/%y')) AS month,
SUM(billed_amount) AS total_billed,
ROUND(SUM(paid_amount),2) AS total_paid,
SUM(paid_amount) - SUM(billed_amount) AS difference_between_paid_billed,
ROUND(SUM(paid_amount)/SUM(billed_amount),2) AS paid_ratio,
COUNT(claim_id) AS claim_count
FROM claims c
GROUP BY month
;