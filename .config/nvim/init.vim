let g:python_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc


" Neovim Terminal-mode settings

tnoremap <Esc> <C-\><C-n>
tnoremap <C-v><Esc> <Esc>

augroup TerminalModeSetup
  au!
  autocmd TermOpen * setlocal nonumber norelativenumber
augroup END

let g:ale_sign_column_always = 1
