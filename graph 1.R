rainfall <- read.csv("D:/rainfall.csv"
, header = TRUE)
max_temp <- read.csv("D:/max_temp.csv"
, header = TRUE)
min_temp <- read.csv("D:/min_temp.csv"
, header = TRUE)
rainfall_data <- rainfall[, -1]
max_temp_data <- max_temp[, -1]
min_temp_data <- min_temp[, -1]
get_correlation_vector <- function(df1, df2) {
sapply(1:12, function(i) cor(df1[[i]], df2[[i]], use =
"complete.obs"))
}
month_names <- colnames(rainfall_data)
cor_rm <- get_correlation_vector(rainfall_data, max_temp_data)
cor_rn <- get_correlation_vector(rainfall_data, min_temp_data)
cor_mn <- get_correlation_vector(max_temp_data,
min_temp_data)
par(mfrow = c(1, 3))
barplot(cor_rm,
col = topo.colors(12),
names.arg = month_names,
las = 2,
main = "Rainfall vs Max Temp"
,
ylab = "Correlation Coefficient")
barplot(cor_rn,
col = heat.colors(12),
names.arg = month_names,
las = 2,
main = "Rainfall vs Min Temp"
,
ylab = "Correlation Coefficient")
barplot(cor_mn,
col = terrain.colors(12),
names.arg = month_names,
las = 2,
main = "Max Temp vs Min Temp"
,
ylab = "Correlation Coefficient")