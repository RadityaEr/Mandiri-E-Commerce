# 📊 Financial Data Analysis Queries

This repository contains SQL queries for analyzing **user, card, and transaction data**.  
The queries are designed to provide insights into **key KPIs, trends, and geographic patterns**.  

---
## 📊 Dashboard

The interactive dashboard summarizing this analysis is available here:  
👉 [View Looker Studio Dashboard](https://lookerstudio.google.com/your-dashboard-link)

## 🔑 1. KPI Overview

### User & Card Metrics
- **Total Users** – Count of all registered users.  
- **Total Cards Issued** – Count of all issued cards.  
- **Card Type Distribution** – Breakdown of card types and their percentage share.  

### Transaction Metrics
- **Total Transactions** – Count of all transactions.  
- **Total Transaction Amount** – Sum of all transaction values.  
- **Average Transaction Amount** – Average spend per transaction.  
- **Transactions by Gender** – Volume, spend, and average spend by gender.  
- **Transactions by Gender & Card Type** – Segmented insights combining gender and card type.  

### Security & Usage
- **Chip Security** – Count of cards flagged/not flagged on the dark web.  
- **Transaction Method Distribution** – Share of transactions using chip vs. other methods.  

---

## 📈 2. Trend Overview

### Time-based Insights
- **Transactions Over Time** – Monthly transaction volume trend.  
- **Chip Usage Over Time** – Adoption and usage trend of chip transactions.  
- **Error Rate Over Time** – Share of failed/error transactions monthly.  
- **Customer Growth** – Monthly count of new card accounts.  

### Financial Health
- **Debt-to-Income Ratio by Age** – Average debt vs. income across user age groups.  

---

## 🌍 3. Geographic Overview

- **Users by Location (Lat/Long)** – User distribution with average income and credit score (for mapping).  
- **Merchant Activity by City/State** – Transaction volume and spend by merchant location.  

---

## 🗄️ Dataset

The dataset used for these queries is available here:  
👉 [Google Drive Link](https://drive.google.com/drive/folders/14U87BRaPXvv-l9E7dysGqY0VjVv4lxKP?usp=drive_link)

It includes:
- `users_data` – User demographics and financial attributes.  
- `cards_data` – Card issuance and attributes.  
- `transactions_data` – Transaction details.  

---

## 🚀 How to Run the Queries

Download the dataset from the link above.  
Load the CSV files into your database (PostgreSQL recommended):  

```sql
\copy users_data FROM 'path/to/users_data.csv' DELIMITER ',' CSV HEADER;
\copy cards_data FROM 'path/to/cards_data.csv' DELIMITER ',' CSV HEADER;
\copy transactions_data FROM 'path/to/transactions_data.csv' DELIMITER ',' CSV HEADER;
```

Open a SQL client such as **pgAdmin, DBeaver, or psql CLI**.  
Copy and paste the queries from this repo into your SQL client.  
Run the queries to generate results.  

---

## 📌 Notes

- Monetary fields (e.g., `"$1,200"`) are stored as strings and converted into numeric values for calculations.  
- Date fields are truncated to **monthly granularity** for trend analysis.  
- Queries are optimized for **PostgreSQL** but can be adapted for other SQL databases.  

---

## 📜 License
This project is open-source and available under the [MIT License](LICENSE).  
