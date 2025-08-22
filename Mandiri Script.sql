--- 1. KPI Overview ---

--- Total User ---
SELECT COUNT(*) AS total_users
FROM users_data;

--- Total Cards Issued ---
SELECT COUNT(*) AS total_cards
FROM cards_data;

-- Card Type Distribution --
SELECT 
    card_type,
    COUNT(*) AS total_cards,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percent_of_total
FROM cards_data
GROUP BY card_type
ORDER BY total_cards DESC;

-- Total Transaction ---
SELECT COUNT(*) AS total_transactions
FROM transactions_data;

-- Total Transaction Amount
SELECT 
    SUM(REPLACE(amount, '$', '')::NUMERIC) AS total_transaction_amount
FROM transactions_data;

-- Average Transaction Amount
SELECT 
    AVG(REPLACE(amount, '$', '')::NUMERIC) AS avg_transaction_amount
FROM transactions_data;

-- Transaction by Gender --
SELECT 
    u.gender,
    COUNT(t.id) AS total_transactions,
    SUM(REPLACE(REPLACE(t.amount, '$', ''), ',', '')::NUMERIC) AS total_spend,
    AVG(REPLACE(REPLACE(t.amount, '$', ''), ',', '')::NUMERIC) AS avg_transaction_amount
FROM users_data u
JOIN transactions_data t 
    ON u.id = t.client_id
GROUP BY u.gender
ORDER BY total_spend DESC;

-- Transaction by Card Type per Gender --
SELECT 
    u.gender,
    c.card_type,
    COUNT(t.id) AS total_transactions,
    SUM(REPLACE(REPLACE(t.amount, '$', ''), ',', '')::NUMERIC) AS total_spend,
    AVG(REPLACE(REPLACE(t.amount, '$', ''), ',', '')::NUMERIC) AS avg_transaction_amount
FROM transactions_data t
JOIN users_data u
    ON t.client_id = u.id
JOIN cards_data c
    ON t.card_id = c.id
GROUP BY u.gender, c.card_type
ORDER BY u.gender, total_spend DESC;


-- Chip Security --
SELECT COUNT(*) AS dark_web_cards
FROM cards_data
WHERE card_on_dark_web = 'No';

-- Distribution of transaction types
SELECT 
    use_chip,
    COUNT(*) AS transaction_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percent_of_total
FROM transactions_data
GROUP BY use_chip
ORDER BY transaction_count DESC;


--- 2. Trend Overview ---

--- Transaction Over Time ---
SELECT 
    DATE_TRUNC('month', date::date) AS month,
    COUNT(*) AS total_transactions
FROM transactions_data
GROUP BY month
ORDER BY month;

--- Chip Usage Over Time ---
SELECT 
    DATE_TRUNC('month', date::date) AS month,
    use_chip,
    COUNT(*) AS transaction_count
FROM transactions_data
GROUP BY month, use_chip
ORDER BY month, use_chip;

--- Error Over Time ---
SELECT 
    DATE_TRUNC('month', date::date) AS month,
    COUNT(*) FILTER (WHERE errors IS NOT NULL AND errors <> '') AS error_transactions,
    COUNT(*) AS total_transactions,
    ROUND(100.0 * COUNT(*) FILTER (WHERE errors IS NOT NULL AND errors <> '') / COUNT(*), 2) AS error_rate_percent
FROM transactions_data
GROUP BY month
ORDER BY month;

-- Customer Growth --
SELECT 
    DATE_TRUNC('month', TO_DATE(acct_open_date, 'MM/YYYY')) AS month,
    COUNT(*) AS new_cards
FROM cards_data
GROUP BY month
ORDER BY month;

-- Debt to Income Ratio --
SELECT 
    current_age AS age,
    AVG(REPLACE(REPLACE(total_debt, '$', ''), ',', '')::NUMERIC) AS avg_debt,
    AVG(REPLACE(REPLACE(yearly_income, '$', ''), ',', '')::NUMERIC) AS avg_income,
    ROUND(
        AVG(REPLACE(REPLACE(total_debt, '$', ''), ',', '')::NUMERIC) 
        / NULLIF(AVG(REPLACE(REPLACE(yearly_income, '$', ''), ',', '')::NUMERIC), 0),
        2
    ) AS debt_to_income_ratio
FROM users_data
GROUP BY current_age
ORDER BY current_age;

--- 3. Geographic

-- Users by location (lat/long for mapping)
SELECT 
    latitude,
    longitude,
    COUNT(*) AS user_count,
    AVG(REPLACE(REPLACE(yearly_income, '$', ''), ',', '')::NUMERIC) AS avg_income,
    AVG(credit_score) AS avg_credit_score
FROM users_data
GROUP BY latitude, longitude;

-- Merchant by City/State
-- Merchant activity by city/state
SELECT 
    merchant_city,
    merchant_state,
    COUNT(*) AS total_transactions,
    SUM(REPLACE(REPLACE(amount, '$', ''), ',', '')::NUMERIC) AS total_spend
FROM transactions_data
GROUP BY merchant_city, merchant_state
ORDER BY total_spend DESC;
