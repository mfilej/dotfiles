function __fish_cask_search_terms
    set -l token (commandline -ct)

    if test -n "$token"
        command brew search --casks -- $token 2>/dev/null
    end
end

function __fish_cask_installed
    command brew list --cask 2>/dev/null
end

complete -c cask -f

complete -c cask \
    -n 'not __fish_seen_subcommand_from install uninstall search' \
    -a install \
    -d 'Install a cask'
complete -c cask \
    -n 'not __fish_seen_subcommand_from install uninstall search' \
    -a uninstall \
    -d 'Uninstall a cask'
complete -c cask \
    -n 'not __fish_seen_subcommand_from install uninstall search' \
    -a search \
    -d 'Search casks'

complete -c cask \
    -n '__fish_seen_subcommand_from install' \
    -a '(__fish_cask_search_terms)'
complete -c cask \
    -n '__fish_seen_subcommand_from search' \
    -a '(__fish_cask_search_terms)'
complete -c cask \
    -n '__fish_seen_subcommand_from uninstall' \
    -a '(__fish_cask_installed)'
