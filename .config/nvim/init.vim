let g:python_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

set inccommand=nosplit " Live preview for :s[ubstitute]

" Neovim Terminal-mode settings

tnoremap <Esc> <C-\><C-n>
tnoremap <C-v><Esc> <Esc>
tnoremap <Tab> <C-\><C-n> :tabn<CR>
tnoremap <S-Tab> <C-\><C-n> :tabp<CR>

augroup TerminalModeSetup
  au!
  autocmd TermOpen * setlocal nonumber norelativenumber
augroup END

let g:ale_sign_column_always = 1
