abbr vim nvim
abbr python python3.12

alias  l='eza -lh  --icons=auto' # long list
alias ls='eza -1   --icons=auto' # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto' # long list dirs
alias lt='eza -T --icons=auto' # list tree

if status is-interactive
    # Commands to run in interactive sessions can go here
    zoxide init --cmd cd fish | source
    starship init fish | source
end

set -g fish_greeting
set -gx PATH $PATH:$HOME/.cargo/bin
set -gx VISUAL nvim
set -gx EDITOR nvim

# Pokemon Random Sprite
krabby random
