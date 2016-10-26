#variables
DATAURL = http://www-bcf.usc.edu/~gareth/ISL/Credit.csv
AD = data/Credit.csv
CS = code/scripts/
CF = code/functions/
CT = code/tests/
PAPER = abstract.Rmd introduction.Rmd data.Rmd methods.Rmd analysis.Rmd results.Rmd conclusions.Rmd

#targets
.PHONY: all data eda tests ols ridge lasso pcr plsr regressions report slides clean deep-clean skeleton session

all: eda regressions report
	Rscript $(CS)session-info-script.R

data:
	curl $(DATAURL) --output $(AD)

eda: $(CS)eda-script.R $(AD)
	Rscript $<

regressions: $(CS)regression-script.R $(AD)
	Rscript $<

tests: code/test-that.R $(CF)regression-functions.R $(CT)test-regression.R
	Rscript $<

report: regressions eda $(CF)regression-functions.R
	Rscript -e "library(rmarkdown); render('report/report.Rmd')"
	Rscript -e "library(rmarkdown); render('report/report.Rmd', output_format='html_document')"

clean:
	rm -f report/report.pdf
	rm -f report/report.html

deep-clean:
	rm -r -f code data images report
	
skeleton:
	mkdir data code images report slides
	touch data/README.md report/report.Rmd
	cd code;\
	mkdir functions scripts tests;\
	touch README.md test-that.R;\
	touch scripts/data-preprocessing.R scripts/eda-script.R scripts/session-info-script.R;\
	touch functions/regression-functions.R tests/test-regression.R
	mkdir report/sections;
	cd report/sections;\
	touch $(PAPER)



