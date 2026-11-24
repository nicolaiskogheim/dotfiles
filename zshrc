# Make zgen's extra completions available before completion initialization.
zsh_completions_dir="${ZGEN_DIR:-$HOME/.zgen}/zsh-users/zsh-completions-master/src"
if [[ -d "$zsh_completions_dir" ]]; then
  fpath=("$zsh_completions_dir" $fpath)
fi
unset zsh_completions_dir

zmodload zsh/complist
zstyle ':completion:*' show-ambiguity true

autoload -U colors
colors
zstyle ':completion:*' show-ambiguity "1;2;$color[fg-red]"

zmodload zsh/terminfo

[ -f "$HOME/dotfiles/shell_agnostic_rc.inc" ] && source "$HOME/dotfiles/shell_agnostic_rc.inc"

# TODO: auto download zgen
# Oh My Zsh initializes completion; prevent zgen from doing it again.
ZGEN_AUTOLOAD_COMPINIT=0
# Load NVM when a Node-related command is first used.
export NVM_LAZY_LOAD=true
[ -f "$HOME/dotfiles/assets/zgen.zsh" ] && source "$HOME/dotfiles/assets/zgen.zsh"

zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"

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

if (( $+commands[thefuck] )); then
    eval "$(thefuck --alias)"
fi

# Use Zsh's help function and its installation-specific help directory.
if (( $+aliases[run-help] )); then
    unalias run-help
fi
autoload -Uz run-help

# Base16 Shell
BASE16_SHELL="${HOME}/.base16-seti.dark.sh"
[[ -e "$BASE16_SHELL" ]] && source $BASE16_SHELL

# psql -h dbpg-ifi-kurs -U nicolai

local ret_status="%(?::%{$fg_bold[red]%}➜ %s)"
PROMPT='${ret_status}%{$fg_bold[green]%}%p%{$fg[cyan]%}%c %{$reset_color%}'
RPROMPT="\$(git-radar --zsh --fetch) "
export GIT_RADAR_COLOR_BRANCH="$fg_bold[blue]"


if (( $+functions[zgen] )) && ! zgen saved; then

  zgen oh-my-zsh

  zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/fasd
  zgen oh-my-zsh plugins/pip
  zgen load zsh-users/zsh-completions src
  zgen load zsh-users/zsh-history-substring-search
  zgen oh-my-zsh plugins/vi-mode
  #zgen load command-not-found
  #zgen load autoenv
  zgen oh-my-zsh plugins/archlinux

  zgen load Lokaltog/powerline
  zgen oh-my-zsh plugins/colored-man-pages
  # zgen oh-my-zsh themes/robbyrussell
  # zgen load nicolaiskogheim/prompt prompt
  zgen load noh4ck/zenv

  # Must be after plugins and compinit
  zgen load zsh-users/zsh-syntax-highlighting
  zgen load lukechilds/zsh-nvm

  zgen save
fi

# Initialize completion if the plugin setup hasn't already done so.
if (( ! $+_comps )); then
   autoload -Uz compinit
   compinit
fi

# TODO: auto download fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag -l -g ""'

# Omit commands beginning with a space from history.
setopt HIST_IGNORE_SPACE

## Keybinds
bindkey -M viins "$terminfo[kcuu1]" history-substring-search-up
bindkey -M viins "$terminfo[kcud1]" history-substring-search-down
bindkey -M viins '^[[A' history-substring-search-up
bindkey -M viins '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Load machine-specific Zsh setup after plugins and completion initialization.
local_zsh_config="$HOME/dotfiles/local/$(hostname).zsh"
if [[ -f "$local_zsh_config" ]]; then
    source "$local_zsh_config"
fi
unset local_zsh_config
