# Load environment variables first (for both interactive and non-interactive shells)
if test -f ~/.env
    export (cat ~/.env | grep -v '^#' | xargs)
end

if status is-interactive
    # Set default editor
    set -gx EDITOR zed

    # PATH configuration
    fish_add_path /opt/homebrew/opt/llvm/bin
    fish_add_path /opt/homebrew/opt/openjdk/bin
    fish_add_path /opt/homebrew/opt/erlang@22/bin
    fish_add_path /usr/local/opt/coreutils/libexec/gnubin
    fish_add_path /usr/local/opt/ruby/bin
    fish_add_path /usr/local/sbin
    fish_add_path $HOME/.cargo/bin
    fish_add_path /usr/local/opt/openssl@1.1/bin
    fish_add_path $HOME/go/bin
    fish_add_path $HOME/.rd/bin
    fish_add_path $HOME/.pixi/bin
    fish_add_path /Users/matho180/.codeium/windsurf/bin

    # Tide theme configuration (equivalent to powerlevel10k)
    set -g tide_left_prompt_items pwd git python newline
    set -g tide_right_prompt_items status cmd_duration context time
    set -g tide_time_format %H:%M:%S

    # Git icon (branch icon)
    set -g tide_git_icon \ue0a0

    # PWD icons
    set -g tide_pwd_icon ''
    set -g tide_pwd_icon_home ''
    set -g tide_pwd_icon_unwritable ''

    # FZF configuration
    set -gx FZF_DEFAULT_COMMAND "fd --type file --color=always"
    set -gx FZF_DEFAULT_OPTS "--ansi --color fg:-1,bg:-1,hl:230,fg+:3,bg+:233,hl+:229 --color info:150,prompt:110,spinner:150,pointer:167,marker:174"

    # fzf.fish configuration
    set -g fzf_preview_dir_cmd eza --icons -1 --color=always
    set -g fzf_preview_file_cmd bat --color=always
    set -g fzf_fd_opts --hidden --exclude=.git

    # Aliases
    alias ls='ezad'
    alias cat='bat --theme=(if test (defaults read -globalDomain AppleInterfaceStyle 2>/dev/null) = Dark; echo default; else; echo GitHub; end)'
    alias branch='git checkout master && git pull upstream master && git checkout -b'
    alias ghpr='GH_FORCE_TTY=100% gh pr list | fzf --ansi --preview "GH_FORCE_TTY=100% gh pr view {1}" --preview-window down --header-lines 3 | awk \'{print $1}\' | xargs gh pr checkout'
    alias masked='maskedemail-cli --token $fastmail_token'
    alias python='python3'

    # Initialize rbenv
    if command -v rbenv >/dev/null
        rbenv init - fish | source
    end

    # Initialize thefuck
    if command -v thefuck >/dev/null
        thefuck --alias | source
    end

    # Initialize 1Password CLI
    if command -v op >/dev/null
        op completion fish | source
        if test -f ~/.config/op/plugins.sh
            # Note: plugins.sh is bash, may need fish conversion
        end
    end

    # Initialize pixi
    if command -v pixi >/dev/null
        pixi completion --shell fish | source
    end

    # Initialize zoxide (equivalent to autojump/z)
    if command -v zoxide >/dev/null
        zoxide init fish --cmd j | source
    end

    # Initialize mise (formerly rtx)
    if command -v mise >/dev/null
        mise activate fish | source
    end

    # Initialize conda if available
    if test -f /opt/homebrew/Caskroom/miniconda/base/etc/fish/conf.d/conda.fish
        source /opt/homebrew/Caskroom/miniconda/base/etc/fish/conf.d/conda.fish
    end

    # Initialize mamba if available
    if test -f /opt/homebrew/Caskroom/miniconda/base/etc/fish/conf.d/mamba.fish
        source /opt/homebrew/Caskroom/miniconda/base/etc/fish/conf.d/mamba.fish
    end

    # Initialize SDKMAN using bass
    if test -f $HOME/.sdkman/bin/sdkman-init.sh
        set -gx SDKMAN_DIR $HOME/.sdkman
        # SDKMAN functions available via: bass source "$SDKMAN_DIR/bin/sdkman-init.sh"
        # Or create wrapper functions in conf.d if needed
    end

    # iTerm2 shell integration
    if test -f ~/.iterm2_shell_integration.fish
        source ~/.iterm2_shell_integration.fish
    end

    # fzf key bindings (if not using fzf.fish plugin)
    if test -f ~/.config/fish/functions/fzf_key_bindings.fish
        fzf_key_bindings
    end
end
