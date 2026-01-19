SELECT *
FROM weebb
LIMIT 10;

ALTER TABLE weebb
CHANGE COLUMN `ï»¿dex_trade_time` dex_trade_time DATETIME;

ALTER TABLE weebb
MODIFY COLUMN `ï»¿dex_trade_time` VARCHAR(50);

UPDATE weebb
SET `ï»¿dex_trade_time` = STR_TO_DATE(`ï»¿dex_trade_time`, '%c/%e/%Y %H:%i');

ALTER TABLE weebb
CHANGE COLUMN `ï»¿dex_trade_time` dex_trade_time DATETIME;

ALTER TABLE weebb
ADD COLUMN month_number INT,
ADD COLUMN month_name VARCHAR(20),
ADD COLUMN weekday_name VARCHAR(20);

UPDATE weebb
SET 
  month_number = MONTH(dex_trade_time),
  month_name = MONTHNAME(dex_trade_time),
  weekday_name = DAYNAME(dex_trade_time);
  
ALTER TABLE weebb
ADD COLUMN gas_cost_eth DECIMAL(30, 18);

UPDATE weebb
SET gas_cost_eth = (gas_used * gas_price) / 1000000000000000000;

-- Query for Most Traded Tokens on DEX
-- Most sold tokens
SELECT 
  token_sold_symbol AS token_symbol,
  COUNT(*) AS times_sold,
  ROUND(SUM(dex_trade_usd), 2) AS total_value_sold_usd
FROM weebb
GROUP BY token_sold_symbol
ORDER BY times_sold DESC;

-- Most bought tokens
SELECT 
  token_bought_symbol AS token_symbol,
  COUNT(*) AS times_bought,
  ROUND(SUM(dex_trade_usd), 2) AS total_value_bought_usd
FROM weebb
GROUP BY token_bought_symbol
ORDER BY times_bought DESC;

--  Gas Usage and Success Rate
SELECT 
    success AS transaction_success,
    ROUND(AVG(gas_used), 2) AS avg_gas_used,
    ROUND(AVG(gas_price), 2) AS avg_gas_price,
    COUNT(*) AS total_transactions
FROM weebb
GROUP BY success;

-- ----------------Price Impact Analysis--------------------

-- Which has higher average trade value — NFTs or DEX tokens?
SELECT 
  ROUND(AVG(dex_trade_usd), 2) AS avg_dex_trade_usd,
  ROUND(AVG(nft_trade_usd), 2) AS avg_nft_trade_usd
FROM weebb;

-- average trade value trend across months. For NFTs and DEX
SELECT 
  month_name,
  ROUND(AVG(dex_trade_usd), 2) AS avg_dex_trade_usd,
  ROUND(AVG(nft_trade_usd), 2) AS avg_nft_trade_usd
FROM weebb
GROUP BY month_number, month_name
ORDER BY month_number;

-- -----------Top Wallet Addresses----------------
-- Top 10 wallets with the most transactions

SELECT 
    tx_from_address AS wallet_address, 
    COUNT(*) AS total_count,
    ROUND(SUM(dex_trade_usd), 2) AS total_amount
FROM weebb
GROUP BY tx_from_address
ORDER BY total_amount DESC
LIMIT 10;

-- Top 10 sellers
SELECT 
    tx_from_address AS wallet_address, 
    COUNT(nft_tx) AS total_count,
    ROUND(SUM(nft_trade_usd), 2) AS total_amount
FROM weebb AS nft
GROUP BY tx_from_address
ORDER BY total_amount DESC
LIMIT 10;

-- Comparing wallet activities on both dex and NFT platform

WITH DEX AS (
    SELECT 
        tx_from_address AS wallet_address, 
        COUNT(*) AS total_count,
        ROUND(SUM(dex_trade_usd), 2) AS total_amount
    FROM weebb
    GROUP BY tx_from_address
    ORDER BY total_amount DESC
    LIMIT 10
),

NFT AS (
    SELECT 
        tx_from_address AS wallet_address, 
        COUNT(*) AS total_count,
        ROUND(SUM(nft_trade_usd), 2) AS total_amount
    FROM weebb
    GROUP BY tx_from_address
    ORDER BY total_amount DESC
    LIMIT 10
)

SELECT 
    d.wallet_address, 
    d.total_count, 
    d.total_amount,
    COALESCE(n.total_count, 0) AS nft_total_count,
    COALESCE(n.total_amount, 0) AS nft_total_amount
FROM DEX AS d 
LEFT JOIN NFT AS n
ON d.wallet_address = n.wallet_address;


-- A. Trade Volume by Month
SELECT 
  month_number,
  month_name,
  COUNT(trade_tx) AS total_transactions,
  COUNT(nft_tx) AS total_nft_trans,
  ROUND(SUM(dex_trade_usd), 2) AS total_dex_trade_usd,
  ROUND(SUM(nft_trade_usd), 2) AS total_nft_trade_usd
FROM weebb
GROUP BY month_number, month_name
ORDER BY month_number;

-- Trade volume by week
SELECT 
    weekday_name, 
    COUNT(trade_tx) AS total_transactions,
    ROUND(SUM(dex_trade_usd), 2) AS total_dex_value
FROM weebb
GROUP BY weekday_name
ORDER BY total_dex_value DESC;

SELECT 
    weekday_name, 
    COUNT(nft_tx) AS total_transactions,
    ROUND(SUM(nft_trade_usd), 2) AS total_dex_value
FROM weebb
GROUP BY weekday_name
ORDER BY total_dex_value DESC;

SELECT 
    weekday_name, 
    COUNT(trade_tx) AS dex_count,
    COUNT(nft_tx) AS nft_count,
    ROUND(SUM(dex_trade_usd), 2) AS total_dex_value,
    ROUND(SUM(nft_trade_usd), 2) AS total_nft_value
FROM weebb
GROUP BY weekday_name
ORDER BY total_dex_value DESC, total_nft_value DESC;

-- gas price analysis by weekdays
SELECT weekday_name, COUNT(*) AS total_transaction,
		MAX(gas_price) AS highest, 
        MIN(gas_price) AS lowest,
        AVG(gas_price) AS average
FROM weebb
GROUP BY weekday_name
ORDER BY lowest ASC;

-- ---------- Token Type Breakdown --------------------
-- Token Types and Trade Trends
SELECT 
    nft_token AS nft_token_standard, 
    COUNT(*) AS total_trades,
    ROUND(SUM(nft_trade_usd),2) AS total_nft_trade_usd
FROM weebb
GROUP BY nft_token
ORDER BY total_trades DESC;

