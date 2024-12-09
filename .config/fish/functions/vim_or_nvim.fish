function vim_or_nvim
    if set -q KITTY_PID
        echo nvim
    else
        echo vim
    end
end
