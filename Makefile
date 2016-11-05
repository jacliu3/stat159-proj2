#variables
DATAURL = http://www-bcf.usc.edu/~gareth/ISL/Credit.csv
CSV = data/Credit.csv
CS = code/scripts/
PAPER = abstract.Rmd introduction.Rmd data.Rmd methods.Rmd analysis.Rmd results.Rmd conclusions.Rmd

#targets
.PHONY: all data eda ols ridge lasso pcr plsr regressions report slides clean deep-clean skeleton session paper

all: eda regressions report
	Rscript $(CS)session-info-script.R

data: 
	curl $(DATAURL) --output $(CSV)

eda: $(CS)eda-script.R data
	Rscript $<

ols: data $(CS)olsregression-script.R
	Rscript $(CS)olsregression-script.R

ridge: data $(CS)ridgeregression-script.R
	Rscript $(CS)ridgeregression-script.R

lasso: data $(CS)lassoregression-script.R
	Rscript $(CS)lassoregression-script.R

pcr: data $(CS)pcr-script.R
	Rscript $(CS)pcr-script.R

plsr: data $(CS)plsr-script.R
	Rscript $(CS)plsr-script.R

regressions: data ols ridge lasso pcr plsr 

paper: report/sections/$(PAPER)

report: regressions eda paper
	Rscript -e "library(rmarkdown); render('report/report.Rmd')"

slides:
	Rscript -e "library(rmarkdown); render('slides/slides.Rmd')"

clean:
	rm -f report/report.pdf
	rm -f report/report.html

deep-clean:
	rm -r -f code data images report
	
skeleton:
	mkdir data code images report slides
	touch data/README.md report/report.Rmd
	cd code;\
	mkdir scripts;\
	touch README.md;\
	mkdir report/sections;
	cd report/sections;\
	touch $(PAPER)
