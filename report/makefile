# Project configs
LATEXARGS := -interaction nonstopmode

# Compiler configs
ifndef LATEX
	LATEX  := xelatex
endif
BIBTEX := bibtex

# Project rules
all: specification-1 specification-2

specification-1: specification-1.pdf
specification-2: specification-2.pdf

# Etc.
OBJS   := $(wildcard **/*.tex) $(wildcard *.tex)

ifdef BIBREF
	BIBREF := $(BIBREF).bib
endif

# Rules
.PHONY: clean clean-pdf all

all: $(TARGETS)

$(BRIEF).pdf: $(BRIEF).tex $(BIBREF)

%.pdf: %.tex $(BIBREF)
	$(LATEX) --shell-escape ${LATEXARGS} $(basename $@)
ifdef BIBREF
	$(BIBTEX) $(basename $@)
	$(LATEX) --shell-escape ${LATEXARGS} $(basename $@)
	$(LATEX) --shell-escape ${LATEXARGS} $(basename $@)
endif
	$(LATEX) --shell-escape ${LATEXARGS} $(basename $@)

clean:
	rm -f *.{aux,bbl,blg,log,nav,snm,out,toc}
	rm -rf _minted-*

clean-pdf:
	rm $(BRIEF).pdf
