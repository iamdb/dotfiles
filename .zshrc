autoload -Uz compinit
compinit

setopt auto_list
setopt auto_menu
setopt always_to_end

export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
export ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS="--layout=reverse --info=inline --border --margin=1 --padding=1"

export MCFLY_KEY_SCHEME=vim
export MCFLY_INTERFACE_VIEW=BOTTOM

export GARDEN_DISABLE_ANALYTICS=true
export LESS=R

#########################
#      keybindings
#########################
bindkey   '\eOH'   beginning-of-line
bindkey   '\eOF'   end-of-line
bindkey   '^[[3~'  delete-char
bindkey   '^[OA'   history-beginning-search-backward
bindkey   '^[OB'   history-beginning-search-forward

eval "$(sheldon source)"
