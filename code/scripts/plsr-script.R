library(pls)
# Set seed to project default
set.seed(123)

# Load scaled credit data and test/train vectors
scaled <-  read.csv('data/scaled-credit.csv', header = T)
scaled$X <- NULL
x <- scaled
x$Balance <- NULL
x <- as.matrix(x)
y <- scaled$Balance
load('data/test-train-vectors.Rdata')

# Fit various models by cross-validation
plsr.cv.fit <- plsr(y[train] ~ x[train,], validation = "CV")
save(plsr.cv.fit, file = "data/plsr-cv-models.RData")

# Extract the best ncomp (aka the number of components)
plsr.best.ncomp <- which.min(plsr.cv.fit$validation$PRESS)

# Plot cross-validation errors
png("images/scatterplot-plsr.png")
validationplot(plsr.cv.fit, val.type = "MSEP", main = "Scatter Plot for PLSR")
dev.off()

# Calculate MSE 
predictions <- predict(plsr.cv.fit, newdata = x[test,], ncomp = 1:plsr.best.ncomp)
plsr.error <- mean((predictions - y[test])^2)

# Fit full model
plsr.fit <-  plsr(y ~ x, ncomp = plsr.best.ncomp)

# Output primary results to text file
sink("data/plsr-results.txt")
cat("Best Number of Components:", plsr.best.ncomp, "\n")
cat("Test MSE:", plsr.error, "\n")
cat("Official coefficients:", "\n")
print(coef(plsr.fit))
sink()

# Save official model, best ncomp and test set MSE to RData file
save(plsr.fit, plsr.best.ncomp, plsr.error, file = "data/plsr-results.RData")
