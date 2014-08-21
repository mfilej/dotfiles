# Path

set -x PATH ./bin $HOME/.bin $HOME/.rbenv/shims $HOME/Library/Python/2.7/bin $PATH

# Other env vars

set -x EDITOR vim

# Aliases

alias .G="git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME/"
alias g=git

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

# rbenv

function rbenv_shell
  set -l vers $argv[1]

  switch "$vers"
    case '--unset'
      set -e RBENV_VERSION
    case ''
      if [ -z "$RBENV_VERSION" ]
        echo "rbenv: no shell-specific version configured" >&2
        return 1
      else
        echo "$RBENV_VERSION"
      end
    case '*'
      rbenv prefix "$vers" > /dev/null
      set -g -x RBENV_VERSION "$vers"
  end
end

function rbenv
  set -l command $argv[1]
  [ (count $argv) -gt 1 ]; and set -l args $argv[2..-1]

  switch "$command"
    case shell
      rbenv_shell $args
    case '*'
      command rbenv $command $args
  end
end

eval (direnv hook fish)
