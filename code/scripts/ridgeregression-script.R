library(glmnet)
#set seed to project default
set.seed(123)

#load scaled credit data and test/train vectors
scaled = read.csv('data/scaled-credit.csv', header=T)
load('data/test-train-vectors.RData')

#dummy out categorical variables
x = model.matrix(Balance~., scaled)[,-1]
y = scaled$Balance

#fit various models with different lambdas by cross-validation
grid = 10^seq(10, -2, length = 100)
fit = cv.glmnet(x[train,], y[train], alpha=0, intercept=FALSE, standardize=FALSE, lambda=grid)
save(fit, file="data/ridgeregression-cv-models.RData")

#extract the best lambda of all the lambdas we've tried
best_lambda = fit$lambda.min

#plot cross-validation errors in terms of lambda
png("images/scatterplot-ridgeregression.png")
plot(fit)
dev.off()

#generate best model to compute test MSE for test set
best_fit = glmnet(x[train,], y[train], alpha=0, standardize=FALSE, lambda=best_lambda)
predictions = predict(best_fit, s=best_lambda, newx=x[test,])
error = mean((predictions-y[test])^2)

#fit full model using best lambda
fit = glmnet(x, y, alpha=0, standardize=FALSE, lambda=best_lambda)

#output primary results to text file
sink("data/ridgeregression-results.txt")
cat("Best Lambda:", best_lambda, "\n")
cat("Test MSE:", error, "\n")
cat("Official coefficients", "\n")
coef(fit)
sink()

#save official coefficients, best lambda and test set MSE to RData file
save(fit, best_lambda, error, file="data/ridgeregression-best-results.RData")