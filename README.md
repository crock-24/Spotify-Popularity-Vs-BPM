# Spotify Streams Analysis: Musical Key and Tempo Effects

This project investigates how **musical key** and **tempo (BPM)** influence the **total number of Spotify streams** a song receives. Using statistical modeling and visualization in **R**, we explore whether these musical elements are significantly associated with stream counts — both independently and through their interaction.

---

## Dataset Overview

- **Dataset Source**: [Kaggle - Top Spotify Songs 2023](https://www.kaggle.com/datasets/nelgiriyewithana/top-spotify-songs-2023)
- **Number of Observations**: 857 unique songs
- **Variables Used**:
  - `streams`: Total number of Spotify streams (**response variable**)
  - `bpm`: Continuous variable indicating song tempo (beats per minute)
  - `bpm2`: Categorical version of `bpm` (5 levels), created using the `Hmisc` package in R to bin the tempo into evenly sized groups:
    - 65–97 bpm
    - 97–114 bpm
    - 114–129 bpm
    - 129–147 bpm
    - 147–206 bpm
  - `key`: Musical key of the song (11 levels: B, C#, F, A, D, F#, G#, G, E, A#, D#)

---

## Objective

The primary goal is to determine whether:

- The musical key of a song affects its streaming performance
- The tempo category (`bpm2`) affects streams
- There is a **statistically significant interaction** between key and tempo in influencing stream counts

---

## Statistical Methods

- Software Used: R version 4.3.0 ([R Project](https://www.r-project.org/))
- Significance Level: α = 0.05
- Methodology:
  - Two-Way ANOVA (Type III sums of squares) to account for unbalanced group sizes
  - Tukey’s Honest Significant Difference** (HSD) test for pairwise comparisons
  - Residual diagnostics (residual vs. fitted plot, Q-Q plot) to check:
    - Normality
    - Equal variance
    - Outliers
    - Independence
   
---

## Exploratory Data Analysis

- Boxplots were used to visualize the distribution of `streams` across:
  - 11 musical keys
  - 5 tempo categories
- An **interaction plot** was generated to visually assess how combinations of key and tempo impact streaming performance.

---

## ANOVA Modeling & Results

A two-way ANOVA model was fit:

Significant differences in Spotify stream counts were found between:

- 97–114 bpm range received significantly more streams than 129–147 bpm
- 147–206 bpm range received significantly more streams than 129–147 bpm

---

## Assumption Checks

The assumptions for ANOVA were found to be **violated**:

- Normality: Q-Q plot showed heavy skew on both tails
- Equal Variance: Residual plot showed a fanning pattern, indicating heteroscedasticity
- Outliers: Several songs had standardized residuals > 4 standard deviations from predictions

These violations mean that **caution** should be used when interpreting the p-values and confidence intervals from the ANOVA.

---

## Discussion

This analysis provided insight into the potential influence of tempo on streaming success, suggesting that songs in certain BPM ranges may be more commercially effective than others. However:

- Musical key did not appear to be a statistically significant factor in stream count
- Interaction effects** between key and BPM were not significant

It's important to note that **lack of significance does not prove no effect** — only that the analysis failed to detect one under current assumptions and data structure.

### Limitations

- The results are based on observational data, not experimental design
- Model assumptions were violated, weakening the robustness of statistical inference
- Other confounding factors (e.g., genre, artist popularity, release date) were not controlled for

