if status is-interactive
    ~/.local/bin/mise activate fish | source
else
    ~/.local/bin/mise activate fish --shims | source
end
