function fish_right_prompt
  set -l last_command_status $status
  if [ $last_command_status -ne 0 ]
    set_color 900
    echo "↪ $last_command_status"
    set_color normal
  end
end
