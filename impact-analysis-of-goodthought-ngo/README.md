# 📊 GoodThought NGO Data Analysis Project

## 🧭 Project Overview

This data analytics project explores the operations of **GoodThought**, a non-governmental organization committed to improving lives through education, healthcare, and sustainable development from **2010 to 2023**. The analysis aims to generate actionable insights from the NGO’s internal **PostgreSQL** database, focusing on donor contributions, project assignments, and impact assessments across regions.

## 🗃️ Dataset Description

The dataset comprises the following relational tables:

- **`assignments`**: Contains data about individual NGO projects, including:
  - `assignment_id`, `assignment_name`
  - `budget`, `region`, `impact_score`
  - `start_date`, `end_date`

- **`donations`**: Records each donation transaction:
  - `donation_id`, `donor_id`, `assignment_id`
  - `amount`, `donation_date`

- **`donors`**: Information about individuals or organizations who contributed:
  - `donor_id`, `donor_name`, `donor_type`, `country`

## 🧹 Data Cleaning & Preparation

During initial exploration, some anomalies (e.g., **negative budget values**) were detected. Cleaning steps included:

- **Absolute conversion of budget values** for accurate financial analysis without altering the raw source.
- Validating foreign key relationships between tables to ensure referential integrity.
- Truncating and previewing tables to validate schema and data quality before analysis.

## 📈 Analytical Objectives & Queries

The project conducted SQL-driven analysis to answer the following key questions:

### A. **Regional Assignment Distribution**
- Identified which regions received the most NGO project attention.
- Computed percentages of total assignments per region.

### B. **High Impact Projects**
- Isolated projects with above-average impact scores and significant budgets.
- Used `AVG(impact_score)` as a benchmark for performance.

### C. **Donor Contribution Trends**
- Summarized donation behavior by donor type (individual vs organization).
- Ranked top donors based on total contribution amounts.

### D. **Year-on-Year Impact**
- Assessed changes in assignment volume and funding over the years.
- Explored time-series trends using `EXTRACT(YEAR FROM donation_date)`.

## 🛠️ Tools Used

- **SQL**: PostgreSQL flavor for all queries.
- **Jupyter Notebook**: Used as the working environment for query design, results interpretation, and markdown documentation.
- **Pandas & Matplotlib** *(Optional in further extensions)*: For advanced analysis and data visualization.

## 📌 Key Insights

- Some regions received disproportionately higher funding and project support.
- A handful of donors consistently made large contributions, suggesting a potential for targeted donor engagement strategies.
- Project budgets had occasional data entry issues, warranting better data validation in upstream systems.
- A clear upward trend in project impact over time suggests growing efficiency or better targeting of resources.

## ✅ Conclusion

This project illustrates how structured query language (SQL) and domain-specific analytics can be leveraged to enhance operational transparency and strategic planning in the nonprofit sector. By understanding donor behavior, regional needs, and project performance, GoodThought can refine its efforts to maximize impact.
