
args=("$@")
LOCATION=${args[0]}
SVN_BRANCH=${args[1]}

LANGUAGES="en de"

cd $LOCATION/$SVN_BRANCH
make clean
