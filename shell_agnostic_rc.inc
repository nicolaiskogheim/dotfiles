#!/bin/bash
# vim:ft=sh

alias ="echo omnomnom"

#so as not to be disturbed by Ctrl-S ctrl-Q in terminals:
stty -ixon

export EDITOR=vim
export HISTCONTROL=ignorespace
export TERM="xterm-256color"


trim() {
  local s2 s="$*"
  # note the tab character in the expressions of the following two lines when copying
  until s2="${s#[	 ]}"; [ "$s2" = "$s" ]; do s="$s2"; done
  until s2="${s%[	 ]}"; [ "$s2" = "$s" ]; do s="$s2"; done
  echo "$s"
}

which cal 1>&2 2>/dev/null && \
    alias cal='cal | grep -C100 --color=always "\b$(trim $(date +%e))\b"'

mc() {
    mkdir -p "$*" && cd "$*"
}


################################################
##               LOCALISATION                 ##
################################################

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
