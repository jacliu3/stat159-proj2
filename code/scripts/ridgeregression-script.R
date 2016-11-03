library(glmnet)

# Set seed to project default
set.seed(123)

# Load scaled credit data and test/train vectors
scaled <- read.csv('data/scaled-credit.csv', header = T)
load('data/test-train-vectors.RData')

x <- as.matrix(scaled[ , 2:(ncol(scaled)-1)])
y <- scaled$Balance

# Fit various models with different lambdas by cross-validation
grid <- 10^seq(10, -10, length = 100)
ridge.cv.fit <- cv.glmnet(x[train,], y[train], alpha = 0, intercept = FALSE,
                         standardize = FALSE, lambda = grid)
save(ridge.cv.fit, file = "data/ridge-cv-models.RData")

# Extract the best lambda of all the lambdas we've tried
best.lambda <- ridge.cv.fit$lambda.min

# Plot cross-validation errors in terms of lambda
png("images/ridge-scatterplot.png")
plot(ridge.cv.fit)
dev.off()

# Compute test MSE on best model
predictions <- predict(ridge.cv.fit, s = best.lambda, newx = x[test,])
error <- mean((predictions - y[test])^2)

# Fit full model using best lambda
ridge.fit <- glmnet(x, y, alpha = 0, intercept = FALSE, standardize = FALSE,
              lambda = best.lambda)

# Output primary results to text file
sink("data/ridge-results.txt")
cat("Best Lambda:", best.lambda, "\n")
cat("Test MSE:", error, "\n")
cat("Official coefficients:", "\n")
print(coef(ridge.fit))
sink()

# Save official model, best lambda and test set MSE to RData file
save(ridge.fit, best.lambda, error, file = "data/ridge-results.RData")
