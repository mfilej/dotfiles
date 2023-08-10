# Preserve EDITOR if already set by Kitty, otherwise use vim
set -q EDITOR || set -x EDITOR vim

set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8

set -x ERL_AFLAGS "-kernel shell_history enabled -kernel shell_history_file_bytes 1024000"
set -x GPG_TTY (tty)
set -x HOMEBREW_CASK_OPTS "--appdir=~/Applications"
set -x KERL_BUILD_DOCS yes
set -x RIPGREP_CONFIG_PATH "$HOME/.config/ripgreprc"
set -x SSH_AUTH_SOCK "$HOME/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock"

set -g fish_greeting

# Use hybrid keybindings, except when in a terminal inside (n)vim
set -q VIM || set -g fish_key_bindings fish_hybrid_key_bindings

abbr -g --add -- - "cd -"
abbr -g --add -- ... "../.."
abbr -g --add asdf rtx
abbr -g --add com docker-compose
abbr -g --add doc docker
abbr -g --add fly flyctl
abbr -g --add g git
abbr -g --add gf gitfox
abbr -g --add lb open -aLaunchBar
abbr -g --add ls ls -lah
abbr -g --add mig mix ecto.migrate
abbr -g --add migen mix ecto.gen.migration
abbr -g --add n nvim
abbr -g --add pgrep pgrep -lf
abbr -g --add yt yt-dlp

# We never really want regular vim when using Kitty
set -q KITTY_PID && abbr --add vim nvim

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

source /Users/miha/.config/op/plugins.sh
