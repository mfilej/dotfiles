set -x EDITOR vim
set -x HOMEBREW_CASK_OPTS "--appdir=~/Applications"

alias cask "brew cask"

function g --wraps git
  git $argv
end

function .G --wraps git
  git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME/ $argv
end

set -g CDPATH . ~

eval (direnv hook fish)

if test -n "$ITERM_SESSION_ID"
  source ~/.config/fish/iterm2_shell_integration.fish
end 
