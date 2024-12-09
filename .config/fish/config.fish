# Preserve EDITOR if already set by Kitty, otherwise use vim
set -q EDITOR || set -x EDITOR vim

# Use hybrid keybindings, except when in a terminal inside (n)vim
set -q VIM || set -g fish_key_bindings fish_hybrid_key_bindings
