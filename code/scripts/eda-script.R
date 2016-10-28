library(ggplot2)

credit.data <- read.csv("data/Credit.csv")
credit.data$X <- NULL
names(credit.data) <- tolower(names(credit.data))

sink(file="data/eda-output.txt")
sink()

for (col.name in names(credit.data)) {
  sink(file="data/eda-output.txt", append=TRUE)
  cat(toupper(col.name), "\n\n", sep="")
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
    
    temp.plot <- ggplot(data.frame(col=temp.data)) + geom_histogram(aes(x=col)) + xlab(col.name)
    ggsave(filename=paste0("images/", col.name, "-hist.png"), plot=temp.plot)
    
    temp.plot <- ggplot(data.frame(col=temp.data)) + geom_boxplot(aes(y=col, x=1)) + coord_flip() + ylab(col.name)
    ggsave(filename=paste0("images/", col.name, "-boxplot.png"), plot=temp.plot)
  }
}
