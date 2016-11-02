library(glmnet)

# Set seed to project default
set.seed(123)

# Load scaled credit data and test/train vectors
scaled <- read.csv('data/scaled-credit.csv', header = T)
scaled$X <- NULL
load('data/test-train-vectors.Rdata')
x <- scaled
x$Balance <- NULL
x <- as.matrix(x)
y <- scaled$Balance

# Tune hyperparameter by cross-validation
grid <- 10^seq(10, -10, length  =  100)
lasso.cv.fit <- cv.glmnet(x[train,], y[train], alpha = 1, intercept = FALSE,
                 standardize = FALSE, lambda = grid)
save(lasso.cv.fit, file = "data/lasso-cv-models.RData")

# Extract the best lambda
best.lambda <- lasso.cv.fit$lambda.min

# Plot cross-validation errors in terms of lambda
png("images/lasso-scatterplot.png")
plot(lasso.cv.fit)
dev.off()

# Calculate MSE of test set
predictions <- predict(lasso.cv.fit, s = best.lambda, newx = x[test,])
error <- mean((predictions - y[test])^2)

# Fit full model using best lambda
lasso.fit <- glmnet(x, y, alpha = 0, intercept = FALSE, standardize = FALSE,
              lambda = best.lambda)

# Output primary results to text file
sink("data/lasso-results.txt")
cat("Best Lambda:", best.lambda, "\n")
cat("Test MSE:", error, "\n")
cat("Official coefficients", "\n")
coef(lasso.fit)
sink()

# Save model, label, and test MSE
save(lasso.fit, best.lambda, error, file = "data/lasso-results.RData")
