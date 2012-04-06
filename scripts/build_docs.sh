
args=("$@")
REPO=${args[0]}
BRANCH=${args[1]}
OUTPUT_LOCATION=${args[2]}
BUILDDIR="/tmp/ms-$BRANCH-build"
TEMPBRANCH="$BRANCH-$RANDOM"

mkdir -p $BUILDDIR

#LOCATION="/osgeo/mapserver.org"
LANGUAGES="en de es fr"
cd $REPO

git checkout $BRANCH
git pull origin | grep "up-to-date"

if test $? -eq 0; then
   echo "repo not updated, no use building"
   exit
fi

git checkout -b $TEMPBRANCH

# Copy all untranslated files in language dir and
# copy all RFC from trunk 
for lang in $LANGUAGES;
do 
    if [ $lang != "en" ]; then
	cd en
	IFS=$'\n'
	for file in `find .`;
	do
	    if [ ! -e "../$lang/$file" ]; then
		cp -r "$file" ../$lang/
	    fi
	done
	unset IFS
	cd ..
    fi
done

make BUILDDIR=$BUILDDIR html
make BUILDDIR=$BUILDDIR latex
make BUILDDIR=$BUILDDIR epub
cd $BUILDDIR/latex
for lang in $LANGUAGES;
do
	mkdir -p $OUTPUT_LOCATION/$lang/
	cd $BUILDDIR/latex/$lang
	make all-pdf
	cp MapServer.pdf $OUTPUT_LOCATION/$lang/
done

cp -fr $BUILDDIR/html/* $OUTPUT_LOCATION/
cp $BUILDDIR/epub/en/MapServer.epub $OUTPUT_LOCATION/en/MapServer.epub

git clean -f -d
git checkout master
git branch -d $TEMPBRANCH
