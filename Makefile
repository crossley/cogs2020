all:
	Rscript -e "rmarkdown::render('lectures.Rmd')"
	Rscript -e "rmarkdown::render('practice.Rmd')"
	Rscript -e "rmarkdown::render('tutorials.Rmd')"
	Rscript -e "rmarkdown::render('index.Rmd')"

clean:
	rm -f *.html
