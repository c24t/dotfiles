autoload -U colors && colors
autoload -U promptinit && promptinit

# # http://zsh.sourceforge.net/Doc/Release/Zsh-Modules.html#The-zsh_002fcomplist-Module
# # no idea why this doesn't work
# zmodload zsh/complist
# autoload -Uz complist && complist

# The following lines were added by compinstall

zstyle ':completion:*' auto-description 'specify %d'
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' '+m:{[:lower:]}={[:upper:]}' '+r:|[._-]=** r:|=**' '+l:|=* r:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' original false
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/Users/libc/.zshrc'

fpath=(~/.zsh/completions $fpath)
autoload -Uz compinit
compinit
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

# edit this file and source it
alias vizsh="vim $ZSHRC && source $ZSHRC"

# add an alias
# ALIASES/AUTO_ALIASES are defined in .zshenv
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
for file in $(find $ALIASES -follow); do source $file; done

# alias completions   {{{2
# can't put these in .aliases since we might not have completion while sourcing
# it from .zshenv
function _cco {
	_values \
		"cco" $(glast)
}
compdef _cco cco

# zsh ships with nice git completions, see
# /usr/share/zsh/5.3/functions/_git
compdef _git-checkout mb

# }}}
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
export PATH="$HOME/bin/:$PATH"
export PATH="$HOME/script/bin/:$PATH"
# }}}

# plugins {{{{1
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
# }}}

# added by fzf installer
# put it before bindkeys to remap ^T
# export FZF_TMUX_OPTS="-p -h 92% -w 92%"
export FZF_TMUX_OPTS=""
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_OPTS='--height 40 --min-height 20 --layout=reverse'
# makes C_r laggy?
# https://github.com/junegunn/fzf/issues/937#issuecomment-310254682
export FZF_TMUX=0
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window hidden:wrap --bind '?:toggle-preview'"
export FZF_CTRL_R_OPTS=""
export FZF_CTRL_T_OPTS='--preview "head -40 {}"'

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

bindkey "^T" push-line-or-edit
bindkey '^F' fzf-file-widget
# }}}

# source os/machine/company-specific files
export EXTRAS=$HOME/.zshrc_extra
for file in $(find $EXTRAS -follow); do source $file; done

# vim:foldmethod=marker
# vim:noet:sw=2:ts=2
