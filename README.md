---
title: "Project 2- Predictive Modeling"
author: "Steven Chen, Jacqueline Liu"
date: "Nov 4th, 2016"
---
## Predictive Modeling Process

###Structure 

The file structure of this project is as follows:

```
stat159-project2/
	.gitignore
	README.md
	LICENSE
	Makefile
	session-info.txt
	session.sh                    
	code/
		README.md
	  	...
	  	scripts/
	  		...
	data/
		README.md
		...
	images/
		...
	report/
		report.Rmd
		report.pdf
		sections/
			...
	slides/
		slides.Rmd
		slides.html
		...
```

Inside the `code/` subdirectory, you can find all the R scripts used to perform our analysis.

The `data/` subdirectory contains our primary data set `Credit.csv`, R Data, and text outputs from our analysis.

The `images` subdirectory contains all the graphs and plots we output during the analysis.

The `report` subdirectory contains our report in .Rmd and .pdf format as well as individual sections of report.

The `slides` subdirectory contains our slide presentation in .Rmd and .html format.

###Perform Analysis

This project is focused on reproducing the analysis from sections 6.2, 6.3, 6.6 and 6.7 in Chapter 6:_Linear Model Selection and Regularization_, of the book [An introduction to Statistical Learning (by James et at)](http://www-bcf.usc.edu/~gareth/ISL/).


To start reproducing our analysis, start off by cloning our repository:

```bash
git clone https://github.com/jacliu3/stat159-proj2
cd stat159-proj2
```

Inside our repository, you can run make commands to run the analysis and generate different outputs. Below is a list of make commands:

- `all:` will be associated to phony targets `eda`, `regressions`, and `report`
- `data:` will download the file `Credit.csv` to the folder `data/` 
- `tests:` will run the unit tests of your functions
- `eda:` will perform the exploratory data analysis
- `ols`: OLS regression
- `ridge`: Ridge Regression
- `lasso`: Lasso Regression
- `pcr`: Principal Components Regression
- `plsr`: Partial Least Squares Regression
- `regressions`: all five types of regressions
- `report:` will generate `report.pdf` (or `report.html`)
- `slides`: will generate `slides.html`
- `session`: will generate `session-info.txt`
- `clean:` will delete the generated report (pdf and/or html)


<a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/">Creative Commons Attribution-NonCommercial 4.0 International License</a>. 

All source code (i.e. code in R script files) is licensed under GNU General Public License, version 3. See the LICENSE file for more information
