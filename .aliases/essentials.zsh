alias ll="ls -GFlh"
alias l="ll"
alias la="ls -lah"
alias lll="la"
alias t="tree"

alias g="grep"
alias psa="ps aux"
alias rmrf="rm -rf"
alias pull="git pull"
alias pul=pull
alias push="git push"

# dates
alias longstardate="date +%Y%m.%d.%H%M"
alias shortdate="date +%d%b"
alias epoch="date +%s"

# tmux
alias tl="tmx2 ls"
alias tt="tmx2 attach -t"

# findfile, findfilefollow
ff () { find . -type f -iname "*$1*" | grep -i "$1" }
fff () { find . -type f -iname "*$1*" -follow | grep -i "$1"}

fd () { find . -type d -iname "*$1*" | grep -i "$1" }
fdf () { find . -type d -iname "*$1*" -follow | grep -i "$1"}

# grepall, grepallfollow
ga () {find . -type f -print0 | xargs -0 egrep "$1" | echo "balls"}
gaa () {find . -type f -follow -print0 | xargs -0 egrep "$1"}

# grepall select by suffix
gas () {find . -type f -name "*.$2" -print0 | xargs -0 egrep -n "$1" --color=auto}
gaas () {find . -type f -follow -name "*.$2" -print0 | xargs -0 egrep -n "$1" --color=auto}

# `ps aux` cut -- get the pid
psac () {awk '{print $2}'}

mcd () { mkdir -p $1 && cd $1 }

# dir stack management
alias d="dirs -lp"
alias pd="popd -q"
alias pdd="pd && pd"
alias pddd="pd && pd && pd"
alias cdd="cd -P"

# git
alias gg="git grep"
alias gbh="git rev-parse --short HEAD"
alias gbhh="git rev-parse --short HEAD\^"
alias gbhhh="git rev-parse --short HEAD\^\^"
alias stash="git stash"
alias glg="git lg"
alias glgg="git lgg"
alias glggg="git lggg"
alias glgo="git lgo"
alias gbn="git symbolic-ref HEAD --short"
alias gg="git grep"

# quick git checkout -- check out a recent branch
cco () {
	git checkout $1
}

# archeology
hf () {
	< $HISTFILE | grep -i $1 | cut -d ';' -f 2- | ~/script/uniq.py | grep -i --color=auto $1
}

pytags () {
	/usr/local/brew/opt/findutils/libexec/gnubin/find -L . -type f -name "*.py" | gv -E -f .tagignore | xargs ctags -R --languages=python --python-kinds=cfm
}

shruggie () {
	echo '¯\_(ツ)_/¯' | tee pbcopy
}

flippie () {
	echo '(╯°□°)╯︵ ┻━┻' | tee pbcopy
}

mb () {
	if [ -n "$2" ]; then
		git rev-parse --short $(git merge-base $1 $2)
	elif [ -n "$1" ]; then
		git rev-parse --short $(git merge-base $1 HEAD)
	else
		git rev-parse --short $(git merge-base master HEAD)
	fi
}

switchmaster() {
	git co master &&\
	git pull upstream master &&\
}

steamrollmaster() {
	git co master &&\
	git fetch upstream &&\
	git reset --hard 'upstream/master' &&\
	git rebase upstream/master
}

mergemaster() {
	switchmaster
	git co - &&\
	git merge master
}

# vim: set ft=zsh:sw=2 ts=2:noet:
