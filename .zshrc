autoload -U promptinit && promptinit
autoload -U colors && colors

# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename '/Users/libc/.zshrc'

autoload -Uz compinit && compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=$HOME/.history
HISTSIZE=10000
SAVEHIST=100000
setopt autocd extendedglob
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install

# prompt {{{1
# red prompt for normal mode, cribbed from SO
bindkey -v
function zle-line-init zle-keymap-select {
	case ${KEYMAP} in
		(vicmd)      PROMPT=$'%{\e[0;31m%}%#%{\e[0m%} ' ;;
		(main|viins) PROMPT=$'%# ' ;;
		(*)          PROMPT=$'%# ' ;;
	esac
	zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
# }}}

# aliases {{{1
ZSHRC=$HOME/.zshrc

export ALIASES=$HOME/.aliases
export AUTO_ALIASES=$ALIASES/auto

# source ~/.aliases/**/*
for file in $(find $ALIASES -follow); do source $file; done

# edit this file and source it
alias vizsh="vim $ZSHRC && source $ZSHRC"

# add an alias
aaa () {
	echo "alias $1=\"$2\"" >> $AUTO_ALIASES
	source $AUTO_ALIASES
	which $1
}

# add a bunch of aliases
vialiases () {
	(cd $ALIASES
		vim
	)
	for file in $(find $ALIASES -follow); do source $file; done
}
# }}}

# setopts {{{1
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

setopt HIST_FIND_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST

setopt ALWAYS_TO_END
setopt AUTO_NAME_DIRS
setopt AUTO_PUSHD
setopt NO_BEEP

setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_VERIFY

# clear rprompt on new commands, thank god for this
setopt TRANSIENTRPROMPT
# }}}

# defaults {{{1
export EDITOR=vim
export LESS="-iFRX"
# colorize ls
export CLICOLOR=1
# }}}

# path munging {{{1
export PATH="$HOME/bin:$PATH"
# }}}

# plugins {{{{1
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
# }}}

# bindkeys {{{1
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^H' backward-delete-char

# obsoleted by history-substring-search
# bindkey "^[[A" history-beginning-search-backward
# bindkey "^[[B" history-beginning-search-forward

bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

# override default history-beginning-search-x
bindkey -M vicmd 'j' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up

bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
bindkey '^E' autosuggest-accept

# :nmap <Space> i
bindkey -M vicmd ' ' vi-insert

bindkey "^R" history-incremental-search-backward
bindkey "^T" push-line-or-edit
# }}}

# source os/machine/company-specific files
export EXTRAS=$HOME/.zshrc_extra
for file in $(find $EXTRAS -follow); do source $file; done

# vim:foldmethod=marker
# vim:noet:sw=2:ts=2
