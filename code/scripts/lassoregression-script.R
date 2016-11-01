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
fit <- cv.glmnet(x[train,], y[train], alpha = 1, intercept = FALSE,
                 standardize = FALSE, lambda = grid)
save(fit, file = "data/lassoregression-cv-models.RData")

# Extract the best lambda
best.lambda <- fit$lambda.min
