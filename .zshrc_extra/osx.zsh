# use homebrew-installed macvim
alias vim="/usr/local/brew/bin/mvim -vf"
alias vimdiff="/usr/local/brew/bin/mvimdiff -vf"
alias view="/usr/local/brew/bin/mview -vf"

# use brew-installed GNU core/findutils
export PATH="/usr/local/brew/opt/findutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/brew/opt/findutils/libexec/gnuman:$MANPATH"
export PATH="/usr/local/brew/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/brew/opt/coreutils/libexec/gnuman:$MANPATH"
