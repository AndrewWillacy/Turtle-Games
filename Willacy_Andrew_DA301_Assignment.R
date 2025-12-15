###############################################################################
# LSE Data Analytics Online Career Accelerator 
# DA301: Advanced Analytics for Organisational Impact
# Week 5 Assignment - Exploratory Data Analysis in R
#
###############################################################################
########################### ASSIGNMENT 5 SCENARIO #############################
###############################################################################

# Turtle Games’s sales department has historically preferred to use R for sales
# analyses. You are tasked with performing exploratory data analysis (EDA) to
# investigate customer behaviour and loyalty points, using the cleaned dataset.
# Insights will help the sales team improve their understanding of customers.

###############################################################################
############################ ASSIGNMENT OBJECTIVE #############################
###############################################################################

# 1. Load and wrangle the data
# 2. Perform EDA: summary statistics and visualisations
# 3. Explore patterns, distributions, outliers
# 4. Comment on insights that may require further investigation
# 5. Make observations and recommendations for the business

###############################################################################
############################# 1. SETUP ########################################
###############################################################################

# Install packages 
install.packages(c("stringr","tidyverse","readxl","readr","openxlsx","ggplot2",
                   "skimr","DataExplorer","scales","corrplot","moments","dplyr"))

# Load libraries
library(tidyverse)
library(ggplot2)
library(dplyr)
library(skimr)
library(DataExplorer)
library(scales)
library(corrplot)
library(moments)
library(stringr)
library(tibble)
library(plotly)
library(htmlwidgets)

###############################################################################
############################ 2. LOAD & EXPLORE DATA ###########################
###############################################################################

# Prompt the user to choose the CSV file interactively
reviews_r <- read.csv(file.choose(), header = TRUE)
# ('turtle_reviews_clean')

# Preview
head(reviews_r)
summary(reviews_r)
dim(reviews_r)   # 2000 rows, 9 columns presnt as expected

str(reviews_r)  # gives a compact summary of the dataset
glimpse(reviews_r)  # Gives an overview of the dataset similar to str() but easier
# to read

skim(reviews_r)  # Gives a far more detailed account of the dataframe

# Other
as_tibble(reviews_r)  # Gives a table like output of the dataset
class(reviews_r)  # Confirms this is a dataframe

# Generate a list of Numeric and categorical variables
num_vars <- reviews_r %>% select(where(is.numeric)) %>% names()
cat_vars <- reviews_r %>% select(where(is.character), where(is.factor)) %>% names()

num_vars  # Confirms numeric columns
cat_vars  # Confirms string columns

# A correlation matrix to look for relationships between features
corrplot(correlation_matrix, method = "circle", tl.col = "black", tl.cex = 0.7)

# Spending score and loyalty points are heavily related (as we saw earlier in the
# analysis with Python)
# Age has affect on spending score, but not a great beal, again confirming earlier
# results

###############################################################################
########################### 3. DESCRIPTIVE ANALYSIS ###########################
###############################################################################

# Quick report
DataExplorer::create_report(reviews_r)

# Missing values
missing_tbl <- reviews_r %>%
  summarise(across(everything(), \(x) mean(is.na(x)))) %>%
  pivot_longer(everything(), names_to="variable", values_to="missing_rate") %>%
  arrange(desc(missing_rate))
missing_tbl   # No missing found as to be expected

###############################################################################
############################ 4. HISTOGRAMS ###################################
###############################################################################
# Quick histogram plots or the features (age, income, spending_score and 
# loyalty_points) to look at distribution

hist(reviews_r$age, main="Age distribution", col="blue")
hist(reviews_r$income, main="Income distribution", col="blue")
hist(reviews_r$spending_score, main="Spending score distribution", col="blue")
hist(reviews_r$loyalty_points, main="Loyalty points distribution", col="blue")

###############################################################################
######################### 5. LOYALTY POINTS ANALYSIS ##########################
###############################################################################

# Mean & median
mean_lp <- mean(reviews_r$loyalty_points)
median_lp <- median(reviews_r$loyalty_points)

ggplot(reviews_r, aes(x=loyalty_points)) +
  geom_histogram(binwidth=200, fill="blue", color="red", alpha=0.6) +
  geom_vline(aes(xintercept=median_lp, color="Median"), linetype="dashed") +
  labs(title="Distribution of Loyalty Points") +
  scale_color_manual(values=c("Median"="red")) +
  theme_minimal()

# Save the plot
ggsave("loyalty_points_full_hist.jpeg", width = 8, height = 6, dpi = 300)

# Interpretation:
# The mean loyalty point is 1578
# The median loyalty point is 1276
# Each bar width represents 200 loyalty points
# Each bar represents the frequency (number of customers) who fall into that range
# The barplot shows that most customers have loyalty popints of between 0 and 1800,
# The plot is right skewed as the majority do not have a very high number of points.
# That means those with high loyalty points ar distorting the mena value of the
# majority of customers
###############################################################################

# The majority of customers have 2000 or less koyalty points. Now lets look at 
# that in more detail

reviews_under_2000 <- reviews_r %>%
  filter(!is.na(loyalty_points), loyalty_points <= 2000)

# Define n_kept
n_kept <- nrow(reviews_under_2000)

# Summary stats
mean_lp   <- mean(reviews_under_2000$loyalty_points, na.rm = TRUE)
median_lp <- median(reviews_under_2000$loyalty_points, na.rm = TRUE)

stats <- tibble(
  stat  = c("Mean", "Median"),
  value = c(mean_lp, median_lp))

# Histogram
ggplot(reviews_under_2000, aes(x = loyalty_points)) +
  geom_histogram(binwidth = 100, fill = "blue", color = "red", alpha = 0.6) +
  geom_vline(data = stats,
             aes(xintercept = value, color = stat, linetype = stat),
             linewidth = 1) +
  labs(
    title = "Distribution of Loyalty Points (≤ 2000)",
    x = "Loyalty Points",
    y = "Frequency",
    color = "Statistic",
    linetype = "Statistic",
    subtitle = paste0("n = ", n_kept,
                      " | Mean = ", round(mean_lp, 1),
                      " | Median = ", round(median_lp, 1))
  ) +
  scale_x_continuous(
    breaks = seq(0, max(reviews_under_2000$loyalty_points, na.rm = TRUE), by = 500)
  ) +
  theme_minimal()

# Save the plot
ggsave("loyalty_points_less_2000_hist.jpeg", width = 8, height = 6, dpi = 300)


# Interpretation:
# The mean loyalty points are now 1022
# The median loyalty points are now 1122
# The plot shows a more even plot although it does seem that most customers are in the 
# 1100 -1500 loyalty point range


# Range (the lowest or highest number of loyalty points)
min(reviews_r$loyalty_points); max(reviews_r$loyalty_points)
IQR(reviews_r$loyalty_points)

# Highest number of loyalty points = 6847
# Lowest number of loyalty points = 25

# Outliers

# --- IQR fences ---
q <- quantile(reviews_r$loyalty_points, probs = c(0.25, 0.75), na.rm = TRUE)
Q1 <- q[[1]]; Q3 <- q[[2]]
IQR_val     <- IQR(reviews_r$loyalty_points, na.rm = TRUE)
lower_bound <- Q1 - 1.5 * IQR_val
upper_bound <- Q3 + 1.5 * IQR_val

# Outliers (both low & high)
outliers <- reviews_r %>%
  filter(loyalty_points < lower_bound | loyalty_points > upper_bound)
# If you only want high outliers:
# outliers <- reviews_r %>% filter(loyalty_points > upper_bound)

# Summary print
n_out <- nrow(outliers)
n_tot <- nrow(reviews_r)
pct   <- 100 * n_out / n_tot

cat(sprintf("Outliers (1.5×IQR): %d of %d (%.1f%%)\nQ1=%.2f, Q3=%.2f, IQR=%.2f, 
            Lower=%.2f, Upper=%.2f\n", n_out, n_tot, pct, Q1, Q3, IQR_val, 
            lower_bound, upper_bound))

# Boxplot of outliers
ggplot(reviews_r, aes(y = loyalty_points)) +
  geom_boxplot(outlier.colour = "red") +
  labs(
    title = sprintf("Loyalty points — outliers: %d (%.1f%%)", n_out, pct),
    y = "Loyalty points"
  ) +
  theme_minimal()

# Save the plot
ggsave("loyalty_outliers_box.jpeg", width = 8, height = 6, dpi = 300)

# Interpretation:
# Outliers (1.5×IQR): 266 of 2000 (13.3%)
# Q1=772.00, Q3=1751.25, IQR=979.25, Lower=-696.88, Upper=3220.12

###############################################################################
############################# 6. DISTRIBUTIONS ################################
###############################################################################

# Determine the variance.
var(reviews_r$loyalty_points) 

# This gives a variance score of 1646704. This means there is a lot of variance 
# in the loyalty points

# Calculate the standard deviation.
sd(reviews_r$loyalty_points)  

# Standard deviation (SD) is 1283.24
# This means that on average, a customer’s loyalty points differ from the mean 
# by about 1,283 points.

# Normality (Q-Q plot)
qqnorm(reviews_r$loyalty_points); qqline(reviews_r$loyalty_points, col="red")

shapiro.test(reviews_r$loyalty_points)
# W = 0.84307, p-value < 2.2e-16  or 0  # So <0.05
## This is showing that the data does not follow a normal line of distribution.

skewness(reviews_r$loyalty_points)
# 1.463694
# This is higher than 0, so indicates the data is right skewed 

## The Kurtosis test returns a value of 4.70. This is higher tan a normal disribution 
## value of 3, so shows a heavy tail whuch could indciate extreme outliers

kurtosis(reviews_r$loyalty_points)
# 4.70883
# This is higher tan a normal disribution value of 3, so shows a heavy tail which 
# could indciate extreme outliers, confirming what we saw in the previous section

# Boxplot loyalty points outliers
ggplot(reviews_r, aes(y=loyalty_points)) + geom_boxplot(fill="red")

# Save the plot
ggsave("loyalty_points_box.jpeg", width = 8, height = 6, dpi = 300)

# Interpretation:
# Not a particularly interesting or insightful plot.
# Loyalty points present several outliers on the top whisker. This suggests that 
# there are customers who have significantly higher loyalty points 
# than the mean

###############################################################################
###################### 7. EDUCATION, LOYALTY, GENDER ##########################
###############################################################################
# Boxplot loyalty points vs education by gender
ggplot(reviews_r, aes(x=education, y=loyalty_points, fill=gender)) +
  geom_boxplot()

# Save the plot
ggsave("loyalty_edu_gender_box.jpeg", width = 8, height = 6, dpi = 300)

###############################################################################
###################### 8. LOYALTY, INCOME, EDUCATION ##########################
###############################################################################

# Boxplot loyalty points vs income by education
ggplot(reviews_r, aes(x=income, y=loyalty_points, fill=education)) +
  geom_boxplot()

# Save the plot
ggsave("loyalty_income_edu_box.jpeg", width = 8, height = 6, dpi = 300)

###############################################################################
################## 9. SPENDING SCORE, EDUCATION, GENDER #######################
###############################################################################

# A boxplot spending_score  by education by gender
ggplot(reviews_r, aes(x = education, y = spending_score, fill = gender)) +
  geom_boxplot() +
  labs(title = "Spending score vs Education across Genders", x = "Education", 
       y = "Spending score", fill = "Gender") 

# Save the plot
ggsave("spending_score_boxplot.jpeg", width = 8, height = 6, dpi = 300)


###############################################################################
################ 9. SPENDING SCORE, LOYALTY POINTS, GENDER ####################
###############################################################################

# Scatter plot spending score vs loyalty points by gender
ggplot(reviews_r, mapping = aes(x = spending_score, y = loyalty_points,
                                colour = gender)) +
  geom_point() +
  labs(title = "Loyalty points by spending score (Gender)",
       x = "Spending score",
       y = "Loyalty points")

# Save the plot
ggsave("spending_loyalty_gender_scatter.jpeg", width = 8, height = 6, dpi = 300)

# Interpretation:
# This plot doesn't really give any insights. Male and females across the whole 
# range. As discused in the python section there are customers with a high spending
# score but low loyalty points. I suggested then that as this is a point in time,
# its possible some customers spend their loyalty points immediately while others
# may chose the hold onto them for something expensive.

###############################################################################
################### 10. LOYALTY POINTS, INCOME, GENDER ########################
###############################################################################

ggplot(reviews_r, mapping = aes(x = income, y = loyalty_points,
                                colour = gender)) +
  geom_point() +
  labs(title = "Income by spending score (Gender)",
       x = "Income",
       y = "Loyalty points")

# Save the plot
ggsave("loyalty_income_gender_scatter.jpeg", width = 8, height = 6, dpi = 300)

# Interpretation:
# Like the plot in Python we see that the loyalty points spread out dramatically 
# after an income of £60k.So are some customers spending their points immediately
# and others hanging onto them?

###############################################################################
################### 11. LOYALTY POINTS, INCOME, GENDER ########################
###############################################################################

# Scatterplot of income by spending score
ggplot(reviews_r, mapping = aes(x = income, y = spending_score,
                                colour = gender)) +
  geom_point() +
  labs(title = "Income by spending score (Gender)",
       x = "Income",
       y = "Spending score")

# Save the plot
ggsave("spending_income_gender_scatter.jpeg", width = 8, height = 6, dpi = 300)

# So here we start to see distinct groups or clusters (as with the python analysis).
# But this mtime, gender is also represented. 
# So it appears that above an income of £90k, males may have a high income but a 
# low spending score, while females may have a high income and a high spending score.
# Below this level of income ther appears to be 5 distinct clusters, with fairly 
# even distribution of male and females.

###############################################################################
######################## 12. AGE, EDUCATION, GENDER ###########################
###############################################################################

# Boxplot to look for relationships between age, education and gender
ggplot(reviews_r, aes(x = education, y = age, fill = gender)) +
  geom_boxplot() +
  labs(title = "Boxplot of Age vs Educations across Genders", x = "Education",
       y = "Age", fill = "Gender") +
  scale_y_continuous(limits = c(0, 80), breaks = seq(0, 80, by = 10))

# Save the plot
ggsave("age_edu_gender_boxplot.jpeg", width = 8, height = 6, dpi = 300)

# The biggest spread in age seems to be with PhD educated males, followed by basic
# educated males, and then graduates where the gender spread is very similar
# Postgraduate males seem to be the least represanted

###############################################################################
######################## 13. AGE, LOYALTY POINTS, GENDER ######################
###############################################################################

# Scatter plot of age by loyalty points by gender
ggplot(reviews_r, mapping = aes(x = age, y = loyalty_points,
                                colour = gender)) +
  geom_point() +
  labs(title = "Age by loyalty points (Gender)",
       x = "Age",
       y = "Loyalty points")

# Save the plot
ggsave("loyalty_income_gender_scatter.jpeg", width = 8, height = 6, dpi = 300)

# This gives no useful insights

###############################################################################
#################### 14. LOYALTY DISTRIBUTION BY CATEGORY #####################
###############################################################################

# A bar chart of the 3 loyalty groups showing distribution
low <- quantile(reviews_r$loyalty_points, 0.25)  # The bottom 25% low loyalty
high <- quantile(reviews_r$loyalty_points, 0.90)  # The top 10% high loyalty

reviews_cat <- reviews_r %>%
  mutate(loyalty_cat = case_when(
    loyalty_points <= low  ~ "Low loyalty",
    loyalty_points >= high ~ "High loyalty",
    TRUE                   ~ "Medium loyalty"
  ))

ggplot(reviews_cat, aes(x=loyalty_cat)) + geom_bar(fill="blue")

# Save the plot
ggsave("loyalty_count_by_group_bar.jpeg", width = 8, height = 6, dpi = 300)

# The mediuym loyalty points range is by far the biggest group of customers, more
# than twice the size of the low loyalty category

###############################################################################
##################### 15. LOYALTY DISTRIBUTION BY GENDER ######################
###############################################################################

# Bar plot of loyalty groups by gender
reviews_summary <- reviews_cat %>%
  group_by(gender, loyalty_cat) %>%
  summarise(count=n(), .groups="drop") %>%
  group_by(gender) %>%
  mutate(percentage=count/sum(count)*100)

ggplot(reviews_summary, aes(x=loyalty_cat, y=percentage, fill=gender)) +
  geom_bar(stat="identity", position="dodge")

head(reviews_cat)

# Save the plot
ggsave("loyalty_group_count_by_gender_bar.jpeg", width = 8, height = 6, dpi = 300)

# There is very little difference in gender spread aross all three loyalty levels.
# It looks like gender plays no role in loyalty

###############################################################################
######################### 16. INCOME DISTRIBUTIION ############################
###############################################################################

# Histogram of income with bin size of 30: more detail than earlier
ggplot(reviews_r, aes(x = income)) +
  geom_histogram(bins = 30, fill = "blue", color = "black") +
  labs(title = "Distribution of Income", x = "Income", y = "Count of customers") +
  scale_x_continuous(limits = c(0, 80), breaks = seq(0, 80, by = 10))

# Save the plot
ggsave("income_distribution_hist.jpeg", width = 8, height = 6, dpi = 300)

# There is a wide spread income,although most customers are between £12k and £30k

###############################################################################
########################### 17. AGE DISTRIBUTION ##############################
###############################################################################

# Histogram of age with bin size of 30: more detail than earlier
ggplot(reviews_r, aes(x = age)) +
  geom_histogram(bins = 30, fill = "blue", color = "black", na.rm = TRUE) +
  labs(title = "Distribution of Age", x = "Age", y = "Frequency") +
  scale_x_continuous(limits = c(0, 80), breaks = seq(0, 80, by = 10))

# Save the plot
ggsave("age_distribution_hist.jpeg", width = 8, height = 6, dpi = 300)


# Age distribution is from around 15 to 73 with peaks in the 30-40 age range

###############################################################################
################## 18. AVERAGE LOYALTY POINTS BY AGE DISRIBUTION ##############
###############################################################################

##Barplot with bins of 5 plot
df_banded <- reviews_r %>%
  mutate(age_band = cut(age, breaks = seq(floor(min(age)), ceiling(max(age)), 
                                          by = 5), right = FALSE))

# Calcualte the average loyalty in each band
age_band_avg <- df_banded %>%
  group_by(age_band) %>%
  summarise(avg_loyalty = mean(loyalty_points), .groups = "drop")

# Plot the barplot with bins
ggplot(age_band_avg, aes(x = age_band, y = avg_loyalty)) +
  geom_col(fill = "steelblue", color = "black", width = 0.8) +
  labs(
    title = "Average Loyalty Points by 5-Year Age Band",
    x = "Age Band",
    y = "Avg Loyalty Points"
  ) +
  scale_y_continuous(labels = comma) +
  theme_minimal(base_size = 12) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


# Save the plot
ggsave("age_band_avg_loyalty_bar.jpeg", width = 8, height = 6, dpi = 300)

# We can see that the age band 32-37 has the highest average number of loyalty
# points.
# Under 22s have the lowest average number of poinjts
# It should be remembered that these are averages so there will be customers with
# loyalty points

###############################################################################
#################### 19. EDUCATION CATEGORY DISTRIBUTION ######################
###############################################################################

# Histogram of education with bin size of 30
ggplot(reviews_r, aes(x = education)) +
  geom_bar(fill = "blue", color = "black") +
  labs(title = "Number of customers by education level", 
       x = "Education", y = "Count") +
  theme_minimal()

# Save the plot
ggsave("edu_count__hist.jpeg", width = 8, height = 6, dpi = 300)

# Customers with graduate level education dominate the count

###############################################################################
###################### 20. OUTLIERS ≥ 3200 POINTS #############################
###############################################################################

# As outliers observed in loyalty points at 3200 and above, # I have decided to 
# investigate how many customers are above this threshold

reviews_r$loyalty_group <- ifelse(reviews_r$loyalty_points >= 3200, 
                                  "3200 and Above", "Below 3200")
loyalty_counts_df <- reviews_r %>%
  group_by(loyalty_group) %>%
  summarise(Count=n(), .groups="drop") %>%
  mutate(Proportion=Count/sum(Count),
         Proportion_Percent=paste0(round(Proportion*100,1),"%"))

ggplot(loyalty_counts_df, aes(x=loyalty_group, y=Count, fill=loyalty_group)) +
  geom_bar(stat="identity")

# Save the plot
ggsave("loyalty_outliers_hist.jpeg", width = 8, height = 6, dpi = 300)

# It can be seen that the overwhelming majority of customers are in the less than 
# 3200 poimnt category. There are a little over 250 customers in the above 3200 
# loyalty point category. These are likely high spend, high value customers

###############################################################################
############################## 21. ANIMATED PLOTS #############################
###############################################################################

# Annimated plot: Incomr ve loyalty points by loyalty category
df <- reviews_cat %>%
  transmute(
    income         = as.numeric(income),
    loyalty_points = as.numeric(loyalty_points),
    loyalty_cat    = factor(as.character(loyalty_cat),
                            levels = c("Low loyalty","Medium loyalty",
                                       "High loyalty"))
  ) %>%
  filter(!is.na(income), !is.na(loyalty_points), !is.na(loyalty_cat))

# Fix axis ranges so they don't jump between frames
xr <- range(df$income, na.rm = TRUE)
yr <- range(df$loyalty_points, na.rm = TRUE)

p <- plot_ly(
  df,
  x = ~income,
  y = ~loyalty_points,
  type  = "scatter",
  mode  = "markers",
  color = ~loyalty_cat,
  colors = c("Low loyalty"="coral","Medium loyalty"="orchid","High loyalty"="purple"),
  frame = ~loyalty_cat,
  marker = list(size = 9, opacity = 0.7, line = list(color = "black", 
                                                     width = 0.5))
) %>%
  layout(
    title = list(text = "Income vs Loyalty Points by Loyalty Category", 
                 font = list(size = 16)),
    xaxis = list(title = "Income (k£)", range = xr),
    yaxis = list(title = "Loyalty Points", range = yr),
    showlegend = FALSE
  ) %>%
  animation_opts(2500, transition = 600,  # ms between frames
                 easing = "cubic-in-out") %>%
  animation_slider(currentvalue = list(prefix = "Category: "))
p

###############################################################################

# Annimated scatter plot spending score by loyalty

df <- reviews_cat %>%
  transmute(
    spending_score = as.numeric(spending_score),
    loyalty_points = as.numeric(loyalty_points),
    loyalty_cat    = factor(as.character(loyalty_cat),
                            levels = c("Low loyalty","Medium loyalty",
                                       "High loyalty"))) %>%
  filter(!is.na(spending_score), !is.na(loyalty_points), !is.na(loyalty_cat))

# Fix axis ranges so they don't jump between frames
xr <- range(df$spending_score, na.rm = TRUE)
yr <- range(df$loyalty_points,  na.rm = TRUE)

p <- plot_ly(df,
  x = ~spending_score,
  y = ~loyalty_points,
  type  = "scatter",
  mode  = "markers",
  color = ~loyalty_cat,
  colors = c("Low loyalty"="coral","Medium loyalty"="orchid","High loyalty"="purple"),
  frame = ~loyalty_cat,
  marker = list(size = 9, opacity = 0.7, line = list(color = "black", width = 0.5))
) %>%
  layout(
    title = list(text = "Spending Score vs Loyalty Points by Loyalty Category", 
                 font = list(size = 16)),
    xaxis = list(title = "Spending Score", range = xr),
    yaxis = list(title = "Loyalty Points",  range = yr),
    showlegend = FALSE
  ) %>%
  animation_opts(
    frame = 2500,      # ↑ increase to slow down (ms per frame)
    transition = 600,  # ms between frames
    easing = "cubic-in-out"
  ) %>%
  animation_slider(currentvalue = list(prefix = "Category: "))
p

###############################################################################
############################### SUMMARY #######################################
###############################################################################

# INSIGHTS:
# - Loyalty points distribution is right-skewed; most customers hold <2000 points.
# - Strong positive correlation between spending score and loyalty points 
# - High loyalty customers typically have higher incomes and spending scores.
# - Outliers exist at very high loyalty points (High disposable income - VIP segment).
# - Gender differences are minimal in loyalty categories.
# - Education has mixed effects; basic education shows high spread.
# - Animated plots confirm spending score is a stronger predictor of loyalty 
#   than income.

# BUSINESS RECOMMENDATIONS:
# 1. Focus loyalty program enhancements on mid-to-high spenders who can be 
#    converted to high loyalty customers.
# 2. Consider targeted VIP perks for customers with >3200 points. 
# 3. Gender-specific marketing is unnecessary; loyalty is not gender-driven.
# 4. Track outliers separately — they may represent strategic “power users.”
# 5. Consider income-spending interaction in future modelling to refine insights.




###############################################################################
# LSE DA301 – Assignment 6
# Week 6: Multiple Linear Regression in R – Turtle Games
#
###############################################################################

###############################################################################
############################# 1. SETUP ########################################
###############################################################################

install.packages(c("broom","rsample","yardstick","car","lmtest","sandwich",
                   "performance"))
install.packages(c("caTools","stringr","tidyverse","readxl","readr","openxlsx",
                   "ggplot2"))
install.packages(c("skimr","DataExplorer","scales","plotly","moments","psych",
                   "corrplot","dplyr","Metrics"))

# Load libraries
library(tidyverse); library(ggplot2); library(dplyr); library(skimr)
library(DataExplorer); library(scales); library(corrplot); library(moments)
library(stringr); library(tibble); library(broom); library(rsample)
library(yardstick); library(car); library(lmtest); library(sandwich)
library(performance); library(caTools); library(Metrics); library(patchwork)
library(splines)

###############################################################################
############################# 2. LOAD DATA & EXPLORE ##########################
###############################################################################

# Prompt the user to choose the CSV file interactively
reviews_r <- read.csv(file.choose(), header = TRUE)
# ('turtle_reviews_clean')

# Quick sanity checks
glimpse(reviews_r)
dim(reviews_r)
head(reviews_r)

# A correlation matrix to look for relationships between features
corrplot(correlation_matrix, method = "square", tl.col = "black", tl.cex = 0.7)

# Spending score and loyalty points are heavily related (as we saw earlier in the
# analysis with Python)
# Age has affect on spending score, but not a great beal, again confirming earlier
# results

###############################################################################
##################### 3. FEATURE SET & TRAIN/TEST SPLIT  ######################
###############################################################################
colnames(reviews_r)

features <- reviews_r[, c("loyalty_points", "spending_score", "income", "age")]

# Sanity check
head(features)  # Confirms we are left with four numeric columns
summary(features)

# Set randomness
set.seed(42)
split <- caTools::sample.split(features$loyalty_points, SplitRatio = 0.8)
train_data <- subset(features, split == TRUE)
test_data  <- subset(features, split == FALSE)

dim(train_data)  # ~80% (1721 rows)
dim(test_data)   # ~20% (279 rows)

###############################################################################
################### 4a. FIT LINEAR REGRESSION (MLR) MODEL #####################
###############################################################################

MLRmodel <- lm(loyalty_points ~ age + income + spending_score, data = train_data)
summary(MLRmodel)

# Results:
# Intercept = -2213 → unrealistic, since loyalty points cannot be negative
# Spending_score = +34.17 per unit increase (holding income/age constant)
# Income = +34.09 per unit increase
# Age = +11.26 per year increase
# All predictors are highly significant (p < 0.05)
# R² = 0.839 → 83.9% variance explained
# RSE = 518 points
# Very strong model, in line with earlier Python analysis

###############################################################################
########################## 4b. FIT SPLINE REGRESSION ##########################
###############################################################################

# Curves for spending_score and income; age stays linear
SplineModel <- lm(
  loyalty_points ~ ns(spending_score, df = 4) + ns(income, df = 4) + age,
  data = train_data
)
summary(SplineModel)   # optional

# The results

# Residuals:
#     Min       1Q     Median       3Q      Max 
# -1689.64  -354.96    40.73     299.74  2004.54 

# Coefficients:
#                               Estimate   Std. Error t value  Pr(>|t|)    
# (Intercept)                 -1564.4062    74.4771  -21.00   <2e-16 ***
# ns(spending_score, df = 4)1  1687.8613    82.4198   20.48   <2e-16 ***
# ns(spending_score, df = 4)2  2086.7515    67.3965   30.96   <2e-16 ***
# ns(spending_score, df = 4)3  3345.4935   140.6003   23.79   <2e-16 ***
# ns(spending_score, df = 4)4  2953.8998    65.9759   44.77   <2e-16 ***
# ns(income, df = 4)1          1001.4435    81.6233   12.27   <2e-16 ***
# ns(income, df = 4)2          2051.4577    72.1069   28.45   <2e-16 ***
# ns(income, df = 4)3          3323.7857   118.8265   27.97   <2e-16 ***
# ns(income, df = 4)4          2981.7796    89.6927   33.24   <2e-16 ***
# age                            11.6572     0.9571   12.18   <2e-16 ***

# Residual standard error: 514.6 on 1711 degrees of freedom
# Multiple R-squared:  0.8419,	Adjusted R-squared:  0.8411 
# F-statistic:  1013 on 9 and 1711 DF,  p-value: < 2.2e-16

# RSE: 501.3 points — so the average error around ±501 points. That's a 3% 
# improvement on the linear model (517 points)
# R^2 = 0.8412 (Adj. 0.8403) So this model explains 84% of the variance 
# (very similar to linear, slightly higher).
# F-stat p < 2e-16 — overall this model is highly significant.
# All spline basis terms for spending_score and income are highly significant  
# (p < 0.001), which suggests the curvature matters. Maybe linear 
# straight lines weren’t quite enough.
# Age is positive and significant (+/-11.45 loyalty points per extra year,
# Median residual ≈ +41 so little bias overall.
# Range from -1596 to +2128 → a few large errors remain (likely at extremes,
# those outliers again), but it's likely we may never fit 100%. This is suggesting 
# that loyalty points are not linear
  
###############################################################################
######################### 5. MULTICOLLINEARITY CHECK ##########################
###############################################################################

base_formula <- loyalty_points ~ spending_score + income + age
m1 <- lm(base_formula, data = train_data)
summary(m1)
car::vif(m1)

# VIF Results:
# age = 1.05, income = 1.00, spending_score = 1.05
# All <5 so No multicollinearity issue. ie each of the predictors are independent 
# of each other

###############################################################################
################ 6. RESIDUAL ANALYSIS (NORMALITY & HOMOSCEDASTICITY############
###############################################################################

################6a. Shapiro test for normality ################################
residuals <- MLRmodel$residuals
shapiro.test(residuals)
# W = 0.99, p-value = 0 So residuals deviate from perfect normality

# --- Q-Q plot ---
qqnorm(residuals); qqline(residuals, col = "red")

# Save the plot
ggsave("residuals_point.jpeg", width = 8, height = 6, dpi = 300)

# --- Histogram of residuals ---
hist(residuals)

# Save the plot
ggsave("residuals_hist.jpeg", width = 8, height = 6, dpi = 300)

################ 6b. Homoscedasticity: residuals vs fitted plot ###############
y_pred_train <- predict(MLRmodel)
ggplot(data.frame(y_pred_train, residuals), aes(x = y_pred_train, y = residuals)) +
  geom_point(color = "blue") +
  geom_hline(yintercept = 0, color = "red", linetype = "dashed") +
  labs(title = "Residuals by y_pred plot", x = "Predicted values", y = "Residuals") +
  theme_classic()

# Save the plot
ggsave("residuals_train_h-asticityplot.jpeg", width = 8, height = 6, dpi = 300)

# Observation: U-shape pattern → heteroscedasticity (non-constant variance).
# Suggests some non-linearity not captured by the model.

############### 6c.Breusch-Pagan test (MLR model) #############################
lmtest::bptest(MLRmodel)

# BP = 41.755, df = 3, p-value = 4.522e-09

# heteroscedasticity is present
# p < 0.05

############### 6d. Robust SE (MLR model) #####################################
robust_lin <- lmtest::coeftest(
  MLRmodel,
  vcov. = sandwich::vcovHC(MLRmodel, type = "HC3"))
print(robust_lin)

# t test of coefficients:
  
#                   Estimate    Std. Error   t value     Pr(>|t|)    
# (Intercept)     -2213.59425    74.27629    -29.802     < 2.2e-16 ***
#  age               11.25645     0.93840     11.995     < 2.2e-16 ***
#  income            34.09199     0.82870     41.139     < 2.2e-16 ***
#  spending_score    34.16616     0.68672     49.752     < 2.2e-16 ***


# Spending score: +/-34.17 points per unit (holding others constant)
# Income: +/-34.09 points per unit
# Age: +/-11.26 points per year

################ 6e. Robust SE (Spline model) #################################
robust_spl <- lmtest::coeftest(
  SplineModel,
  vcov. = sandwich::vcovHC(SplineModel, type = "HC3"))
print(robust_spl)

###############################################################################
################## 7. TEST-SET PERFORMANCE (LINEAR VS SPLINES##################
###############################################################################

# Set stats functions
rmse <- function(a, b) sqrt(mean((a - b)^2))
mae  <- function(a, b) mean(abs(a - b))
r2   <- function(a, b) cor(a, b)^2

y <- test_data$loyalty_points
pred_lin <- predict(MLRmodel,   newdata = test_data)
pred_spl <- predict(SplineModel, newdata = test_data)

res <- data.frame(
  Model = c("Linear (MLR)", "Splines (df=4 for spend & income; age linear)"),
  RMSE  = c(rmse(y, pred_lin), rmse(y, pred_spl)),
  MAE   = c(mae(y, pred_lin),  mae(y, pred_spl)),
  R2    = c(r2(y, pred_lin),   r2(y, pred_spl)))

# round numeric columns only
res_fmt <- res
res_fmt$RMSE <- round(res_fmt$RMSE, 3)
res_fmt$MAE  <- round(res_fmt$MAE,  3)
res_fmt$R2   <- round(res_fmt$R2,   3)
print(res_fmt)

# Choosing final model based on RMSE
final <- if (res$RMSE[1] <= res$RMSE[2]) "Linear (MLR)" else "Splines"
cat("\nFinal model:", final, "\n")

# Interpretation:

#                        Model                         RMSE      MAE     R2
# 1                                  Linear (MLR)    488.948  374.165  0.843
# 2 Splines (df=4 for spend & income; age linear)    488.074  378.115  0.844

# RMSE: The splines model is 0.874 points (0.18% better)

# MAE: Here the spline model is 3.95 points (1.06% worse)

# R^2²: The splines model is 0.001 (~0.12% higher)

# This is very close to call and gnerally the loweest RMSE is the sensible model 
# to go with. But at 0.18% improvement with the spline model over linear it's not
# likely to have any real world difference.
# At ther same time the splines model increased R^2 (Hardly significant), but MAE
# is slighly worse (+/-1%). 
# A linear model is easier to understand for non technical people,as they can
# easily understand “spending score increases by x, so loyalty point increases by y”
# Low overfitting risk. The linear model’s VIFs are clean as the diagnostics
# have are already documented. The splines model adds flexibility, but also 
# complexity, for very small gains.

# So the final choice will be the linear model

###############################################################################
########### 8. BASELINE vs MLR COMPARISION (Side by side comparision)##########
###############################################################################

# Lets test the linear model against a baseline model to see if it really is an 
# improvement

# Set randomness
set.seed(42)

# Setting the traing & test data
n <- nrow(reviews_r)
train_index <- sample(1:n, size = 0.8*n)
train_data  <- reviews_r[train_index, ]
test_data   <- reviews_r[-train_index, ]

model <- lm(loyalty_points ~ age + income + spending_score, data=train_data)
y_test <- test_data$loyalty_points
y_pred_test <- predict(model, newdata=test_data)

baseline_mean <- mean(train_data$loyalty_points)
baseline_pred <- rep(baseline_mean, length(y_test))

baseline_df <- data.frame(Actual=y_test, Predicted=baseline_pred, Model="Baseline")
model_df    <- data.frame(Actual=y_test, Predicted=y_pred_test, Model="Regression")
compare_df  <- rbind(baseline_df, model_df)

ggplot(compare_df, aes(x=Actual, y=Predicted)) +
  geom_point(color="steelblue", alpha=0.5) +
  geom_abline(intercept=0, slope=1, color="red", size=1) +
  facet_wrap(~Model) +
  labs(title="Side-by-Side: Actual vs Predicted (Test Data)",
       x="Actual Loyalty Points", y="Predicted Loyalty Points") +
  theme_classic()

# Save the plot
ggsave("Base_pred_models.jpeg", width=8, height=6, dpi=300)

# Observation:
# Baseline = poor fit, all predictions are flat.
# Regression = points cluster around line (to an extend, but better than baseline), 
# strong predictive performance (in general, but still issues at higher numbers 
# of points)

###############################################################################
######################## 9. EFFECT PLOT (SPENDING SCORE) ######################
###############################################################################

med_income <- median(train_data$income, na.rm=TRUE)
med_age    <- median(train_data$age, na.rm=TRUE)

grid <- tibble(
  spending_score = seq(min(train_data$spending_score, na.rm=TRUE),
                       max(train_data$spending_score, na.rm=TRUE),
                       length.out=200),
  income = med_income,
  age    = med_age)

grid$pred <- predict(model, newdata=grid)

ggplot(grid, aes(spending_score, pred)) +
  geom_line(color="blue", linewidth=1.2) +
  labs(title="Effect of Spending Score on Predicted Loyalty Points",
       x="Spending Score", y="Predicted Loyalty Points") +
  theme_minimal(base_size=13)

# Interpretation:
# As spending score rises, predicted loyalty points increase linearly,
# consistent with regression coefficients.

###############################################################################
########################## 10. PERSONA SCENARIOS ##############################
###############################################################################

# Set randomness
set.seed(42)

# Train/test split
idx <- sample(seq_len(nrow(reviews_r)), size = floor(0.8 * nrow(reviews_r)))
train_data <- reviews_r[idx, ]
test_data  <- reviews_r[-idx, ]

# Fit model
log_target <- FALSE
if (log_target) {
  best <- lm(log1p(loyalty_points) ~ age + income + spending_score, data=train_data)
} else {
  best <- lm(loyalty_points ~ age + income + spending_score, data=train_data)}

# Persona scenarios ( based on an extended version of the segments from part 3
scenarios_persona <- tibble::tribble(
  ~scenario, ~spending_score, ~income, ~age, ~Suggested_Tactic,
  
  # Baseline and typical
  "Typical (median)", median(train_data$spending_score, na.rm=TRUE), 
  median(train_data$income, na.rm=TRUE), 
  median(train_data$age, na.rm=TRUE), 
  "Baseline / benchmark",
  
  # Younger & older contrasts
  "Young high spender", quantile(train_data$spending_score, 0.90, na.rm=TRUE), 
  median(train_data$income, na.rm=TRUE), 
  quantile(train_data$age, 0.10, na.rm=TRUE), 
  "Youth-focused engagement",
  
  "Older high spender", quantile(train_data$spending_score, 0.90, na.rm=TRUE), 
  quantile(train_data$income, 0.75, na.rm=TRUE), 
  quantile(train_data$age, 0.90, na.rm=TRUE), 
  "Retention & loyalty perks",
  
  # Income/spend mix
  "Low income, low spend", quantile(train_data$spending_score, 0.10, na.rm=TRUE), 
  quantile(train_data$income, 0.10, na.rm=TRUE), 
  median(train_data$age, na.rm=TRUE), 
  "Budget-friendly offers & retention",
  
  "High income, low spend", quantile(train_data$spending_score, 0.10, na.rm=TRUE), 
  quantile(train_data$income, 0.90, na.rm=TRUE), 
  median(train_data$age, na.rm=TRUE), 
  "Awareness & activation campaigns",
  
  "Low income, high spend", quantile(train_data$spending_score, 0.90, na.rm=TRUE), 
  quantile(train_data$income, 0.10, na.rm=TRUE), 
  median(train_data$age, na.rm=TRUE), 
  "Value bundles & loyalty perks",
  
  # Middle cases
  "Mid income, mid spend", quantile(train_data$spending_score, 0.50, na.rm=TRUE), 
  quantile(train_data$income, 0.50, na.rm=TRUE), 
  quantile(train_data$age, 0.50, na.rm=TRUE), 
  "Personalised recommendations",
  
  "Affluent avg spender", median(train_data$spending_score, na.rm=TRUE), 
  quantile(train_data$income, 0.90, na.rm=TRUE), 
  median(train_data$age, na.rm=TRUE), 
  "Upselling & premium bundles",
  
  # Extremes
  "High roller young", quantile(train_data$spending_score, 0.95, na.rm=TRUE), 
  quantile(train_data$income, 0.95, na.rm=TRUE), 
  quantile(train_data$age, 0.10, na.rm=TRUE), 
  "VIP programme",
  
  "Frugal older saver", quantile(train_data$spending_score, 0.05, na.rm=TRUE), 
  quantile(train_data$income, 0.25, na.rm=TRUE), 
  quantile(train_data$age, 0.90, na.rm=TRUE), 
  "Retention & basic offers"
)

# Predictions with intervals
pred_mat <- predict(best, newdata=scenarios_persona, interval="prediction")
pred_df  <- as.data.frame(pred_mat)
if (log_target) pred_df <- pred_df %>% mutate(across(everything(), expm1))

scenarios_persona <- scenarios_persona %>%
  mutate(pred_fit = pmax(0, pred_df$fit),
         pred_lwr = pmax(0, pred_df$lwr),
         pred_upr = pmax(0, pred_df$upr))

# Display sorted results
scenarios_sorted <- scenarios_persona %>%
  arrange(desc(pred_fit)) %>%
  mutate(rank=row_number(),
         age_f=comma(round(age,0)),
         income_f=comma(round(income,0)),
         spending_f=comma(round(spending_score,0)),
         predicted_f=comma(round(pred_fit,0)),
         lower_f=comma(round(pred_lwr,0)),
         upper_f=comma(round(pred_upr,0))) %>%
  select(rank, scenario, age=age_f, income=income_f, spending_score=spending_f,
         predicted_points=predicted_f, CI_lower=lower_f, CI_upper=upper_f, Suggested_Tactic)
print(scenarios_sorted)

# Persona color palette
persona_colors <- c(
  "Typical (median)"="#1f77b4","Young high spender"="#ff7f0e","Older high spender"="#2ca02c",
  "Low income, low spend"="#d62728","High income, low spend"="#9467bd",
  "Low income, high spend"="#8c564b","Mid income, mid spend"="#e377c2",
  "Affluent avg spender"="#7f7f7f","High roller young"="#bcbd22","Frugal older saver"="#17becf"
)

# Error bar plot
ggplot(scenarios_persona %>% arrange(desc(pred_fit)),
       aes(x=reorder(scenario, pred_fit), y=pred_fit, fill=scenario)) +
  geom_col(show.legend=FALSE, alpha=0.85) +
  geom_errorbar(aes(ymin=pred_lwr, ymax=pred_upr), width=0.25, color="black") +
  coord_flip() +
  scale_fill_manual(values=persona_colors) +
  scale_y_continuous(labels=label_number(scale_cut=cut_short_scale())) +
  labs(title="Predicted Loyalty Points by Persona Scenario (95% Prediction Interval)",
       x="Persona Scenario", y="Predicted Loyalty Points") +
  theme_minimal(base_size=13) +
  theme(plot.title=element_text(face="bold", size=14),
        axis.text.y=element_text(face="bold"),
        panel.grid.major.y=element_blank())

# Save plot
ggsave("predicted_loyalty_scenarios_bar.jpeg", width=8, height=6, dpi=300)

# rank     scenario               age   income spend_score pred_points CI_lower CI_upper Suggested_Tactic                  
# 1     1 High roller young       23      84      92           4,048    3,059    5,038    VIP programme                     
# 2     2 Older high spender      58      63      87           3,532    2,543    4,522    Retention & loyalty perks         
# 3     3 Affluent avg spender    38      80      50           2,635    1,647    3,623    Upselling & premium bundles       
# 4     4 Young high spender      23      47      87           2,593    1,604    3,581    Youth-focused engagement          
# 5     5 Low income, high spend  38      16      87           1,718      729    2,707    Value bundles & loyalty perks     
# 6     6 Typical (median)        38      47      50           1,515      528    2,503    Baseline / benchmark              
# 7     7 Mid income, mid spend   38      47      50           1,515      528    2,503    Personalised recommendations      
# 8     8 High income, low spend  38      80      13           1,397      408    2,386    Awareness & activation campaigns  
# 9     9 Low income, low spend   38      16      13               0        0      230    Budget-friendly offers & retention
# 10    10 Frugal older saver     58      28       6               0        0      607    Retention & basic offers          

###############################################################################
################################### SUMMARY ###################################
###############################################################################

# The MLR model demonstrates that Turtle Games’ loyalty programme already rewards 
# high-spending customers well, but the biggest business opportunity lies in youth 
# engagement and activating wealthy but under-spending customers.
# Note: I would have liked a bit more variety in the age, income and spending 
# scores as I fee; they are a bit too similar
# There were 6 clusters or customer groups originally so making 10 now is probably
# too many with a lot of overlap
#
#########