filename=main.tex

pdf: clean
	pdflatex $(filename)
	biber $(basename $(filename))
	pdflatex $(filename)
	pdflatex $(filename)

pdf-ps: ps
	ps2pdf ${filename}.ps

pdf-print: ps
	ps2pdf -dColorConversionStrategy=/LeaveColorUnchanged -dPDFSETTINGS=/printer ${filename}.ps

text: html
	html2text -width 100 -style pretty ${filename}/${filename}.html | sed -n '/./,$$p' | head -n-2 >${filename}.txt

html:
	@#latex2html -split +0 -info "" -no_navigation ${filename}
	htlatex ${filename}

ps:	dvi
	dvips -t letter ${filename}.dvi

dvi:
	latex ${filename}
	bibtex ${filename}||true
	latex ${filename}
	latex ${filename}

read:
	evince ${filename}.pdf &

aread:
	acroread ${filename}.pdf

clean:
	rm -f *.aux *.log *.out *.toc *.bbl *.blg *.run.xml *.fdb_latexmk *.fls *.lof *.lot *.bcf *.synctex.gz *.dvi *.ps *.pdf *.html *.css *.xml *.xhtml *.htm *.xhtm *.bbl *.blg
