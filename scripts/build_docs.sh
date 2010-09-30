
args=("$@")
LOCATION=${args[0]}
SVN_BRANCH=${args[1]}
OUTPUT_LOCATION=${args[2]}
SVN_TRUNK="svn-trunk"

#LOCATION="/osgeo/mapserver.org"
LANGUAGES="en de"
cd $LOCATION/$SVN_BRANCH

# remove all lang dir (except en) to get them updated properly
for lang in $LANGUAGES;
do 
    [ $lang == "en" ] || rm -rf $lang
done

svn up

cd $LOCATION/$SVN_BRANCH

# Copy all untranslated files in language dir and
# copy all RFC from trunk 
for lang in $LANGUAGES;
do 
    if [ $lang != "en" ]; then
	cd en
	IFS=$'\n'
	for file in `find . | grep -v .svn`;
	do
	    if [ ! -e "../$lang/$file" ]; then
		cp -r "$file" ../$lang/
	    fi
	done
	unset IFS
	cd ..
    fi

    # and copy all RFCs from trunk to branch
    if [ $SVN_BRANCH != $SVN_TRUNK ]; then
	[ -e $LOCATION/$SVN_TRUNK/$lang/development/rfc/ ] && cp -f $LOCATION/$SVN_TRUNK/$lang/development/rfc/*.txt $LOCATION/$SVN_BRANCH/$lang/development/rfc/
    fi
done

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
done

cp -fr $LOCATION/$SVN_BRANCH/build/html/* $OUTPUT_LOCATION/
cp $LOCATION/$SVN_BRANCH/build/epub/en/MapServer.epub $OUTPUT_LOCATION/en/MapServer.epub
