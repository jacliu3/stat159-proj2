### Data

The dataset `Credit.csv` was taken from _An Introduction to Statistical Learning_ by James et al. It can be found here: http://www-bcf.usc.edu/~gareth/ISL/Credit.csv. The preprocessed version of the data is saved as `scaled-data.csv`; for more information on how it was preprocessed, the script is `code/scripts/data-preprocessing.R`. 

The `test-train-vectors.R` hold the indices of the training and test sets of the data.

For each regression technique, the models created under cross-validation are saved as `<model name>-cv-models.Rdata`. The optimal models, along with the value of their tuning parameter and the associated test error, are saved as `<model name>-results.Rdata`. A human-readable version is saved as `<model name>-results.txt`. 