# Impact Analysis of GoodThought NGO Initiatives

## Project Overview

GoodThought NGO is a global non-profit organization dedicated to education, healthcare, and sustainable development. It has driven positive change by managing diverse humanitarian projects aimed at improving the quality of life in underserved communities worldwide.  This project is part of the official assessment from DataCamp that leverages PostgreSQL database containing data from from 2010 to 2023  to derive data-driven insights for better decision-making.

## Background and Problem Statement

GoodThought NGO runs multiple regional assignments across education, healthcare, and sustainable development. The organization needs to ensure that funds are allocated to projects that deliver the highest impact while maintaining strong donor relationships.

Challenges encountered:
- Presence of negative budget values in the assignments table (data quality issue).
- Unclear relationship between impact score and allocation (are high-impact projects underfunded?).
- Need to rank assignments and donors by impact and contributions.

The database contains three key tables:

- Assignments – Details of NGO projects: name, region, duration, budget, and impact score.
- Donations – Records of all financial contributions tied to specific donors and assignments.
- Donors – Information on individuals and organizations that contribute funding.

## Table of Contents

- [Dataset Description](#dataset-description)
- [Data Cleaning and Preparation](#data-cleaning-and-preparation)
- [Analytical Objectives and Queries](#analytical-objectives-and-queries)
- [Tools Used](#tools-used)
- [Key Insights](#key-insights)
- [Conclusion](#conclusion)



## Dataset Description

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

## Data Cleaning and Preparation

During initial exploration, some anomalies (e.g., **negative budget values**) were detected. Cleaning steps included:

- **Absolute conversion of budget values** for accurate financial analysis without altering the raw source.
- Validating foreign key relationships between tables to ensure referential integrity.
- Truncating and previewing tables to validate schema and data quality before analysis.

## Analytical Objectives and Queries

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

## Tools Used

- **SQL**: PostgreSQL flavor for all queries.
- **DataLab from DataCamp**: Used as the working environment for query design, results interpretation, and markdown documentation.


## Key Insights

- Some regions received disproportionately higher funding and project support.
- A handful of donors consistently made large contributions, suggesting a potential for targeted donor engagement strategies.
- Project budgets had occasional data entry issues, warranting better data validation in upstream systems.
- A clear upward trend in project impact over time suggests growing efficiency or better targeting of resources.

## Conclusion

This project illustrates how structured query language (SQL) and domain-specific analytics can be leveraged to enhance operational transparency and strategic planning in the nonprofit sector. By understanding donor behavior, regional needs, and project performance, GoodThought can refine its efforts to maximize impact.

---
> - Data, Context and Environment Source: **DataLab by DataCamp**
> - Authored by: **Daren Dale Aldea**
> - Note: The analysis problems for **Items B and C** were provided by DataCamp, whereas the **subsequent analyses, context and sections were independently configured and conducted by the author.**
