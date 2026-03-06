-- creating table and columns

CREATE TABLE marketing_raw (
    campaign_id TEXT,
    company TEXT,
    campaign_type TEXT,
    target_audience TEXT,
    duration TEXT,
    channel_used TEXT,
    conversion_rate TEXT,
    acquisition_cost TEXT,
    roi TEXT,
    location TEXT,
    language TEXT,
    clicks TEXT,
    impressions TEXT,
    engagement_score TEXT,
    customer_segment TEXT,
    date TEXT
);

select count(*) from marketing_raw;

-- Data cleaning
-- 1.Changing data type


DROP TABLE IF EXISTS marketing_clean;
CREATE TABLE marketing_clean AS
SELECT
campaign_id::INT AS campaign_id,
company,
campaign_type,
target_audience,
REPLACE(duration,' days','')::INT AS duration_days,
channel_used,
conversion_rate::NUMERIC(5,2) AS conversion_rate,
REPLACE(REPLACE(acquisition_cost,'$',''),',','')::NUMERIC(12,2) AS acquisition_cost,
roi::NUMERIC(6,2) AS roi,
location,
language,
clicks::INT,
impressions::INT,
engagement_score::INT,
customer_segment,
date::DATE AS campaign_date   
FROM marketing_raw;

SELECT campaign_id, campaign_date
FROM marketing_clean
LIMIT 5;


-- creating dimention tables table
-- Campaign

CREATE TABLE dim_campaign AS
SELECT DISTINCT
    campaign_id,
    company,
    campaign_type,
    target_audience,
    duration_days
FROM marketing_clean;

SELECT COUNT(*) FROM dim_campaign;

-- Channel
DROP TABLE IF EXISTS dim_channel;

CREATE TABLE dim_channel AS
SELECT DISTINCT
    channel_used
FROM marketing_clean;

SELECT COUNT(*) FROM dim_channel;

-- location
DROP TABLE IF EXISTS dim_location;

CREATE TABLE dim_location AS
SELECT DISTINCT
    location
FROM marketing_clean;

SELECT COUNT(*) FROM dim_location;

-- customer segment
DROP TABLE IF EXISTS dim_customer_segment;

CREATE TABLE dim_customer_segment AS
SELECT DISTINCT
    customer_segment
FROM marketing_clean;

SELECT COUNT(*) FROM dim_customer_segment;

-- Date
DROP TABLE IF EXISTS dim_date;

CREATE TABLE dim_date AS
SELECT DISTINCT
    campaign_date AS date,
    EXTRACT(YEAR FROM campaign_date) AS year,
    EXTRACT(MONTH FROM campaign_date) AS month,
    EXTRACT(DAY FROM campaign_date) AS day
FROM marketing_clean;

SELECT COUNT(*) FROM dim_date;


-- creating fact table

DROP TABLE IF EXISTS fact_marketing;

CREATE TABLE fact_marketing AS
SELECT
    campaign_id,
    campaign_date,
    channel_used,
    location,
    customer_segment,

    impressions,
    clicks,
    acquisition_cost,
    conversion_rate,
    roi,
    engagement_score

FROM marketing_clean;

SELECT COUNT(*) FROM fact_marketing;


-- DATA ANALYSIS
-- Overall marketinf performance
SELECT
    SUM(acquisition_cost) AS total_spend,
    SUM(clicks) AS total_clicks,
    SUM(impressions) AS total_impressions,
    AVG(conversion_rate) AS avg_conversion_rate,
    AVG(roi) AS avg_roi
FROM fact_marketing;


UPDATE marketing_clean
SET roi = roi / 100;


SELECT roi
FROM marketing_clean
LIMIT 10;

-- adding revenue column
ALTER TABLE marketing_clean
ADD COLUMN revenue NUMERIC;

UPDATE marketing_clean
SET revenue = acquisition_cost * (1 + roi);

UPDATE marketing_clean
SET revenue = NULL;

UPDATE marketing_clean
SET revenue = acquisition_cost * (1 + roi)
WHERE roi IS NOT NULL;

SELECT 
SUM(revenue),
SUM(acquisition_cost * (1 + roi))
FROM marketing_clean;

SELECT acquisition_cost, roi, revenue
FROM marketing_clean
LIMIT 10;

-- TOTAL REVENUE
SELECT SUM(revenue)
FROM marketing_clean;

SELECT SUM(acquisition_cost * (1 + roi)) AS total_revenue
FROM marketing_clean;

-- Total marketing spend
SELECT SUM(acquisition_cost) AS total_spend
FROM marketing_clean;

-- Total Profit
SELECT SUM(revenue - acquisition_cost) FROM marketing_clean;

-- overall roi %
SELECT 
ROUND(
(SUM(revenue) - SUM(acquisition_cost))
/ SUM(acquisition_cost) * 100, 2
) AS overall_roi_percent
FROM marketing_clean;


-- AVG conversion rate

SELECT 
ROUND(AVG(conversion_rate) * 100, 2) AS avg_conversion_rate_percent
FROM marketing_clean;


-- channel performance

SELECT
    channel_used,
    COUNT(*) AS total_campaigns,
    SUM(acquisition_cost) AS total_spend,
    SUM(clicks) AS total_clicks,
    AVG(conversion_rate) AS avg_conversion_rate,
    AVG(roi) AS avg_roi
FROM fact_marketing
GROUP BY channel_used
ORDER BY avg_roi DESC;

--  best performing channel

SELECT
channel_used,
ROUND(AVG(roi) * 100, 2) AS roi_percent
FROM marketing_clean
GROUP BY channel_used
ORDER BY roi_percent DESC;


-- roi percentage
SELECT ROUND(roi, 2) AS roi_percent
FROM marketing_clean;

-- monthly trend analysis
SELECT
    DATE_TRUNC('month', campaign_date) AS month,
    SUM(acquisition_cost) AS total_spend,
    SUM(clicks) AS total_clicks,
    AVG(roi) AS avg_roi
FROM fact_marketing
GROUP BY month
ORDER BY month;

-- top best campaigns
SELECT
    campaign_id,
    SUM(acquisition_cost) AS spend,
    AVG(roi) AS roi
FROM fact_marketing
GROUP BY campaign_id
ORDER BY roi DESC
LIMIT 10;

-- location

SELECT
    location,
    SUM(acquisition_cost) AS total_cost,
    ROUND(
        (
            SUM(acquisition_cost * (1 + roi)) - SUM(acquisition_cost)
        ) / SUM(acquisition_cost) * 100,
        2
    ) AS roi_percent
FROM marketing_clean
GROUP BY location
ORDER BY roi_percent DESC;