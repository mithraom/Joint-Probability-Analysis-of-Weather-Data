# Joint Probability Analysis of Weather Data 🌧️🌡️

> Applying Joint Probability Mass Functions to 100+ years of Thanjavur weather data to uncover rainfall-temperature relationships and their real-world impact.

---

## Overview

This project applies joint probability theory to over a century of meteorological data (1901–2002) from Thanjavur District, Tamil Nadu. Using R, it identifies the months where rainfall and temperature variables are most strongly correlated, constructs joint probability mass functions (PMFs) via binning, and derives marginal PMFs, conditional expectations, and conditional variances — translating classical probability theory into actionable climate insights.

---

## Dataset

**Source:** [India Water Portal](http://www.indiawaterportal.org/met_data/)

| File | Description |
|---|---|
| `rainfall.csv` | Monthly rainfall data, Thanjavur (1901–2002) |
| `max_temp.csv` | Monthly average maximum temperature (1901–2002) |
| `min_temp.csv` | Monthly average minimum temperature (1901–2002) |

Each CSV has a `Year` column followed by 12 monthly columns.

---

## Tasks

### Task 1 — Theory
Covers the mathematical foundations used in this project:
- **Joint PMF** — `p(x, y) = P(X = x and Y = y)`
- **Marginal PMF** — summing the joint PMF over the other variable
- **Conditional Expectation** — `E[X | Y = y] = Σx · x · P(X=x | Y=y)`
- **Conditional Variance** — `Var(X | Y = y) = E[(X - E[X|Y=y])² | Y = y]`

### Task 2 — Correlation Analysis
Identifies the month with the highest Pearson correlation for each variable pair:

| Variable Pair | Month with Max Correlation |
|---|---|
| Rainfall vs Max Temperature | **April** |
| Rainfall vs Min Temperature | **November** |
| Max Temperature vs Min Temperature | **November** |

### Task 3 — Joint Probability Distribution
For each of the three variable pairs (at their peak correlation month):
- Discretizes continuous data into 5 equal-width bins using `cut()`
- Computes the **joint probability matrix** via `prop.table(table(...))`
- Derives **marginal PMFs** using `rowSums()` / `colSums()`
- Computes **conditional expectation E[Y|X]** and **conditional variance Var[Y|X]** for each bin

### Task 4 — Visual Graph Plots
Bar plots of month-wise correlation coefficients across all three variable pairs, plus a general seasonal overlay graph of Max Temp, Min Temp, and Rainfall over the year.

---

## Key Results

**Rainfall vs Max Temp (April) — Conditional Stats:**

| Rainfall Bin | E[MaxTemp \| Rainfall] | Var[MaxTemp \| Rainfall] |
|---|---|---|
| (3.91, 82.7] | 34.80 | 10.47 |
| (82.7, 161] | 37.33 | 9.04 |
| (161, 239] | 36.23 | 11.74 |
| (239, 318] | 35.66 | 9.09 |
| (318, 397] | 35.76 | 8.44 |

**Rainfall vs Min Temp (November) — Conditional Stats:**

| Rainfall Bin | E[MinTemp \| Rainfall] | Var[MinTemp \| Rainfall] |
|---|---|---|
| (6.71, 85.5] | 22.45 | 5.07 |
| (85.5, 164] | 21.88 | 8.81 |
| (164, 242] | 22.96 | 10.03 |
| (242, 321] | 23.51 | 9.04 |
| (321, 400] | 23.61 | 7.77 |

**Max Temp vs Min Temp (November) — Conditional Stats:**

| MaxTemp Bin | E[MinTemp \| MaxTemp] | Var[MinTemp \| MaxTemp] |
|---|---|---|
| (30, 32.4] | 22.08 | 7.47 |
| (32.4, 34.8] | 22.91 | 10.47 |
| (34.8, 37.1] | 22.66 | 9.31 |
| (37.1, 39.5] | 23.56 | 6.85 |
| (39.5, 41.9] | 23.33 | 7.11 |

---

## Project Structure

```
R_Project/
├── Code.R                        # Task 2: Correlation analysis — finds months with max correlation
├── code 2.R                      # Task 3: Joint PMF, marginal PMFs, conditional expectation & variance
├── graph 1.R                     # Task 4: Bar plots and general seasonal graph
├── rainfall.csv                  # Monthly rainfall data, Thanjavur (1901–2002)
├── max_temp.csv                  # Monthly average maximum temperature data
├── min_temp.csv                  # Monthly average minimum temperature data
└── R project report.pdf          # Full project report
```

---

## How to Run

### Prerequisites
- R (version 4.0+)
- No additional packages required (uses base R only)

### Steps

```r
# 1. Clone the repo and set your working directory
setwd("path/to/R_Project")

# 2. Run correlation analysis (Task 2)
source("Code.R")

# 3. Run joint probability analysis (Task 3)
source("code 2.R")

# 4. Generate visualizations (Task 4)
source("graph 1.R")
```

> **Note:** Update the file paths in each script to match your local directory before running.

---

## Real-World Problem Statement

The joint probability patterns identified in this project have direct implications for several societal challenges in Thanjavur and Tamil Nadu:

| Problem | Joint Condition | Impact |
|---|---|---|
| Crop Failure | Low rainfall + High temperature | Drought, farmer distress |
| Water Scarcity | Low rainfall + High evaporation | Reservoir depletion |
| Heat Health Risks | High temperature + No rainfall | Heatstroke, dehydration |
| Education Disruption | Extreme summer + Dry months | Reduced school hours |
| Power Grid Strain | Hot dry months | High AC demand + low hydro output |
| Urban Flooding | Heavy rainfall + Low temperature | Drainage failure in cities |

---

## Proposed Solutions

- **Predictive Advisory Systems** using joint probability forecasts to alert farmers, water boards, and health departments
- **Crop Diversification** promoting drought-tolerant varieties during high-risk months
- **Rainwater Harvesting** campaigns timed around predicted low-rainfall periods
- **Solar Backup Infrastructure** to offset grid strain during hot, dry months
- **Urban Drainage Planning** using month-wise flood-risk maps derived from the analysis

---

## Future Scope

Climate projections (RCP 4.5 and RCP 8.5 scenarios) for Thanjavur from 2025 to 2050 indicate rising minimum temperatures across most blocks. Extending this joint probability framework to projected future data could improve long-term agricultural and urban planning decisions.

---

## Literature References

1. Wilks, D.S. (1995). *Statistical Methods in the Atmospheric Sciences*
2. Katz, R.W. & Brown, B.G. (1992). Extreme events in a changing climate — *Climatic Change*
3. Hamed, K.H. & Rao, A.R. (1998). A modified Mann-Kendall trend test — *Journal of Hydrology*
4. IPCC Reports on Climate Risk and Resilience
5. India Water Portal — [indiawaterportal.org/met_data](http://www.indiawaterportal.org/met_data/)
6. Tamil Nadu Agricultural University (TNAU) — Regional Climate Studies

---

