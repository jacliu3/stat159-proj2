library(pls)

# Set seed to project default
set.seed(123)

# Load scaled credit data and test/train vectors
scaled <- read.csv('data/scaled-credit.csv', header  = T)
load('data/test-train-vectors.Rdata')

x <- as.matrix(scaled[ , 2:(ncol(scaled)-1)])
y <- scaled$Balance

# Fit various models by cross-validation
pcr.cv.fit <- pcr(y[train] ~ x[train,], validation  = "CV")
save(pcr.cv.fit, file  = "data/pcr-cv-models.RData")

# Extract the best ncomp
pcr.best.ncomp <- which.min(pcr.cv.fit$validation$PRESS)

# Plot cross-validation errors
png("images/pcr-scatterplot.png")
validationplot(pcr.cv.fit, val.type  = "MSEP", main  = "Scatter Plot for PCR")
dev.off()

# Generate best model to compute test MSE for test set
predictions <- predict(pcr.cv.fit, newdata  = x[test,], ncomp = pcr.best.ncomp)
pcr.error <- mean((predictions-y[test])^2)

# Fit full model
pcr.fit <- pcr(y ~ x, ncomp = pcr.best.ncomp)

# Output primary results to text file
sink("data/pcr-results.txt")
cat("Best Num of Components:", pcr.best.ncomp, "\n")
cat("Test MSE:", pcr.error, "\n")
cat("Official coefficients:", "\n")
print(coef(pcr.fit))
sink()

# Save official model, best ncomp and test set MSE to RData file
save(pcr.fit, pcr.best.ncomp, pcr.error, file  = "data/pcr-results.RData")
