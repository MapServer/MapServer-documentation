# Makefile for Sphinx documentation
#
# $(SPHINXBUILD) -b html $(ALLSPHINXOPTS) $$lang $(BUILDDIR)/$$lang;
#

# You can set these variables from the command line.
BUILDDIR     = build
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
PAPER         = a4
SHELL = /bin/bash

# Note: uk for ukrainian has been removed due to error with UK flag. We should use
# uk_UA if we need to enable again.
TRANSLATIONS = ar de el es fr id it ja nl_NL pl ru sq tr
LANGUAGES     = en $(TRANSLATIONS)
BUILD_LANGUAGES = $(TRANSLATIONS)

# Internal variables.
PAPEROPT_a4     = -D latex_paper_size=a4
PAPEROPT_letter = -D latex_paper_size=letter
ALLSPHINXOPTS   = -d $(BUILDDIR)/doctrees/$$lang $(SPHINXOPTS) -c . -A language=$$lang -D language=$$lang -A languages='$(LANGUAGES)' -A branch=$(TRAVIS_BRANCH)

ALLSPHINXOPTSI18N = $(SPHINXOPTS) -c . -a -A language=$$lang -D language=$$lang -A languages='$(LANGUAGES)'

# Only for Gettext
I18NSPHINXOPTS   = $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) -c . -A language=en -D language=en -A languages='en'

.PHONY: help clean html web pickle htmlhelp latex changes linkcheck

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  html      to make standalone HTML files"
	@echo "  init      to preprocess translation directories"
	@echo "  compile_messages    to compile po to mo files"
	@echo "  generate_po_from_tmpl    to duplicate pot to po files for a language, e.g from translated\pot directory to translated\lang"
	@echo "  pickle    to make pickle files"
	@echo "  json      to make JSON files"
	@echo "  htmlhelp  to make HTML files and a HTML help project"
	@echo "  latex     to make LaTeX files, you can set PAPER=a4 or PAPER=letter"
	@echo "  all-pdf   to make PDF file"
	@echo "  all-ps    to make PS file"
	@echo "  changes   to make an overview over all changed/added/deprecated items"
	@echo "  linkcheck to check all external links for integrity"
	@echo "  gettext   to generate pot files from en rst files"
	@echo "  gettext_copy   to duplicate pot files from gettext dir to translated\pot"

clean:
	-rm -rf $(BUILDDIR)/* init compile_messages

init: en/*
	@set -e; for lang in $(TRANSLATIONS_STATIC) ;\
	do \
		for file in `cd en; find . -type f -name '*.txt' ; cd ..;`; \
		do \
			if [ ! -f $$lang/$$file ]; then  \
				mkdir -p `dirname "$$lang/$$file"`; \
				(echo ".. meta::"; echo "  :ROBOTS: NOINDEX") | cat - "en/$$file" > "$$lang/$$file"; \
			fi \
		done; \
		for file in `cd en; find . -type f ; cd ..;`; \
		do \
			if [ ! -f $$lang/$$file ]; then  \
				mkdir -p `dirname "$$lang/$$file"`; \
				cp -p "en/$$file" "$$lang/$$file"; \
			fi \
		done; \
	done
	@echo "Init finished. Other target can now be built.";\
	touch init


compile_messages: init translated/*/*.po
	@set -e; for lang in $(BUILD_LANGUAGES) ;\
	do \
		echo "Compiling messages for $$lang..."; \
		for f in `find ./translated/$$lang -type f -name \*.po`; \
		do \
		bn=`basename $$f .po`; \
		echo "Compiling messages for $$f"; \
		msgfmt $$f -o ./translated/$$lang/LC_MESSAGES/$$bn.mo; \
		done; \
	done
	@echo "Messages compiled. Now you can build updated version for html and pdf.";\
	touch compile_messages

generate_po_from_tmpl:
	@for lang in $(BUILD_LANGUAGES) ;\
	do \
		echo "Generate po files from pot files for $$lang..."; \
		for f in `find ./translated/pot/ -name \*.pot -printf "%f\n"`; \
		do \
		echo "Copy pot files to po file for $$f"; \
		cp ./translated/pot/$$f ./translated/$$lang/$${f%.*}.po; \
		done; \
	done
	@echo "*.pot files copy to *.po files. Now you can start your translation.";\

update_po_from_pot:
	@for lang in $(BUILD_LANGUAGES) ;\
	do \
		echo "Update po files from pot files for $$lang..."; \
		for f in `find ./translated/pot/ -name \*.pot -printf "%f\n"`; \
		do \
			echo "update po files from pot file for $$f"; \
			msgmerge ./translated/$$lang/$${f%.*}.po ./translated/pot/$$f -U -N; \
		done; \
	done
	@echo "*.po files updated from *.pot files.";\

html: compile_messages
	@set -e; \
	lang=en; \
	mkdir -p $(BUILDDIR)/html $(BUILDDIR)/doctrees/$$lang; \
	echo $(SPHINXBUILD) -b html $(ALLSPHINXOPTS) $$lang $(BUILDDIR)/html; \
	$(SPHINXBUILD) -b html $(ALLSPHINXOPTS) $$lang $(BUILDDIR)/html; \
	for lang in $(BUILD_LANGUAGES); \
	do \
		mkdir -p $(BUILDDIR)/html/$$lang $(BUILDDIR)/doctrees/$$lang; \
		if [[ "$(BUILD_LANGUAGES)" =~ "$$lang" ]]; then \
			$(SPHINXBUILD) -b html $(ALLSPHINXOPTSI18N) en build/html/$$lang; \
		fi \
	done
	@echo "Build finished. The HTML pages are in $(BUILDDIR)/html/<language>.";

gettext:
		mkdir -p $(BUILDDIR)/gettext/en $(BUILDDIR)/doctrees/en; \
		echo "$(SPHINXBUILD) -b gettext $(I18NSPHINXOPTS) en $(BUILDDIR)/gettext/en";\
		$(SPHINXBUILD) -b gettext $(I18NSPHINXOPTS) en $(BUILDDIR)/gettext/en;\

	@echo "Build finished. The pot files pages are in $(BUILDDIR)/gettext/en.";\

gettext_copy:
	    cp $(BUILDDIR)/gettext/en/*.pot translated/pot/; \

	@echo "Build finished. The pot files pages are in $(BUILDDIR)/gettext/en.";\

singlehtml: compile_messages
	@set -e; for lang in en $(TRANSLATIONS_STATIC);\
	do \
		mkdir -p $(BUILDDIR)/singlehtml/$$lang $(BUILDDIR)/doctrees/$$lang; \
		$(SPHINXBUILD) -b singlehtml $(ALLSPHINXOPTS) $$lang $(BUILDDIR)/singlehtml/$$lang;\
	done
	@set -e; for lang in $(TRANSLATIONI18N);\
	do \
		mkdir -p $(BUILDDIR)/singlehtml/$$lang $(BUILDDIR)/doctrees/$$lang; \
		$(SPHINXBUILD) -b singlehtml $(ALLSPHINXOPTSI18N) en $(BUILDDIR)/singlehtml/$$lang;\
	done
	@echo
	@echo "Build finished. The HTML pages are in $(BUILDDIR)/singlehtml/<language>.";\

pickle: compile_messages
	@set -e; for lang in en $(TRANSLATIONS_STATIC);\
	do \
		mkdir -p $(BUILDDIR)/pickle/$$lang $(BUILDDIR)/doctrees/$$lang; \
		$(SPHINXBUILD) -b pickle $(ALLSPHINXOPTS) $$lang $(BUILDDIR)/pickle/$$lang;\
	done
	@set -e; for lang in $(TRANSLATIONI18N);\
	do \
		mkdir -p $(BUILDDIR)/pickle/$$lang $(BUILDDIR)/doctrees/$$lang; \
		$(SPHINXBUILD) -b pickle $(ALLSPHINXOPTSI18N) en $(BUILDDIR)/pickle/$$lang;\
	done
	@echo
	@echo "Build finished; now you can process the pickle files."

web: pickle

json: compile_messages
	@set -e; for lang in en $(TRANSLATIONS_STATIC);\
	do \
		mkdir -p $(BUILDDIR)/json/$$lang $(BUILDDIR)/doctrees/$$lang; \
		$(SPHINXBUILD) -b json $(ALLSPHINXOPTS) $$lang $(BUILDDIR)/json/$$lang;\
	done
	@set -e; for lang in $(TRANSLATIONI18N);\
	do \
		mkdir -p $(BUILDDIR)/json/$$lang $(BUILDDIR)/doctrees/$$lang; \
		$(SPHINXBUILD) -b json $(ALLSPHINXOPTSI18N) en $(BUILDDIR)/json/$$lang;\
	done
	@echo
	@echo "Build finished; now you can process the JSON files."

htmlhelp: compile_messages
	@set -e; for lang in en $(TRANSLATIONS_STATIC);\
	do \
		mkdir -p $(BUILDDIR)/htmlhelp/$$lang $(BUILDDIR)/doctrees/$$lang; \
		$(SPHINXBUILD) -b htmlhelp $(ALLSPHINXOPTS) $$lang $(BUILDDIR)/htmlhelp/$$lang;\
	done
	@echo
	@echo "Build finished; now you can run HTML Help Workshop with the" \
	      ".hhp project file in $(BUILDDIR)/htmlhelp/<language>."

latex: compile_messages
	@set -e; \
		mkdir -p $(BUILDDIR)/latex/en $(BUILDDIR)/doctrees/en; \
		$(SPHINXBUILD) -b latex $(ALLSPHINXOPTS) en $(BUILDDIR)/latex/en;
	@echo "Build finished; the LaTeX files are in $(BUILDDIR)/latex/<language>."
	@echo "Run \`make all-pdf' or \`make all-ps'"

pdf: compile_messages
	@set -e;\
	$(SPHINXBUILD) -b pdf $(ALLSPHINXOPTS) en $(BUILDDIR)/pdf;\
	@set -e; for lang in $(BUILD_LANGUAGES);\
	do \
		mkdir -p $(BUILDDIR)/pdf/$$lang $(BUILDDIR)/doctrees/$$lang; \
		$(SPHINXBUILD) -b pdf $(ALLSPHINXOPTSI18N) en $(BUILDDIR)/pdf/$$lang;\
	done
	@echo
	@echo "Build finished; the PDF files are in $(BUILDDIR)/pdf/<language>."\
	@echo "Run \`make pdf' "

epub: compile_messages
	@set -e; for lang in en;\
	do \
		mkdir -p $(BUILDDIR)/epub/$$lang $(BUILDDIR)/doctrees/$$lang; \
		$(SPHINXBUILD) -b epub $(ALLSPHINXOPTS) $$lang $(BUILDDIR)/epub/$$lang;\
	done
	@echo
	@echo "Build finished; the epub files are in $(BUILDDIR)/epub/<language>."\
	@echo "Run \`make epub' "

all-pdf: latex
	@set -e; \
	make -C $(BUILDDIR)/latex/en all-pdf ;

all-ps: latex
	@set -e; for lang in $(LANGUAGES);\
	do \
		make -C $(BUILDDIR)/latex/$$lang all-ps ; \
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

# for installation see https://sphinxcontrib-spelling.readthedocs.io/en/latest/install.html		  
spelling:
	@for lang in $(LANGUAGES);\
	do \
		mkdir -p $(BUILDDIR)/spelling/$$lang $(BUILDDIR)/doctrees/$$lang; \
		$(SPHINXBUILD) -b spelling $(ALLSPHINXOPTS) $$lang $(BUILDDIR)/spelling/$$lang;\
	done
	@echo
	@echo "Spelling complete; look for any errors in the above output " \
	      "or in $(BUILDDIR)/spelling/<language>/output.txt."		  

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


all: html all-pdf epub all-ps
