#!/usr/bin/zsh

# Start configuration added by Zim install {{{
#
# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------

#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# Prompt for spelling correction of commands.
setopt CORRECT

# Customize spelling correction prompt.
SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# -----------------
# Zim configuration
# -----------------

# Use degit instead of git as the default tool to install and update modules.
#zstyle ':zim:zmodule' use 'degit'

# --------------------
# Module configuration
# --------------------

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
#zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
    if (( ${+commands[curl]} )); then
        curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
            https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
    else
        mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
            https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
    fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
    source ${ZIM_HOME}/zimfw.zsh init -q
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh

# load .env variables
source ~/.env

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key
# }}} End configuration added by Zim install

# Set CLICOLOR if you want Ansi Colors in iTerm2
export CLICOLOR=1

# Set colors to match iTerm2 Terminal Colors
# export TERM=xterm-256color
export LC_ALL=en_US.UTF-8

HISTFILE="${HOME}/.zshhistory"
SAVEHIST=5000
HISTSIZE=5000
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history
setopt autocd

ttyctl -f #fixes error where the terminal confuses enter with return (prints ^M)
export EDITOR=/opt/homebrew/bin/code
# export $BROWSER=google-chrome
export HOMEBREW_NO_AUTO_UPDATE=1
export PATH=/usr/local/bin:$PATH
#less syntax-highlighting
export LESS="--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4"
export LESSOPEN="|/usr/local/bin/lesspipe.sh %s" LESS_ADVANCED_PREPROCESSOR=1
export LESSCOLORIZER='pygmentize'

export ZSH_WAKATIME_BIN=/opt/homebrew/bin/wakatime

#npm settings
# this is the root folder where all globally installed node packages will  go
export NPM_PACKAGES="/usr/local/npm_packages"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
# add to PATH
export PATH="$NPM_PACKAGES/bin:$PATH"

#mdv theme
export MDV_THEME="734.0784, 20"

# using fd with fzf
export FZF_DEFAULT_COMMAND="fd --type file --color=always"
export FZF_DEFAULT_OPTS="--ansi"

# zsh-history-substring-search settings
HISTORY_SUBSTRING_SEARCH_FUZZY=true
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=green,fg=black,bold' #define colors for found items

#theme stuff
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir virtualenv anaconda vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time)
POWERLEVEL9K_TIME_FORMAT="%D{ %H:%M:%S}"
POWERLEVEL9K_STATUS_VERBOSE=false #only show status if failed
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_VCS_GIT_ICON=

POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="\u2570\uf460 "

export DEFAULT_USER="mitochondrium" #hide user in prompt if default user
export HOMEBREW_CASK_OPTS="--appdir=/Applications" #give correct location to homebrew cask

#aliases
alias yad="yarn add --dev"
alias -g latest='*(om[1])'
alias -g tree="tree -C"
alias cat="bat --theme=\$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo default || echo GitHub)"
alias branch="git checkout master && git pull upstream master && git checkout -b"
alias ghpr="GH_FORCE_TTY=100% gh pr list | fzf --ansi --preview 'GH_FORCE_TTY=100% gh pr view {1}' --preview-window down --header-lines 3 | awk '{print $1}' | xargs gh pr checkout"
alias masked="maskedemail-cli --token $fastmail_token"


function autotunnel(){
    autossh -M 0 -o "ServerAliveInterval 30" -o "ServerAliveCountMax 120" -N -L localhost:8888:$1:8888 matthi@rackham.uppmax.uu.se
}
function cheat() {
    curl "cheat.sh/$1"
}
#show dots for slow autocompletion
LISTMAX=0
unsetopt LIST_AMBIGUOUS MENU_COMPLETE COMPLETE_IN_WORD
setopt AUTO_MENU AUTO_LIST LIST_PACKED
unambigandmenu() {
    echo -n "\e[31m...\e[0m"
    # avoid opening the list on the first expand
    unsetopt AUTO_LIST
    zle expand-or-complete
    setopt AUTO_LIST
    zle magic-space
    zle backward-delete-char
    zle expand-or-complete
    zle redisplay
}
zle -N unambigandmenu
bindkey "^i" unambigandmenu

function ezad() {
    if [ -n "$1" ]
    then
        eza --icons --all --color=always --group-directories-first "$@"
    else
        eza --icons --all --color=always --group-directories-first
    fi
}

function lsdd() {
    if [ -n "$1" ]
    then
        lsd --almost-all --group-dirs first "$@"
    else
        lsd --almost-all --group-dirs first
    fi
}
# Automatically list directory contents on `cd`.
# auto-ls () { lsdd -tr}
auto-ls () { ezad}
# auto-ls () { ls --color=auto; }
chpwd_functions=( auto-ls $chpwd_functions )

bgnotify_threshold=60  ## set your own notification threshold

# GRC colorizes nifty unix tools all over the place
# if (( $+commands[grc] )) && (( $+commands[brew] ))
# then
#   source `brew --prefix`/etc/grc.bashrc
# fi


#fixes for autojump
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh


#colorize ls output
# alias ls='lsdd'
alias ls='ezad'
# alias ls='ls --color=auto'

# fzf config
export FZF_BASE=/usr/local/opt/fzf
export FZF_DEFAUL_OPTS='
--color fg:-1,bg:-1,hl:230,fg+:3,bg+:233,hl+:229
--color info:150,prompt:110,spinner:150,pointer:167,marker:174
'

#fzf-tab config

zstyle ":completion:*:git-checkout:*" sort false
zstyle -d ':completion:*' format
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':fzf-tab:*' fzf-bindings 'space:accept,backward-eof:abort'   # Space as accept, abort when deleting empty space
zstyle ':fzf-tab:*' print-query ctrl-c        # Use input as result when ctrl-c
zstyle ':fzf-tab:*' accept-line enter         # Accept selected entry on enter
zstyle ':fzf-tab:*' fzf-pad 4
zstyle ':fzf-tab:*' prefix ''                 # No dot prefix
zstyle ':fzf-tab:*' single-group color header # Show header for single groups
zstyle ':fzf-tab:complete:(cd|ls|lsd|lsdd|j):*' fzf-preview '[[ -d $realpath ]] && eza --icons -1 --color=always -- $realpath'
zstyle ':fzf-tab:complete:((micro|cp|mv|rm|bat|less|code|nano|atom):argument-rest|kate:*)' fzf-preview 'bat --color=always -- $realpath 2>/dev/null || ls --color=always -- $realpath'
zstyle ':fzf-tab:complete:updatelocal:argument-rest' fzf-preview "git --git-dir=$UPDATELOCAL_GITDIR/\${word}/.git log --color --date=short --pretty=format:'%Cgreen%cd %h %Creset%s %Cred%d%Creset ||%b' ..FETCH_HEAD 2>/dev/null"
zstyle ':fzf-tab:complete:updatelocal:argument-rest' fzf-flags --preview-window=down:5:wrap
enable-fzf-tab

export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

#
#autojump + fzf
j() {
    if [[ "$#" -ne 0 ]]; then
        cd $(autojump $@)
        return
    fi
    cd "$(autojump -s | sort -k1gr | awk '$1 ~ /[0-9]:/ && $2 ~ /^\// { for (i=2; i<=NF; i++) { print $(i) } }' |  fzf --height 40% --reverse --inline-info)"
}


export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"

export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

# go path
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/mamba.sh" ]; then
    . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<


# lf - file manager

lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

[ -f "~/.config/lf/lfrc" ] && source "~/.config/lf/lfrc"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
alias R="/opt/homebrew/opt/r/bin/R --vanilla"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
## iterm2 shell integration 
source ~/.iterm2_shell_integration.zsh

# emulate docker non-arm docker images
docker() {
    if [[ `uname -m` == "arm64" ]] && [[ "$1" == "run" || "$1" == "build" ]]; then
        /usr/local/bin/docker "$1" --platform linux/amd64 "${@:2}"
    else
        /usr/local/bin/docker "$@"
    fi
}

export PATH="/opt/homebrew/opt/erlang@22/bin:$PATH"

eval $(thefuck --alias)

# folder of all of your autocomplete functions
fpath=($HOME/.zsh-completions $fpath)
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/mitochondrium/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# 1password completions
eval "$(op completion zsh)"; compdef _op opexport PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH=$PATH:/Users/mitochondrium/.pixi/bin
eval "$(pixi completion --shell zsh)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
