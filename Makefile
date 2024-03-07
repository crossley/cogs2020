all:
	Rscript -e "rmarkdown::render('syllabus.Rmd')"
	Rscript -e "rmarkdown::render('lectures.Rmd')"
	Rscript -e "rmarkdown::render('tutorials.Rmd')"
	Rscript -e "rmarkdown::render('homework.Rmd')"
	Rscript -e "rmarkdown::render('index.Rmd')"

clean:
	rm -f *.html
