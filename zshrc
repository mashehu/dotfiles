#!/usr/bin/zsh

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
#load zplug
source /usr/local/opt/zplug/init.zsh
fpath=(/usr/local/share/zsh-completions $fpath)
ttyctl -f #fixes error where the terminal confuses enter with return (prints ^M)
# export $EDITOR=atom
# export $BROWSER=google-chrome
export HOMEBREW_NO_AUTO_UPDATE=1
export PATH=/usr/local/bin:$PATH
#less syntax-highlighting
export LESS="--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4"
export LESSOPEN="|/usr/local/bin/lesspipe.sh %s" LESS_ADVANCED_PREPROCESSOR=1
export LESSCOLORIZER='pygmentize'
#npm settings
# this is the root folder where all globally installed node packages will  go
export NPM_PACKAGES="/usr/local/npm_packages"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
# add to PATH
export PATH="$NPM_PACKAGES/bin:$PATH"

#mdv theme
export MDV_THEME="734.0784, 20"

#shpotify
export CLIENT_ID="5942b98466664a6096dc69e1996033f2"
export CLIENT_SECRET="9840abacd3ce4f45a9527aca7528be4d"

export FZF_BASE=/usr/local/opt/fzf
export FZF_DEFAUL_OPTS='
--color fg:252,bg:233,hl:67,fg+:252,bg+:235,hl+:81
--color info:144,prompt:161,spinner:135,pointer:135,marker:118
'

zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' #case insensitive fallback for tab-completion
# Bundles from the default repo (robbyrussell's oh-my-zsh).
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/pip", from:oh-my-zsh
# zplug "plugins/autojump", from:oh-my-zsh #needs to be installed via homebrew
zplug "plugins/brew", from:oh-my-zsh
zplug "plugins/brew-cask", from:oh-my-zsh
zplug "plugins/common-aliases", from:oh-my-zsh
zplug "plugins/npm", from:oh-my-zsh
zplug "plugins/yarn", from:oh-my-zsh
zplug "plugins/osx", from:oh-my-zsh
zplug "plugins/web-search", from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/extract", from:oh-my-zsh
zplug "plugins/fzf", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh


# zplug djui/alias-tips
zplug "zsh-users/zsh-completions", depth:1 #more completions
zplug "zsh-users/zsh-autosuggestions", from:github #proposes transparent suggestions based on command history
zplug "zsh-users/zsh-syntax-highlighting", from:github, defer:1
zplug "zsh-users/zsh-history-substring-search", from:github, defer:3
zplug "lukechilds/zsh-better-npm-completion", defer:2
zplug "wbinglee/zsh-wakatime", from:github
zplug "ascii-soup/zsh-url-highlighter", from:github
# zplug "zdharma/zui", from:github
# zplug "zdharma/zbrowse", from:github
zplug "supercrabtree/k", from:github #better ls
zplug "akoenig/gulp", from:github
zplug "Tarrasch/zsh-bd", from:github
# zplug "wookayin/fzf-fasd", from:github
zplug "changyuheng/fz", defer:1
zplug "Aloxaf/fzf-tab", from:github
zplug "plugins/z", from:oh-my-zsh

if zplug check zsh-users/zsh-autosuggestions; then
    ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-substring-search-up history-substring-search-down)
    ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=("${(@)ZSH_AUTOSUGGEST_CLEAR_WIDGETS:#(up|down)-line-or-history}")
    ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste accept-line)
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#8b8b8b"
fi

if zplug check zsh-users/zsh-history-substring-search; then
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
    HISTORY_SUBSTRING_SEARCH_FUZZY=true
    HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=green,fg=black,bold' #define colors for found items

fi

#theme stuff
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir virtualenv anaconda vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time)
POWERLEVEL9K_TIME_FORMAT="%D{ %H:%M:%S}"
POWERLEVEL9K_STATUS_VERBOSE=false #only show status if failed
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_VCS_GIT_ICON=

POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="\u2570\uf460 "
zplug "romkatv/powerlevel10k", use:powerlevel10k.zsh-theme

# powerlevel10k insta-prompt
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi
#
if command -v brew >/dev/null 2>&1; then
	# Load rupa's z if installed
	[ -f $(brew --prefix)/etc/profile.d/z.sh ] && source $(brew --prefix)/etc/profile.d/z.sh
fi
export DEFAULT_USER="mitochondrium" #hide user in prompt if default user
export HOMEBREW_CASK_OPTS="--appdir=/Applications" #give correct location to homebrew cask
# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load
# source ~/.zplug/repos/changyuheng/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh
#aliases
alias yad="yarn add --dev"
alias -g latest='*(om[1])'
alias -g tree="tree -C"


function autotunnel(){
  autossh -M 0 -o "ServerAliveInterval 30" -o "ServerAliveCountMax 120" -N -L localhost:8888:$1:8888 matthi@rackham.uppmax.uu.se
}
function cheat() {
  curl "cheat.sh/$1"
}
#show dots for slow autocompletion
expand-or-complete-with-dots() {
  echo -n "\e[31m...\e[0m"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dot
function lsdd() {
    if [ -n "$1" ]
    then
        lsd --almost-all --group-dirs first "$@"
    else
        lsd --almost-all --group-dirs first
    fi
}
# Automatically list directory contents on `cd`.
auto-ls () { lsdd }
# auto-ls () { ls --color=auto; }
chpwd_functions=( auto-ls $chpwd_functions )

# GRC colorizes nifty unix tools all over the place
if (( $+commands[grc] )) && (( $+commands[brew] ))
then
  source `brew --prefix`/etc/grc.bashrc
fi


#fixes for autojump
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh


#colorize ls output
alias ls='lsdd'
# alias ls='ls --color=auto'
# export PATH=/usr/local/miniconda3/bin:"$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

#autojump + fzf
j() {
    if [[ "$#" -ne 0 ]]; then
        cd $(autojump $@)
        return
    fi
    cd "$(autojump -s | sort -k1gr | awk '$1 ~ /[0-9]:/ && $2 ~ /^\// { for (i=2; i<=NF; i++) { print $(i) } }' |  fzf --height 40% --reverse --inline-info)"
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
. /usr/local/miniconda3/etc/profile.d/conda.sh
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
export RUBY_CONFIGURE_OPTS=--with-openssl-dir=/usr/local/opt/openssl@1.1
