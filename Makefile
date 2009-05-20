# Makefile for Sphinx documentation
#
# $(SPHINXBUILD) -b html $(ALLSPHINXOPTS) $$lang $(BUILDDIR)/$$lang;
#

# You can set these variables from the command line.
BUILDDIR     = build
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
PAPER         =
LANGUAGES     = en de

# Internal variables.
PAPEROPT_a4     = -D latex_paper_size=a4
PAPEROPT_letter = -D latex_paper_size=letter
ALLSPHINXOPTS   = -d $(BUILDDIR)/doctrees/$$lang $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) -c . -A language=$$lang -D language=$$lang

.PHONY: help clean html web pickle htmlhelp latex changes linkcheck

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  html      to make standalone HTML files"
	@echo "  pickle    to make pickle files"
	@echo "  json      to make JSON files"
	@echo "  htmlhelp  to make HTML files and a HTML help project"
	@echo "  latex     to make LaTeX files, you can set PAPER=a4 or PAPER=letter"
	@echo "  changes   to make an overview over all changed/added/deprecated items"
	@echo "  linkcheck to check all external links for integrity"

clean:
	-rm -rf build/*

html:
	@for lang in $(LANGUAGES);\
	do \
		mkdir -p $(BUILDDIR)/html/$$lang $(BUILDDIR)/doctrees/$$lang; \
		$(SPHINXBUILD) -b html $(ALLSPHINXOPTS) $$lang $(BUILDDIR)/html/$$lang;\
		cp -R _static $(BUILDDIR)/html/; \
	done
	@echo
	@echo "Build finished. The HTML pages are in $(BUILDDIR)/html/<language>.";\


pickle:
	@for lang in $(LANGUAGES);\
	do \
		mkdir -p $(BUILDDIR)/pickle/$$lang $(BUILDDIR)/doctrees/$$lang; \
		$(SPHINXBUILD) -b pickle $(ALLSPHINXOPTS) $$lang $(BUILDDIR)/pickle/$$lang;\
	done
	@echo
	@echo "Build finished; now you can process the pickle files."

web: pickle

json:
	@for lang in $(LANGUAGES);\
	do \
		mkdir -p $(BUILDDIR)/json/$$lang $(BUILDDIR)/doctrees/$$lang; \
		$(SPHINXBUILD) -b json $(ALLSPHINXOPTS) $$lang $(BUILDDIR)/json/$$lang;\
	done
	@echo
	@echo "Build finished; now you can process the JSON files."

htmlhelp:
	@for lang in $(LANGUAGES);\
	do \
		mkdir -p $(BUILDDIR)/htmlhelp/$$lang $(BUILDDIR)/doctrees/$$lang; \
		$(SPHINXBUILD) -b htmlhelp $(ALLSPHINXOPTS) $$lang $(BUILDDIR)/htmlhelp/$$lang;\
	done
	@echo
	@echo "Build finished; now you can run HTML Help Workshop with the" \
	      ".hhp project file in $(BUILDDIR)/htmlhelp/<language>."

latex:
	@for lang in $(LANGUAGES);\
	do \
		mkdir -p $(BUILDDIR)/latex/$$lang $(BUILDDIR)/doctrees/$$lang; \
		$(SPHINXBUILD) -b latex $(ALLSPHINXOPTS) $$lang $(BUILDDIR)/latex/$$lang;\
	done
	@echo
	@echo "Build finished; the LaTeX files are in $(BUILDDIR)/latex/<language>."\
	@echo "Run \`make all-pdf' or \`make all-ps'"

all-pdf:
	@for lang in $(LANGUAGES);\
	do \
		/usr/bin/make -C $(BUILDDIR)/latex/$$lang all-pdf ; \
		if [ -d $(BUILDDIR)/html/$$lang ]; then \
		mv -f $(BUILDDIR)/latex/$$lang/MapServer.pdf $(BUILDDIR)/html/$$lang ; \
		fi \
	done

all-ps:
	@for lang in $(LANGUAGES);\
	do \
		/usr/bin/make -C $(BUILDDIR)/latex/$$lang all-ps ; \
		if [ -d $(BUILDDIR)/html/$$lang ]; then \
		mv -f $(BUILDDIR)/latex/$$lang/MapServer.pdf $(BUILDDIR)/html/$$lang ; \
		fi \
	done

changes:
	@for lang in $(LANGUAGES);\
	do \
		mkdir -p $(BUILDDIR)/changes/$$lang $(BUILDDIR)/doctrees/$$lang; \
		$(SPHINXBUILD) -b changes $(ALLSPHINXOPTS) $$lang $(BUILDDIR)/changes/$$lang;\
	done
	@echo
	@echo "The overview file is in $(BUILDDIR)/changes/<language>."

linkcheck:
	@for lang in $(LANGUAGES);\
	do \
		mkdir -p $(BUILDDIR)/linkcheck/$$lang $(BUILDDIR)/doctrees/$$lang; \
		$(SPHINXBUILD) -b linkcheck $(ALLSPHINXOPTS) $$lang $(BUILDDIR)/linkcheck/$$lang;\
	done
	@echo
	@echo "Link check complete; look for any errors in the above output " \
	      "or in $(BUILDDIR)/linkcheck/<language>/output.txt."

labels:
	@for lang in $(LANGUAGES);\
	do \
		mkdir -p $(BUILDDIR)/labels/$$lang $(BUILDDIR)/doctrees/$$lang; \
		$(SPHINXBUILD) -b labels $(ALLSPHINXOPTS) $$lang $(BUILDDIR)/labels/$$lang;\
		cp $(BUILDDIR)/labels/$$lang/labels.txt $$lang/include/labels.inc;\
	done
	@echo
	@echo "Label generation complete; look for any errors in the above output " \
	      "or in $(BUILDDIR)/labels/<language>/labels.txt."
