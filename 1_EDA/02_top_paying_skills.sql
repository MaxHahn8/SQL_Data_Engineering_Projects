/*
**Question: What are the highest-paying skills for data analysts?** 

- Calculate the median salary for each skill required in data analyst positions
- Focus on german positions with specified salaries
- Include skill frequency to identify both salary and demand
- Why?
    - Helps identify which skills command the highest compensation while also showing how common those skills are,
     providing a more complete picture for skill development priorities.
    - The median is used instead of the average to reduce the impact of outlier salaries.
*/

SELECT
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg),0) AS median_salary,
    COUNT (jpf.*) AS demand_count
FROM 
    job_postings_fact AS jpf

INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id

INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id

WHERE
    jpf.job_title_short LIKE '%Data Analyst%' AND jpf.job_country = 'Germany'

GROUP BY
    sd.skills

HAVING
    COUNT (jpf.*) > 200

ORDER BY
    median_salary DESC
LIMIT 25;

/*
┌────────────┬───────────────┬──────────────┐
│   skills   │ median_salary │ demand_count │
│  varchar   │    double     │    int64     │
├────────────┼───────────────┼──────────────┤
│ mysql      │      210000.0 │          203 │
│ airflow    │      138000.0 │          243 │
│ redshift   │      123250.0 │          202 │
│ bigquery   │      121200.0 │          410 │
│ javascript │      111175.0 │          394 │
│ snowflake  │      111175.0 │          415 │
│ go         │      111175.0 │          528 │
│ tableau    │      111175.0 │         3015 │
│ looker     │      111175.0 │          845 │
│ matlab     │      111175.0 │          235 │
│ pandas     │      111175.0 │          236 │
│ qlik       │      109163.0 │          562 │
│ python     │      108413.0 │         5027 │
│ r          │      106088.0 │         2319 │
│ excel      │      105650.0 │         2774 │
│ sql        │      105650.0 │         6487 │
│ spark      │      105588.0 │          333 │
│ git        │      105000.0 │          379 │
│ aws        │      100500.0 │          636 │
│ power bi   │      100000.0 │         2917 │
│ sap        │       97050.0 │         1483 │
│ sas        │       96263.0 │          792 │
│ databricks │       93438.0 │          415 │
│ powerpoint │       90000.0 │          514 │
│ sql server │       89100.0 │          327 │
└────────────┴───────────────┴──────────────┘
The highest-paying skills are mostly tools used in data engineering and cloud data infrastructure rather than traditional data analysis.
Companies are willing to pay more for people who can build and maintain data systems
because those skills are harder to find and directly support large-scale business operations.

Why are these skills paid more?
MySQL, Redshift, BigQuery, Snowflake, and Airflow are core data infrastructure tools.
These skills are often required for senior roles such as Data Engineer, Analytics Engineer, or Data Platform Engineer.
Fewer professionals have deep expertise in these technologies compared to common analyst tools.
Companies generate value from reliable data pipelines, so they pay a premium for people who can build and maintain them.

Key Takeaways
- MySQL stands out dramatically with a median salary of $210,000, far above all other skills.
- Data engineering skills dominate the top ranks, suggesting infrastructure expertise is highly valued.
- Cloud data warehouse technologies (Redshift, BigQuery, Snowflake) appear multiple times, showing strong demand for cloud-based analytics.
- Tableau, Looker, and MATLAB have the same median salary as several engineering tools, indicating that specialized analytics and visualization skills remain valuable.
- Demand and salary are not always linked. Tableau appears in over 3,000 job postings but pays the same median salary as skills with only a few hundred postings.
- High demand skills like SQL, Python, and Excel are not at the very top of the salary ranking because they are common baseline requirements rather than rare differentiators.
Conclusion

The data suggests that knowing SQL and Python helps you get into the field,
but specializing in data engineering, cloud platforms, and data infrastructure tools is where the biggest salary gains tend to occur.
Skills such as Airflow, BigQuery, Redshift, and Snowflake appear to command the strongest salary premiums because they are both technically demanding and critical
for modern data systems.
*/