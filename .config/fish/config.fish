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

function take
  mkdir -p $argv
  cd $argv
end

# Prompt

set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showstashstate 'yes'

set __fish_git_prompt_char_dirtystate '𝚫'
set __fish_git_prompt_char_stagedstate '±'
set __fish_git_prompt_char_untrackedfiles '+'
set __fish_git_prompt_char_stashstate '§'
set __fish_git_prompt_char_invalidstate '×'

set __fish_git_prompt_color_dirtystate '996'
set __fish_git_prompt_color_stagedstate '9c3'
set __fish_git_prompt_color_untrackedfiles '999'

function fish_prompt
  set_color $fish_color_cwd
  printf '%s' (prompt_pwd)
  set_color 888

  printf '%s' (__fish_git_prompt " ⋲ %s")

  set_color 444
  printf ' ❯ '
  set_color normal
end

function fish_right_prompt
  set -l last_command_status $status
  if [ $last_command_status -ne 0 ]
    set_color 900
    echo "↪ $last_command_status"
    set_color normal
  end
end

eval (direnv hook fish)
