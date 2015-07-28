#Git stuff
GIT_PROMPT_ONLY_IN_REPO=1
#GIT_PROMPT_SHOW_LAST_COMMAND_INDICATOR=1

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
source /etc/bash_completion.d/*


## Brew completion
source /usr/local/etc/bash_completion.d/*

## To use GNU-utilities

PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
MANPATH="$(brew --prefix coreutils)/libexec/gnuman:$MANPATH"
PATH="$(brew --prefix)/sbin:$PATH"

# java
export JUNIT_HOME="$HOME/java"
export PATH="$PATH:$JUNIT_HOME"
export CLASSPATH="$CLASSPATH:$JUNIT_HOME/junit-4.12.jar:$JUNIT_HOME/hamcrest-core-1.3.jar"

# [ -f ~/.fzf.bash ] && source ~/.fzf.bash


alias gpg="gpg2"
export EDITOR=vim

# quicklook
ql() {
  qlmanage -p $1 &> /dev/null
}


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

alias emacs="cowthink Noonononono. Nope."
alias stripcolors='gsed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g"'

function myfunc() {
  echo "$1";
}

alias tks="tmux kill-session"
