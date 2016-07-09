aug AutoloadVimrc
  au!
  au BufWritePost ~/.vimrc source $MYVIMRC
aug END

set nocompatible

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

if $SHELL =~ 'fish'
  set shell=/bin/sh
endif

runtime macros/matchit.vim

let mapleader = " "

syntax enable
color vividchalk

highlight Comment       ctermfg=103
highlight CursorLine    guibg=#333333 guifg=NONE gui=NONE ctermbg=235 ctermfg=NONE cterm=NONE
highlight Search        guibg=black gui=underline ctermbg=black cterm=underline
highlight LineNr        ctermfg=246 ctermbg=234

" Load project-specific .vimrc, but disallow shell execution
set exrc
set secure

set wildignore+=.bundle/*
set wildignore+=build/**
set wildignore+=db/development/**
set wildignore+=db/test/**
set wildignore+=log/*
set wildignore+=*/node_modules/*
set wildignore+=*/public/uploads/**
set wildignore+=*/public/templates/**
set wildignore+=*/tmp/**

set grepprg=ag\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m

let g:ctrlp_switch_buffer = ''
let g:ctrlp_map = '<leader>p'
nmap <leader>P :CtrlP %%<cr>
" mnemonic: buffer
nmap <leader>b :CtrlPBuffer<cr>

" mnemonic: file
nmap <leader>fr :topleft :split config/routes.rb<cr>
nmap <leader>fg :topleft 100 :split Gemfile<cr>

" mnemonic: git
nmap <leader>gb :Gblame<cr>
nmap <leader>gk :Gcommit -v<cr>

vmap <leader>c "*y<CR>

nmap <leader>v :vs ~/.vimrc<CR>

nmap <leader>r :w\|:!reload_chromium<cr><cr>
nmap <leader>R :map <lt>leader>r :w<Bslash><Bar>!

nmap <leader>N :set paste!<CR>
nmap <leader>K :Ag "\b<C-R><C-W>\b"<CR>:cw<CR>

nmap <leader>[ :tabp<CR>
nmap <leader>] :tabn<CR>

nmap <leader>y ysiw
nmap <leader>Y ysaW

" Switching windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Disable F1 key
:map <F1> <nop>
:imap <F1> <nop>

" Syntax coloring lines that are too long just slows down the world
set synmaxcol=2048

set linespace=1

set textwidth=78

set formatoptions-=t

" Make the current window big, but leave others context
set winwidth=84
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=3
set winminheight=3
set winheight=999

" Show invisibles and line numbers
set list
set number

" Highlight current line
set cursorline

" Treat dash-separated words as keywords (CSS classes)
set isk+=-

" Insert only one space when joining lines that contain sentence-terminating
" punctuation like `.`.
set nojoinspaces

" Use the same symbols as TextMate for tabstops and EOLs
" Also adds trailing markers
" set listchars=tab:▸\ ,eol:¬,trail:⋅
set listchars=tab:▸\ ,trail:⋅

" Mark the right border
set colorcolumn=+1


" Soft tabs (C-V<Tab> to insert a proper tab)
set expandtab
" Soft tab width (preserve real tab as 8)
set softtabstop=2 shiftwidth=2 

" Start newlines properly
set autoindent
" set smartindent
filetype plugin indent on

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Backspace behavior
set backspace=indent,eol,start

set laststatus=2
set statusline=[%n]\ %<%.99f\ %{fugitive#statusline()}\ %=%-16(\ %l,%c-%v\ %)%P

set showcmd
set showmode
set hidden

" Autocomplete commands like a shell
set wildmenu
set wildmode=list:longest

" Case-insensitive searching unless expression contains a capital letter
set ignorecase
set smartcase

set hlsearch  " highlight search matches
set incsearch " highlight matches as you type

cnoremap %% <C-R>=expand('%:h').'/'<cr>

" ctrl-a moves to the beginning of the line in command mode
cnoremap <c-a> <home>

map <leader>h :set hls!<CR>

" Switch between the last two files with leader-leader
nnoremap <leader><leader> <c-^>

" Toggle wrap
nmap <leader>w :set nowrap!<CR>

set scrolloff=3

" No beeping
set visualbell

" Re-read file if it changes outside of vim (e.g. git checkout)
set autoread

set nobackup
set nowritebackup
set noswapfile

" Fixes fugitive's Gbrowse command
let g:netrw_browsex_viewer = "open"

" if has("vms")
"   set nobackup  " do not keep a backup file, use versions instead
" else
"   set backup    " keep a backup file
" endif

" Configure vim in iterm2 (http://usevim.com/2012/05/16/mouse/)
" Send more characters for redraws
set ttyfast
" Enable mouse use in all modes
set mouse=a
" Set this to the name of your terminal that supports mouse codes.
" Must be one of: xterm, xterm2, netterm, dec, jsbterm, pterm
set ttymouse=xterm2

" Key mappings
" Taking the training wheels off - no arrow keys in normal mode
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

" vim-hardmode
" autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
" nnoremap <leader>H <Esc>:call ToggleHardMode()<CR>

augroup rubypath
  autocmd!
  autocmd FileType ruby setlocal suffixesadd+=.rb
  autocmd FileType ruby setlocal path+=lib,spec/**/*
augroup END

" Thorfile, Rakefile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Thorfile,Guardfile,Vagrantfile,Envfile,config.ru,*.jbuilder} set ft=ruby

" Treat JSON files like JavaScript
au BufRead,BufNewFile *.json set ft=javascript

" gitconfig uses hard tabs
autocmd FileType gitconfig setl noexpandtab shiftwidth=8

autocmd Filetype gitcommit setlocal spell textwidth=72
autocmd Filetype markdown setlocal spell

autocmd FileType fish compiler fish

map <leader>W :call <SID>StripTrailingWhitespaces()<CR>

if has("autocmd")
  autocmd BufWritePre *.rb,*.ex,*.exs,*.js,*.sass,*.haml :call <SID>StripTrailingWhitespaces()
endif

function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

function! PromoteToLet()
  :normal! dd
  :normal! P
  :.s/\(\w\+\)\s\+=\s\+\(.*\)$/let(:\1) { \2 }/
  :normal ==
endfunction

:command! PromoteToLet :call PromoteToLet()
:map <leader>L :PromoteToLet<cr>

function! ClearAssignmentPadding()
  :normal! dd
  :normal! P
  :.s/\(\w\+\)\s\+=\s\+\(.*\)$/\1 = \2/
  :normal ==
endfunction

:command! ClearAssignmentPadding :call ClearAssignmentPadding()
:map <leader>= :ClearAssignmentPadding<cr>

" test.vim mappings
map <Leader>tf :w \| :TestFile<CR>
map <Leader>tn :w \| :TestNearest<CR>
map <Leader>ts :w \| :TestSuite<CR>
map <Leader>tt :w \| :TestLast<CR>
map <Leader>tv :w \| :TestVisit<CR>

" Switch between test and production code
function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction
function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  let going_to_spec = !in_spec
  let in_rails = filereadable("config/boot.rb")
  if going_to_spec
    if in_rails
      let new_file = substitute(new_file, '^app/', '', '')
    else
      let new_file = substitute(new_file, '^lib/', '', '')
    end
    let new_file = substitute(new_file, '\.rb$', '_spec.rb', '')
    let new_file = 'spec/' . new_file
  else
    let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
    let new_file = substitute(new_file, '^spec/', '', '')
    if in_rails
      if match(current_file, '^spec/lib/') == -1
        let new_file = 'app/' . new_file
      end
    else
      let new_file = 'lib/' . new_file
    endif
  endif
  return new_file
endfunction
nnoremap <leader>. :call OpenTestAlternate()<cr>

" https://github.com/jkramer/vim-checkbox/blob/master/plugin/checkbox.vim
function! ToggleCheckbox()
	let line = getline('.')

	if(match(line, "\\[ \\]") != -1)
		let line = substitute(line, "\\[ \\]", "[x]", "")
	elseif(match(line, "\\[x\\]") != -1)
		let line = substitute(line, "\\[x\\]", "[ ]", "")
	endif

	call setline('.', line)
endf
nnoremap <leader>x :call ToggleCheckbox()<cr>
