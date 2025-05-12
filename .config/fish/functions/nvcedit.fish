function __nvcedit_select_file --argument-names dir
    set -l preview "bat --style=numbers --color=always --line-range=:500 {}"
    find $dir -type f -name "*.lua" | fzf --delimiter / --with-nth -2.. --preview $preview
end

function __nvcedit_open_file --argument-names dir file
    # Use a subshell to avoid changing the current directory of the parent shell
    fish -c "cd $dir && exec nvim $file"
end

function nvcedit --argument-names config --description "Edit LazyVim config"
    set -l dir ~/.config/nvim/lua/

    # Without an argument, use fzf to select a file
    if test -z "$config"
        set -l file (__nvcedit_select_file $dir)
        if test -z "$file"
            echo "No file selected"
            return 1
        else
            __nvcedit_open_file $dir $file
        end
        return
    end

    # First, check for .lua files in lua/config/
    set -l config_file $dir"config/"$config".lua"
    if test -f $config_file
        __nvcedit_open_file $dir $config_file
        return
    end

    # Second, check for .lua files in lua/plugins/
    set -l plugin_file $dir"plugins/"$config".lua"
    if test -f $plugin_file
        __nvcedit_open_file $dir $plugin_file
        return
    end

    # Lastly, if the argument is a GitHub user/repo argument, initialize a new plugin file
    if string match -q "*/*" $config
        set -l user_repo (string split "/" $config)
        set -l plugin $user_repo[2]

        # Trim .nvim or .vim suffix from plugin name
        set plugin (string replace -r '\.n?vim$' '' $plugin)

        set -l file $dir"plugins/"$plugin".lua"
        if ! test -f $file
            echo "Creating new plugin file $file for $config"
            echo "return { { \"$config\"} }" >$file
        end
        __nvcedit_open_file $dir $file
        return
    end

    echo "Usage: nvcedit <config|user/repo>"
    echo
    echo "   - config is an existing .lua file in lua/config/ or lua/plugins/"
    echo "   - user/repo is a GitHub user/repo to initialize a new plugin"
end
