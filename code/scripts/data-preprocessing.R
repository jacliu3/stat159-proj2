# Read and format data into numerical form
credit.data <- read.csv("data/Credit.csv")
credit.data$X <- NULL
credit.data <- cbind(data.frame(model.matrix(Balance~., data=credit.data))[-1],
                     Balance = credit.data$Balance)

# Centering and standardizing the features
scaled.data <- scale(credit.data)

# Save as csv file
write.csv(scaled.data, file="data/scaled-credit.csv")
