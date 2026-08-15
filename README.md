# Inventory Aging Analysis

A SQL-based inventory analysis, where I applied FIFO (First-In, First-Out) logic to classify warehouse stock into aging buckets. The analysis helped identify slow-moving inventory, reduce holding costs, and support replenishment decisions.

## Problem Statement
Classify warehouse inventory into age buckets (0-90, 91-180, 181-270, 271-365 days) using FIFO logic to identify slow-moving stock and support supply chain decisions.

## Dataset
13 warehouse transactions (InBound/OutBound) from May 2019 to May 2020.

## Tools Used
- PostgreSQL (CTEs, Window Functions, CASE WHEN)

## Final Output
<img width="642" height="92" alt="image" src="https://github.com/user-attachments/assets/058e294f-3636-45e2-a58a-a4d19705c443" />

## Key Finding
As of 25 May 2020, 176 units were fresh (0–90 days), while 102 units were aging (91–180 days), with no critically old stock detected.


## Business Recommendation
Prioritise promotions or markdowns on the 102 aging units before they cross 180 days.

## Files
- `inventory_aging.sql` — Solution query
- `inventory_data.csv` — Sample dataset
- `Inventory_Aging_Analysis.pdf` — Full report
