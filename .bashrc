#!/usr/bin/env bash
#Git stuff
export GIT_PROMPT_ONLY_IN_REPO=1
#GIT_PROMPT_SHOW_LAST_COMMAND_INDICATOR=1

trim() {
  local s2 s="$*"
  # note the tab character in the expressions of the following two lines when copying
  until s2="${s#[   ]}"; [ "$s2" = "$s" ]; do s="$s2"; done
  until s2="${s%[   ]}"; [ "$s2" = "$s" ]; do s="$s2"; done
  echo "$s"
}

# This isn't working
if [ "$0" = "bash" ]; then
  if [ -f ~/.bash-git-prompt/gitprompt.sh ]; then
    source ~/.bash-git-prompt/gitprompt.sh
  fi

  if [ -f ~/.git-completion.bash ]; then
    source ~/.git-completion.bash
  fi
fi

# Go
export GOPATH=$HOME/go
# export GOROOT=/usr/local/go
# export PATH=$PATH:$GOPATH/bin:$GOROOT/bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/usr/local/opt/go/libexec/bin

# User defined completion
# source /etc/bash_completion.d/* # No, please no.


if command -v brew >/dev/null 2>&1 ; then
    ## Brew completion
    source /usr/local/etc/bash_completion.d/*

    ## To use GNU-utilities

    PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
    MANPATH="$(brew --prefix coreutils)/libexec/gnuman:$MANPATH"
    PATH="$(brew --prefix)/sbin:$PATH"
fi

# java
export JUNIT_HOME="$HOME/java"
export PATH="$PATH:$JUNIT_HOME"
export CLASSPATH="$CLASSPATH:$JUNIT_HOME/junit-4.12.jar:$JUNIT_HOME/hamcrest-core-1.3.jar"

# [ -f ~/.fzf.bash ] && source ~/.fzf.bash


alias gpg="gpg2"
export EDITOR=vim


export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export TERM="xterm-256color"
alias trash=rmtrash

# Android SDK
export PATH="$PATH:/Users/nicolai/Library/Android/sdk/platform-tools:/Users/nicolai/Library/Android/sdk/tools"
alias i=ionic

# openvpn
PATH="$PATH:/usr/local/Cellar/openvpn/2.3.6/sbin"


if [ -f ~/.someconflicts.sh ] ; then
    source ~/.someconflicts.sh
fi

export HISTCONTROL=ignorespace
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Elimd server
alias eclimd="/Applications/Eclipse.app/Contents/Eclipse/eclimd"
alias cal='cal | grep -C100 --color=always "\b$(trim $(date +%e))\b"'

# # shellcheck disable=SC1091
# # shellcheck source=/Users/nicolai/bin/getKeyboardLayout.sh
# source "$HOME/bin/getKeyboardLayout.sh"

#so as not to be disturbed by Ctrl-S ctrl-Q in terminals:
stty -ixon

export FINDBUGS_HOME=/usr/local/Cellar/findbugs/3.0.1/libexec


# Have this last to make sure my own bins are searched first
# PATH="$HOME/bin:$HOME/bin/git-radar:$PATH"

if [ "$(uname -s)" == "Darwin" ] ; then
    # Decrease animation duration when using expose
    defaults write com.apple.dock expose-animation-duration -float 0.2; killall Dock
fi

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
export GVM_DIR="/Users/nicolai/.gvm"
[[ -s "/Users/nicolai/.gvm/bin/gvm-init.sh" ]] && source "/Users/nicolai/.gvm/bin/gvm-init.sh"

