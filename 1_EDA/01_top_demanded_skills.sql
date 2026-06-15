/*
Question: What are the most in-demand skills for data analysts?
- Identify the top 10 in-demand skills for data analysts
- Focus on german job postings
- Why? Retrieves the top 10 skills with the highest demand in the remote job market,
 providing insights into the most valuable skills for data analysts seeking work in germany

*/
SELECT
    sd.skills,
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

ORDER BY
    demand_count DESC
LIMIT 10;

/*
Here's the breakdown of the most demaded skills for data analysts looking for work in germany:

Data analyst demand in Germany rests on two non-negotiables: SQL (6,487) and Python (5,027), both far ahead of everything else.
Python clearly outranks R (more than 2x), so it's the analytics language to prioritize.
The next tier is visualization, with Tableau (3,015) and Power BI (2,917) nearly tied, and Excel still demanded at scale (2,774). 
Everything below that is a differentiator, not an entry requirement.

Key takeaways:
- SQL and Python are mandatory and sit far above the rest.
- Prioritize Python over R for analytics.
- Add Tableau or Power BI; they're nearly tied in demand.
- Excel is still worth keeping sharp.
- Remaining tools are bonus skills, not entry requirements.

┌──────────┬──────────────┐
│  skills  │ demand_count │
│ varchar  │    int64     │
├──────────┼──────────────┤
│ sql      │         6487 │
│ python   │         5027 │
│ tableau  │         3015 │
│ power bi │         2917 │
│ excel    │         2774 │
│ r        │         2319 │
│ sap      │         1483 │
│ azure    │          920 │
│ looker   │          845 │
│ sas      │          792 │
└──────────┴──────────────┘
  10 rows       2 columns

*/