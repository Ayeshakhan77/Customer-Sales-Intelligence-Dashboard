# 📊 Customer Sales Intelligence Dashboard

> **End-to-end retail analytics project** — Python · PostgreSQL · Power BI

[![Python](https://img.shields.io/badge/Python-3.x-3776AB?style=flat&logo=python&logoColor=white)](https://python.org)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-336791?style=flat&logo=postgresql&logoColor=white)](https://postgresql.org)
[![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?style=flat&logo=powerbi&logoColor=black)](https://powerbi.microsoft.com)
[![Pandas](https://img.shields.io/badge/Pandas-EDA-150458?style=flat&logo=pandas&logoColor=white)](https://pandas.pydata.org)

---

## 🧩 Business Problem

A retail company needed to move from gut-feeling decisions to data-driven strategy. The core question:

> *"How can we leverage consumer shopping data to identify which customer segments drive the most revenue, which product categories to prioritize, and what will improve retention and profitability?"*

**Specific concerns the analysis addresses:**
- Which customer demographics generate the most revenue?
- Are discount campaigns helping revenue or eroding margins?
- Which product categories and channels deserve more investment?
- How can the existing loyal customer base be activated?

---

## 🗂️ Project Structure

```
customer-sales-intelligence/
│
├── data/
│   ├── raw/                    # Original dataset (CSV)
│   └── cleaned/                # Cleaned dataset (post-Python processing)
│
├── notebooks/
│   └── 01_eda_cleaning.ipynb   # Full EDA & data cleaning workflow
│
├── sql/
│   └── business_queries.sql    # 12 business-driven SQL queries
│
├── dashboard/
│   └── sales_dashboard.pbix    # Power BI dashboard file
│
└── README.md
```

---

## 🔄 Analytical Pipeline

```
Raw CSV (3,900 rows)
      │
      ▼
┌─────────────────────┐
│  Phase 1: Python    │  → Data cleaning, EDA, feature engineering
│  Pandas · Seaborn   │
└─────────────────────┘
      │
      ▼
┌─────────────────────┐
│  Phase 2: SQL       │  → 12 targeted business queries
│  PostgreSQL         │
└─────────────────────┘
      │
      ▼
┌─────────────────────┐
│  Phase 3: Power BI  │  → Interactive dashboard + insights report
│  DAX · Slicers      │
└─────────────────────┘
```

---

## 🧹 Data Cleaning Highlights (Python)

| Issue Found | Treatment Applied |
|---|---|
| Missing values | Median imputation for numeric; mode for categorical |
| Duplicate records | Identified and removed |
| Inconsistent strings | `.str.strip().str.title()` normalization on Gender, Season, Location |
| Outliers in Purchase Amount | IQR method — flagged for review |
| No age segmentation | `pd.cut()` to create Age Group bins (Under 36 / 36–55 / 55+) |

---

## 🔍 SQL Business Questions Answered

```sql
-- Sample: Revenue by age group
SELECT
  CASE
    WHEN age < 36 THEN 'Young (Under 36)'
    WHEN age BETWEEN 36 AND 55 THEN 'Mid-Aged (36-55)'
    ELSE 'Senior (55+)'
  END AS age_group,
  SUM(purchase_amount) AS total_revenue,
  AVG(purchase_amount) AS avg_spend,
  COUNT(*) AS total_orders
FROM customer_sales
GROUP BY age_group
ORDER BY total_revenue DESC;
```

**All 12 queries cover:**
- Gender revenue comparison
- Age group spend analysis
- Top product categories by revenue & order volume
- Discount impact on average purchase value
- Sales channel split (online vs. offline)
- Seasonal revenue patterns
- Loyalty and repeat purchase behavior
- Subscriber vs. non-subscriber revenue
- Shipping preference and basket value correlation
- Geographic revenue distribution

---

## 📈 Key Findings

| # | Finding | Impact |
|---|---|---|
| 1 | **Males generate higher total revenue** than females across all categories | 🔴 HIGH |
| 2 | **Male customers use discounts more but still spend above average** — discount-resilient buyers | 🔴 HIGH |
| 3 | **Mid-aged males (36–55) are the single highest-spending demographic** — top value segment | 🔴 HIGH |
| 4 | **Accessories & Footwear have the highest customer review ratings** of all categories | 🟡 MEDIUM |
| 5 | **Non-subscribers drive more total revenue** despite near-identical average spend — larger base | 🔴 HIGH |
| 6 | **Clothing is purchased with discounts more than any other category** — margin risk | 🔴 HIGH |
| 7 | **3,116 loyal customers identified** — currently underutilized retention asset | 🔴 HIGH |
| 8 | **Accessories lead all categories in total order volume** — highest purchase frequency | 🟡 MEDIUM |
| 9 | **Most repeat buyers are non-subscribers** — subscription conversion gap | 🔴 HIGH |
| 10 | **Young customers (under 36) generate the lowest revenue** across all segments | 🟡 MEDIUM |
| 11 | **Mid-aged group (36–55) dominates overall revenue** — core commercial audience | 🔴 HIGH |
| 12 | **Express shipping users spend slightly more** than standard shipping customers | 🟡 MEDIUM |
| 13 | **Clothing is #1 and Accessories #2 in spend across every age group** | 🟡 MEDIUM |
| 14 | **Mid-aged customers drive the highest Clothing revenue** of any group | 🔴 HIGH |

---

## 📊 Power BI Dashboard Features

- **KPI Cards** — Total Revenue, Total Orders, Average Purchase Amount, Loyal Customer Count
- **Revenue by Gender** — Bar chart comparison
- **Age Group Revenue** — Clustered bar across demographic segments
- **Category Performance** — Revenue + Order volume side-by-side
- **Discount Impact Analysis** — Average spend with vs. without discount, by category
- **Subscriber vs. Non-Subscriber** — Revenue and order count comparison
- **Shipping Type Analysis** — Express vs. Standard average basket value
- **Cross-filter Slicers** — Gender · Age Group · Season · Category · Channel

---

## 💡 Business Recommendations

**Priority 1 — Immediate (0–30 Days)**
- Launch targeted campaign for mid-aged male customers (36–55) on Clothing — no discount needed
- Activate 3,116 loyal customers with a structured retention/rewards program
- Add Express Shipping as a checkout upsell to lift average basket value

**Priority 2 — Short-Term (1–3 Months)**
- Introduce minimum basket thresholds for Clothing discounts to protect margin
- Target repeat non-subscriber buyers with a subscription trial offer
- Bundle Accessories with Clothing purchases to increase average order value

**Priority 3 — Strategic (3–6 Months)**
- Build a youth acquisition strategy with entry-level product pricing
- Use Footwear & Accessories satisfaction scores to power a referral program

---

## 🛠️ Tech Stack

| Tool | Purpose |
|---|---|
| Python 3 | Data cleaning, EDA, feature engineering |
| Pandas | DataFrame operations and transformations |
| Matplotlib & Seaborn | Exploratory visualizations |
| Jupyter Notebook | Reproducible analysis workflow |
| PostgreSQL 15 | Business query analysis |
| Power BI Desktop | Interactive dashboard |
| DAX | Custom KPI measures |

---

## 📁 Dataset

- **Size:** 3,900 rows · Customer transaction records
- **Type:** Structured, tabular (CSV)
- **Key columns:** Age, Gender, Purchase Amount, Product Category, Sales Channel, Discount Applied, Review Rating, Season, Frequency of Purchase, Subscription Status, Shipping Type

---

## 🚀 How to Run

```bash
# 1. Clone the repository
git clone https://github.com/yourusername/customer-sales-intelligence.git
cd customer-sales-intelligence

# 2. Install Python dependencies
pip install pandas matplotlib seaborn jupyter

# 3. Open the notebook
jupyter notebook notebooks/01_eda_cleaning.ipynb

# 4. For SQL: load cleaned CSV into PostgreSQL, then run
psql -d your_database -f sql/business_queries.sql

# 5. For dashboard: open dashboard/sales_dashboard.pbix in Power BI Desktop
```

---

## 📬 Contact

**DataLens Analytics**
- 🔗 LinkedIn: [linkedin.com/in/yourprofile](https://linkedin.com/in/yourprofile)
- 🌐 Portfolio: [datalensanalytics.com](https://datalensanalytics.com)
- 📧 Email: hello@datalensanalytics.com

---

*Built as part of a professional data analytics portfolio. All data is used for analytical and educational purposes.*
