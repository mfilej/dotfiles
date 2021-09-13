set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8
set -x EDITOR "/opt/homebrew/bin/nvim"
set -x GPG_TTY (tty)
set -x HOMEBREW_CASK_OPTS "--appdir=~/Applications"
set -x ERL_AFLAGS "-kernel shell_history enabled -kernel shell_history_file_bytes 1024000"
set -x RIPGREP_CONFIG_PATH "$HOME/.config/ripgreprc"
set -e fish_greeting

abbr --add -- - "cd -"
abbr --add com docker-compose
abbr --add do docker
abbr --add g git
abbr --add gg gigalixir
abbr --add keybase keybase --standalone
abbr --add lb open -aLaunchBar
abbr --add ls ls -lah
abbr --add pgrep pgrep -lf
abbr --add v vim

# vim-fugitive equivalents
abbr --add cb  git branch
abbr --add ce  git commit --amend --no-edit
abbr --add co  git checkout
abbr --add c git commit
abbr --add crc git reset --soft HEAD^
abbr --add cva git commit --amend -v 
abbr --add cvc git commit -v
abbr --add r  git rebase
abbr --add rr  git rebase --continue

abbr --add ff git pull --ff-only

alias vim nvim

direnv hook fish | source
