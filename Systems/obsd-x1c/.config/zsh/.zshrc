autoload -Uz vcs_info
setopt prompt_subst

#precmd() { vcs_info }
#zstyle ':vcs_info:git:*' formats '%b '
#setopt PROMPT_SUBST
#PROMPT='%F{green}%*%f %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f$ '

zstyle ':vcs_info:git*' formats " %F{blue}%b%f %m%u%c %a "
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr ' %F{green}✚%f'
zstyle ':vcs_info:*' unstagedstr ' %F{red}●%f'

precmd() {
    vcs_info
    print -P '%B%~%b ${vcs_info_msg_0_}'
}

PROMPT='%F{green}%*%f %B%(!.#.$)%b '


#### Zsh history
HIST_STAMPS="yyyy/mm/dd"
HISTSIZE=5000               # how many lines of history to keep in memory
HISTFILE=~/.zsh_history     # where to save history to disk
SAVEHIST=5000               # number of history entries to save to disk
#HISTDUP=erase              # erase duplicates in the history file
setopt    appendhistory     # append history to the history file (no overwriting)
setopt    sharehistory      # share history across terminals
setopt    incappendhistory  # immediately append to the history file, not just when a term is killed
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS

bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward



source $HOME/.config/zsh/.zshalias


## plugins
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


PATH=$HOME/bin:$HOME/.local/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin:/usr/local/bin:/usr/local/sbin
export PATH
