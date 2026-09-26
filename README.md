# Retail Sales & Customer Insights Dashboard

A SQL-cleaned, Power BI-visualised analysis of a real UK online retail transaction dataset, built to identify sales trends, top-performing products, and customer distribution by country.

## Overview

This project takes a real, unclean transactional dataset and turns it into a reliable, decision-ready dashboard. The focus was on the data preparation as much as the visuals — a dashboard is only as trustworthy as the SQL underneath it.

**[Insert your dashboard screenshot here: `dashboard-overview.png`]**

## Dataset

- **Source:** [UCI Machine Learning Repository — Online Retail](https://archive.ics.uci.edu/dataset/352/online+retail)
- **Size:** 541,909 raw transaction records
- **Coverage:** A UK-based, non-store online retailer selling all-occasion gift-ware, December 2010 – December 2011
- **License:** CC BY 4.0

## Data Cleaning (SQL)

All cleaning and transformation was done in SQL against a local SQLite database, using DB Browser for SQLite. The full script is included in this repo: [`cleaning_script.sql`](./cleaning_script.sql).

Key cleaning steps:

- **Removed cancelled orders** — any `InvoiceNo` starting with `C`, which the dataset uses to flag cancellations
- **Removed invalid transactions** — rows with zero/negative `Quantity` or `UnitPrice`, which represent returns, errors, or non-sale adjustments
- **Removed transactions with no `CustomerID`** — these can't be attributed to a real customer and would distort customer-level analysis
- **Standardised country naming** — `EIRE` (the dataset's internal code) was renamed to `Ireland` for clarity
- **Calculated a `Revenue` column** (`Quantity × UnitPrice`) to support all downstream reporting

From the cleaned data, three summary tables were built directly in SQL:

| Table | Purpose |
|---|---|
| `sales_by_month` | Monthly revenue and order volume trend |
| `sales_by_product` | Revenue and units sold per product |
| `sales_by_country` | Revenue and customer count per country |

## Data Quality Notes

Two entries in the top-selling "products" list — **`POSTAGE`** and **`Manual`** — aren't physical products. They're administrative line items the retailer uses for shipping charges and manual account adjustments. I identified this while reviewing the top-10 output and made a deliberate decision to leave them in the dataset rather than filter them out, since removing data silently (without a documented reason) is worse practice than flagging a known quirk transparently. A future iteration of this project could split these out into a separate "non-product charges" category.

## Dashboard

Built in Power BI Desktop, the dashboard includes:

- **Total Revenue** — headline KPI card
- **Monthly Sales Trend** — line chart showing revenue across the full 13-month period
- **Top 10 Products by Revenue** — bar chart, filtered to the highest-performing items
- **Revenue by Country** — bar chart showing the geographic distribution of sales

## Tools Used

- **DB Browser for SQLite** — data cleaning, transformation, and SQL querying
- **SQL** — all cleaning logic, joins, and aggregation
- **Power BI Desktop** — dashboard design and visualisation

## Repository Contents

```
├── cleaning_script.sql       # Full SQL cleaning & transformation script
├── sales_by_month.csv        # Cleaned monthly summary table
├── sales_by_product.csv      # Cleaned product summary table
├── sales_by_country.csv      # Cleaned country summary table
├── retail-dashboard.pbix     # Power BI dashboard file
├── dashboard-overview.png    # Screenshot of the finished dashboard
└── README.md
```

## Author

**Ali Abdo**
[aliabdo.dev](https://aliabdo.dev) · [LinkedIn](https://www.linkedin.com/in/ali-abdo-164744298/) · [GitHub](https://github.com/Ali-Abdo03)
