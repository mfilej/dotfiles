function scry
    set -l mise_cmd mise x github:stephendolan/scry -- scry

    switch "$argv[1]"
        case --help -h --version -v init templates
            $mise_cmd $argv
            return $status
    end

    # Capture stdout, keep stderr on the terminal
    set -l result ( $mise_cmd cd $argv 2>/dev/tty )
    set -l rc $status

    if test $rc -eq 0; and test -n "$result"
        eval "$result"
    end

    return $rc
end
