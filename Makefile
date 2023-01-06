# Thesis
THESIS_ALL_TEX= $(ls -l *.tex)
DEFAULT_TARGET= whole_thesis
DEFAULT_PDF= thesis.pdf
COMPILE_SLIDES := xelatex -shell-escape

default: $(DEFAULT_TARGET)
all: whole_thesis \
     chapter_introduction chapter_conclusion

thesis.pdf: whole_thesis

# Compile the whole thesis
whole_thesis: $(THESIS_ALL_TEX) Makefile references.bib
	cp macros.include.default.tex macros.include.tex
	pdflatex -shell-escape thesis.tex
	biber thesis.bcf
	pdflatex -shell-escape thesis.tex
	pdflatex -shell-escape thesis.tex

############################
# Only compile one chapter #
############################
	
chapter_introduction: $(THESIS_ALL_TEX) Makefile references.bib
	echo "\\\def \\\includechapterintroduction {true}" > macros.include.tex
	echo "\\\totalcompilationfalse" >> macros.include.tex
	echo "\\\watermarkfalse" >> macros.include.tex
	pdflatex -synctex=1 -shell-escape -jobname=$@ thesis.tex
	#nix-shell -p rubber --run "rubber --pdf --synctex --unsafe -Wall --jobname $@ thesis.tex"

markovDecisionProcess_chapter: $(THESIS_ALL_TEX) Makefile references.bib
	echo "\\\def \\\includemdpchapter {true}" > macros.include.tex
	echo "\\\totalcompilationfalse" >> macros.include.tex
	echo "\\\watermarkfalse" >> macros.include.tex
	pdflatex -synctex=1 -shell-escape -jobname=$@ thesis.tex
	biber $@.bcf
	pdflatex -synctex=1 -shell-escape -jobname=$@ thesis.tex

markovianBandit_chapter: $(THESIS_ALL_TEX) Makefile references.bib
	echo "\\\def \\\includemarkovianbanditchapter {true}" > macros.include.tex
	echo "\\\totalcompilationfalse" >> macros.include.tex
	echo "\\\watermarkfalse" >> macros.include.tex
	pdflatex -synctex=1 -shell-escape -jobname=$@ thesis.tex
	biber $@.bcf
	pdflatex -synctex=1 -shell-escape -jobname=$@ thesis.tex

indexDefinition_chapter: $(THESIS_ALL_TEX) Makefile references.bib
	echo "\\\def \includeindexDefinitionchapter {true}" > macros.include.tex
	echo "\\\totalcompilationfalse" >> macros.include.tex
	echo "\\\watermarkfalse" >> macros.include.tex
	pdflatex -synctex=1 -shell-escape -jobname=$@ thesis.tex
	biber $@.bcf
	pdflatex -synctex=1 -shell-escape -jobname=$@ thesis.tex

indexComputation_chapter: $(THESIS_ALL_TEX) Makefile references.bib
	echo "\\\def \includeindexComputationchapter {true}" > macros.include.tex
	echo "\\\totalcompilationfalse" >> macros.include.tex
	echo "\\\watermarkfalse" >> macros.include.tex
	pdflatex -synctex=1 -shell-escape -jobname=$@ thesis.tex
	biber $@.bcf
	pdflatex -synctex=1 -shell-escape -jobname=$@ thesis.tex

reinforcementLearning_chapter: $(THESIS_ALL_TEX) Makefile references.bib
	echo "\\\def \\\includereinforcementlearningchapter {true}" > macros.include.tex
	echo "\\\totalcompilationfalse" >> macros.include.tex
	echo "\\\watermarkfalse" >> macros.include.tex
	pdflatex -synctex=1 -shell-escape -jobname=$@ thesis.tex
	biber $@.bcf
	pdflatex -synctex=1 -shell-escape -jobname=$@ thesis.tex

learningAlgorithmsRestedMB_chapter: $(THESIS_ALL_TEX) Makefile references.bib
	echo "\\\def \includelearningAlgorithmsRestedMBchapter {true}" > macros.include.tex
	echo "\\\totalcompilationfalse" >> macros.include.tex
	echo "\\\watermarkfalse" >> macros.include.tex
	pdflatex -synctex=1 -shell-escape -jobname=$@ thesis.tex
	biber $@.bcf
	pdflatex -synctex=1 -shell-escape -jobname=$@ thesis.tex

learningAlgorithmsRestlessMB_chapter: $(THESIS_ALL_TEX) Makefile references.bib
	echo "\\\def \includelearningAlgorithmsRestlessMBchapter {true}" > macros.include.tex
	echo "\\\totalcompilationfalse" >> macros.include.tex
	echo "\\\watermarkfalse" >> macros.include.tex
	pdflatex -synctex=1 -shell-escape -jobname=$@ thesis.tex
	biber $@.bcf
	pdflatex -synctex=1 -shell-escape -jobname=$@ thesis.tex

chapter_conclusion: $(THESIS_ALL_TEX) Makefile references.bib
	echo "\\\def \\\includechapterconclusion {true}" > macros.include.tex
	echo "\\\totalcompilationfalse" >> macros.include.tex
	echo "\\\watermarkfalse" >> macros.include.tex
	pdflatex -synctex=1 -shell-escape -jobname=$@ thesis.tex

chapter_appendix: $(THESIS_ALL_TEX) Makefile references.bib
	echo "\\\def \\\includechapterappendix {true}" > macros.include.tex
	echo "\\\totalcompilationfalse" >> macros.include.tex
	echo "\\\watermarkfalse" >> macros.include.tex
	pdflatex -synctex=1 -shell-escape -jobname=$@ thesis.tex

chapter_appendixtwo: $(THESIS_ALL_TEX) Makefile references.bib
	echo "\\\def \\\includechapterappendixtwo {true}" > macros.include.tex
	echo "\\\totalcompilationfalse" >> macros.include.tex
	echo "\\\watermarkfalse" >> macros.include.tex
	pdflatex -synctex=1 -shell-escape -jobname=$@ thesis.tex


#########################
# Convenience shortcuts #
#########################

check_missing_refs_no_rebuild:
	tools/check_missing_refs.py -d .

check_missing_refs: whole_thesis check_missing_refs_no_rebuild

check_unreferenced_labels:
	tools/check_unreferenced_labels.bash *.tex

check_uncited_references:
	tools/check_uncited_references.bash references.bib *.tex

############
# cleaning #
############
clean:
	rm -f *.aux *.bbl *.bcf *.blg *.lof *.log *.lot *.out *.run.xml *.toc *.upa *-blx.bib *.snm *.nav *.vrb
	rm -f macros.include.tex
	rm -rf svg-inkscape

distclean: clean
	rm -f thesis.pdf
	rm -f chapter*.pdf
	rm -f slides.pdf slides_old.pdf

mrproper: clean

# Disable parallel build
.NOTPARALLEL:
