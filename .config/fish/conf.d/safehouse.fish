set -g safehouse_dirs \
    "/opt/zerobrew" \
    "/opt/homebrew" \
    "$HOME/.config" \
    "$HOME/.cache" \
    "$HOME/.local" \
    "$HOME/bin" \
    "$HOME/.fly" \
    "$HOME/.codex" \
    "$HOME/.claude"

set -g safehouse_dirs_ro \
    "/Applications/OrbStack.app"

function safe
    set -l safehouse_dir_args
    for dir in $safehouse_dirs
        set -a safehouse_dir_args --add-dirs="$dir"
    end

    set -l safehouse_dir_ro_args
    for dir in $safehouse_dirs_ro
        set -a safehouse_dir_ro_args --add-dirs-ro="$dir"
    end

    safehouse --enable=process-control --enable=docker \
        $safehouse_dir_args \
        $safehouse_dir_ro_args \
        $argv
end

function __safehouse_prepend_mise_shims
    set -lx PATH "$HOME/.local/share/mise/shims" $PATH
    $argv
end
function claude
    __safehouse_prepend_mise_shims safe claude --dangerously-skip-permissions $argv
end
function codex
    __safehouse_prepend_mise_shims safe codex --dangerously-bypass-approvals-and-sandbox $argv
end
function opencode
    __safehouse_prepend_mise_shims safe opencode $argv
end
