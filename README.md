# Investigating the Impact of Beer Tax on Traffic Fatalities
### Panel Data Econometrics | R | Policy Analytics

## Project Overview
Alcohol-related road accidents remain a major public health concern. Policymakers often consider increasing alcohol taxes as a strategy to discourage excessive drinking and reduce traffic fatalities.

This project investigates whether **higher beer taxes reduce traffic fatalities across U.S. states** using panel regression techniques.

The analysis applies econometric modeling to evaluate the relationship between alcohol taxation and fatal accident rates using multi-year state-level data.

---

## Research Question
Do higher beer taxes reduce traffic fatalities?

---

## Dataset
The analysis uses the **Fatalities dataset from the AER package in R**, which contains panel data on U.S. states over multiple years.

Key variables include:

- Fatalities from traffic accidents
- Beer tax rates
- Alcohol consumption indicators
- Blood alcohol content laws
- Employment rates
- Population statistics
- Young driver demographics

Because the dataset contains both **cross-sectional (states)** and **time-series (years)** data, it is suitable for **panel data econometric analysis**.

---

## Methodology

### Data Preparation
- Examined dataset structure
- Checked for missing values
- Prepared variables for panel regression

### Panel Regression Model
Panel econometric models were implemented to estimate the relationship between beer taxes and fatalities.

Two model specifications were explored:

- Random Effects Model
- Fixed Effects Model

The regression model was implemented **manually using matrix algebra**, rather than relying on built-in regression functions such as `lm()`.

This demonstrates a deeper understanding of econometric estimation techniques.

### Estimation Technique
- Feasible Generalized Least Squares (FGLS)
- Model validation using the **plm package**

---

## Results

Key findings from the panel regression analysis:

- Beer tax coefficient: **−0.052**
- p-value: **0.6753**

The negative coefficient suggests that higher beer taxes may reduce fatalities, but the effect is **not statistically significant at the 5% level**.

This indicates that **other socioeconomic or behavioral factors likely play a larger role in determining traffic fatalities**.

---

## Key Insights

• Road safety outcomes are influenced by multiple factors beyond alcohol taxation.  

• Differences across states highlight the importance of controlling for regional heterogeneity.  

• Panel econometric techniques allow more accurate policy evaluation.

---

## Policy Implications

Although the statistical relationship was weak, alcohol taxation could still serve as a **complementary policy tool** when combined with:

- stricter drunk driving enforcement
- road safety campaigns
- public health interventions

Governments may also use alcohol tax revenue to fund road safety programs.

---

## Tools & Technologies

- R
- Panel Data Econometrics
- Matrix Algebra
- Feasible Generalized Least Squares (FGLS)
- Data Analysis

---

## Skills Demonstrated

- Econometric modeling
- Panel data analysis
- Policy evaluation
- Statistical inference
- R programming

---

## Author
**Nida Muhammad Umer**

BS Economics & Mathematics  
Aspiring Data Analyst / Data Scientist

