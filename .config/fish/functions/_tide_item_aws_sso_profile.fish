function _tide_item_aws_sso_profile
    if set -q AWS_SSO_PROFILE
        _tide_print_item aws_sso_profile $tide_aws_sso_profile_icon' ' (echo $AWS_SSO_PROFILE)
    end
end
