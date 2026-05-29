# Fish completions for aqua - https://aquaproj.github.io/

set -l commands init install generate update-aqua update-checksum update which info remove vacuum token cp policy init-policy exec list generate-registry root-dir version help completion

complete -c aqua -f
complete -c aqua -n "not __fish_seen_subcommand_from $commands" -a "init" -d "Create a configuration file if it doesn't exist"
complete -c aqua -n "not __fish_seen_subcommand_from $commands" -a "install i" -d "Install tools"
complete -c aqua -n "not __fish_seen_subcommand_from $commands" -a "generate g" -d "Search packages in registries and output the configuration interactively"
complete -c aqua -n "not __fish_seen_subcommand_from $commands" -a "update-aqua upa" -d "Update aqua"
complete -c aqua -n "not __fish_seen_subcommand_from $commands" -a "update-checksum upc" -d "Create or Update aqua-checksums.json"
complete -c aqua -n "not __fish_seen_subcommand_from $commands" -a "update up" -d "Update registries and packages"
complete -c aqua -n "not __fish_seen_subcommand_from $commands" -a "which" -d "Output the absolute file path of the given command"
complete -c aqua -n "not __fish_seen_subcommand_from $commands" -a "info" -d "Show information"
complete -c aqua -n "not __fish_seen_subcommand_from $commands" -a "remove rm" -d "Uninstall packages"
complete -c aqua -n "not __fish_seen_subcommand_from $commands" -a "vacuum" -d "Remove unused installed packages"
complete -c aqua -n "not __fish_seen_subcommand_from $commands" -a "token" -d "Manage GitHub Access token"
complete -c aqua -n "not __fish_seen_subcommand_from $commands" -a "cp" -d "Copy executable files in a directory"
complete -c aqua -n "not __fish_seen_subcommand_from $commands" -a "policy" -d "Manage Policy"
complete -c aqua -n "not __fish_seen_subcommand_from $commands" -a "exec" -d "Execute tool"
complete -c aqua -n "not __fish_seen_subcommand_from $commands" -a "list" -d "List packages in Registries"
complete -c aqua -n "not __fish_seen_subcommand_from $commands" -a "generate-registry gr" -d "Generate a registry's package configuration"
complete -c aqua -n "not __fish_seen_subcommand_from $commands" -a "root-dir" -d "Output the aqua root directory"
complete -c aqua -n "not __fish_seen_subcommand_from $commands" -a "version" -d "Show version"
complete -c aqua -n "not __fish_seen_subcommand_from $commands" -a "help h" -d "Shows a list of commands or help for one command"
complete -c aqua -n "not __fish_seen_subcommand_from $commands" -a "completion" -d "Output shell completion script"

# Global options
complete -c aqua -l log-level -d "Log level" -r
complete -c aqua -s c -l config -d "Configuration file path" -r -F
complete -c aqua -l disable-cosign -d "Disable Cosign verification"
complete -c aqua -l disable-slsa -d "Disable SLSA verification"
complete -c aqua -l disable-github-artifact-attestation -d "Disable GitHub Artifact Attestations verification"
complete -c aqua -l disable-github-immutable-release -d "Disable GitHub Release Attestations verification"
complete -c aqua -s h -l help -d "Show help"
complete -c aqua -s v -l version -d "Print the version"

# completion subcommand
complete -c aqua -n "__fish_seen_subcommand_from completion" -a "bash zsh fish powershell" -d "Shell type"
