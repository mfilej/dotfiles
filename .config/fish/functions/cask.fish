# `cask` is an alias for `brew cask`, but it also allows us to call `cask up`
# which otherwise causes homebrew-cask to complain.
function cask
  if test "$argv[1]" = "up"
    brew up
  else if test "$argv[1]" = "search"
    brew search "$argv[2..-1]"
  else
    brew cask $argv
  end
end
