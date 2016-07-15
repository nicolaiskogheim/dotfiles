#!/usr/bin/env bash

[ -f "$HOME/dotfiles/shell_agnostic_rc.inc" ] \
    && source "$HOME/dotfiles/shell_agnostic_rc.inc"

[ -f ~/.bash-git-prompt/gitprompt.sh ] && \
    source ~/.bash-git-prompt/gitprompt.sh

[ -f ~/.git-completion.bash ] && \
    source ~/.git-completion.bash

[ -f ~/.fzf.bash ] \
    && source ~/.fzf.bash

[ -f ~/.someconflicts.sh ] && \
    source ~/.someconflicts.sh

# User defined completion
# source /etc/bash_completion.d/* # No, please no.
