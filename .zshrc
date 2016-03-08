# The following lines were added by compinstall
zstyle :compinstall filename '/Users/nicolai/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

zmodload zsh/complist
autoload -U compinit
compinit -u
autoload bashcompinit
bashcompinit
zstyle ':completion:*' show-ambiguity true

autoload -U colors
colors
zstyle ':completion:*' show-ambiguity "1;2;$color[fg-red]"

zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

source ~/.bashrc
source ~/.zgen.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag -l -g ""'

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
  zgen oh-my-zsh plugins/gradle

  zgen load Lokaltog/powerline
  zgen oh-my-zsh plugins/colored-man-pages
  zgen load chrissicool/zsh-256color
  # zgen oh-my-zsh themes/robbyrussell
  zgen load nicolaiskogheim/prompt prompt

  zgen save
fi

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory autocd beep nomatch notify
#setopt extendedglob  # Make ^,$ and the likes behave as regex-chars
# End of lines configured by zsh-newuser-install

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
alias ="echo omnomnom"

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
export GVM_DIR="/Users/nicolai/.gvm"
[[ -s "/Users/nicolai/.gvm/bin/gvm-init.sh" ]] && source "/Users/nicolai/.gvm/bin/gvm-init.sh"

# psql -h dbpg-ifi-kurs -U nicolai

function TRAPUSR1() {
  RPROMPT="$(date)"

  # redisplay
  export GIT_RADAR_REDRAW=true
  zle && zle reset-prompt
  export GIT_RADAR_REDRAW=false
}

export GIT_RADAR_ZSH_PID="$(echo $$)"
export GIT_RADAR_ASYNC_EXEC=true
