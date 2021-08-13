function git
  set -l git_cmd

  if test (pwd) = $HOME
    set git_cmd (which git) --git-dir=$HOME/.dotfiles.git --work-tree=$HOME/
  else
    set git_cmd (which git)
  end

  if count $argv > /dev/null
    $git_cmd $argv
  else
    $git_cmd status -sb
  end
end

