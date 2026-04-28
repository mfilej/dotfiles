function cask --description 'Run brew install|uninstall|search with --cask'
    set -l subcommand $argv[1]

    if not contains -- $subcommand install uninstall search
        printf 'usage: cask {install|uninstall|search} [args...]\n' >&2
        return 1
    end

    command brew $subcommand --cask $argv[2..-1]
end
