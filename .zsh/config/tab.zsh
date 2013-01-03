new_tab_preexec_hook () {print -Pn "\e]2; %~/ \a"}
new_tab_precmd_hook ()  {print -Pn "\e]2; %~/ \a"}

add-zsh-hook preexec new_tab_preexec_hook
add-zsh-hook precmd new_tab_precmd_hook
