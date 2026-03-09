function safe
    safehouse --enable=process-control --add-dirs="$HOME/.config" --add-dirs="$HOME/bin" $argv
end

function claude
    safe claude --dangerously-skip-permissions $argv
end
function codex
    safe codex --dangerously-bypass-approvals-and-sandbox $argv
end
function opencode
    set -lx OPENCODE_PERMISSION allow
    safe opencode $argv
end
