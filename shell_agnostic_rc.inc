#!/bin/bash
# vim:ft=sh

alias ="echo omnomnom"
alias mkdrit=mkdir
alias nah='git reset --hard && git clean -df'

alias such=git
alias very=git
alias wow='git status'
# $ wow
# $ such commit
# $ very push
# sorrynotsorry

pdfjoin() {
    gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=${@}
}

#  So as not to be disturbed by Ctrl-S ctrl-Q in terminals:
#  The default (legacy) behaviour of Ctrl-S is to stop
#+ terminal output; Ctrl-Q continues output.
#  I use Ctrl-S to navigate left in tmux and vim.
stty -ixon

export EDITOR=nvim
# Arch uses VISUAL instead of EDITOR
export VISUAL=vim
export HISTCONTROL=ignorespace
export TERM="xterm-256color"


trim() {
  local s2 s="$*"
  # note the tab character in the expressions of the following two lines when copying
  until s2="${s#[	 ]}"; [ "$s2" = "$s" ]; do s="$s2"; done
  until s2="${s%[	 ]}"; [ "$s2" = "$s" ]; do s="$s2"; done
  echo "$s"
}

which cal 1>/dev/null 2>&1 && \
    alias cal='cal | grep -C100 --color=always "\b$(trim $(date +%e))\b"'

#  Create a directory and cd into it
#  NOTE: It only makes sense to use this
#+ with one argument. Thus whatever string
#+ is used will be the name of the directory
mc() {
    mkdir -p "$*" && cd "$*" || exit
}


################################################
##               LOCALISATION                 ##
################################################

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8


################################################
##               TOOL CONFIG                  ##
################################################

# I don't want cows :(
# http://docs.ansible.com/ansible/intro_configuration.html#nocows
export ANSIBLE_NOCOWS=1

################################################
##              LOCAL CONFIG                  ##
################################################

LOCAL_CONFIG_PATH="$HOME/dotfiles/local/$(hostname)"
if [ -f "$LOCAL_CONFIG_PATH" ]
then
    source "$LOCAL_CONFIG_PATH"
fi
