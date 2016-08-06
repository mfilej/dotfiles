" VIMRC
" =====

aug AutoloadVimrc
  au!
  au BufWritePost ~/.vimrc source $MYVIMRC
aug END

set nocompatible
set exrc   " load project-specific .vimrc
set secure "   (but disallow shell execution)

execute pathogen#infect()


" Colors & Theme
" --------------

syntax enable
set t_Co=256
color vividchalk

highlight Comment     ctermfg=103
highlight CursorLine  guibg=#333333 guifg=NONE gui=NONE
                    \ ctermbg=235 ctermfg=NONE cterm=NONE
highlight Search      guibg=black gui=underline ctermbg=black cterm=underline
highlight LineNr      ctermfg=246 ctermbg=234

" Bindings
" --------

let mapleader = " "
let g:ctrlp_map = '<leader>p'
let g:ctrlp_switch_buffer = '' " ignore if buffer is already open somewhere
nmap <leader>P :CtrlP %%<cr>
nmap <leader>b :CtrlPBuffer<cr> " mnemonic: buffer
nmap <leader>fg :Bsplit<cr> " mnemonic: file
nmap <leader>gb :Gblame<cr> " mnemonic: git
nmap <leader>gh :Gbrowse<cr>
nmap <leader>gk :Gcommit -v<cr>
nmap <leader>v :vs ~/.vimrc<CR>
nmap <leader>r :w\|:!reload_chromium<cr><cr>
nmap <leader>R :map <lt>leader>r :w<Bslash><Bar>!
nmap <leader>N :set paste!<CR>
nmap <leader>K :Ag "\b<C-R><C-W>\b"<CR>:cw<CR>
nmap <leader>[ :tabp<CR>
nmap <leader>] :tabn<CR>
nmap <leader>y ysiw
nmap <leader>Y ysaW
nmap <leader>w :set nowrap!<CR> " toggle line wrapping

map <Leader>tf :w \| :TestFile<CR> " test.vim mappings
map <Leader>tn :w \| :TestNearest<CR>
map <Leader>ts :w \| :TestSuite<CR>
map <Leader>tt :w \| :TestLast<CR>
map <Leader>tv :w \| :TestVisit<CR>

nnoremap <leader><leader> <c-^>
nnoremap <leader>. :A<cr> " alternate
nnoremap <c-j> <c-w>j " switching windows
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
noremap <up> <nop> " no arrow keys in normal mode
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

vmap <leader>c "*y<CR>

cnoremap %% <C-R>=expand('%:h').'/'<cr> " %% expands to pwd in command mode
cnoremap <c-a> <home> " move to beginning of the line in command mode too

map <F1> <nop> " disable F1 key
imap <F1> <nop>


" Options
" -------

set synmaxcol=2048 " long lines slow down highlighting
set linespace=1
set textwidth=78

" Make the current window big, but leave others context
set winwidth=84
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=3
set winminheight=3
set winheight=999

" Insert only one space when joining lines that contain sentence-terminating
" punctuation like `.`.
set nojoinspaces

" Use the same symbols as TextMate for tabstops and EOLs
" Also adds trailing markers
" set listchars=tab:▸\ ,eol:¬,trail:⋅
set list
set listchars=tab:▸\ ,trail:⋅

set number " show line numbers
set cursorline " highlight current line
set isk+=- " treat dash-separated words as keywords (CSS classes)
set colorcolumn=+1 " mark the right border
set expandtab " use soft tabs (C-V<Tab> to insert tab character)
set softtabstop=2 shiftwidth=2 " soft tab width (preserve real tab as 8)
set showcmd
set showmode
set hidden
set wildmode=list:longest " autocomplete commands like a shell
set visualbell " no beeping
set ignorecase " case-insensitive search
set smartcase  "   (unless expression contains a capital letter)
set hlsearch  " highlight search matches
set re=1 " https://git.io/v6YxR
set nobackup
set nowritebackup
set noswapfile

set statusline=[%n]\ %<%.99f\ %{fugitive#statusline()}\ %=%-16(\ %l,%c-%v\ %)%P

let g:netrw_browsex_viewer = "open" " fix fugitive's :Gbrowse command


" Mouse & iTerm2 support
" ----------------------

" Configure vim in iterm2 (http://usevim.com/2012/05/16/mouse/)
" Send more characters for redraws
set ttyfast
" Enable mouse use in all modes
set mouse=a
" Set this to the name of your terminal that supports mouse codes.
" Must be one of: xterm, xterm2, netterm, dec, jsbterm, pterm
set ttymouse=xterm2


" Ignores
" -------

set wildignore+=.bundle/*
set wildignore+=build/**
set wildignore+=db/development/**
set wildignore+=db/test/**
set wildignore+=log/*
set wildignore+=*/node_modules/*
set wildignore+=*/public/uploads/**
set wildignore+=*/public/templates/**
set wildignore+=*/tmp/**


" File-specific settings
" ----------------------

" Thorfile, Rakefile and Gemfile are Ruby
autocmd BufRead,BufNewFile
  \ {Rakefile,Thorfile,Guardfile,Vagrantfile,Envfile,config.ru,*.jbuilder}
  \ set ft=ruby

" Treat JSON files as JavaScript
autocmd BufRead,BufNewFile *.json set ft=javascript

" gitconfig uses hard tabs
autocmd FileType gitconfig setl noexpandtab shiftwidth=8

autocmd Filetype gitcommit setlocal spell textwidth=72
autocmd Filetype markdown setlocal spell
autocmd FileType fish compiler fish

if has("autocmd")
  autocmd BufWritePre
  \ *.rb,*.ex,*.exs,*.js,*.sass,*.haml
  \ :call <SID>StripTrailingWhitespace()
endif


" Functions
" ---------

function! <SID>StripTrailingWhitespace()
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
map <leader>W :call <SID>StripTrailingWhitespace()<CR>

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


" Projectionist.vim
" -----------------

let g:projectionist_heuristics = {
      \  "mix.exs": {
      \     "lib/*.ex": {"alternate": "test/{}_test.exs"},
      \     "test/*_test.exs": {"alternate": "lib/{}.ex"}
      \   },
      \   "Gemfile": {
      \     "lib/*.rb": {"alternate": "test/{}_test.rb"},
      \     "test/*_test.rb": {"alternate": "lib/{}.rb"}
      \   },
      \   "config/boot.rb": {
      \     "app/models/*.rb": {"type": "model"},
      \     "app/controllers/*.rb": {"type": "controller"},
      \     "app/views/*": {"type": "view"},
      \     "app/*.rb": {"alternate": "spec/{}_spec.rb"},
      \     "lib/*.rb": {"alternate": "spec/lib/{}_spec.rb"},
      \     "spec/lib/*_spec.rb": {"alternate": "lib/{}.rb"},
      \     "spec/*_spec.rb": {"alternate": "app/{}.rb"},
      \   },
      \ }
