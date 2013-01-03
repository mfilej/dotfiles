HISTFILE=$HOME/.zsh-history
HISTSIZE=10000
SAVEHIST=10000

setopt hist_ignore_dups # ignore duplication command history list
setopt inc_append_history
setopt share_history
setopt extended_history
setopt hist_ignore_dups
setopt hist_verify # perform substitution before executing !{line}
# setopt nullglob # rvm support
