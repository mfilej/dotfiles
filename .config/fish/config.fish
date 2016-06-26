set -x GEM_HOME $HOME/.gem
set -x PATH ./bin $HOME/.bin $GEM_HOME/bin $HOME/Library/Python/2.7/bin /usr/local/opt/postgresql-9.4/bin $PATH

set -x EDITOR vim

alias cask "brew cask"

function g --wraps git
  git $argv
end

function .G --wraps git
  git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME/ $argv
end

set -g CDPATH . ~

eval (direnv hook fish)
