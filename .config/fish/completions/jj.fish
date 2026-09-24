# Load on first jj completion; use the jj selected by mise/PATH, not Homebrew's pinned binary.
complete --keep-order --exclusive --command jj \
    --arguments '(COMPLETE=fish command jj -- (commandline --current-process --tokenize --cut-at-cursor) (commandline --current-token))'
