function __fish_pg_terminate_needs_db
    set -l tokens (commandline -opc)
    set -e tokens[1]

    test (count $tokens) -eq 0
end

complete -c pg-terminate --no-files
complete -c pg-terminate -n '__fish_pg_terminate_needs_db' -f -x -a '(__fish_complete_pg_database)' -d "Database name"
