local return_code="%(?..%{%F{009}%}%? ↵%{%f%})"
local current_dir="%{%F{081}%}%~%{%f%}"
local current_dir_name="%{%F{081}%}%.%{%f%}"
local prompt_char="%{%F{239}%}⟫%{%f%}"

git_prompt_info() {
  zgit_isgit || return 0

  local color="%{%F{083}%}"

  if zgit_hasunmerged; then
    color="%{%F{130}%}"
  elif ! zgit_isindexclean || ! zgit_isworktreeclean; then
    color="%{%F{220}%}"
  fi

  # echo -n "%{%F{239}%}@%{%f%}"
  echo -n "${color}$(zgit_head)%{%f%}"

  if zgit_hasuntracked; then
    echo -n "%{%F{155}%}+%{%f%}"
  fi
}

ruby_prompt_info() {
  echo -n "%{%F{232}%}"
  echo -n "$(rbenv version-name)"
  #echo -n "$(rvm-prompt)"
  echo -n "%{%f%}"
}

# PS1="${current_dir} \$(git_prompt_info)
# ${prompt_char} "
# PS1="${current_dir_name}\$(git_prompt_info)${prompt_char} "
# RPROMPT="${return_code}   \$(ruby_prompt_info)"
PS1="${current_dir_name}${prompt_char}"
RPROMPT="${return_code}  \$(git_prompt_info) \$(ruby_prompt_info)"

#PROMPT='${return_code}
#${git_info} %{$fg_bold[cyan]%}${PWD/#$HOME/~}%{$reset_color%}
#%{$fg[cyan]%}➥%{$reset_color%} '

#RPROMPT='%{$fg[red]%}⟢%{$reset_color%}%{$fg_bold[red]%}$(rvm_prompt_info)%{$reset_color%}'

