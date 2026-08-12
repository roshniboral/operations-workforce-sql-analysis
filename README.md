# Operations & Workforce SQL Analysis

## 📌 Project Overview

This project analyzes employee workforce and operational data using SQL to identify patterns in productivity, absenteeism, workload, training, and departmental performance.

The analysis focuses on answering practical business questions that can help management identify performance gaps, workforce risks, and areas requiring improvement.

## 🎯 Business Objectives

- Analyze overall workforce size and distribution
- Measure workforce productivity and key performance indicators
- Compare productivity across departments
- Identify departments with higher absenteeism
- Identify top and underperforming employees
- Analyze workload and overtime-related risks
- Identify employees with productivity and absenteeism risks
- Measure the concentration of performance improvement needs across departments

## 🛠️ Tools & Technologies

- **PostgreSQL**
- **SQL**
- GitHub

## 📊 Dataset

The project uses an employee-level `operations_data` dataset containing workforce and performance information such as:

- Employee ID
- Employee Name
- Department
- Productivity Percentage
- Training Hours
- Overtime Hours
- Leaves / Absenteeism

## 🧠 SQL Concepts Demonstrated

This project demonstrates the practical use of:

- `SELECT`
- `WHERE`
- `ORDER BY`
- `LIMIT`
- Aggregate Functions (`COUNT`, `AVG`, `MAX`, `MIN`)
- `GROUP BY`
- `HAVING`
- Subqueries
- `CASE WHEN`
- Window Functions
- `ROW_NUMBER()`
- `FILTER`
- Ranking and comparative analysis

## 📋 Business Questions Covered

### 1. Workforce Overview

- Total Workforce Size
- Workforce Distribution
- Overall Productivity
- Workforce KPI Overview

### 2. Department Performance

- Department vs. Overall Performance
- Department Performance Ranking
- Department Absenteeism
- Training & Overtime by Department
- Department Performance Gap
- Department Workforce Risk

### 3. Employee Performance

- Top 10 Performers
- Bottom 10 Performers
- Performance Distribution
- Top 3 Performers Within Each Department
- Underperforming Employees

### 4. Workforce Efficiency & Risk

- Productivity vs. Overtime
- Absenteeism & Productivity Risk
- High-Workload Risk
- High Productivity & Low Absenteeism
- Workforce Risk Concentration

## 💡 Key Business Insights

The analysis is designed to identify:

- Departments performing above or below the overall workforce productivity level
- Employees with exceptionally high or low productivity
- Departments with above-average absenteeism
- Employees experiencing high overtime alongside lower productivity
- Employees combining high absenteeism with low productivity
- Departments with a higher concentration of employees requiring performance improvement

## 📁 Project Files

| File | Description |
|---|---|
| `operations_workforce_analysis.sql` | SQL queries used for the complete analysis |

## 🔍 Notes

The dataset does not contain a direct `working_hours` column. Therefore, training hours and overtime hours are analyzed separately where working-hours-related questions are addressed.

For performance-risk analysis, employees with productivity below 75% are categorized as **Needs Improvement**.

## 🚀 Future Analysis

Additional business and workforce analysis questions will be added to the project as the analysis progresses.
