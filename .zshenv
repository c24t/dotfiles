# export ALIASES=$HOME/.aliases
# export AUTO_ALIASES=$ALIASES/auto

# source ~/.aliases/**/*
for file in $(find $HOME/.aliases -follow); do source $file; done
