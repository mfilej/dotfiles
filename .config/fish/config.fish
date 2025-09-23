# Use hybrid keybindings, except when in a terminal inside (n)vim
set -q VIM || set -g fish_key_bindings fish_hybrid_key_bindings


# Source ALL the things

if status is-interactive
    ~/.local/bin/mise activate fish | source
else
    ~/.local/bin/mise activate fish --shims | source
end

/Users/miha/.local/bin/mise x -- jj util completion fish | source
pitchfork activate fish | source
source ~/.config/op/plugins.sh
