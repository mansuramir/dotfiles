#!/bin/zsh
#
# .zshrc - Run on interactive Zsh session.
#

### os and platform identification
platform='unknown'
macosarch='unknown'
linux_distro='unknown'
unamestr=$(uname)
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
    platform='macos'
    export HOSTOS="macos"
elif [[ "$unamestr" == 'FreeBSD' ]]; then
   platform='freebsd'
fi

if [[ $platform == 'macos' ]]; then
    macosarch=$(uname -m)
    if [[ "$macosarch" == 'arm64' ]]; then
        macosarch='applesilicon'
    elif [[ "$macosarch" == 'x86_64' ]]; then
        macosarch='intel'
    fi
fi

if [[ $platform == 'linux' ]]; then
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        if [[ "${ID}" == 'arch' ]] || [[ "${ID}" == 'endeavouros' ]]; then
            linux_distro='arch'
            export HOSTOS="linuxarch"
        #elif [["${ID}" == "fedora*" ]]; then
        else
            linux_distro='fedora'
            export HOSTOS="linuxfedora"
        fi
    fi
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

disable r ## to enable calling R language from the command line

if [[ $platform == 'macos' ]]; then
    alias bupd="brew update && brew upgrade && brew cleanup"
fi
if [[ $platform == 'linux' ]]; then
    alias hx=helix
    alias zed=zeditor
fi

export BAT_THEME="Dracula"

## ZSH autocomplete, autosuggestions, syntax highlighting
#source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
## ZSH autocomplete, autosuggestions, syntax highlighting
if [[ $macosarch == 'applesilicon' ]]; then
    source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source /opt/homebrew/share/zsh/site-functions
elif [[ $macosarch == 'intel' ]]; then
    source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    #source /opt/homebrew/share/zsh/site-functions
elif [[ $linux_distro == 'fedora' ]]; then
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    #source /opt/homebrew/share/zsh/site-functions
elif [[ $linux_distro == 'arch' ]]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source /usr/share/zsh/site-functions
fi


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


# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
if [[ $platform == 'macos' ]]; then
    plugins=(git brew macos colored-man-pages golang python)
elif [[ $platform == 'linux' ]]; then
    plugins=(git brew colored-man-pages golang python)
fi

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_GB.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env

# opam configuration
[[ ! -r $HOME/.opam/opam-init/init.zsh ]] || source $HOME/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

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

export PATH=$HOME/.local/bin:$PATH

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export PATH="$HOME/go/bin:$HOME/.cargo/bin:/opt/homebrew/bin:$PATH"
export MANPATH=/opt/local/share/man:$MANPATH
export DISPLAY=:0.0



export DOTNET_CLI_TELEMETRY_OPTOUT=1

[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env


### POSTGRESQL 16 ###
#If you need to have postgresql@15 first in your PATH, run:
if [[ $platform == 'macos' ]]; then
    export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

    #For compilers to find postgresql@16 you may need to set:
    export LDFLAGS="-L/opt/homebrew/opt/postgresql@16/lib"
    export CPPFLAGS="-I/opt/homebrew/opt/postgresql@16/include"
fi

export GOPATH=$HOME/.go
export PATH=$HOME.local/bin:$HOME/.go/bin:$PATH



### HELIX ####
export HELIX_RUNTIME=$HOME/.local/helix/runtime

#### Starship
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
eval "$(starship init zsh)"



### ROC Nightly
export PATH=$PATH:$HOME/.local/share/roc/roc_nightly


### include alias file
source $HOME/.config/zsh/.zshalias
