# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

disable r ## to enable calling R language from the command line

alias bupd="brew update && brew upgrade && brew cleanup"
export BAT_THEME="Dracula"

# Path to your oh-my-zsh installation.
#export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="aussiegeek"

## ZSH autocomplete, autosuggestions, syntax highlighting
#source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"
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

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git brew macos colored-man-pages golang python)

#source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f "/Users/mansuramir/.ghcup/env" ] && source "/Users/mansuramir/.ghcup/env" # ghcup-env

# opam configuration
[[ ! -r /Users/mansuramir/.opam/opam-init/init.zsh ]] || source /Users/mansuramir/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# Java openjdk
jdk() {
      version=$1
      unset JAVA_HOME;
      export JAVA_HOME=$(/usr/libexec/java_home -v"$version");
      java -version
}

# Helix Search
hxs() {
	RG_PREFIX="rg -i --files-with-matches"
	local files
	files="$(
		FZF_DEFAULT_COMMAND_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
			fzf --multi 3 --print0 --sort --preview="[[ ! -z {} ]] && rg --pretty --ignore-case --context 5 {q} {}" \
				--phony -i -q "$1" \
				--bind "change:reload:$RG_PREFIX {q}" \
				--preview-window="70%:wrap" \
				--bind 'ctrl-a:select-all'
	)"
	[[ "$files" ]] && hx --vsplit $(echo $files | tr \\0 " ")
}

export PATH=~/.local/bin:$PATH

# bun completions
[ -s "/Users/mansuramir/.bun/_bun" ] && source "/Users/mansuramir/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export PATH="$HOME/go/bin:$HOME/.cargo/bin:/opt/homebrew/bin:$PATH"
export MANPATH=/opt/local/share/man:$MANPATH
export DISPLAY=:0.0


source /opt/homebrew/share/zsh/site-functions
export DOTNET_CLI_TELEMETRY_OPTOUT=1

[ -f "/Users/mansuramir/.ghcup/env" ] && source "/Users/mansuramir/.ghcup/env" # ghcup-env

## Modular Mojo ##
## Mojo's Python virtual environment created at /Users/mansuramir/.modular/pkg/packages.modular.com_mojo/venv
export MODULAR_HOME="/Users/mansuramir/.modular"
export PATH="/Users/mansuramir/.modular/pkg/packages.modular.com_mojo/bin:$PATH"  ## Add Mojo's path in front of $PATH


### POSTGRESQL 16 ###
#If you need to have postgresql@15 first in your PATH, run:
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

#For compilers to find postgresql@16 you may need to set:
export LDFLAGS="-L/opt/homebrew/opt/postgresql@16/lib"
export CPPFLAGS="-I/opt/homebrew/opt/postgresql@16/include"


### ROC NIGHTLY ###
export PATH="$HOME/.local/roc_nightly:$HOME/Code/Admiran/bin:$PATH"
export PATH="$PATH:/Users/mansuramir/.modular/bin"

### HELIX ####
export HELIX_RUNTIME=$HOME/.local/helix/runtimei

#### Starship
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml
