# Customer Loyalty & Segmentation Analysis

**Customer Analytics & Predictive Modelling Project | 2025**

> *How can customer behaviour, loyalty points, spending patterns, and review sentiment be used to improve marketing strategy, customer value management, and sales performance?*

---

## Executive Summary

This project analyses customer loyalty, spending behaviour, segmentation opportunities, and review sentiment for a global games and entertainment retailer.

Using Python and R, the project investigates how customers accumulate loyalty points, whether customers can be segmented into commercially useful groups, and how customer review text can inform marketing and operational decision-making.

The analysis combines exploratory data analysis, regression modelling, decision trees, K-Means clustering, natural language processing, and R-based statistical modelling to create a practical customer value framework.

Key findings revealed that:

* Loyalty points are strongly and predictably driven by spending score and income
* The loyalty points distribution was right-skewed, with a distinct high-value customer group
* Approximately 13% of customers were high-value loyalty outliers
* Five distinct customer segments were identified, ranging from Affluent High Spenders to Low Income Low Spenders
* One large mid-income / mid-spend segment accounted for around 40% of customers
* Review sentiment was generally positive, with customers frequently referencing family-friendly value, product quality, and ease of use
* Negative reviews highlighted operational issues such as missing pieces and shipping-related problems
* Linear regression provided a strong, business-friendly model for predicting loyalty points

The final recommendations focused on targeted loyalty rewards, VIP treatment for high-value customers, activation campaigns for affluent low-spend customers, and operational improvements informed by review sentiment.

---

## Business Problem

A global games and entertainment retailer wanted to improve overall sales performance by understanding customer base more deeply, specifically loyalty behaviour, customer segmentation opportunities, and the business value of customer-generated review text.

The core business questions were:

* How do customers engage with and accumulate loyalty points?
* Can customers be segmented into meaningful groups for targeted marketing?
* Can loyalty points be predicted using customer attributes and spending behaviour?
* How can review sentiment be used to inform marketing campaigns and business improvements?
* Which customer groups should be prioritised to increase customer value?

The project was designed to support stakeholders responsible for:

* Loyalty programme strategy
* Marketing campaign targeting
* Customer value management
* Product and service improvement
* Sales performance optimisation

---

## Data Sources

| Source                       | Data Collected                                                                                     | Purpose                                             |
| ---------------------------- | -------------------------------------------------------------------------------------------------- | --------------------------------------------------- |
| **Customer Reviews Dataset** | Customer age, gender, income, education, spending score, loyalty points, review text and summaries | Loyalty modelling, segmentation, sentiment analysis |
| **Metadata File**            | Dataset structure, field descriptions and data quality reference                                   | Data validation and interpretation                  |

**Dataset structure:** 2,000 rows × 9 columns after cleaning. Importantly, the dataset contains 2,000 reviews from only 782 unique customers - customers who wrote multiple reviews. Demographic analysis was performed on unique customers only (782 rows) while predictive modelling used the full 2,000-row dataset.

The cleaned dataset contained:

* 2,000 review records
* 782 unique customers
* 9 core analytical fields
* Numeric customer attributes
* Customer-generated review and summary text

Key fields included:

| Field            | Description                       |
| ---------------- | --------------------------------- |
| `age`            | Customer age                      |
| `income`         | Customer income / remuneration    |
| `spending_score` | Customer spending behaviour score |
| `loyalty_points` | Loyalty programme points balance  |
| `gender`         | Customer gender                   |
| `education`      | Education category                |
| `review`         | Full customer review text         |
| `summary`        | Review summary text               |

---

## Tools & Skills Used

| Category                        | Tools / Libraries                                                        |
| ------------------------------- | ------------------------------------------------------------------------ |
| **Languages**                   | Python, R                                                                |
| **Python Data Processing**      | pandas, NumPy                                                            |
| **Python Visualisation**        | matplotlib, seaborn                                                      |
| **Machine Learning**            | Linear Regression, Decision Trees, K-Means Clustering                    |
| **Natural Language Processing** | Sentiment analysis, keyword extraction, review text analysis             |
| **R Analysis**                  | tidyverse, ggplot2, dplyr, skimr, DataExplorer, corrplot, moments, psych |
| **R Modelling**                 | Multiple Linear Regression, spline modelling, residual diagnostics       |
| **Model Evaluation**            | RMSE, MAE, R², residual analysis, train/test split                       |
| **Environment**                 | Jupyter Notebook, R script                                               |

**Skills demonstrated:**

Dual-language analysis (Python + R) · Customer segmentation · Predictive modelling · Regression analysis · Decision trees · K-Means clustering · NLP sentiment analysis · R statistical modelling · Python data analysis · Model diagnostics · Customer value analysis · Business recommendation development · Stakeholder-focused reporting

---


## Analytical Approach

The project followed a structured multi-stage analytical workflow combining Python-based modelling and R-based statistical analysis.

### 1. Data Cleaning & Preparation

The original customer review dataset was cleaned and prepared for analysis.

Key cleaning steps included:

* Checked for missing and 'null' values - None found
* Removed unnecessary columns such as 'language' and 'platform' - analytically irrelevant
* Renamed columns for clarity
* 'Customer ID's assigned - a `customer_id` column was created to identify the 782 unique customers (customer view) within the 2,000-row review (review level)  data
* Sanity checks performed on cleaned data before analysis
* Validated data structure and consistency
* Created a cleaned dataset for downstream analysis
* Unknown spending score calculation - flagged as a limitation - the formula for the spending score is not documented, making full interpretation of the variable difficult

The final cleaned dataset contained:

| Dataset View              | Rows          | Purpose                                        |
| ------------------------- | ------------- | ---------------------------------------------- |
| Full review-level dataset | 2,000 rows    | Modelling, sentiment, review behaviour         |
| Unique customer view      | 782 customers | Customer demographic and segmentation analysis |

> A key analytical decision was to use the review-level dataset for modelling loyalty points, while using the unique-customer dataset for demographic exploration to avoid overstating repeated customer records.

---

### 2. Exploratory Data Analysis

Exploratory analysis was conducted to understand customer demographics, spending behaviour, loyalty point distribution, and potential predictors.

The analysis investigated:

* Gender distribution
* Age distribution
* Income distribution
* Education categories
* Spending score patterns
* Loyalty point distribution
* Relationships between spending score, income, age, and loyalty points

Key observations included:

* Female customers represented approximately 56% of unique customers
* Male customers represented approximately 44% of unique customers
* Most customers were between 29 and 40 years old
* Income distribution showed several peaks, including lower-income customers and higher-income customer groups
* Loyalty points were right-skewed, with a notable high-value customer tail
* Spending score showed a stronger relationship with loyalty points than gender or education

---
### 2. Exploratory Data Analysis (Python)

Analysis conducted on unique customers (782 rows):

- **Gender:** 435 Female (56%), 347 Male (44%)
- **Education:** Graduates largest group (45%), Basic smallest (2%)
- **Age:** Majority aged 29–40; distribution is slightly right-skewed
- **Income:** Multimodal distribution — peaks at <£20k, ~£40k, and ~£70k, suggesting distinct income segments in the customer base
- **Loyalty points:** Right-skewed distribution; 266 customers (13%) are high-value outliers above 3,200 points

**Key finding:** Loyalty points are strongly correlated with spending score and income. The relationship is broadly linear up to a spending score of ~60, beyond which variance increases significantly — a useful signal for model selection.
---
### 3. Predictive Modelling

Predictive modelling was used to assess whether loyalty points could be estimated from customer attributes.

Models explored included:

| Model Type                      | Purpose                                                      |
| ------------------------------- | ------------------------------------------------------------ |
| Linear Regression               | Predict loyalty points using spending score, income, and age |
| Decision Trees                  | Explore non-linear customer value patterns                   |
| Multiple Linear Regression in R | Build a more interpretable statistical model                 |
| Spline Regression               | Test whether non-linear relationships improved model fit     |

The core predictive features were:

| Feature          | Role                                     |
| ---------------- | ---------------------------------------- |
| `spending_score` | Primary behavioural predictor            |
| `income`         | Customer value / affordability predictor |
| `age`            | Demographic predictor                    |

The R-based multiple linear regression model achieved strong explanatory power, with the model explaining approximately **84% of the variance** in loyalty points.

Diagnostic work included:

* Train/test split
* Residual analysis
* RMSE and MAE evaluation
* R² assessment
* Multicollinearity checks
* Normality testing
* Heteroscedasticity checks
* Robust standard error consideration

The analysis found that spending score was the strongest practical predictor of loyalty points, while income also contributed meaningfully.

---

### 4. Customer Segmentation

K-Means clustering was used to identify customer groups based on income and spending behaviour.

The clustering analysis explored both five- and six-cluster solutions, supported by elbow and silhouette methods.

The segmentation revealed:

* A large mid-income / mid-spend customer segment accounting for approximately 40% of customers
* High-income / high-spend customers suitable for premium campaigns
* High-income / low-spend customers representing an activation opportunity
* Lower-income / high-spend customers requiring value-focused offers and retention support
* High-loyalty outliers representing potential VIP or power-user segments

The segmentation was designed to support practical marketing actions rather than purely statistical grouping.

---

### 5. Sentiment & Review Text Analysis

Customer review text was analysed to understand sentiment, recurring customer themes, and potential operational improvement areas.

The analysis investigated:

* Most common review terms
* Positive review themes
* Negative review themes
* Sentiment distribution
* Customer pain points
* Marketing message opportunities

Key review insights included:

* Overall sentiment was skewed positively
* Customers frequently referenced family-friendly play, quality, and ease of use
* Negative reviews highlighted issues such as missing pieces and shipping problems
* Review text could be used to support marketing language and operational improvement priorities

---

### 6. R-Based Statistical Analysis

R was used to extend the analysis through deeper exploratory analysis, statistical diagnostics, and model evaluation.

The R analysis included:

* Summary statistics
* Correlation analysis
* Distribution analysis
* Boxplots by demographic variables
* Loyalty category analysis
* Animated visualisations using Plotly
* Multiple Linear Regression
* Spline modelling
* Residual diagnostics
* Model performance evaluation

The R analysis confirmed several Python findings:

* Spending score was strongly associated with loyalty points
* Gender differences were minimal in loyalty categories
* High loyalty customers typically had higher income and spending scores
* Very high loyalty point customers should be treated as a distinct strategic group

---

## Key Findings & Business Recommendations

### Finding 1: Spending Behaviour is the Strongest Loyalty Driver

Spending score showed the strongest relationship with loyalty points, outperforming demographic variables such as gender and education.

| Insight                                         | Business Meaning                                              |
| ----------------------------------------------- | ------------------------------------------------------------- |
| Spending score strongly predicts loyalty points | Loyalty programme rewards spending behaviour effectively      |
| Income adds useful signal                       | Higher-income customers may represent greater value potential |
| Gender differences are minimal                  | Gender-specific loyalty campaigns are unlikely to add value   |

#### Recommendation

Focus loyalty programme strategy on spending behaviour rather than demographic targeting alone.

---

### Finding 2: High-Value Loyalty Outliers Represent a VIP Segment

Approximately 13% of customers were high-value outliers in the loyalty points distribution.

Customers with loyalty points above approximately 3,200 represented a premium value group.

#### Recommendation

Create a VIP loyalty track for high-value customers, including:

* Early product access
* Exclusive events
* Tiered rewards
* Premium loyalty perks
* Personalised retention campaigns

---

### Finding 3: High-Income / Low-Spend Customers Are an Activation Opportunity

Some affluent customers had relatively low spending scores, suggesting untapped revenue potential.

#### Recommendation

Run activation campaigns for high-income but low-spend customers using:

* Awareness campaigns
* Premium bundles
* Personalised product recommendations
* Limited-time engagement offers

---

### Finding 4: Mid-to-High Spenders Offer Strong Growth Potential

Mid-to-high spending customers represented a realistic opportunity to increase basket value and loyalty engagement.

#### Recommendation

Develop targeted campaigns focused on:

* Cross-selling
* Personalised bundles
* Loyalty milestones
* Reward progression
* Repeat purchase incentives

---

### Finding 5: Review Sentiment Can Inform Marketing and Operations

Customer reviews were generally positive, but negative reviews highlighted practical operational problems.

| Review Theme                                   | Business Action                   |
| ---------------------------------------------- | --------------------------------- |
| Positive sentiment around family-friendly play | Reinforce in marketing messaging  |
| Positive references to quality and ease of use | Use in campaign language          |
| Negative comments about missing pieces         | Operational quality control focus |
| Shipping-related complaints                    | Logistics and fulfilment review   |

#### Recommendation

Use review sentiment as an ongoing customer listening tool to inform both marketing content and operational improvement priorities.

---

## Predictive Customer Scenarios

The R model was used to generate practical customer scenarios showing how different combinations of age, income, and spending score could translate into predicted loyalty point values.

| Scenario                   | Predicted Loyalty Points | Suggested Tactic                   |
| -------------------------- | ------------------------ | ---------------------------------- |
| High roller young customer | ~4,048                   | VIP programme                      |
| Older high spender         | ~3,532                   | Retention and loyalty perks        |
| Affluent average spender   | ~2,635                   | Upselling and premium bundles      |
| Young high spender         | ~2,593                   | Youth-focused engagement           |
| Low income, high spend     | ~1,718                   | Value bundles and loyalty perks    |
| High income, low spend     | ~1,397                   | Awareness and activation campaigns |

These scenarios translated model outputs into practical customer engagement strategies.

---

## Limitations

Several limitations were identified during the analysis:

* The dataset was relatively small at 2,000 review records and 782 unique customers
* The calculation method for spending score was unknown
* The method for accruing loyalty points was not fully defined
* Customer tenure, seasonality, promotion exposure, product category, and purchase frequency were unavailable
* Product numbers were not mapped to meaningful product categories
* Review text was available, but more structured sentiment labels would improve analysis
* Some high-value outliers may represent genuine VIP customers or unusual behaviour requiring further validation

Despite these limitations, the analysis produced a strong customer value framework suitable for marketing and loyalty strategy development.

---

## Future Steps

Potential future enhancements include:

* Customer lifetime value (CLV) modelling
* Product-level sentiment analysis
* Loyalty churn prediction
* Campaign response modelling
* Integration of purchase frequency and tenure data
* A/B testing framework for loyalty campaigns
* More advanced NLP sentiment modelling
* Product category mapping for review analysis
* Segment-level dashboard development
* Monthly monitoring of model performance using RMSE, MAE, and R²
* Further testing of income-spending interaction effects

---

## Deliverables

| Deliverable           | Description                                                                                            |
| --------------------- | ------------------------------------------------------------------------------------------------------ |
| Jupyter Notebook      | Python-based exploratory analysis, modelling, clustering, and sentiment workflow                       |
| R Script              | R-based exploratory analysis, visualisation, regression modelling, diagnostics, and scenario modelling |
| Technical Report      | Structured technical explanation of methods, findings, limitations, and recommendations                |
| Business Presentation | Stakeholder-focused summary of insight and recommendations                                             |

---

## About

This project was completed as part of the **LSE Data Analytics Career Accelerator (2025, Distinction)**.

The analysis focused on using customer loyalty, spending behaviour, segmentation, predictive modelling, and review sentiment to support commercial decision-making and customer value growth.

**Andrew Willacy**
[LinkedIn](https://www.linkedin.com/in/andrew-willacy-572682347/) | [GitHub Portfolio](https://github.com/AndrewWillacy) | [andrew.willacy.data@gmail.com](mailto:andrew.willacy.data@gmail.com)









# Customer Loyalty Analytics & Segmentation
**LSE Data Analytics Career Accelerator — DA301: Advanced Analytics for Organisational Impact | October 2025**

> *How do customers engage with loyalty points? Can they be segmented into actionable groups? And what can their own words tell us about how they experience the brand?*

---

## Executive Summary

This project analyses customer loyalty, behaviour, and sentiment for a global games retailer across 2,000 customer reviews from 782 unique customers. Using Python and R in parallel, the analysis identifies the key drivers of loyalty point accumulation, segments customers into distinct behavioural profiles, and applies NLP sentiment analysis to customer review text to surface satisfaction drivers and pain points.

**Key result:** Loyalty points are strongly and predictably driven by spending score and income. A linear regression model (R² = 0.839–0.844) offers robust, operationally usable predictions. Five distinct customer segments were identified, ranging from Affluent High Spenders to Low Income Low Spenders — each with different engagement profiles and commercial implications. Sentiment from reviews is predominantly positive, with family-friendly themes dominating; shipping and missing product pieces are the most frequently flagged pain points.

---

## Business Problem

A global games manufacturer and retailer wanted to improve overall sales performance by understanding its customer base more deeply. Four questions drove the analysis:

> **1. How do customers engage with and accumulate loyalty points?**
> **2. How can customers be segmented into groups for targeted marketing?**
> **3. How can customer review text inform marketing campaigns and business improvements?**
> **4. Can descriptive statistics justify the suitability of loyalty data for predictive modelling?**

---

## Data Source

| File | Contents |
|------|----------|
| `turtle_reviews.csv` | Customer gender, age, income, spending score, loyalty points, education, language, platform, product reviews and summaries |

**Dataset structure:** 2,000 rows × 9 columns after cleaning. Importantly, the dataset contains 2,000 reviews from only 782 unique customers — customers who wrote multiple reviews. Demographic analysis was performed on unique customers only (782 rows) while predictive modelling used the full 2,000-row dataset.

---

## Tools & Skills Used

| Category | Tools / Libraries |
|----------|------------------|
| **Languages** | Python 3, R |
| **Python Libraries** | pandas, NumPy, Matplotlib, Seaborn, scikit-learn, NLTK (TextBlob/VADER) |
| **R Libraries** | tidyverse, ggplot2, moments, lmtest, sandwich, car |
| **ML Models** | Linear Regression, Decision Trees (pruned), Random Forest, K-Means Clustering |
| **NLP** | Sentiment polarity scoring, tokenisation, stop word removal, word cloud generation |
| **Environment** | Jupyter Notebook (Python), R Script |

**Skills demonstrated:** Dual-language analysis (Python + R) · Regression modelling with diagnostic validation · Decision tree training, evaluation, and pruning · K-means clustering with Elbow and Silhouette validation · NLP sentiment analysis on unstructured text · Customer segmentation · Model selection and justification · Stakeholder-focused reporting

---

## Analytical Approach

### 1. Data Cleaning & Preparation

The raw dataset required cleaning before analysis:

- **Null values** checked — none found
- **Unnecessary columns removed** — `language` and `platform` dropped as analytically irrelevant
- **Columns renamed** for clarity
- **Customer IDs assigned** — a `customer_id` column was created to identify the 782 unique customers within the 2,000-row review dataset
- **Sanity checks** performed on cleaned data before analysis
- **Unknown spending score calculation** flagged as a limitation — the formula for the spending score is not documented, making full interpretation of the variable difficult

### 2. Exploratory Data Analysis (Python)

Analysis conducted on unique customers (782 rows):

- **Gender:** 435 Female (56%), 347 Male (44%)
- **Education:** Graduates largest group (45%), Basic smallest (2%)
- **Age:** Majority aged 29–40; distribution is slightly right-skewed
- **Income:** Multimodal distribution — peaks at <£20k, ~£40k, and ~£70k, suggesting distinct income segments in the customer base
- **Loyalty points:** Right-skewed distribution; 266 customers (13%) are high-value outliers above 3,200 points

**Key finding:** Loyalty points are strongly correlated with spending score and income. The relationship is broadly linear up to a spending score of ~60, beyond which variance increases significantly — a useful signal for model selection.

### 3. Regression Analysis (Python & R)

**Python — baseline models:**
- Three baseline linear regression models built using age, income, and spending score as predictors of loyalty points
- Residual analysis and scatter plots used to inspect model fit
- Correlation structure confirmed income and spending score as the dominant predictors

**R — advanced regression:**
- Multiple linear regression models built, including a base model and a spline model to capture non-linearity
- **Model diagnostic tools applied:** Shapiro–Wilk (normality), Breusch–Pagan (heteroscedasticity), HC3 robust standard errors (addressing heteroscedasticity in inference)
- Train/test splits used to report out-of-sample performance

| Metric | Value |
|--------|-------|
| R² (Python linear) | 0.839–0.844 |
| Out-of-sample RMSE | Reported from R train/test split |
| Key predictors | spending_score, income (age minor contributor) |

**Model selection rationale:** The linear model was recommended for operational use over the decision tree — it is interpretable, communicates well to non-technical stakeholders, and performs robustly on out-of-sample data. Spline models offered marginal improvement but at the cost of explainability.

### 4. Decision Trees & Random Forest (Python)

Three decision tree models (A, B, C) were trained and evaluated unpruned:

| Metric | Model A | Model B | Model C |
|--------|---------|---------|---------|
| Train MAE | 0.0 | 0.0 | 69.16 |
| Test MAE | 39.25 | 26.18 | 83.27 |
| Train R² | 1.000 | 1.000 | 0.989 |
| Test R² | 0.994 | 0.996 | 0.984 |
| RMSE (Test) | 100.98 | 79.94 | 161.55 |

**Model B selected** as the best all-rounder despite overfitting in the unpruned form. Model B was pruned to max depth = 3, balancing performance against overfitting.

**Feature importance (pruned tree):** Income (0.525) and spending_score (0.475) dominate; age contributes negligibly. A Random Forest was subsequently built, at which point age emerged as a slightly more useful predictor (importance 0.017 in the ensemble versus 0.0 in the pruned tree).

### 5. K-Means Clustering (Python)

**2D clustering (income and spending_score, k=5):**

Both Elbow and Silhouette methods agreed on k=5.

| Cluster | Segment Name | Income Profile | Spending Score | Size (n) | Key Insight |
|---------|-------------|---------------|----------------|----------|-------------|
| 0 | Affluent Big Spenders | High (~£73k) | High (82–97) | 356 | Key profit drivers |
| 1 | Moderate Mid-Market | Middle (~£44k) | Medium (34–61) | 774 | Largest group; stable, average spenders |
| 2 | Affluent Low Spenders | High (~£75k) | Very Low (1–39) | 330 | High potential; rich but disengaged |
| 3 | Budget High Spenders | Low (~£20k) | High (79–99) | 269 | Value-driven; loyal despite low income |
| 4 | Low Income Low Spenders | Low (~£20k) | Low (3–40) | 271 | Least commercially valuable segment |

**3D clustering (income, spending_score, age, k=6):**

Adding age as a third variable and re-running Elbow/Silhouette methods produced k=6. The 3D model adds age-based nuance — distinguishing younger affluent high spenders from older mid-age frugal spenders — at the cost of some interpretability. The k=5 model was recommended for marketing use; k=6 retained for analytical depth.

### 6. NLP Sentiment Analysis (Python)

Customer review text was processed and analysed:

- **Preprocessing:** Text lowercased, punctuation, numerics and stop words removed, text tokenised
- **Outputs:** Word cloud, most common words, top positive and negative words, sentiment polarity histogram
- **Overall sentiment:** Positively skewed — the majority of reviews are positive or neutral; a smaller but significant tail of negative reviews exists
- **Positive themes:** Family, fun, quality, kids, playing, love — consistent with a family-focused product range
- **Negative themes:** Shipping delays and missing product pieces were the most consistently flagged issues in negative reviews

---

## Key Findings

### Loyalty Point Drivers

| Finding | Detail |
|---------|--------|
| Primary predictors | Spending score and income explain the large majority of loyalty point variance |
| Distribution | Right-skewed; 266 customers (13%) are high-value outliers above 3,200 points |
| Predictive model | Linear regression R² = 0.839–0.844; robust, interpretable, recommended for operational use |
| Non-linearity | Relationship breaks down above spending score ~60; variance increases significantly at high scores |

### Customer Segments (k=5)

- **Affluent Low Spenders** (330 customers) represent the highest growth opportunity — high income, very low engagement
- **Budget High Spenders** (269 customers) demonstrate strong loyalty despite limited income — value-driven behaviour worth protecting
- **Mid-Market** (774 customers, 40% of the base) are the stable core — reliable but offer limited incremental value without targeted nudges

### Sentiment

- Overall sentiment is positive — the brand is broadly well-regarded
- Family-friendly, fun, quality themes dominate positive reviews
- Shipping failures and missing product pieces are the operational pain points most frequently surfaced in negative reviews — specific and actionable

---

## Business Recommendations

- **Activate Affluent Low Spenders** — run targeted awareness and re-engagement campaigns for the high-income, low-spend segment (Cluster 2). They have the means to spend more; the question is why they don't
- **VIP programme for outliers** — customers with ≥3,200 loyalty points represent premium value. Early-access drops, exclusive events, and tiered rewards would deepen their engagement
- **Protect Budget High Spenders** — these customers spend proportionally despite limited income; they are brand-loyal and should not be deprioritised in favour of wealthier segments
- **Fix the operational pain points** — missing pieces and shipping issues appear consistently in negative reviews. These are solvable problems that are actively undermining an otherwise positive brand perception
- **Lean into the family-friendly message** — "fun, quality, easy for kids" themes dominate positive sentiment. Marketing campaigns should amplify this, not dilute it
- **Deploy the linear model operationally** — use R²=0.839+ model to predict loyalty point accumulation for new customers and support targeted reward timing

---

## Limitations

- **Spending score unknown** — the formula for calculating the spending score is not documented. This limits interpretation of the variable and prevents understanding of what drives it
- **Loyalty point accrual unknown** — how loyalty points are earned is not specified, limiting the practical application of the predictive model
- **Small dataset** — 782 unique customers is a limited sample for generalisation; behaviours such as tenure, promotional exposure, and seasonality are not captured
- **Product data opaque** — product numbers are present but categories are not defined, making product-level sentiment analysis impossible
- **Review dataset is unbalanced** — 2,000 reviews from 782 customers means some customers are disproportionately represented in the sentiment analysis
- **Review platform unknown** — where and how reviews were collected is not documented, which could affect representativeness

---

## Further Analysis

- **Product categorisation** — map product numbers to product categories to enable product-level sentiment and sales analysis
- **Spending score reverse-engineering** — investigate whether spending score can be decomposed from other available variables to improve model interpretability
- **Extended demographic breakdowns** — analyse reviews and loyalty patterns by individual product, gender, age group, and education level
- **Tenure and recency** — incorporate customer tenure and recency of purchase to build a more complete RFM (Recency, Frequency, Monetary) model
- **Deeper R modelling** — explore additional spline configurations or mixed-effects models to improve out-of-sample performance on the high-variance tail (spending score >60)

---

## Repository Structure

```
├── data/
│   └── turtle_reviews_clean.csv
├── notebooks/
│   └── Willacy_Andrew_DA301_Assignment_Notebook.ipynb    # Python analysis
├── scripts/
│   └── Willacy_Andrew_DA301_Assignment_Rscript.R         # R analysis
├── report/
│   └── Willacy_Andrew_DA301_Assignment_Report.pdf
└── README.md
```

---

## Results Summary

| Question | Finding |
|----------|---------|
| How do customers accumulate loyalty points? | Spending score and income are the primary drivers; linear model R²=0.839–0.844 |
| How can customers be segmented? | Five distinct segments identified; Affluent Low Spenders the highest growth opportunity |
| What do reviews tell us? | Positive sentiment dominates; shipping and missing pieces are the key pain points to fix |
| Is loyalty data suitable for predictive modelling? | Yes — distribution is right-skewed but robust enough for linear modelling with appropriate diagnostics |

---

## About

This project was completed as part of the **LSE Data Analytics Career Accelerator (DA301: Advanced Analytics for Organisational Impact), October 2025**, achieving a score of 71/90. Analysis was conducted in both Python and R.

**Andrew Willacy**
[LinkedIn](https://www.linkedin.com/in/andrew-willacy-572682347/) | [GitHub Portfolio](https://github.com/AndrewWillacy) | andrew.willacy.data@gmail.com














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
<img width="500" height="350" alt="Screenshot 2026-03-01 130521" src="https://github.com/user-attachments/assets/38f1a422-40ed-4ad9-ae8a-f27bf095b182" />

* Achieved ~84% explained variance (R² ≈ 0.84).
<img width="400" height="210" alt="Screenshot 2026-03-01 125429" src="https://github.com/user-attachments/assets/b506b4bc-57f3-4e59-8a84-5699365d79cb" />

* Compared linear, spline, and tree-based models to balance performance and interpretability. Spline models marginally improve fit but add complexity with limited business benefit

#### Customer segmentation

* Applied K-Means clustering to identify distinct behavioural segments

* Defined clear customer groups including:

  * High-income, high-spend (VIP segment)

  * High-income, low-spend (high growth opportunity)

  * Mid-income, mid-spend (core revenue base)

<img width="500" height="300" alt="Screenshot 2026-02-28 203320" src="https://github.com/user-attachments/assets/3518d258-12fc-4ac4-914b-c914ce97626d" />
<img width="600" height="150" alt="Screenshot 2026-02-28 203343" src="https://github.com/user-attachments/assets/ef525ff5-fb45-4a32-b713-ffe7a3ff5829" />

* Applied K-Means clustering to identify distinct behavioural segments

<img width="600" height="330" alt="Screenshot 2026-02-28 202552" src="https://github.com/user-attachments/assets/8db621ec-5efa-49a0-a6aa-bd3a0e2b45df" />



#### Sentiment analysis

* Analysed review text using NLP techniques

* Identified operational pain points impacting customer satisfaction

<img width="600" height="320" alt="Screenshot 2026-03-01 125520" src="https://github.com/user-attachments/assets/307b9d0c-65fd-421a-bbe5-e3b4e9c8a941" />


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
