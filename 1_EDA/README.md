# 🔍 Exploratory Data Analysis w/ SQL: Data Analyst Job Market

![EDA Project Overview](../Images/1_1_Project1_EDA.png)

A SQL project analyzing the **data analyst** job market using real-world job-posting data. It demonstrates my ability to **write production-quality analytical SQL, design efficient queries, and turn business questions into honest, caveat-aware insights**.

---

## 🧾 Executive Summary (For Hiring Managers)

- ✅ **Project scope:** Built **3 analytical queries** answering the core questions a data analyst faces when deciding what to learn
- ✅ **Data modeling:** Used **multi-table joins** across a fact table, dimension tables, and a bridge table to resolve a many-to-many relationship
- ✅ **Analytics:** Applied **aggregations, filtering, sorting, and a log-weighted scoring metric** to rank skills by demand, salary, and overall value
- ✅ **Comparative angle:** Ran the optimal-skills analysis **globally and for Germany alone**, surfacing both a stable top tier and a real data-quality limitation
- ✅ **Outcomes:** Delivered **actionable, statistically honest insights** — including where the German subset is too thin to trust

If you only have a minute, review these:

1. [`01_top_demanded_skills.sql`](./01_top_demanded_skills.sql) – demand analysis with multi-table joins
2. [`02_top_paying_skills.sql`](./02_top_paying_skills.sql) – salary analysis with aggregations
3. [`03_optimal_skills.sql`](./03_optimal_skills.sql) – combined demand/salary optimization, run global vs. Germany

---

## 🧩 Problem & Context

Anyone planning a data analyst career needs to answer three questions:

- 🎯 **Most in-demand:** *Which skills appear most often in data analyst postings?*
- 💰 **Highest paid:** *Which skills command the highest median salaries?*
- ⚖️ **Best trade-off:** *Which skills offer the best balance of demand and pay — the ones actually worth learning first?*

The third question is the interesting one. A skill that pays a fortune across three postings isn't a practical bet, and a skill that's everywhere but pays poorly isn't a financial one. This project builds a scoring metric to capture both, then tests whether the answer holds up when the market is narrowed from global to Germany.

This analysis runs against a **data warehouse** built on a star schema:

![Data Warehouse Schema](../Images\1_2_Data_Warehouse.png)

- **Fact Table:** `job_postings_fact` — central table with job posting details (titles, locations, salaries, dates)
- **Dimension Tables:**
  - `company_dim` — company information linked to job postings
  - `skills_dim` — skills catalog with skill names and types
- **Bridge Table:** `skills_job_dim` — resolves the many-to-many relationship between postings and skills

---

## 🧰 Tech Stack

- 🐤 **Query Engine:** DuckDB for fast OLAP-style analytical queries
- 🧮 **Language:** SQL (ANSI-style with analytical functions)
- 📊 **Data Model:** Star schema with fact + dimension + bridge tables
- 🛠️ **Development:** VS Code for SQL editing + Terminal for the DuckDB CLI
- 📈 **Visualization:** Python (matplotlib) for the comparative charts
- 📦 **Version Control:** Git/GitHub for versioned SQL scripts

---

## 📂 Repository Structure

```text
1_EDA/
├── 01_top_demanded_skills.sql    # Demand analysis query
├── 02_top_paying_skills.sql      # Salary analysis query
├── 03_optimal_skills.sql         # Combined demand/salary optimization (global vs Germany)
└── README.md                     # You are here
```

---

## 🏗 Analysis Overview

### Query Structure

1. **[Top Demanded Skills](./01_top_demanded_skills.sql)** — counts how often each skill appears in data analyst postings to find the most in-demand skills.
2. **[Top Paying Skills](./02_top_paying_skills.sql)** — ranks the 25 highest-paying skills by median salary, alongside their demand counts.
3. **[Optimal Skills](./03_optimal_skills.sql)** — combines the two into a single **optimal score** to find the skills worth learning first, then runs it for both the global and German markets.

### The optimal score

```
optimal_score = median_salary × ln(demand_count) / 100,000
```

The natural-log term is the key design choice. It keeps demand in the equation while damping its scale, so a handful of rare, high-salary outliers can't dominate the ranking and genuinely common skills still surface near the top.

---

## 📊 Headline Result: the top tier is stable across both markets

![Optimal score: Global vs Germany](../Images\optimal_score_comparison.png)

**SQL, Python, and Tableau take the top three spots in both the global and German rankings.** That the order survives an independent cut of the data is the strongest single takeaway: these three are the safe foundation for a data analyst regardless of market.

| Rank | Global         | Germany        |
|------|----------------|----------------|
| 1    | SQL — 9.09     | SQL — 3.92     |
| 2    | Python — 8.64  | Python — 3.69  |
| 3    | Tableau — 8.51 | Tableau — 3.44 |
| 4    | R — 8.09       | Go — 2.93      |
| 5    | Power BI — 7.60| Looker — 2.76  |

The German scores are far smaller — but that's a volume signal, not a quality one.

---

## ⚠️ The catch: German sample size

![Salaried-posting volume, log scale](../Images\demand_volume_gap.png)

The German scores are lower because the `ln(demand_count)` term is smaller, and that term is smaller because there are dramatically fewer salaried German postings. SQL is backed by roughly **8,900 salaried postings globally but only ~40 in Germany** — over two orders of magnitude apart (note the log scale).

This is why the German query returned **nothing** under the original `HAVING COUNT > 200` filter: almost no individual skill clears 200 salaried postings in the German subset, so the threshold had to be removed entirely. The honest framing: trust the global ranking for statistical weight, and read the German ranking below the top three or four rows as indicative rather than precise.

---

## 💶 Where Germany differs: a small salary premium on core skills

![Median salary on core skills](../Images\core_salary_comparison.png)

On the skills that *do* have enough German data to compare, median salary runs consistently a little higher than the global baseline — modest, but pointing the same direction across nearly every core skill:

- SQL: **$105,650** vs $100,000 global
- Python: **$108,413** vs $100,000 global
- Tableau: **$111,175** vs $100,000 global
- Excel: **$105,650** vs $86,150 global (the widest gap)

---

## 💡 Key Insights

- 🧠 **The core stack is SQL + Python + a BI tool.** These lead the optimal ranking in both markets and carry the least risk for someone deciding what to learn first.
- ⚖️ **Demand drives the score, not salary.** The log transform does its job, surfacing widely useful skills over rare high-payers.
- 🇩🇪 **The German subset is small.** The same top skills lead locally, but the data lacks the volume to rank the long tail reliably.
- 🔁 **Watch for imputed salaries.** Several skills share an identical `$111,175` median (Tableau, Go, Looker, Pandas), which likely reflects a default in the source data rather than a true market figure — don't over-read small differences built on it.
- 🚫 **High-salary outliers are correctly buried.** GitHub ($199,675), GCP ($144,250), and NoSQL ($144,710) post the top German salaries but rank low because they appear in only a handful of postings — exactly the distortion the `ln()` weighting was designed to prevent.

---

## 💻 SQL Skills Demonstrated

### Query Design & Optimization

- **Complex Joins:** Multi-table `INNER JOIN` across `job_postings_fact`, `skills_job_dim`, and `skills_dim`
- **Aggregations:** `COUNT()`, `MEDIAN()`, `ROUND()` for statistical analysis
- **Filtering:** Boolean logic with `WHERE` and multiple conditions (`job_title_short LIKE '%Data Analyst%'`, `job_country = 'Germany'`, `salary_year_avg IS NOT NULL`)
- **Sorting & Limiting:** `ORDER BY ... DESC` with `LIMIT` for top-N analysis

### Data Analysis Techniques

- **Grouping:** `GROUP BY` for per-skill aggregation
- **Mathematical Functions:** `LN()` to log-transform demand and prevent outlier distortion
- **Calculated Metrics:** A derived optimal score combining log-weighted demand with median salary
- **HAVING Clause:** Filtering aggregated results by minimum posting count — and recognizing when that threshold makes a subset return nothing
- **NULL Handling:** Proper filtering of incomplete records (`salary_year_avg IS NOT NULL`)

### Analytical Judgment

- Ran the same logic across two market scopes to **validate findings** rather than report a single cut
- Identified and flagged **data-quality limitations** (sample size, imputed salaries) instead of presenting every number at face value

---

*Data: data analyst job postings with specified annual salaries. Salary figures are medians in USD. "Demand" counts salaried postings per skill.*
