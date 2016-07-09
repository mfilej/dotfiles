function iterm2_print_user_vars
  iterm2_set_user_var gitBranch (__fish_git_prompt "%s"; or echo "")
end
