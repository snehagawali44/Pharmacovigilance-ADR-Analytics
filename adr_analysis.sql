CREATE DATABASE adr_analysis;
SELECT * FROM adr_analysis.adr_data ;
USE adr_analysis;

-- Q1.Which drugs have the highest number of ADR reports?
SELECT DrugName,
COUNT(*) AS Total_Reports
FROM adr_data
GROUP BY DrugName
ORDER BY Total_Reports DESC
LIMIT 10;

-- Q2. How many ADR reports are serious vs non-serious?
SELECT Seriousness,
COUNT(*) AS Total_Cases
FROM adr_data
GROUP BY Seriousness;

-- Q3. Which gender reported more ADRs?
SELECT Gender,
COUNT(*) AS Total_Reports
FROM adr_data
GROUP BY Gender
ORDER BY Total_Reports DESC;

-- Q4. What is the average patient age for each seriousness category?
SELECT Seriousness,
       ROUND(AVG(PatientAge), 2) AS Avg_Age
FROM adr_data
GROUP BY Seriousness;

-- Q5. Which drugs are most associated with serious ADRs?
SELECT DrugName,
COUNT(*) AS Serious_Cases
FROM adr_data
WHERE Seriousness IN ('Severe', 'Fatal')
GROUP BY DrugName
ORDER BY Serious_Cases DESC
LIMIT 10;

-- Q6. What will be the distribution of Serious and Non-Serious ADRs?
SELECT 
CASE 
	WHEN Seriousness IN ('Severe', 'Fatal')
    THEN 'Serious ADR'
    ELSE 'Non-Serious ADR'
END AS ADR_Category,
COUNT(*) AS Total_Cases
FROM adr_data
GROUP BY ADR_category;

-- Q7. Average ADR Onset Days by Drug.(How quickly do ADRs appear for different drugs?)
SELECT DrugName,
ROUND(AVG(OnsetDays), 2) AS Avg_Onset_Days
FROM adr_data
GROUP BY DrugName
ORDER BY Avg_Onset_Days ASC;

-- Q8. Average Drug Exposure Duration.(What is the average duration of drug exposure before ADR reporting?)
SELECT 
ROUND(AVG(DurationDays), 2) AS Avg_Exposure_Duration
FROM adr_data;

-- Q9. Which drugs were most commonly reported with concomitant drugs?
SELECT DrugName,
COUNT(*) AS Total_Reports
FROM adr_data
WHERE ConcomitantDrugs != 'None Reported'
GROUP BY DrugName
ORDER BY Total_Reports DESC
LIMIT 10;

-- Q10. Which age groups reported the most ADRs?
SELECT
CASE
    WHEN PatientAge < 18 THEN 'Child'
    WHEN PatientAge BETWEEN 18 AND 40 THEN 'Young Adult'
    WHEN PatientAge BETWEEN 41 AND 60 THEN 'Middle Age'
    ELSE 'Senior'
END AS Age_Group,
COUNT(*) AS Total_Reports
FROM adr_data
GROUP BY Age_Group
ORDER BY Total_Reports DESC;

-- Q11. Which drugs showed delayed ADR onset?
SELECT DrugName,
ROUND(AVG(OnsetDays), 2) AS Avg_Onset
FROM adr_data
GROUP BY DrugName
ORDER BY Avg_Onset DESC
LIMIT 10;
