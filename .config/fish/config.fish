set -g CDPATH . ~
set -x EDITOR vim
set -x HOMEBREW_CASK_OPTS "--appdir=~/Applications"

alias g git
alias cask "brew cask"
alias lb "open -aLaunchBar"

function .G --wraps git
  git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME/ $argv
end

eval (direnv hook fish)

if test -n "$ITERM_SESSION_ID"
  source ~/.config/fish/iterm2_shell_integration.fish
end 
