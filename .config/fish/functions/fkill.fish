# https://github.com/gyakovlev/fish-fzy/blob/c8335ca5027805ad8f5797f0dc7c6bfb530e03c3/functions/fkill.fish
function fkill --description="List process with fzy, enter to kill"
  ps ax -o pid,time,command | fzy -q "$LBUFFER" | awk '{print $1}' | xargs kill
end
