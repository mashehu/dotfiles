#!/usr/bin/zsh


#load antigen
ZSHA_BASE=$HOME/.zsh-antigen
source $ZSHA_BASE/antigen/antigen.zsh
fpath=(/usr/local/share/zsh-completions $fpath)
ttyctl -f #fixes error where the terminal confuses enter with return (prints ^M)
export $EDITOR=atom
#less syntax-highlighting
LESSPIPE=`which src-hilite-lesspipe.sh`
export LESSOPEN="| ${LESSPIPE} %s"
export LESS=' -R -X -F '


# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle pip
antigen bundle autojump #needs to be installed via homebrew
antigen bundle brew
antigen bundle brew-cask
antigen bundle common-aliases
antigen bundle npm
antigen bundle osx
antigen bundle web-search

antigen bundle djui/alias-tips
antigen bundle zsh-users/zsh-completions src #more completions
antigen bundle zsh-users/zsh-autosuggestions #proposes transparent suggestions based on command history
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle wbinglee/zsh-wakatime
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=green,fg=black,bold' #define colors for found items


#theme stuff

# Load the theme.

# antigen theme agnoster

# antigen theme https://github.com/caiogondim/bullet-train-oh-my-zsh-theme bullet-train
# BULLETTRAIN_GIT_SHOW=false
# BULLETTRAIN_VIRTUALENV_PREFIX=🏖
# BULLETTRAIN_PROMPT_CHAR="❯"
antigen theme bhilburn/powerlevel9k powerlevel9k
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir virtualenv)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time)
POWERLEVEL9K_STATUS_VERBOSE=false #only show status if failed
POWERLEVEL9K_PROMPT_ON_NEWLINE=true

# Tell antigen that you're done.
antigen apply

# needed for zsh-history-substring-search to work (remapping up and down key)
bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down

export DEFAULT_USER="mitochondrium" #hide user in prompt if default user
export HOMEBREW_CASK_OPTS="--appdir=/Applications" #give correct location to homebrew cask


#aliases

#show dots for slow autocompletion
expand-or-complete-with-dots() {
  echo -n "\e[31m...\e[0m"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

# Automatically list directory contents on `cd`.
auto-ls () { ls; }
chpwd_functions=( auto-ls $chpwd_functions )

#fixes for autojump
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
