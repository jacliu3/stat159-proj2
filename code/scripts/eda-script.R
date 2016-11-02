library(ggplot2)

# Read data
credit.data <- read.csv("data/Credit.csv")
credit.data$X <- NULL
names(credit.data) <- tolower(names(credit.data))

# Create file of summary statistics and visuals
sink(file = "data/eda-output.txt")
sink()

for (col.name in names(credit.data)) {
  sink(file = "data/eda-output.txt", append = TRUE)
  cat(toupper(col.name), "\n\n", sep = "")
  sink()
  temp.data <- credit.data[, col.name]
  
  if (is.numeric(temp.data)) {
    # Quantitative variables
    # Basic statistics
    sink(file = "data/eda-output.txt", append = TRUE)
    cat("Min: ", signif(min(temp.data), digits = 4), "\t", sep = "")
    cat("Max: ", signif(max(temp.data), digits = 4), "\t", sep = "")
    cat("Range: ", signif(diff(range(temp.data)), digits = 4), "\n", sep = "")
    cat("Median: ", signif(median(temp.data), digits = 4), "\t", sep = "")
    cat("First Q: ", signif(quantile(temp.data, 1/4), digits = 4), "\t", sep = "")
    cat("Third Q: ", signif(quantile(temp.data, 3/4), digits = 4), "\t", sep = "")
    cat("IQR: ", signif(IQR(temp.data), digits = 4), "\n", sep = "")
    cat("Mean: ", signif(mean(temp.data), digits = 4), "\t", sep = "")
    cat("SD: ", signif(sd(temp.data), digits = 4), "\n\n", sep = "")
    sink()
    
    # Histograms and boxplots
    temp.plot <- ggplot(data.frame(col = temp.data)) + xlab(col.name) +
                 geom_histogram(aes(x = col))
    ggsave(filename = paste0("images/", col.name, "-hist.png"), plot = temp.plot)
    
    temp.plot <- ggplot(data.frame(col = temp.data)) + coord_flip() +
                  ylab(col.name) + geom_boxplot(aes(y = col, x = 1))
    ggsave(filename = paste0("images/", col.name, "-boxplot.png"), plot = temp.plot)
  } else {
    
    # Qualitative variables
    # Frequency tables
    sink(file = "data/eda-output.txt", append = TRUE)
    cat("Counts:")
    print(table(temp.data, deparse.level = 0))
    cat("\n")
    cat("Proportions:")
    print(round(table(temp.data, deparse.level = 0) / length(temp.data),
                digits = 2))
    cat("\n")
    sink()
  }
}

quantitativeVariables = c(colnames(credit.data)[1:6], 'balance')
qualitativeVariables = colnames(credit.data)[7:11]
correlations = cor(credit.data[quantitativeVariables])
sink(file = "data/eda-output.txt", append = TRUE)
cat("Correlation Matrix\n")
correlations
cat("\n")
sink()

png('images/scatterplot-matrix.png')
pairs(~income+limit+rating+cards+age+education+balance, data=credit.data[quantitativeVariables], main = 'Scatterplot Matrix', cex=0.5)
dev.off()

allQualitative = aov(balance~gender+student+married+ethnicity, data=credit.data[qualitativeVariables])

male = credit.data$balance[credit.data$gender != "Male"]
female = credit.data$balance[credit.data$gender == "Female"]
png("images/boxplot-balance-gender.png")
boxplot(male, female, names=c("Male", "Female"), main="Balance Conditioned on Gender")
dev.off()

asian = credit.data$balance[credit.data$ethnicity == "Asian"]
caucasian = credit.data$balance[credit.data$ethnicity == "Caucasian"]
africanamerican = credit.data$balance[credit.data$ethnicity == "African American"]
png("images/boxplot-balance-ethnicity.png")
boxplot(asian, caucasian, africanamerican, names=c("Asian", "Caucasian", "African American"), main="Balance Conditioned on Ethnicity")
dev.off()

student = credit.data$balance[credit.data$student == "Yes"]
nonstudent = credit.data$balance[credit.data$student == "No"]
png("images/boxplot-balance-student.png")
boxplot(student, nonstudent, names=c("Student", "Nonstudent"), main="Balance Conditioned on Student")
dev.off()

married = credit.data$balance[credit.data$married == "Yes"]
nonmarried = credit.data$balance[credit.data$married == "No"]
png("images/boxplot-balance-married.png")
boxplot(married, nonmarried, names=c("Married", "Nonmarried"), main="Balance Conditioned on Marital Status")
dev.off()
