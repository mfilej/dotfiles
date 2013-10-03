if [ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  ZSH_HIGHLIGHT_STYLES[path]=fg=cyan
  ZSH_HIGHLIGHT_STYLES[path_prefix]=fg=cyan
  ZSH_HIGHLIGHT_STYLES[path_approx]=fg=cyan
fi
