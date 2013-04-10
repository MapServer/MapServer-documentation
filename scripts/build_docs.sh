
args=("$@")
REPO=${args[0]}
BRANCH=${args[1]}
OUTPUT_LOCATION=${args[2]}
BUILDDIR="/tmp/ms-$BRANCH-$RANDOM-build"


#LOCATION="/osgeo/mapserver.org"
LANGUAGES="en de fr"
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
   
   if [ "$lang" == "fr" ]; then
     warn=".. warning::

Attention: cette page de documentation n'est pas a jour. Nous vous conseillons **fortement**
de naviguer vers la version anglaise de cette page.

"
   elif [ "$lang" == "de" ]; then
   warn=".. warning::

Achtung baby!: cette page de documentation n'est pas a jour. Nous vous conseillons **fortement**
de naviguer vers la version anglaise de cette page.

   "
   elif [ "$lang" == "it" ]; then
   warn=".. warning::

Pericoloso!: cette page de documentation n'est pas a jour. Nous vous conseillons **fortement**
de naviguer vers la version anglaise de cette page.

   "

   elif [ "$lang" == "es" ]; then
   warn=".. warning::

Ole!: cette page de documentation n'est pas a jour. Nous vous conseillons **fortement**
de naviguer vers la version anglaise de cette page.

   "
   elif [ "$lang" == "zh_cn" ]; then
   warn=".. warning::

Ching chong!: cette page de documentation n'est pas a jour. Nous vous conseillons **fortement**
de naviguer vers la version anglaise de cette page.

   "
   else
   warn=".. warning::

No translation!: cette page de documentation n'est pas a jour. Nous vous conseillons **fortement**
de naviguer vers la version anglaise de cette page.

   "
   fi
	
   IFS=$'\n'
	for file in `find .`;
	do
     file_dirname=`dirname "$file"`
     if [ ! -e "../$lang/$file" ]; then
       if [ -f "$file" ]; then
         mkdir -p "../$lang/$file_dirname"
         cp "$file" "../$lang/$file_dirname"
       fi
     else
       if [ -f $file ]; then
         filename=$(basename "$file")
         extension="${filename##*.}"
         if [ "$extension" == "txt" -o "$extension" == "inc" ]; then
           orig_mtime=`cd $REPO && git log -1 --pretty=format:"%at" -- "en/$file"`
           trans_mtime=`cd $REPO && git log -1 --pretty=format:"%at" -- "$lang/$file"`
           if [[ $trans_mtime -lt $orig_mtime ]]; then
              tmpfile="/tmp/foo-$RANDOM"
              echo $warn > $tmpfile
              cat "../$lang/$file" >> "$tmpfile"
              mv "$tmpfile" "../$lang/$file"
           fi
         fi
       fi
     fi
	done
	unset IFS
	cd ..
    fi
done

cd $BUILDDIR
make html
make latex
make epub

cd $BUILDDIR/build/latex
for lang in $PDF_LANGUAGES;
do
	mkdir -p $OUTPUT_LOCATION/$lang/
	cd $BUILDDIR/build/latex/$lang
	make all-pdf
	cp MapServer.pdf $OUTPUT_LOCATION/$lang/
done

cp -fr $BUILDDIR/build/html/* $OUTPUT_LOCATION/
cp $BUILDDIR/build/epub/en/MapServer.epub $OUTPUT_LOCATION/en/MapServer.epub

