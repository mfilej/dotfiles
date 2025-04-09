function __jj_prompt
    jj root >/dev/null && jj log --revisions @ --no-graph --ignore-working-copy --color always --limit 1 --template '
        separate(" ",
          change_id.shortest(4),
          bookmarks,
          concat(
            if(conflict, "💥"),
            if(divergent, "🚧"),
            if(hidden, "👻"),
            if(immutable, "🔒"),
          ),
          raw_escape_sequence("\x1b[1;32m") ++ if(empty, "(empty)"),
          raw_escape_sequence("\x1b[1;32m") ++ if(description.first_line().len() == 0,
            "(no description set)",
            if(description.first_line().substr(0, 29) == description.first_line(),
              description.first_line(),
              description.first_line().substr(0, 29) ++ "…",
            )
          ) ++ raw_escape_sequence("\x1b[0m"),
        )
      '
end

function _tide_item_jj
    if test $PWD != $HOME
        _tide_print_item jj $tide_jj_icon' '(__jj_prompt)
    end
end
