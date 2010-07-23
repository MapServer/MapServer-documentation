
args=("$@")
LOCATION=${args[0]}
SVN_BRANCH=${args[1]}
OUTPUT_LOCATION=${args[2]}

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
	mkdir -p $OUTPUT_LOCATION/$lang/
	cd $LOCATION/$SVN_BRANCH/build/latex/$lang
	make all-pdf
	cp MapServer.pdf $OUTPUT_LOCATION/$lang/
        cp -r $LOCATION/$SVN_BRANCH/build/html/$lang $OUTPUT_LOCATION/
done

cp $LOCATION/$SVN_BRANCH/build/epub/en/MapServer.epub $OUTPUT_LOCATION/en/MapServer.epub
