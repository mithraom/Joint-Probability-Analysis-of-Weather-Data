# Load the datasets using base R
rainfall <- read.csv("C:\\R_Project\\rainfall.csv", header = TRUE)
max_temp <- read.csv("C:\\R_Project\\max_temp.csv", header = TRUE)
min_temp <- read.csv("C:\\R_Project\\min_temp.csv", header = TRUE)

# Remove the first column if it's 'Year' to keep only monthly data
rainfall_data <- rainfall[, -1]
max_temp_data <- max_temp[, -1]
min_temp_data <- min_temp[, -1]

# Get month names (column names)
months <- colnames(rainfall_data)

# Initialize vectors for storing correlation values
cor_rain_max <- numeric(length(months))
cor_rain_min <- numeric(length(months))
cor_max_min  <- numeric(length(months))

# Compute correlations month by month
for (i in seq_along(months)) {
  cor_rain_max[i] <- cor(rainfall_data[[i]], max_temp_data[[i]], use = "complete.obs")
  cor_rain_min[i] <- cor(rainfall_data[[i]], min_temp_data[[i]], use = "complete.obs")
  cor_max_min[i]  <- cor(max_temp_data[[i]], min_temp_data[[i]], use = "complete.obs")
}

# Find the month with maximum correlation
max_cor_rain_max <- months[which.max(cor_rain_max)]
max_cor_rain_min <- months[which.max(cor_rain_min)]
max_cor_max_min  <- months[which.max(cor_max_min)]

# Print results
cat("Month with highest correlation between Rainfall and Max Temp:", max_cor_rain_max, "\n")
cat("Month with highest correlation between Rainfall and Min Temp:", max_cor_rain_min, "\n")
cat("Month with highest correlation between Max Temp and Min Temp:", max_cor_max_min, "\n")
