
args=("$@")
REPO=${args[0]}
BRANCH=${args[1]}
OUTPUT_LOCATION=${args[2]}
BUILDDIR="/tmp/ms-$BRANCH-$RANDOM-build"


#LOCATION="/osgeo/mapserver.org"
LANGUAGES="ar en de el es fr id it ja nl_NL pl ru sq tr zh_cn"
PDF_LANGUAGES="ar en de el es fr id it ja nl_NL pl ru sq tr zh_cn"

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
   
   if [ "$lang" == "de" ]; then
   warn=".. warning::

   Diese Übersetzung ist seid mindestens @DAYS@ Tagen nicht aktualisiert
   verglichen mit der originalen Version. Wir empfehlen dringend stattdessen die
   originale Englische Seite zu verwenden.


   "
   elif [ "$lang" == "it" ]; then
   warn=".. warning::

   outdated by @DAYS@ days!

   "

   elif [ "$lang" == "es" ]; then
   warn=".. warning::

   outdated by @DAYS@ days!

   "
   elif [ "$lang" == "fr" ]; then
   warn=".. warning::

   La traduction de cette page est en retard de @DAYS@ jours !
   Contribuez à la traduction est aussi simple que d'utiliser 
   transifex : https://www.transifex.com/organization/mapserver/dashboard

   "
   elif [ "$lang" == "zh_cn" ]; then
   warn=".. warning::

   outdated by @DAYS@ days!

   "
   else
   warn=".. warning::

   outdated by @DAYS@ days !

   "
   fi
	
   IFS=$'\n'
	for file in `find .`;
	do
     file_dirname=`dirname "$file"`
     if [ ! -e "../$lang/$file" ]; then
       #echo "$file does not exist in $lang, copying from en"
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
             let days="($orig_mtime - $trans_mtime)/86400"
             if [[ $days -ge 7 ]]; then
               #leave a 7 day grace period before adding the warning
               tmpfile="/tmp/foo-$RANDOM"
               echo $warn | sed "s/@DAYS@/$days/" > $tmpfile
               cat "../$lang/$file" >> "$tmpfile"
               mv "$tmpfile" "../$lang/$file"
             fi
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
#make clean
#make compile_messages
make TARGET=mapserverorg html
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
cd $REPO
rm -rf $BUILDDIR
