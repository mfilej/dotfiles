function vcs_ff
  if test -d .jj
    echo "jj git fetch"
  else
    echo "git pull --ff-only"
  end
end
