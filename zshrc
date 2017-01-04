# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git debian npm zsh-syntax-highlighting node arty docker)

HISTSIZE=50000

if [ -e $HOME/.zshrc.local ] ; then
    source $HOME/.zshrc.local
fi

source $ZSH/oh-my-zsh.sh

# Disable command corrections
unsetopt correct_all

#########################################################################################
# Turn on incremental search with CTRL-R
bindkey \\C-R history-incremental-search-backward
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line

alias cal='cal -3'
alias soz='source ~/.zshrc'

alias grb='git rebase'
alias gdf='git diff --name-only'
alias grl='git reflog --max-count=30'
alias gsu='git submodule update --init --recursive'
alias gsh='git show'
alias gdc='git diff --cached'

alias v='vim'
alias ka='killall'
alias gps='ps aux | grep'
alias ls='ls --group-directories-first --color=tty'
alias sudo="sudo " # expand sudo aliases

# Take screenshot of selected area
alias scr="gnome-screenshot -a 2>/dev/null"

alias wanip='dig +short myip.opendns.com @resolver1.opendns.com'
function lanip() {
    local dev=${1:-eth0}
    ip -o -f inet addr show $dev | sed 's_.*inet \(.*\)/.*_\1_'
}

# Debian plugin uses ag for apt-get upgrade.  I use ag for searching.
unalias ag

export PATH=$PATH:$HOME/.rvm/bin:$HOME/bin
export PSQL_EDITOR='vim -c"set syntax=sql"'
export EDITOR=vim
#export MANPAGER="env MAN_PN=1 vim -M +MANPAGER -"

function w() {
    [ $# -eq 0 ] && /usr/bin/w || which $@
}

function historystats() {
    history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" \
            | column -c3 -s " " -t | sort -nr | nl |  head -n10
}

# Dump colors supported by terminal
function listcolors() {
    for i in $(seq 0 $(tput colors) ) ; do
        tput setaf $i
        echo -n "\t█ $i"
        [ $(($i % 10)) -eq 0 ] && echo
    done
    tput setaf 15
    echo
}

function google {
    local urlencoded=$(echo -n "${(j: :)@}" | perl -MURI::Escape -ne 'print uri_escape($_)')
    xdg-open "https://www.google.com/search?q=${urlencoded}"
    sleep 1
    echo
}

function ts2date {
    local factor=1
    if [[ $1 -gt 9999999999 ]] ; then
        factor=1000
    fi
    date -d@$(($1 / $factor))
}
