set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8
set -x EDITOR "/usr/local/bin/nvim"
set -x HOMEBREW_CASK_OPTS "--appdir=~/Applications"
set -e fish_greeting

abbr --add -- - "cd -"
abbr --add g git
abbr --add ls ls -la

alias vim nvim
alias lb "open -aLaunchBar"

function .G --wraps git
  git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME/ $argv
end

direnv hook fish | source
