#!/usr/bin/zsh

# Prevent initialization of completion system before zim
skip_global_compinit=1

# Load environment variables first
source ~/.env

# Set default editor
export EDITOR='code'

# Theme Configuration
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir virtualenv anaconda vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time)
POWERLEVEL9K_TIME_FORMAT="%D{ %H:%M:%S}"
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_VCS_GIT_ICON=
POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="\u2570\uf460 "

# History configuration
HISTFILE="${HOME}/.zshhistory"
SAVEHIST=10000
HISTSIZE=10000
setopt HIST_IGNORE_ALL_DUPS
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history
setopt autocd

# Path configuration
typeset -U path
path=(
    /opt/homebrew/opt/llvm/bin
    /opt/homebrew/opt/openjdk/bin
    /opt/homebrew/opt/erlang@22/bin
    /usr/local/opt/coreutils/libexec/gnubin
    /usr/local/opt/ruby/bin
    /usr/local/sbin
    $HOME/.cargo/bin
    /usr/local/opt/openssl@1.1/bin
    $HOME/go/bin
    $HOME/.rd/bin
    $HOME/.pixi/bin
    $path
)

# Module configurations (before loading Zim)
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Initialize Zim
ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
    if (( ${+commands[curl]} )); then
        curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
            https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
    else
        mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
            https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
    fi
fi
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
    source ${ZIM_HOME}/zimfw.zsh init -q
fi

# Load Zim
source ${ZIM_HOME}/init.zsh

# History Substring Search Configuration
HISTORY_SUBSTRING_SEARCH_FUZZY=true
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=green,fg=black,bold'

# Key bindings
bindkey -e
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key

# FZF configuration
export FZF_DEFAULT_COMMAND="fd --type file --color=always"
export FZF_DEFAULT_OPTS="--ansi --color fg:-1,bg:-1,hl:230,fg+:3,bg+:233,hl+:229 --color info:150,prompt:110,spinner:150,pointer:167,marker:174"

# FZF-tab configuration
zstyle ":completion:*:git-checkout:*" sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':fzf-tab:*' fzf-bindings 'space:accept,backward-eof:abort'
zstyle ':fzf-tab:*' print-query ctrl-c
zstyle ':fzf-tab:*' accept-line enter
zstyle ':fzf-tab:*' fzf-pad 4
zstyle ':fzf-tab:*' prefix ''
zstyle ':fzf-tab:*' single-group color header
zstyle ':fzf-tab:complete:(cd|ls|lsd|lsdd|j):*' fzf-preview '[[ -d $realpath ]] && eza --icons -1 --color=always -- $realpath'
zstyle ':fzf-tab:complete:((micro|cp|mv|rm|bat|less|code|nano|atom):argument-rest|kate:*)' fzf-preview 'bat --color=always -- $realpath 2>/dev/null || ls --color=always -- $realpath'

# Aliases and functions
alias ls='ezad'
alias cat="bat --theme=\$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo default || echo GitHub)"
alias branch="git checkout master && git pull upstream master && git checkout -b"
alias ghpr="GH_FORCE_TTY=100% gh pr list | fzf --ansi --preview 'GH_FORCE_TTY=100% gh pr view {1}' --preview-window down --header-lines 3 | awk '{print $1}' | xargs gh pr checkout"
alias masked="maskedemail-cli --token $fastmail_token"
alias python="python3"

function ezad() {
    if [ $# -eq 0 ]; then
        eza --icons --all --color=always --group-directories-first
    else
        eza --icons --all --color=always --group-directories-first "$@"
    fi
}

function autotunnel() {
    autossh -M 0 -o "ServerAliveInterval 30" -o "ServerAliveCountMax 120" -N -L "localhost:8888:${1}:8888" matthi@rackham.uppmax.uu.se
}

# Auto ls after cd
function _auto_ls() {
    emulate -L zsh
    eza --icons --all --color=always --group-directories-first
}

typeset -ga chpwd_functions
if [[ ${chpwd_functions[(r)_auto_ls]} != "_auto_ls" ]]; then
    chpwd_functions+=(_auto_ls)
fi

# Load external configurations
# [[ -s "$(brew --prefix)/etc/profile.d/autojump.sh" ]] && source "$(brew --prefix)/etc/profile.d/autojump.sh"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.iterm2_shell_integration.zsh ] && source ~/.iterm2_shell_integration.zsh
[ -f "~/.config/lf/lfrc" ] && source "~/.config/lf/lfrc"

# Initialize conda if available
if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
    . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    conda activate base
fi
if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/mamba.sh" ]; then
    . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/mamba.sh"
fi

# Initialize SDKMAN
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Initialize other tools
eval "$(rbenv init -)"
eval "$(thefuck --alias)"
eval "$(op completion zsh)"
eval "$(pixi completion --shell zsh)"
eval "$(zoxide init zsh --cmd j)"

# Enable fzf-tab (must be at the end)
enable-fzf-tab

# Added by Windsurf
export PATH="/Users/matho180/.codeium/windsurf/bin:$PATH"
source /Users/matho180/.config/op/plugins.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
eval "$(mise activate zsh)"
