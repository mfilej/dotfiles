# Make mise available to tools such as VSCode extensions that assume zsh instead
# of the configured shell
eval "$(~/.local/bin/mise activate zsh)"

# Activate homebrew just in case
eval "$(/opt/homebrew/bin/brew shellenv)"

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
