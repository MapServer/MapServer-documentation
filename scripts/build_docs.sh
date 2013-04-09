
args=("$@")
REPO=${args[0]}
BRANCH=${args[1]}
OUTPUT_LOCATION=${args[2]}
BUILDDIR="/tmp/ms-$BRANCH-$RANDOM-build"


#LOCATION="/osgeo/mapserver.org"
LANGUAGES="en de es fr it zh_cn"
PDF_LANGUAGES="en"

cd "$REPO"
git checkout $BRANCH
git pull origin $BRANCH | grep "up-to-date"

if test $? -eq 0; then
  echo "repo not updated, no use building"
  exit
fi

mkdir -p $BUILDDIR
git archive --format=tar $BRANCH | (cd $BUILDDIR && tar xf -)
cd $BUILDDIR

# Copy all untranslated files in language dir and
for lang in $LANGUAGES;
do 
   if [ ! -d $lang ] ; then continue; fi 
   if [ $lang != "en" ]; then
	cd $BUILDDIR/en
	IFS=$'\n'
	for file in `find .`;
	do
     file_dirname=`dirname "$file"`
     if [ ! -e "../$lang/$file" ]; then
       cp -r "$file" "../$lang/$file_dirname"
     else
       if [ -f $file ]; then
         orig_mtime=`git log -1 --pretty=format:"%at" "$REPO/en/$file"`
         trans_mtime=`git log -1 --pretty=format:"%at" "$REPO/$lang/$file"`
         echo "$file : $orig_mtime $trans_mtime"
       fi
     fi
	done
	unset IFS
	cd ..
    fi
done

exit


make BUILDDIR=$BUILDDIR html
make BUILDDIR=$BUILDDIR latex
make BUILDDIR=$BUILDDIR epub
cd $BUILDDIR/latex
for lang in $PDF_LANGUAGES;
do
	mkdir -p $OUTPUT_LOCATION/$lang/
	cd $BUILDDIR/latex/$lang
	make all-pdf
	cp MapServer.pdf $OUTPUT_LOCATION/$lang/
done

cp -fr $BUILDDIR/html/* $OUTPUT_LOCATION/
cp $BUILDDIR/epub/en/MapServer.epub $OUTPUT_LOCATION/en/MapServer.epub

cd $REPO
git clean -f -d
git checkout master
git branch -D $TEMPBRANCH
