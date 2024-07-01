set __fish_git_prompt_showdirtystate yes
set __fish_git_prompt_showuntrackedfiles yes
set __fish_git_prompt_showstashstate yes

set __fish_git_prompt_char_dirtystate 𝚫
set __fish_git_prompt_char_stagedstate '±'
set __fish_git_prompt_char_untrackedfiles '+'
set __fish_git_prompt_char_stashstate '§'
set __fish_git_prompt_char_invalidstate '×'

set __fish_git_prompt_color_dirtystate 996
set __fish_git_prompt_color_stagedstate 9c3
set __fish_git_prompt_color_untrackedfiles 999

function fish_prompt
    set_color $fish_color_cwd
    printf '%s' (prompt_pwd)
    set_color 888

    printf '%s' (__fish_git_prompt "  %s")

    set_color 444
    printf ' > '
    set_color normal
end
