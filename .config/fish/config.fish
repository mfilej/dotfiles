# Preserve EDITOR if already set by Kitty, otherwise use vim
set -q EDITOR || set -x EDITOR vim

# Use hybrid keybindings, except when in a terminal inside (n)vim
set -q VIM || set -g fish_key_bindings fish_hybrid_key_bindings

# If the terminal is capable enough, forget about regular vim
set -q KITTY_PID && abbr --add vim nvim

# Unset global to allow universal variable to take over
set -ge SSH_AUTH_SOCK

abbr -g --add -- - "cd -"
abbr -g --add -- ... "../.."
abbr -g --add ass aws-sso
abbr -g --add com docker-compose
abbr -g --add doc docker
abbr -g --add fly flyctl
abbr -g --add g git
abbr -g --add gf gitfox
abbr -g --add lb open -aLaunchBar
abbr -g --add ls ls -lah
abbr -g --add m mise
abbr -g --add mig mix ecto.migrate
abbr -g --add migen mix ecto.gen.migration
abbr -g --add n nvim
abbr -g --add pgrep pgrep -lf
abbr -g --add rtx mise
abbr -g --add yt yt-dlp

# vim-fugitive equivalents
abbr -g --add cb git branch
abbr -g --add ce git commit --amend --no-edit
abbr -g --add co git checkout
abbr -g --add c git commit
abbr -g --add crc git reset --soft HEAD^
abbr -g --add cva git commit --amend -v
abbr -g --add cvc git commit -v
abbr -g --add r git rebase
abbr -g --add rr git rebase --continue

abbr -g --add ff git pull --ff-only

source ~/.config/op/plugins.sh
~/.local/bin/mise activate fish | source
