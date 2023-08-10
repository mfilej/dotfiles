function nvim
    if set -q NVIM
        nvr --servername $NVIM -cc tabnew $argv
    else
        if set -q KITTY_WINDOW_ID
            set -l nvim_listen_address $TMPDIR"nvim-"$KITTY_WINDOW_ID
            set -xg GIT_EDITOR nvr --servername $nvim_listen_address -cc tabnew
            env /opt/homebrew/bin/nvim --listen $nvim_listen_address
        else
            /usr/bin/vim
        end
    end
end
