export ALIASES=$HOME/.aliases

for file in $(find $ALIASES -follow); do source $file; done
