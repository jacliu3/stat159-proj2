set.seed(123)

# Read and format data into numerical form
credit.data <- read.csv("data/Credit.csv")
credit.data$X <- NULL
credit.data <- cbind(data.frame(model.matrix(Balance~., data=credit.data))[-1],
                     Balance = credit.data$Balance)

# Centering and standardizing the features
scaled.data <- scale(credit.data)

# Save dataset csv fil and training/testing set vectors
write.csv(scaled.data, file="data/scaled-credit.csv")
train <- sample(1:400, 300)
test <- (1:400)[-train]
save(train, test, file="data/test-train-vectors.Rdata")
