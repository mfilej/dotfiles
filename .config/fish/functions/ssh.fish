function ssh
  if set -q KITTY_PID
    kitten ssh $argv
  else
    /usr/bin/ssh $argv
  end
end
