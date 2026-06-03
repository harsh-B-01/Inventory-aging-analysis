# Inventory Aging Analysis

## Problem Statement
Classify warehouse inventory into age buckets (0-90, 91-180, 181-270, 271-365 days)
using FIFO logic to identify slow-moving stock and support supply chain decisions.

## Dataset
13 warehouse transactions (InBound/OutBound) from May 2019 to May 2020.

## Tools Used
- PostgreSQL (CTEs, Window Functions, CASE WHEN)

## Key Finding
As of 25th May 2020: 176 units are fresh (0-90 days), 102 units are aging (91-180 days),
no critically old stock detected.

## Business Recommendation
Prioritise promotions or markdowns on the 102 aging units before they cross 180 days.

## Files
- `inventory_aging.sql` — Solution query
- `data/inventory_data.csv` — Sample dataset
- `report/Inventory_Aging_Analysis.pdf` — Full report
