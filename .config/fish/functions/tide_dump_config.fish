function tide_dump_config
    set -f vars (set --name | grep '^tide_' | egrep -v 'tide_(prompt_|last_pid|parent_dirs|pwd_len|crystal_|direnv_|distrobox_|docker_|elixir_|gcloud_|git_|go_|java_|kubectl_|nix_shell_|node_|os_|php_|pulumi_|python_|ruby_|rustc_|terraform_|time_|toolbox_|vi_|zig_)')

    for var in $vars
        echo "set -U $var '"(eval echo '$'$var)"'"
    end
end
