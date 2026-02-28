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

### 📁 Analytical Approach
A full end-to-end analytics workflow was implemented:

Data preparation

Cleaned and validated customer and review datasets (2,000 reviews, 782 customers)

Removed duplicates, standardised formats, and validated demographic and behavioural fields

Created derived variables including loyalty tiers and customer segments

Exploratory analysis

Analysed relationships between income, spending score, and loyalty accumulation

Identified outliers and behavioural trends across demographic groups

Predictive modelling

Built regression models to predict loyalty points

Achieved ~84% explained variance (R² ≈ 0.84)

Compared linear, spline, and tree-based models to balance performance and interpretability

Customer segmentation

Applied K-Means clustering to identify distinct behavioural segments

Defined clear customer groups including:

High-income, high-spend (VIP segment)

High-income, low-spend (high growth opportunity)

Mid-income, mid-spend (core revenue base)

Sentiment analysis

Analysed review text using NLP techniques

Identified operational pain points impacting customer satisfaction




🎯 Objectives

Understand customer demographics and spending behaviour

Analyse how loyalty points are accumulated

Identify and profile distinct customer segments

Predict loyalty points using statistical and machine-learning models

Analyse customer sentiment from reviews

Provide data-driven recommendations to improve customer value

📄 Deliverables
File	Description
Willacy_Andrew_DA301_Report.pdf	Full technical report covering methodology, analysis, findings, and recommendations
Willacy_Andrew_DA301_Assignment_Notebook.ipynb	Reproducible Python analysis (EDA, modelling, clustering, NLP)
Willacy_Andrew_DA301_Assignment.R	Exploratory analysis and regression modelling conducted in R
📊 Data Sources

The cleaned dataset (turtle_reviews_clean.csv) contains:

2,000 reviews from 782 unique customers

Demographic features: age, gender, education, income

Behavioural features: spending score, loyalty points

Text data: customer review and summary fields

The data was supplied in raw format and required cleaning, validation, and restructuring prior to analysis.

🧹 Data Cleaning & Preparation

Key steps included:

Removing duplicates and irrelevant fields

Standardising variable names and formats

Handling missing values and validating ranges

Creating derived fields (e.g. loyalty categories, age bands)

Separating unique customers from repeat reviews where appropriate

The final dataset was validated for consistency before modelling.

🧮 Analytical Approach

A multi-method analytical approach was applied:

Exploratory Data Analysis (EDA):
Distributions, correlations, outliers, and demographic breakdowns

Regression Modelling:

Multiple Linear Regression

Spline Regression

Model diagnostics (Shapiro–Wilk, Breusch–Pagan, robust standard errors)

Train/test evaluation using RMSE, MAE, and R²

Tree-Based Models:
Decision Trees and Random Forests to assess non-linear effects and feature importance

Clustering:
K-Means clustering (Elbow & Silhouette methods) to identify customer segments

Natural Language Processing (NLP):
Sentiment analysis of customer reviews and word-frequency exploration

R Analysis:
Parallel exploratory and regression analysis to validate findings and compare methodologies

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
