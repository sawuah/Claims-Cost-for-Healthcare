# Claims Cost for Healthcare

## Executive Summary:
Business Problem
The solution answers
Next Steps
The number impact

## Business problem and questions: 
A healthcare insurance company is rapidly losing money and wants to figure out why. The organization needs to understand healthcare spending across claim types, CPT and ICD codes, members, and providers. There is a lack of clarity that prevents data driven decision making and proper resource utilization. 

#### Questions:

- **Which claim types are the most expensive?**

- **Which CPT and ICD codes drive the highest spending?**

- **Which members account for the largest share of the total cost?**

- **How do billed amounts compare to paid amounts?**

## Methodology:
### Excel

- **Imported** dataset into Excel to gain a general overview of trends, patterns, and data quality.

- **Filtered** data to identify missing values, inconsistencies, and outliers. 

- Created **pivot tables** to analyze total paid by claim type, icd code, cpt codes, and member.

- Applied **conditional formatting** to identify any abnormal logic such as cases where paid amounts are more than billed amounts. 

### SQL

- **Imported**dataset in SQL using Import Wizard.

- **Cross checked** with Excel to make sure all records were present. Performed a **quick data check** to make sure there were no abnormalities. 

- **Created analytical views summarizing** (claim types, top CPT cost drivers, ICD cost drivers, member level insights, paid vs. billed comparisons, provider performance).  **Included aggregated metrics:** day, month, year, total paid, total billed, paid ratio, claim count

### Tableau

- **Created key KPIs** to support paid vs. billed, code, member, and provider analysis.
  
- **Created visualizations** including cost flow, code lookup tool, member price breakdown
  
- **Designed a multi page dashboard** with built-in navigation, starting with a central homepage. 

## Skills:

Microsoft Excel: **pivot tables, conditional formatting, filtering**

SQL: **importing, aggregate function, joins, grouping**

Tableau: **data visualization, calculated fields, interactive filters, multi-page navigation** 

## Results and Business Recommendation
### Most expensive claim types

- Inpatient and Emergency are the two most expensive claim types. 

 - Impatient = $1,092,456

- Emergency = $294,441

- Despite similar claim volume shares (around 20 percent), Impatient spending is nearly four times higher than Emergency. 

- Outpatient holds 23.39 percent of claims but only holds $129,053 of the total paid by the insurance company. 

### Most expensive CPT and ICD codes

- Top 10 most expensive CPT codes: 67890, 23456, 123, 12345, 45678, 99223, 56789, 54321, 34567, 567

- Top 10 most expensive ICD codes: A12.3, B20, B20.1, I10, B99.4, E11.65, A01.1, C34.91, E11.9, J45.909 

### Most expensive members

- Member ID: 6. 28, 32, 58, 82 

- Top 5 members account for 11.6 percent of the total amount paid. 

### Paid vs. Billed amounts

- The insurance company pays 75% of the billed amount. 

#### By claim type:

- Paid ratio Emergency: 77.38%

- Paid ratio Impatient: 74.43%

- Paid ratio Outpatient: 86.84%

- Paid ratio Pharmacy: 87.78%

- Paid Ratio Lab: 91.46%
		
#### Dashboards

<img width="1356" height="757" alt="Screenshot 2026-03-24 222458" src="https://github.com/user-attachments/assets/120e1c82-c16d-46e7-ad8e-f62ff9d1fc7d" />
<img width="1359" height="767" alt="Screenshot 2026-03-24 222550" src="https://github.com/user-attachments/assets/b8691a53-a0cf-4ba7-b14c-d47038d87fd5" />
<img width="1364" height="770" alt="Screenshot 2026-03-24 223557" src="https://github.com/user-attachments/assets/92d0e351-aa33-4c2f-bb0b-5aec55807c10" />
<img width="1364" height="771" alt="Screenshot 2026-03-24 222723" src="https://github.com/user-attachments/assets/4d1aa1a2-eda1-45aa-87d7-5cda7251fd4c" />










### Contact
[Linkedin](www.linkedin.com/in/sandraawuah00) 
Email: sandraawuah00@gmail.com
[Tableau Public](https://public.tableau.com/app/profile/sandra.awuah/vizzes)

### Data From Analytic Builder
