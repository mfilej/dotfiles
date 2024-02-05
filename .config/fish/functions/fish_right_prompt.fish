function fish_right_prompt
    set last_command_status $status
    set -q AWS_SSO_PROFILE && set profile $AWS_SSO_PROFILE
    set -q AWS_VAULT && set profile $AWS_VAULT

    if test -n "$profile"
        echo "⦗"
        set_color yellow
        echo "$profile" | cut -d ':' -f 1
        set_color normal
        echo "⦘"
    end

    if [ $last_command_status -ne 0 ]
        set_color -r 900
        echo "↪ $last_command_status"
        set_color normal
    end
end
