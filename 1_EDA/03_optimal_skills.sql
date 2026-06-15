/*
Question: What are the most optimal skills for data analysts—balancing both demand and salary?

- Create a ranking column that combines demand count and median salary to identify the most valuable skills.
- Focus only on german Data Analyst positions with specified annual salaries.
- Why?
    - This approach highlights skills that balance market demand and financial reward. It weights core skills appropriately, rather than letting rare,
     outlier skills distort the results.
    - The natural log transformation ensures that both high-salary and widely in-demand skills surface as the most practical and valuable to learn for data analyst careers.
*/

SELECT
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg),0) AS median_salary,
    --COUNT (jpf.*) AS demand_count,
    ROUND(LN(COUNT (jpf.*)),1) AS ln_demand_count,
    ROUND((MEDIAN(jpf.salary_year_avg) * LN(COUNT (jpf.*)))/100_000,2) AS Optimal_score
FROM 
    job_postings_fact AS jpf

INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id

INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id

WHERE
    jpf.job_title_short LIKE '%Data Analyst%' 
    AND jpf.job_country = 'Germany'
    AND jpf.salary_year_avg IS NOT NULL


GROUP BY
    sd.skills

--HAVING
  --  COUNT (jpf.*) > 200

ORDER BY
    Optimal_score DESC
LIMIT 25;