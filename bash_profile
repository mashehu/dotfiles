shopt -s cdspell            # autocorrects cd misspellings

alias la='ls -lah $LS_COLOR'
# awesome!  CD AND LA. I never use 'cd' anymore...
function cl(){ cd "$@" && la; }

export CLICOLOR=1

# autojump
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh



# added by Anaconda2 5.1.0 installer
export PATH="/anaconda2/bin:$PATH"

# added by Miniconda2 installer
export PATH="/Users/mitochondrium/miniconda2/bin:$PATH"
# added by Anaconda3 5.3.0 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/Users/mitochondrium/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/Users/mitochondrium/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/mitochondrium/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/Users/mitochondrium/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<
