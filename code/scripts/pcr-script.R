library(pls)
#set seed to project default
set.seed(123)

#load scaled credit data and test/train vectors
scaled = read.csv('data/scaled-credit.csv', header=T)
load('data/test-train-vectors.RData')

#dummy out categorical variables
x = model.matrix(Balance~., scaled)[,-1]
y = scaled$Balance

#fit various models by cross-validation
fit = pcr(y[train] ~ x[train,], validation="CV")
save(fit, file="data/pcr-cv-models.RData")

#extract the best param
best_param = min(fit$validation$PRESS)

#plot cross-validation errors
png("images/scatterplot-pcr.png")
validationplot(fit, val.type="MSEP", main="Scatter Plot for PCR")
dev.off()

#generate best model to compute test MSE for test set
predictions = predict(fit, newdata=x[test,], comps=1:11)
error = mean((predictions-y[test])^2)

#fit full model
fit = pcr(y ~ x, comps=1:11)

#output primary results to text file
sink("data/pcr-results.txt")
cat("Best Param:", best_param, "\n")
cat("Test MSE:", error, "\n")
cat("Official coefficients", "\n")
coef(fit)
sink()

#save official coefficients, best param and test set MSE to RData file
save(fit, best_param, error, file="data/pcr-best-results.RData")