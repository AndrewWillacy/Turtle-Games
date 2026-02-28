## 🐢 Turtle Games: Customer Segmentation and Loyalty Modelling

Author: Andrew Willacy  
Date: October 2025  
Tools: Python, R, Jupyter Notebook, tidyverse, ggplot2, scikit-learn, NLP  
Techniques: Customer segmentation, regression modelling, predoctive modelling, clustering (K-Means), sentiment analysis

### Business Problem

Turtle Games  is a global manufacturer and retailer of games, books, toys, and video games. They collected large volumes of customer transaction and review data but lacked clear insight into:
* Which customers drive the most value
* How customers engage with and accumulate loyalty points
* The process required to segment customers for targeted marketing
* Where marketing efforts should focus to maximise engagement and retention
* The use of customer reviews to inform marketing campaigns

This analysis aims to resolve that.

### 📊 Data Sources

The cleaned dataset (turtle_reviews_clean.csv) contains:

* 2,000 reviews from 782 unique customers

* Demographic features: age, gender, education, income

* Behavioural features: spending score, loyalty points

* Text data: customer review and summary fields

The data was supplied in raw format and required cleaning, validation, and restructuring prior to analysis.

### 🧮 Analytical Approach

A full end-to-end analytics workflow was implemented:

#### Data preparation

* Cleaned and validated customer and review datasets (2,000 reviews, 782 customers)

* Removed duplicates, standardised formats, and validated demographic and behavioural fields

* Created derived variables including loyalty tiers and customer segments

#### Exploratory analysis

* Analysed relationships between income, spending score, and loyalty accumulation

* Identified outliers and behavioural trends across demographic groups

#### Predictive modelling

* Built regression models to predict loyalty points

* Achieved ~84% explained variance (R² ≈ 0.84).
* 
* Compared linear, spline, and tree-based models to balance performance and interpretability. Spline models marginally improve fit but add complexity with limited business benefit

#### Customer segmentation

* Applied K-Means clustering to identify distinct behavioural segments

* Defined clear customer groups including:

* High-income, high-spend (VIP segment)

* High-income, low-spend (high growth opportunity)

* Mid-income, mid-spend (core revenue base)

#### Sentiment analysis

* Analysed review text using NLP techniques

* Identified operational pain points impacting customer satisfaction

### 🔍 Key Findings

#### 📌 Customer Behaviour & Loyalty:

Top ~13% of customers hold disproportionately high loyalty points

Spending score and income were the strongest predictors of loyalty

#### 📌 Clear opportunity segment identified

High-income customers with low spend represent strong growth potential

#### 📌 Segmentation enables targeted strategy

Distinct customer clusters allow tailored engagement and loyalty strategies

#### 📌 Sentiment analysis revealed operational improvement areas

Negative sentiment highlighted issues such as fulfilment and delivery reliability



🔍 Key Findings
📌 Customer Behaviour & Loyalty

Loyalty points are right-skewed, with most customers holding fewer than 2,000 points

Approximately 13% of customers are high-value outliers (≥3,200 points)

Spending score and income are the strongest predictors of loyalty points

Gender has minimal impact on loyalty outcomes

📌 Predictive Modelling

A linear regression model explains ~84% of the variance in loyalty points

Spline models marginally improve fit but add complexity with limited business benefit

The linear model offers the best balance of performance and interpretability

📌 Customer Segmentation

Distinct customer clusters exist based on income, spending score, and age

One large mid-income / mid-spend segment accounts for ~40% of customers

High-income, low-spend customers represent a key activation opportunity

High-spend, high-income customers form a clear VIP segment

📌 Sentiment Analysis

Customer sentiment is predominantly positive

Negative sentiment highlights operational issues such as missing items and delivery problems

Review text provides valuable qualitative insight not captured by numeric data alone

💡 Recommendations

Activate High-Potential Customers
Target high-income, low-spend customers with awareness and engagement campaigns.

Strengthen Mid-to-High Loyalty Segments
Use personalised bundles, cross-sell offers, and milestone rewards to increase frequency and basket size.

Develop a VIP Loyalty Track
Customers with ≥3,200 loyalty points should receive exclusive benefits and early access incentives.

Address Operational Pain Points
Use sentiment insights to reduce issues linked to negative reviews.

Monitor Model Performance Over Time
Track predictive accuracy and sentiment trends at segment level.

🚀 Next Steps

Customer Segmentation: Refine clustering with additional behavioural features such as tenure, purchase frequency, and seasonality.

Predictive Modelling: Extend modelling to predict churn risk and future customer lifetime value.

Loyalty Programme Optimisation: Simulate alternative loyalty point structures and reward thresholds.

Product-Level Analysis: Link reviews and sentiment to specific product categories to identify strengths and weaknesses.

Automated Pipelines: Build a reproducible Python/R pipeline for data ingestion, cleaning, modelling, and reporting.

Dashboard Development: Create interactive dashboards to monitor loyalty metrics, segments, and sentiment trends.
