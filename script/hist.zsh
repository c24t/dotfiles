#!/usr/bin/env zsh

eval $(cat $HOME/.history | perl -p -e 's/^: \d+:0;//' | ~/script/uniq.py | fzf)
