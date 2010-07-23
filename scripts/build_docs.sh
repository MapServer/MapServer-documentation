
args=("$@")
LOCATION=${args[0]}
SVN_BRANCH=${args[1]}

#LOCATION="/osgeo/mapserver.org"
LANGUAGES="en de"
cd $LOCATION/$SVN_BRANCH
svn up

cd $LOCATION/$SVN_BRANCH
make html
make latex
make epub
cd $LOCATION/$SVN_BRANCH/build/latex
for lang in $LANGUAGES;
do
	cd $LOCATION/$SVN_BRANCH/build/latex/$lang
	make all-pdf
	cp MapServer.pdf $LOCATION/htdocs/$lang
        cp -r $LOCATION/$SVN_BRANCH/build/html/$lang $LOCATION/htdocs/
done

cp $LOCATION/$SVN_BRANCH/build/epub/en/MapServer.epub $LOCATION/htdocs/en
