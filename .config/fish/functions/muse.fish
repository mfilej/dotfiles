function muse
    # Get the tool (last argument)
    set -l tool $argv[-1]
    # Get all arguments except the last one
    set -l mise_use_args $argv[1..-2]

    if test -z "$tool"
        echo "Usage: muse [options] <tool>"
        return 1
    end

    set -l tool_version (mise ls-remote $tool | tail -r | fzf)

    if test -z "$tool_version"
        echo "No version selected"
        return 1
    end

    mise use $mise_use_args "$tool@$tool_version"
end
