# Exploring Trends in American Baby Names

This project explores historical trends in U.S. baby names using a dataset sourced from **DataCamp's Database**.
It focuses on uncovering meaningful insights into naming patterns, gender trends, and the evolution of baby name popularity across different decades.


---

## Table of Contents

- [Dataset Overview](#dataset-overview)
- [Project Objectives](#project-objectives)
- [SQL Concepts Practiced](#sql-concepts-practiced)
- [Key Findings](#key-findings)
- [Learning Outcomes](#learning-outcomes)
- [Tools Used](#tools-used)

---

## Dataset Overview

The dataset, named `baby_names`, contains records of baby names registered in the United States, with the following columns:

- `year` (int) – Year of registration
- `first_name` (varchar) – Given name of the baby
- `sex` (varchar) – Sex of the baby (M or F)
- `num` (int) – Number of babies given that name in that year

---

## Project Objectives

- Find the most popular baby names for each gender overall
- Identify the top 10 most popular male and female baby names
- Discover female names that appeared both in 1920 and 2020
- Classify top baby names as "Classic" or "Trendy"
- Track the most common names by year for each gender
- Detect gender-neutral names
- Analyze name popularity trends from first to last appearance

---

## SQL Concepts Practiced

- Common Table Expressions (CTEs) to organize multi-step queries
- Subqueries for dynamic filtering and ranking
- Joins to compare records across different years and genders
- Window Functions (using `RANK()`) to rank baby names by popularity
- Aggregations and Grouping to summarize name counts
- Conditional Logic (`CASE` statements) to classify names
- Filtering and Sorting to refine query outputs

---

## Key Findings

- Names like `Mary` and `James` were historically dominant over long periods.
- In recent decades, there was a noticeable increase in the diversity of baby names.
- Gender significantly influences naming trends and popularity.
- Some names remained consistently popular, while others were short-lived trends.
- Gender-neutral names, though rare, can be identified in the dataset.

---

## Learning Outcomes

This mini-project provided practical experience in intermediate SQL. It helped improve skills in:

- Writing clean and structured SQL queries
- Extracting meaningful insights from real-world datasets
- Applying analytical techniques to large categorical datasets

---

## Tools Used

- **SQL:** PostgreSQL flavor for all queries.
- **DataLab from DataCamp:** Used as the working environment for query design, results interpretation, and markdown documentation.

---
> - Data and Environment Source: **All rights reserved to DataLab by DataCamp**
> - Authored by: **Daren Dale Aldea**
> - The analysis problems for **Items D and E** were provided by DataCamp, whereas the **subsequent analyses were independently configured and conducted by the author.**
