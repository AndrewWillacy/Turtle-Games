## 🐢 Turtle Games: Customer Segmentation and Loyalty Modelling

Author: Andrew Willacy  
Date: October 2025  
Tools: Python, R, Jupyter Notebook, tidyverse, ggplot2, scikit-learn, NLP  
Techniques: Customer segmentation, regression modelling, predoctive modelling, clustering (K-Means), sentiment analysis

### 🚩 Business Problem

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
  
* Compared linear, spline, and tree-based models to balance performance and interpretability. Spline models marginally improve fit but add complexity with limited business benefit

#### Customer segmentation

* Applied K-Means clustering to identify distinct behavioural segments

* Defined clear customer groups including:

  * High-income, high-spend (VIP segment)

  * High-income, low-spend (high growth opportunity)

  * Mid-income, mid-spend (core revenue base)

<img width="600" height="330" alt="Screenshot 2026-02-28 202552" src="https://github.com/user-attachments/assets/8db621ec-5efa-49a0-a6aa-bd3a0e2b45df" />



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

### 💡 Business Recommendations

* Target high-income, low-spend customers with tailored engagement campaigns

* Introduce VIP loyalty tiers for high-value customers

* Use segmentation to personalise offers and increase retention

* Monitor sentiment trends to identify operational improvement opportunities

* Deploy predictive models to forecast customer value and guide marketing investment

### 🚀 Next Steps

* Customer Segmentation: Refine clustering with additional behavioural features such as tenure, purchase frequency, and seasonality.

* Predictive Modelling: Extend modelling to predict churn risk and future customer lifetime value.

* Loyalty Programme Optimisation: Simulate alternative loyalty point structures and reward thresholds.

* Product-Level Analysis: Link reviews and sentiment to specific product categories to identify strengths and weaknesses.

* Automated Pipelines: Build a reproducible Python/R pipeline for data ingestion, cleaning, modelling, and reporting.

* Dashboard Development: Create interactive dashboards to monitor loyalty metrics, segments, and sentiment trends.

### 🚚 Technical Deliverables

* Python notebook: full data analysis, modelling, clustering, NLP

* R analysis: regression modelling and statistical validation

* Written report: methodology, findings, and recommendations
