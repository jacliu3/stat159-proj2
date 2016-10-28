credit.data <- read.csv("data/Credit.csv")
credit.data$X <- NULL

for (col.name in names(credit.data)) {
  sink(file="data/eda-output.txt", append=TRUE)
  cat(col.name, "\n\n", sep="")
  sink()
  temp.data <- credit.data[, col.name]
  if (is.numeric(temp.data)) {
    sink(file="data/eda-output.txt", append=TRUE)
    cat("Min: ", signif(min(temp.data), digits=4), "\t", sep="")
    cat("Max: ", signif(max(temp.data), digits=4), "\t", sep="")
    cat("Range: ", signif(diff(range(temp.data)), digits=4), "\n", sep="")
    cat("Median: ", signif(median(temp.data), digits=4), "\t", sep="")
    cat("First Q: ", signif(quantile(temp.data, 1/4), digits=4), "\t", sep="")
    cat("Third Q: ", signif(quantile(temp.data, 3/4), digits=4), "\t", sep="")
    cat("IQR: ", signif(IQR(temp.data), digits=4), "\n", sep="")
    cat("Mean: ", signif(mean(temp.data), digits=4), "\t", sep="")
    cat("SD: ", signif(sd(temp.data), digits=4), "\n\n", sep="")
    sink()
  }
}
