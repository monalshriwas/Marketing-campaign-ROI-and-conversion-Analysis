# Marketing-campaign-ROI-and-conversion-Analysis
## Project Overview

This project analyzes the performance of digital marketing campaigns across multiple channels and locations. 
The objective is to evaluate campaign effectiveness, measure return on investment (ROI), and identify opportunities to improve marketing performance.
The analysis was performed using SQL for data preparation and Power BI for data modeling and visualization. A comprehensive dashboard was created to monitor marketing metrics such as revenue, cost, profit, conversions, and campaign performance.

## Problem Statement
Marketing teams invest heavily in multiple advertising channels but often struggle to understand which campaigns generate the highest return. This project aims to analyze campaign data to determine which marketing channels, campaign types, and locations produce the best results.

## Project Goals
- The analysis focuses on answering the following business questions:
- Which marketing channels generate the highest revenue?
- Which campaigns deliver the best ROI?
- How does marketing performance vary across locations?
- What is the overall conversion rate of campaigns?
- How effectively do impressions convert into clicks and conversions?
- What is the monthly trend of revenue generated from campaigns?

## Data Source
The dataset used in this project was obtained from Kaggle and contains simulated marketing campaign data.
The dataset includes the following fields:
- campaign_id
- company
-	campaign_type
-	target_audience
-	duration
-	impressions
- clicks
- acquisition_cost
- conversion_rate
- engagement_score
- roi
- channel_used
- location
- language
- customer_segment
- date

## Tools and Technologies
- SQL(PostgreSQL)
- Power BI
- Data Modeling
- Data Visualization

## Data Preparation

### Data preparation and transformation were performed using SQL.
Key steps included:
- Cleaning and structuring the dataset
- Creating derived metrics such as revenue and profit
- Calculating revenue using ROI and acquisition cost
- Creating dimension and fact tables for analytical modeling

Data Modeling

A star schema was implemented in Power BI to support efficient reporting.

Fact Table:
- fact_marketing
Dimension Tables:
- dim_channel
- dim_campaign_type
- dim_location
- dim_customer_segment
- dim_date

Relationships were modeled between the fact and dimension tables to enable flexible analysis across different business dimensions.

 ## Dashboard Features

An interactive Power BI dashboard was developed to monitor marketing campaign performance.

Key metrics included:
- Total Revenue
- Total Cost
- Total Profit
- Return on Investment (ROI)
- Average Conversion Rate
  
Visualizations included:

- ROI by Channel
- ROI by Location
- Revenue Trend Over Time
- Campaign Performance Table
- Marketing Funnel (Impressions → Clicks → Conversions)
- Channel Performance (Cost vs Revenue)

## Dashboard

![Dashboard](Dashboard%20Image/dashboard_overview.png)

## Key Insights

- The analysis shows that overall marketing campaigns generate a positive return on investment    with an average ROI of approximately 5%.
- Revenue performance across marketing channels is relatively consistent, with slight differences in ROI between channels. This suggests that marketing investments are distributed efficiently but may benefit from further optimization.
- The marketing funnel indicates that while impressions are high, only a small percentage convert into clicks and conversions, highlighting an opportunity to improve campaign targeting and engagement strategies.
- Location analysis shows similar campaign performance across major cities, suggesting that marketing strategies are performing consistently across regions.

## Recommendations
- Invest more budget in marketing channels that generate higher ROI.
- Improve campaign targeting to increase the conversion rate from clicks to conversions.
- Focus more on high-performing locations to maximize revenue.
- Continuously monitor campaign performance to optimize marketing strategy.
