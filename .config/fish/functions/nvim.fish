function nvim
    if set -q NVIM
        nvr --servername $NVIM -cc tabnew $argv
    else
        if set -q KITTY_WINDOW_ID
            set -l nvim_listen_address $TMPDIR"nvim-"$KITTY_WINDOW_ID
            env /opt/homebrew/bin/nvim --listen $nvim_listen_address $argv
        else
            /usr/bin/vim $argv
        end
    end
end
