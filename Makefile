# Makefile for Sphinx documentation
#
# $(SPHINXBUILD) -b html $(ALLSPHINXOPTS) $$lang $(BUILDDIR)/$$lang;
#

# You can set these variables from the command line.
BUILDDIR     = build
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
PAPER         =
TRANSLATIONS  = de fr it es zh_cn
TRANSLATIONI18N  =
LANGUAGES     = en $(TRANSLATIONS) 

# On mapserver.org we need to write alternate links for the language switcher.
# This is triggered by setting TARGET to 'mapserverorg'
# Unsetting or every other value will cause the standard behaviour.
#
#TARGET        = mapserverorg

# Internal variables.
PAPEROPT_a4     = -D latex_paper_size=a4
PAPEROPT_letter = -D latex_paper_size=letter
ALLSPHINXOPTS   = -d $(BUILDDIR)/doctrees/$$lang $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) -c . -A language=$$lang -D language=$$lang -A target=$(TARGET) -A languages='$(LANGUAGES) $(TRANSLATIONI18N)'

ALLSPHINXOPTSI18N = $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) -c . -a -A language=$$lang -D language=$$lang -A target=$(TARGET) -A languages='$(LANGUAGES) $(TRANSLATIONI18N)'

# Only for Gettext
I18NSPHINXOPTS   = $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) -c . -A language=en -D language=en -A target=$(TARGET) -A languages='en'

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
	-rm -rf $(BUILDDIR)/*

init:
	@for lang in $(TRANSLATIONS) ;\
	do \
# 		We change the Internal Field Separator (IFS) because to handle filename with special char like space. \
		OLDIFS="$$IFS"; \
		IFS=$$'\n'; \
		for file in `cd en; find . -type f -a -regex '.*\.txt$$' -a -not -regex '.*\.svn.*' -printf "%p\n" ; cd ..;`; \
		do \
			if [ ! -f $$lang/$$file ]; then  \
				mkdir -p `dirname "$$lang/$$file"`; \
				(echo ".. meta::"; echo "  :ROBOTS: NOINDEX") | cat - "en/$$file" > "$$lang/$$file"; \
			fi \
		done; \
		IFS=$$OLDIFS; \
#		Copy all no .txt files \
		yes n | cp -ipR en/* $$lang &> /dev/null; \
	done
	@echo "Init finished. Other target can now be build.";\

compile_messages:
	@for lang in $(TRANSLATIONI18N) ;\
	do \
		echo "Compiling messages for $$lang..."; \
		for f in `find ./translated/$$lang -name \*.po -printf "%f\n"`; \
		do \
		echo "Compiling messages for $$f"; \
		msgfmt ./translated/$$lang/$$f -o ./translated/$$lang/LC_MESSAGES/$${f%.*}.mo; \
		done; \
	done
	@echo "Messages compiled. Now you can build updated version for html and pdf.";\

generate_po_from_tmpl:
	@for lang in $(TRANSLATIONI18N) ;\
	do \
		echo "Generate po files from pot files for $$lang..."; \
		for f in `find ./translated/pot/ -name \*.pot -printf "%f\n"`; \
		do \
		echo "Copy pot files to po file for $$f"; \
		cp ./translated/pot/$$f ./translated/$$lang/$${f%.*}.po; \
		done; \
	done
	@echo "*.pot files copy to *.po files. Now you can start your translation.";\

html:
	@for lang in $(LANGUAGES);\
	do \
		mkdir -p $(BUILDDIR)/html/$$lang $(BUILDDIR)/doctrees/$$lang; \
		echo "$(SPHINXBUILD) -b html $(ALLSPHINXOPTS) $$lang $(BUILDDIR)/html/$$lang";\
		$(SPHINXBUILD) -b html $(ALLSPHINXOPTS) $$lang $(BUILDDIR)/html/$$lang;\
	done
	@for lang in $(TRANSLATIONI18N);\
	do \
		echo "$(SPHINXBUILD) -b html $(ALLSPHINXOPTSI18N) en build/html/$$lang";\
		$(SPHINXBUILD) -b html $(ALLSPHINXOPTSI18N) en build/html/$$lang;\
	done
	@echo
	@echo "Build finished. The HTML pages are in $(BUILDDIR)/html/<language>.";\

gettext:
		mkdir -p $(BUILDDIR)/gettext/en $(BUILDDIR)/doctrees/en; \
		echo "$(SPHINXBUILD) -b gettext $(I18NSPHINXOPTS) en $(BUILDDIR)/gettext/en";\
		$(SPHINXBUILD) -b gettext $(I18NSPHINXOPTS) en $(BUILDDIR)/gettext/en;\

	@echo "Build finished. The pot files pages are in $(BUILDDIR)/gettext/en.";\

gettext_copy:
	    cp $(BUILDDIR)/gettext/en/*.pot translated/pot/; \

	@echo "Build finished. The pot files pages are in $(BUILDDIR)/gettext/en.";\

singlehtml:
	@for lang in $(LANGUAGES);\
	do \
		mkdir -p $(BUILDDIR)/singlehtml/$$lang $(BUILDDIR)/doctrees/$$lang; \
		$(SPHINXBUILD) -b singlehtml $(ALLSPHINXOPTS) $$lang $(BUILDDIR)/singlehtml/$$lang;\
	done
	@for lang in $(TRANSLATIONI18N);\
	do \
		mkdir -p $(BUILDDIR)/singlehtml/$$lang $(BUILDDIR)/doctrees/$$lang; \
		$(SPHINXBUILD) -b singlehtml $(ALLSPHINXOPTSI18N) en $(BUILDDIR)/singlehtml/$$lang;\
	done
	@echo
	@echo "Build finished. The HTML pages are in $(BUILDDIR)/singlehtml/<language>.";\

pickle:
	@for lang in $(LANGUAGES);\
	do \
		mkdir -p $(BUILDDIR)/pickle/$$lang $(BUILDDIR)/doctrees/$$lang; \
		$(SPHINXBUILD) -b pickle $(ALLSPHINXOPTS) $$lang $(BUILDDIR)/pickle/$$lang;\
	done
	@for lang in $(TRANSLATIONI18N);\
	do \
		mkdir -p $(BUILDDIR)/pickle/$$lang $(BUILDDIR)/doctrees/$$lang; \
		$(SPHINXBUILD) -b pickle $(ALLSPHINXOPTSI18N) en $(BUILDDIR)/pickle/$$lang;\
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
	@for lang in $(TRANSLATIONI18N);\
	do \
		mkdir -p $(BUILDDIR)/json/$$lang $(BUILDDIR)/doctrees/$$lang; \
		$(SPHINXBUILD) -b json $(ALLSPHINXOPTSI18N) en $(BUILDDIR)/json/$$lang;\
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
	@for lang in $(TRANSLATIONI18N);\
	do \
		mkdir -p $(BUILDDIR)/latex/$$lang $(BUILDDIR)/doctrees/$$lang; \
		$(SPHINXBUILD) -b latex $(ALLSPHINXOPTSI18N) en $(BUILDDIR)/latex/$$lang;\
	done
	@echo
	@echo "Build finished; the LaTeX files are in $(BUILDDIR)/latex/<language>."\
	@echo "Run \`make all-pdf' or \`make all-ps'"

pdf:
	@for lang in $(LANGUAGES);\
	do \
		mkdir -p $(BUILDDIR)/pdf/$$lang $(BUILDDIR)/doctrees/$$lang; \
		$(SPHINXBUILD) -b pdf $(ALLSPHINXOPTS) $$lang $(BUILDDIR)/pdf/$$lang;\
	done
	@for lang in $(TRANSLATIONI18N);\
	do \
		mkdir -p $(BUILDDIR)/pdf/$$lang $(BUILDDIR)/doctrees/$$lang; \
		$(SPHINXBUILD) -b pdf $(ALLSPHINXOPTSI18N) en $(BUILDDIR)/pdf/$$lang;\
	done
	@echo
	@echo "Build finished; the PDF files are in $(BUILDDIR)/pdf/<language>."\
	@echo "Run \`make pdf' "

epub:
	@for lang in en;\
	do \
		mkdir -p $(BUILDDIR)/epub/$$lang $(BUILDDIR)/doctrees/$$lang; \
		$(SPHINXBUILD) -b epub $(ALLSPHINXOPTS) $$lang $(BUILDDIR)/epub/$$lang;\
	done
	@echo
	@echo "Build finished; the epub files are in $(BUILDDIR)/epub/<language>."\
	@echo "Run \`make epub' "

all-pdf:
	@for lang in $(LANGUAGES);\
	do \
		/usr/bin/make -C $(BUILDDIR)/latex/$$lang all-pdf ; \
		if [ -d $(BUILDDIR)/html/$$lang ]; then \
		mv -f $(BUILDDIR)/latex/$$lang/MapServer.pdf $(BUILDDIR)/html/$$lang ; \
		fi \
	done
	@for lang in $(TRANSLATIONI18N);\
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
