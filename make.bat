@ECHO OFF
REM Command file for Sphinx documentation

REM using delayed expansion of variables...
setlocal enableextensions enabledelayedexpansion

REM ...build a list of directories to be processed (language directories)
SET TRANSLATIONS=de es zh_cn
SET TRANSLATIONI18N=fr
SET LANGUAGES=en %TRANSLATIONS%

set SPHINXBUILD=sphinx-build
set ALLSPHINXOPTS= -d _build/doctrees/%%L -c . -A language=%%L -D language=%%L -A languages="%LANGUAGES%"
set ALLSPHINXOPTSI18N= -d _build/doctrees/%%L -c . -A language=%%L -D language=%%L -A languages="%LANGUAGES% %TRANSLATIONI18N%"

if NOT "%PAPER%" == "" (
	set ALLSPHINXOPTS=-D latex_paper_size=%PAPER% %ALLSPHINXOPTS%
	set ALLSPHINXOPTSI18N=-D latex_paper_size=%PAPER% %ALLSPHINXOPTSI18N%
)

REM Only for Gettext
set I18NSPHINXOPTS   = -D latex_paper_size=%PAPER% -d _build/doctrees/en -c . -A language=en -D language=en -A languages="en"


if "%1" == "" goto help

if "%1" == "help" (
	:help
	echo.Please use `make ^<target^>` where ^<target^> is one of
  echo.  init      to preprocess translation directories 
	echo.  html      to make standalone HTML files
	echo.  latex     to make LaTeX files, you can set PAPER=a4 or PAPER=letter
	echo.  gettext     to generate pot files from en rst files
	echo.  gettext_copy     to duplicate pot files from gettext dir to translated\pot
	echo.  compile_messages    to compile po to mo files
	echo.  generate_po_from_tmpl    to duplicate pot to po files for a language, e.g from translated\pot directory to translated\lang
	echo.  changes   to make an overview over all changed/added/deprecated items
	echo.  linkcheck to check all external links for integrity
	goto end
)

if "%1" == "init" (
  FOR  %%L in (%TRANSLATIONS%) DO (
  	xcopy en %%L /d /y /c /s /q
	)
	echo.Init finished.
  goto end
)

if "%1" == "clean" (
	for /d %%i in (_build\*) do rmdir /q /s %%i
	del /q /s _build\*
	goto end
)

if "%1" == "html" (
  FOR  %%L in (%LANGUAGES%) DO (
  	%SPHINXBUILD% -b html  %ALLSPHINXOPTS% %%L _build/html/%%L
	)
  FOR  %%L in (%TRANSLATIONI18N%) DO (
  	%SPHINXBUILD% -b html  %ALLSPHINXOPTSI18N% en _build/html/%%L
	)
	echo.
	echo.Build finished. The HTML pages are in _build/html.
	goto end
)

if "%1" == "latex" (
  FOR  %%L in (%LANGUAGES%) DO (
  	%SPHINXBUILD% -b latex  %ALLSPHINXOPTS% %%L _build/latex/%%L
	)
  FOR  %%L in (%TRANSLATIONI18N%) DO (
  	%SPHINXBUILD% -b latex  %ALLSPHINXOPTSI18N% en _build/latex/%%L
	)
	echo.
	echo.Build finished; the LaTeX files are in _build/latex.
	goto end
)

if "%1" == "gettext" (
		mkdir _build\gettext\en
		mkdir _build\doctrees\en
		%SPHINXBUILD% -b gettext  %ALLSPHINXOPTS% en _build/gettext/en
)

if "%1" == "gettext_copy" (
        xcopy _build\gettext\en translated\pot /y /s /e
)
		
if "%1" == "compile_messages" (
REM Add text below in C:\PythonXX\Lib\site-packages\sitecustomize.py if you get an error about encoding
REM and/or python -c "import sys;print sys.getdefaultencoding()" send you ascii (or fail on accents)

REM #!/usr/bin/env python
REM # -*- coding: iso-8859-1 -*-

REM # Retrieve default 'locale'.
REM import locale, sys
REM loc = locale.getdefaultlocale()
REM if loc[1]:
REM     encoding = loc[1]

REM # A non-Unicode version will return AttributeError...
REM if encoding:
REM     sys.setdefaultencoding(encoding)
  if "%2" == "" (
  FOR  %%L in (%TRANSLATIONI18N%) DO (
  	python i18n_win.py --lang %%L
	)
	echo.
	echo.Messages compiled using TRANSLATIONI18N for lang. Now you can build updated version for html and pdf.
  ) else (
  FOR  %%L in (%2) DO (
  	python i18n_win.py --lang %%L
	)
	echo.
	echo.Messages compiled using command line var for lang. Now you can build updated version for html and pdf.
  )
  goto end
)

if "%1" == "generate_po_from_tmpl" (
  if "%2" NEQ "" (
  FOR  %%L in (%2%) DO (
  	xcopy translated\pot\*.pot translated\%%L\*.po /s /e
	)
	echo.
	echo."*.pot files copy to *.po files. Now you can start your translation."
  )
  goto end
)

if "%1" == "changes" (
  FOR  %%L in (%LANGUAGES%) DO (
  	%SPHINXBUILD% -b changes  %ALLSPHINXOPTS% %%L _build/changes/%%L
	)
	echo.
	echo.The overview file is in _build/changes.
	goto end
)

if "%1" == "linkcheck" (
  FOR  %%L in (%LANGUAGES%) DO (
  	%SPHINXBUILD% -b linkcheck  %ALLSPHINXOPTS% %%L _build/linkcheck/%%L
	)
	echo.
	echo.Link check complete; look for any errors in the above output ^
or in _build/linkcheck/output.txt.
	goto end
)

REM for installation see https://sphinxcontrib-spelling.readthedocs.io/en/latest/install.html
if "%1" == "spelling" (
  FOR  %%L in (%LANGUAGES%) DO (
  	%SPHINXBUILD% -b spelling  %ALLSPHINXOPTS% %%L _build/spelling/%%L
	)
	echo.
	echo.Spelling complete; look for any errors in the above output ^
or in _build/spelling/output.txt.
	goto end
)

:end
