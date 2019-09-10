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

alias git hub
alias vim nvim

function .G --wraps git
  git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME/ $argv
end

direnv hook fish | source
