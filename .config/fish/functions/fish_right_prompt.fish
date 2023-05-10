function fish_right_prompt
  set -l last_command_status $status

  if test -n "$AWS_SSO_PROFILE"
    echo "⦗"
    set_color yellow
    echo "$AWS_SSO_PROFILE"
    set_color normal
    echo "⦘"
  end

  if [ $last_command_status -ne 0 ]
    set_color -r 900
    echo "↪ $last_command_status"
    set_color normal
  end
end
