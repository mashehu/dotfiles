shopt -s cdspell            # autocorrects cd misspellings

alias la='ls -lah $LS_COLOR'
# awesome!  CD AND LA. I never use 'cd' anymore...
function cl(){ cd "$@" && la; }

export CLICOLOR=1

# autojump
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

