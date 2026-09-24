# Two-line, synchronous prompt. No VCS or cloud queries on the repaint path.
function __prompt_path --argument-names budget
    set -l shown $PWD
    if test "$PWD" = "$HOME"
        set shown '~'
    else if string match -q -- "$HOME/*" "$PWD"
        set shown '~'(string sub -s (math (string length -- "$HOME") + 1) -- "$PWD")
    end

    # Directory names can contain newlines or terminal control sequences.
    set shown (string replace -ra '[[:cntrl:]]' '' -- "$shown")
    set -l parts (string split / -- "$shown")
    set -l abbreviated $parts
    set -l short_parts $parts
    set -l i 2
    while test $i -lt (count $parts)
        set -l part $parts[$i]
        if string match -q '.*' -- "$part"
            set abbreviated[$i] (string sub -l 2 -- "$part")
        else
            set abbreviated[$i] (string sub -l 1 -- "$part")
        end
        set i (math $i + 1)
    end

    set -l text (string join / -- $short_parts)
    if test (string length -V -- "$text") -gt $budget
        set i 2
        while test $i -lt (count $parts); and test (string length -V -- "$text") -gt $budget
            set short_parts[$i] $abbreviated[$i]
            set text (string join / -- $short_parts)
            set i (math $i + 1)
        end
    end

    # If even abbreviated parents and the leaf do not fit, keep the leaf's end.
    if test (string length -V -- "$text") -gt $budget
        set -l leaf $short_parts[-1]
        set -l prefix (string join / -- $short_parts[1..-2])
        set -l available (math max 1, $budget - (string length -V -- "$prefix") - 1)
        set short_parts[-1] (string shorten --left --max $available -- "$leaf")
        set text (string join / -- $short_parts)
        # Extremely narrow terminals: sacrifice the parents before the leaf.
        if test (string length -V -- "$text") -gt $budget
            set short_parts (string shorten --left --max $budget -- "$leaf")
        end
    end

    set -l last (count $short_parts)
    set i 1
    while test $i -le $last
        if test $i -gt 1
            printf /
        end
        if test $i -eq $last
            set_color --bold C4A000
        else if test "$short_parts[$i]" = "$parts[$i]"
            set_color 92780C
        else
            set_color 8787AF
        end
        printf '%s' "$short_parts[$i]"
        set i (math $i + 1)
    end
    set_color normal
end

function __prompt_character
    set -l character '$'
    if test "$fish_key_bindings" != fish_default_key_bindings
        switch $fish_bind_mode
            case default
                set character N
            case replace replace_one
                set character R
            case visual
                set character V
        end
    end
    set_color 7BCDFB
    printf '%s' "$character"
    set_color normal
    printf ' '
end

function __prompt_duration
    # Fish reports elapsed time in whole milliseconds, including 0 for quick builtins.
    set -l duration 0
    if set -q CMD_DURATION; and string match -qr '^[0-9]+$' -- "$CMD_DURATION"
        set duration $CMD_DURATION
    end
    set -l seconds (math -s0 "$duration / 1000 % 60")
    set -l millis (string pad -c 0 -w 3 -- (math "$duration % 1000"))
    set -l elapsed "$seconds.$millis"s
    set -l minutes (math -s0 "$duration / 60000 % 60")
    set -l hours (math -s0 "$duration / 3600000")
    if test $minutes -gt 0; or test $hours -gt 0
        set elapsed "$minutes"m' '"$elapsed"
    end
    if test $hours -gt 0
        set elapsed "$hours"h' '"$elapsed"
    end
    printf '%s' "$(set_color 525252 -b 262626) $elapsed$(set_color normal)"
end

function fish_prompt
    # Capture both before ANY command (including `set`) changes $pipestatus.
    set -l previous $status $pipestatus
    set -l failed 0
    set -l pipeline_failed 0
    for code in $previous[2..]
        if test $code -ne 0
            set failed 1
            set pipeline_failed 1
            break
        end
    end
    if test $previous[1] -ne 0
        set failed 1
    end

    set -l cols 80
    if set -q COLUMNS; and string match -qr '^[0-9]+$' -- "$COLUMNS"; and test $COLUMNS -gt 0
        set cols $COLUMNS
    end

    set -l duration (__prompt_duration)
    set -l status_item
    if test $failed -eq 1
        set -l codes $previous[2..]
        if test $pipeline_failed -eq 0
            set codes $previous[1]
        end
        set status_item (printf '%s' (set_color E52221) '[' (string join '|' -- $codes) ']' (set_color normal))
    end
    # Fish redraws this version beside the command just before it runs.
    # The duration belongs to the previous command, shown above this separator.
    if contains -- --final-rendering $argv
        set -l label $duration
        if test -n "$status_item"
            set label (string join ' ' -- "$status_item" "$duration")
            # On very narrow terminals, preserve the timer if both cannot fit.
            if test (string length -V -- "$label") -ge $cols
                set label $duration
            end
        end
        if test (string length -V -- "$label") -ge $cols
            set label (string shorten --max (math max 1, $cols - 1) -- "$label")
        end
        set -l rule_width (math max 0, $cols - (string length -V -- "$label") - 2)
        if test $rule_width -gt 0
            set_color 404040
            string repeat -N -n $rule_width '─'
            set_color normal
            printf ' '
        end
        printf '%s\n' "$label"
        __prompt_character
        return
    end

    set -l right_items
    if test -n "$status_item"
        set -a right_items $status_item
    end
    if set -q PGDATABASE; and test -n "$PGDATABASE"
        set -l database (string replace -ra '[[:cntrl:]]' '' -- "$PGDATABASE")
        if test -n "$database"
            set -a right_items (set_color 336790)"pg:$database"(set_color normal)
        end
    end
    if set -q SSH_TTY; or test "$EUID" = 0
        set -l context "$USER"(string split -m1 . -- "$hostname")[1]
        set -l color 5FAF00
        if test "$EUID" = 0
            set color E52221
        end
        set -a right_items (set_color $color)"$context"(set_color normal)
    end
    if jobs -q
        set -l job_count (jobs -p | count)
        set -a right_items (set_color 5FAF00)''" $job_count"(set_color normal)
    end
    set -l right_duration $duration
    if test (string length -V -- "$right_duration") -gt (math max 1, $cols - 2)
        set right_duration (string shorten --max (math max 1, $cols - 2) -- "$right_duration")
    end
    set -a right_items $right_duration

    # Hide low-priority right items before they force the first line to wrap.
    set -l right (string join ' ' -- $right_items)
    while test (count $right_items) -gt 1; and test (string length -V -- "$right") -gt (math max 0, $cols - 14)
        if test (count $right_items) -eq 2; and test -n "$status_item"
            # Spend path space before sacrificing a failure on narrower screens.
            if test (string length -V -- "$right") -le (math max 0, $cols - 3)
                break
            end
            set -e right_items[1]
        else
            set -e right_items[-2] # Keep the duration at the far right.
        end
        set right (string join ' ' -- $right_items)
    end
    set -l left_items
    if set -q SHLVL; and test $SHLVL -gt 1
        set -a left_items (set_color green)" $SHLVL"(set_color normal)
    end
    if set -q fish_private_mode; and test -n "$fish_private_mode"
        set -a left_items (set_color E52221)'󰗹'(set_color normal)
    end
    set -l extra (string join ' ' -- $left_items)
    while test (count $left_items) -gt 0; and test (string length -V -- "$extra") -gt (math max 0, $cols - (string length -V -- "$right") - 8)
        set -e left_items[1]
        set extra (string join ' ' -- $left_items)
    end
    # Reserve a blank final column, as the transient separator does.
    set -l budget (math max 1, $cols - (string length -V -- "$right") - (string length -V -- "$extra") - 3)
    set -l path (__prompt_path $budget)
    set -l left "$path"
    if test -n "$extra"
        set left "$left $extra"
    end
    set -l gap (math max 1, $cols - (string length -V -- "$left") - (string length -V -- "$right") - 1)
    printf '%s' "$left"
    if test -n "$right"
        string repeat -N -n $gap ' '
        printf '%s' "$right"
    end
    printf '\n'

    __prompt_character
end
