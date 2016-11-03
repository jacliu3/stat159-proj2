# Set seed to project default
set.seed(123)

# Load scaled credit data
scaled <- read.csv('data/scaled-credit.csv', header = T)
scaled$X <- NULL

# Applying regression model
ols.fit <- lm(formula = Balance ~ ., data = scaled)
ols.sum <- summary(ols.fit)

# Saving fitted models
save(ols.fit, ols.sum, file = "data/ols-results.Rdata")

# Generate plots (residual, normal qq)
png("images/ols-residuals.png")
plot(ols.fit, which = 1, main = "Ordinary Least Squares Regression")
dev.off()
png("images/ols-normalqq.png")
plot(ols.fit, which = 2, main = "Ordinary Least Squares Regression")
dev.off()