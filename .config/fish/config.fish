set -g fish_greeting
set -gx PATH $PATH:$HOME/.cargo/bin
set -gx VISUAL nvim
set -gx EDITOR nvim

abbr vim nvim

alias  l='eza -lh  --icons=auto' # long list
alias ls='eza -1   --icons=auto' # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto' # long list dirs
alias lt='eza -T --icons=auto' # list tree

if status is-interactive
    # Pokemon Random Sprite
    krabby random --no-title

    # Commands to run in interactive sessions can go here
    zoxide init --cmd cd fish | source
    starship init fish | source
    enable_transience
end

function fish_user_key_bindings
    # Execute this once per mode that emacs bindings should be used in
    fish_default_key_bindings -M insert

    # Then execute the vi-bindings so they take precedence when there's a conflict.
    # Without --no-erase fish_vi_key_bindings will default to
    # resetting all bindings.
    # The argument specifies the initial mode (insert, "default" or visual).
    fish_vi_key_bindings --no-erase insert
end

# Enable node & npm while ignoring the stdout
nvm use latest > /dev/null

# Transient Prompt
function starship_transient_prompt_func
  starship module character
end

function starship_transient_rprompt_func
  starship module time
end

