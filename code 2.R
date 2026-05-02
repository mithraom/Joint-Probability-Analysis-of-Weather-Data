# Load datasets
rainfall <- read.csv("C:\\R_Project\\rainfall.csv")
max_temp <- read.csv("C:\\R_Project\\max_temp.csv")
min_temp <- read.csv("C:\\R_Project\\min_temp.csv")

# Remove Year column
rainfall_data <- rainfall[ , -1]
max_temp_data <- max_temp[ , -1]
min_temp_data <- min_temp[ , -1]

# Function to find month with highest correlation
get_max_corr_month <- function(df1, df2) {
  cors <- sapply(1:12, function(i) cor(df1[[i]], df2[[i]], use = "complete.obs"))
  return(which.max(cors))  # returns month index (1-12)
}

# Find months with highest correlation
month_rm <- get_max_corr_month(rainfall_data, max_temp_data)
month_rn <- get_max_corr_month(rainfall_data, min_temp_data)
month_mn <- get_max_corr_month(max_temp_data, min_temp_data)

# Discretize into bins
get_joint_distribution <- function(x, y, bins = 5) {
  x_cut <- cut(x, breaks = bins)
  y_cut <- cut(y, breaks = bins)
  joint_table <- table(x_cut, y_cut)
  joint_prob <- prop.table(joint_table)  # joint probability matrix
  return(joint_prob)
}

# Compute marginal pmfs
get_marginals <- function(joint_prob) {
  x_marginal <- rowSums(joint_prob)
  y_marginal <- colSums(joint_prob)
  return(list(x = x_marginal, y = y_marginal))
}

# Compute conditional expectation and variance of Y given X
get_conditional_stats <- function(joint_prob) {
  x_levels <- rownames(joint_prob)
  y_levels <- colnames(joint_prob)
  
  # Midpoints of bins (approximated)
  x_vals <- sapply(strsplit(x_levels, ","), function(s) mean(as.numeric(gsub("[^0-9.]", "", s))))
  y_vals <- sapply(strsplit(y_levels, ","), function(s) mean(as.numeric(gsub("[^0-9.]", "", s))))
  
  cond_exp <- numeric(length(x_vals))
  cond_var <- numeric(length(x_vals))
  
  for (i in 1:length(x_vals)) {
    row_probs <- joint_prob[i, ]
    total_p <- sum(row_probs)
    if (total_p == 0) {
      cond_exp[i] <- NA
      cond_var[i] <- NA
    } else {
      cond_y <- as.numeric(y_vals)
      mean_y <- sum(row_probs * cond_y) / total_p
      var_y <- sum(row_probs * (cond_y - mean_y)^2) / total_p
      cond_exp[i] <- mean_y
      cond_var[i] <- var_y
    }
  }
  return(data.frame(X_bin = x_levels, E_Y_given_X = cond_exp, Var_Y_given_X = cond_var))
}

# Analysis for Rainfall vs Max Temp
cat("\n=== Rainfall vs Max Temp (Month:", month_rm, ")\n")
joint_rm <- get_joint_distribution(rainfall_data[[month_rm]], max_temp_data[[month_rm]])
marginals_rm <- get_marginals(joint_rm)
stats_rm <- get_conditional_stats(joint_rm)
print(stats_rm)

# Analysis for Rainfall vs Min Temp
cat("\n=== Rainfall vs Min Temp (Month:", month_rn, ")\n")
joint_rn <- get_joint_distribution(rainfall_data[[month_rn]], min_temp_data[[month_rn]])
marginals_rn <- get_marginals(joint_rn)
stats_rn <- get_conditional_stats(joint_rn)
print(stats_rn)

# Analysis for Max Temp vs Min Temp
cat("\n=== Max Temp vs Min Temp (Month:", month_mn, ")\n")
joint_mn <- get_joint_distribution(max_temp_data[[month_mn]], min_temp_data[[month_mn]])
marginals_mn <- get_marginals(joint_mn)
stats_mn <- get_conditional_stats(joint_mn)
print(stats_mn)
