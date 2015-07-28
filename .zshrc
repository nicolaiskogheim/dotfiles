source ~/.bashrc
source ~/.zgen.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"

if ! zgen saved; then

  zgen oh-my-zsh

  zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/fasd
  zgen oh-my-zsh plugins/heroku
  zgen oh-my-zsh plugins/pip
  zgen load zsh-users/zsh-completions src
  zgen load zsh-users/zsh-syntax-highlighting
  zgen load zsh-users/zsh-history-substring-search
  zgen oh-my-zsh plugins/vi-mode
  #zgen load command-not-found
  #zgen load autoenv

  zgen load Lokaltog/powerline
  zgen oh-my-zsh plugins/colored-man
  zgen load chrissicool/zsh-256color
  zgen oh-my-zsh themes/robbyrussell

  zgen save
fi

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=4000
setopt appendhistory autocd beep extendedglob nomatch notify
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/nicolai/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

export KEYTIMEOUT=1
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

alias fuck='$(thefuck $(fc -ln -1))'

# unalias run-help # "no such hash table element: run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/help

function mc() {
  mkdir -p "$*" && cd "$*"
}


# Base16 Shell
BASE16_SHELL="${HOME}/.base16-seti.dark.sh"
[[ -e "$BASE16_SHELL" ]] && source $BASE16_SHELL
