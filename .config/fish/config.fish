set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8
set -x EDITOR "/usr/local/bin/nvim"
set -x GPG_TTY (tty)
set -x HOMEBREW_CASK_OPTS "--appdir=~/Applications"
set -e fish_greeting

abbr --add -- - "cd -"
abbr --add com docker-compose
abbr --add do docker
abbr --add g git
abbr --add keybase keybase --standalone
abbr --add lb open -aLaunchBar
abbr --add pgrep pgrep -lf
abbr --add v vim

# vim-fugitive equivalents
abbr --add cb  git branch
abbr --add ce  git commit --amend --no-edit
abbr --add co  git checkout
abbr --add crc git reset --soft HEAD^
abbr --add cva git commit --amend -v 
abbr --add cvc git commit -v
abbr --add rr  git rebase --continue

alias vim nvim

direnv hook fish | source
