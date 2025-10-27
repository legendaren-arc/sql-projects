# Impact Analysis of GoodThought NGO Initiatives

### I. Project Overview

GoodThought NGO is a global non-profit organization dedicated to education, healthcare, and sustainable development. It has driven positive change by managing diverse humanitarian projects aimed at improving the quality of life in underserved communities worldwide.  This project is part of the official assessment from DataCamp that leverages PostgreSQL database containing data from from 2010 to 2023  to derive data-driven insights for better decision-making.

### II. Background and Problem Statement

GoodThought NGO runs multiple regional assignments across education, healthcare, and sustainable development. The organization needs to ensure that funds are allocated to projects that deliver the highest impact while maintaining strong donor relationships.

Challenges encountered:
- **Data Integrity Issues:** Negative budget values and inconsistencies in project funding records.
- **Performance Ambiguity:** Lack of clarity on whether **high-impact projects receive proportionate funding**.
- **Donor Engagement:** Unclear patterns of donor contribution behavior over time.

The business problem focuses on **understanding the relationship between funding, donor behavior, and project impact** to guide more data-driven and transparent resource allocation.

### III. Database Schema Overview

| Table | Description |
|--------|--------------|
| **Assignments** | Contains project details including region, duration, budget, and impact score. |
| **Donations** | Tracks all monetary contributions linked to donors and specific projects. |
| **Donors** | Stores donor information including type (individual/organization) and country. |

### IV. Entity Relationship Diagram (ERD)

To visualize the relational structure and dependencies among the three core entities, here’s the ERD representation used for the analysis:

![Entity Relationship Diagram](./erd.png)


### V. Data Cleaning and Preparation

Initial data exploration uncovered anomalies such as **negative budgets** and **unreferenced foreign keys**.  
To ensure analytical accuracy and relational consistency, the following data preparation steps were conducted:

- Converted all **negative budgets to absolute values** for financial reliability.  
- Validated **foreign key constraints** to preserve referential integrity.  
- Verified schema consistency by **previewing and truncating tables** prior to analysis.  
- Ensured date and numeric fields were correctly cast for temporal and statistical analysis.

This meticulous data cleaning process ensured a **trustworthy foundation** for subsequent insights.

### VI. Analytical Objectives and Queries

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


### VII. Tools Used

- **SQL**: PostgreSQL flavor for all queries.
- **DataLab from DataCamp**: Used as the working environment for query design, results interpretation, and markdown documentation.


### VIII. Key Insights

- Some regions received disproportionately higher funding and project support.
- A handful of donors consistently made large contributions, suggesting a potential for targeted donor engagement strategies.
- Project budgets had occasional data entry issues, warranting better data validation in upstream systems.
- A clear upward trend in project impact over time suggests growing efficiency or better targeting of resources.

### IX. Conclusion

This project illustrates how structured query language (SQL) and domain-specific analytics can be leveraged to enhance operational transparency and strategic planning in the nonprofit sector. By understanding donor behavior, regional needs, and project performance, GoodThought can refine its efforts to maximize impact.

### X. Recommendations

1. **Implement Data Validation Rules:** Prevent future negative or null financial entries in the project database.  
2. **Reassess Funding Allocation:** Evaluate underfunded yet high-impact projects for strategic investment.  
3. **Leverage Donor Segmentation:** Build personalized engagement programs for top donors to enhance retention.  
4. **Enhance Transparency:** Develop internal dashboards that visualize impact scores and donation trends for stakeholders.
