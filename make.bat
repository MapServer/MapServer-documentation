@ECHO OFF

REM Command file for Sphinx documentation

set SPHINXBUILD=sphinx-build
set ALLSPHINXOPTS= -d _build/doctrees/%%L -c . -A language=%%L -D language=%%L
if NOT "%PAPER%" == "" (
	set ALLSPHINXOPTS=-D latex_paper_size=%PAPER% %ALLSPHINXOPTS%
)

if "%1" == "" goto help

if "%1" == "help" (
	:help
	echo.Please use `make ^<target^>` where ^<target^> is one of
	echo.  html      to make standalone HTML files
	echo.  latex     to make LaTeX files, you can set PAPER=a4 or PAPER=letter
	echo.  changes   to make an overview over all changed/added/deprecated items
	echo.  linkcheck to check all external links for integrity
	goto end
)

if "%1" == "clean" (
	for /d %%i in (_build\*) do rmdir /q /s %%i
	del /q /s _build\*
	goto end
)

if "%1" == "html" (
  FOR /D %%L in ("??") DO (
  	%SPHINXBUILD% -b html  %ALLSPHINXOPTS% %%L _build/html/%%L
	)
	echo.
	echo.Build finished. The HTML pages are in _build/html.
	goto end
)

if "%1" == "latex" (
  FOR /D %%L in ("??") DO (
  	%SPHINXBUILD% -b latex  %ALLSPHINXOPTS% %%L _build/latex/%%L
	)
	echo.
	echo.Build finished; the LaTeX files are in _build/latex.
	goto end
)

if "%1" == "changes" (
  FOR /D %%L in ("??") DO (
  	%SPHINXBUILD% -b changes  %ALLSPHINXOPTS% %%L _build/changes/%%L
	)
	echo.
	echo.The overview file is in _build/changes.
	goto end
)

if "%1" == "linkcheck" (
  FOR /D %%L in ("??") DO (
  	%SPHINXBUILD% -b linkcheck  %ALLSPHINXOPTS% %%L _build/linkcheck/%%L
	)
	echo.
	echo.Link check complete; look for any errors in the above output ^
or in _build/linkcheck/output.txt.
	goto end
)

:end
