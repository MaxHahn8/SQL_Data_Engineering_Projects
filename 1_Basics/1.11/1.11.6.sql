SELECT
    skill_id,
    skills,
    COUNT(job_id) AS job_count
FROM job_postings_fact AS jpf