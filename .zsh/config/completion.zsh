autoload -U compinit; compinit 

setopt complete_in_word # completion takes place at the cursor position
setopt always_to_end    # move cursor to end of word after completion


# show auto-completion menu
zstyle ':completion:*:*:*:*:*' menu select

# case-insensitive for lowecase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

bindkey '^P' history-substring-search-up # zsh-history-substring-search plugin
bindkey '^N' history-substring-search-down
