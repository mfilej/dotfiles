function confedit --description 'Fuzzy-search ~/.config file paths and open matches in nvim'
    set -l dir ~/.config
    set -l initial_query (string join ' ' -- $argv)
    set -l preview 'bat --style=numbers --color=always --line-range=:500 {}'

    set -l selections (
        command find $dir \
            \( -path '*/.git' -o -path '*/.jj' -o -path '*/node_modules' \) -prune \
            -o -type f \
            ! -name '.DS_Store' \
            -print |
        command fzf \
            --multi \
            --query "$initial_query" \
            --preview "$preview" \
            --preview-window 'up,60%,border-bottom'
    )

    if test (count $selections) -eq 0
        return 1
    end

    command nvim $selections
end
