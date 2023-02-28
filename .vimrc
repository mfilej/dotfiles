" VIMRC
" =====

set nocompatible
set exrc   " load project-specific .vimrc
set secure "   (but disallow shell execution)


" Colors & Theme
" --------------

packadd! dracula_pro

syntax off " Let treesitter handle highlighting

try
  let g:dracula_colorterm = 0
  colorscheme dracula_pro
catch
endtry

highlight ColorColumn   ctermbg=234 guibg=#1c1c1c
highlight CursorLine  guibg=#333333 guifg=NONE gui=NONE
                    \ ctermbg=235 ctermfg=NONE cterm=NONE

highlight TabLineFill ctermfg=0 guifg=#000
highlight TabLine ctermfg=246 ctermbg=0 cterm=NONE guifg=#1e1e28 guibg=#000000 gui=NONE
highlight TabLineSel ctermfg=236 ctermbg=4 cterm=bold guibg=#1e1e28 guifg=#454158
" highlight VertSplit ctermfg=0 ctermbg=232 guifg=#000000 guibg=#080808
highlight NormalFloat ctermbg=0 guibg=#000000
highlight PmenuSbar ctermbg=0  guibg=#000000
highlight Pmenu ctermbg=4

" More diagnostics at
" https://www.reddit.com/r/neovim/comments/tibfjr/comment/i1d7q1b/?context=3

set fillchars=fold:┈,diff:┈,eob:⁻


" Bindings
" --------

let mapleader = " "

nmap <leader>gb :Git blame<cr>| " mnemonic: git
nmap <leader>gh :GBrowse<cr>| " mnemonic: GitHub
nmap <leader>gk :Git commit -v<cr>
nmap <leader>gw :Gwrite<cr>
nmap <leader>gg :Gstatus :<cr>
nmap <leader>gG :Gtabedit :<cr>
nmap <leader>gf :!gitfox<cr>
nmap <leader>gl <cmd>0Gclog<cr>
nmap <leader>gco :G checkout 
nmap <leader>dm :wa \| :Make<CR>
nmap <leader>dd :wa \| :Dispatch<CR>
nmap <leader>of :silent !open %%<CR>
nmap <leader>R :nmap <lt>cr> :w<Bslash><Bar>!
nmap <leader>N :set paste!<CR>
nmap <leader>y ysiw
nmap <leader>Y ysaW
nmap <leader>w :set nowrap!<CR> " toggle line wrapping
nmap <leader>ee <cmd>Ttoggle<CR>
nnoremap <leader>ef <cmd>w<CR><cmd>Dispatch! mix surface.format % <CR><cmd>e!<CR>

nmap <Tab> :tabn<CR>
nmap <S-Tab> :tabp<CR>
" <Tab> and <C-i> are the same and can not be bound independently at the
" moment: https://github.com/neovim/neovim/issues/5916
" Work around the issue by mapping <C-i> to <a-i> outside of vim (e.g.
" BetterTouchTool) and then make vim listen to <a-i> instead.
nnoremap <a-i> <C-i>

" test.vim mappings
map <Leader>tf :wa \| :TestFile<CR>
map <Leader>tfn :wa \| :TestSuite --next-failure<CR>
map <Leader>tfo :wa \| :TestSuite --only-failures<CR>
map <Leader>tn :wa \| :TestNearest<CR>
map <Leader>ts :wa \|  :TestSuite<CR>
map <Leader>tt :wa \| :TestLast<CR>
map <Leader>tv :TestVisit<CR>

" Always center after jumping to next/prev search result.
" For * and g*, stay on current result.
nnoremap * *N
nnoremap # #n
nnoremap g* g*N
nnoremap g# g#n

nnoremap <leader><leader> <c-^>
nnoremap <leader>. :A<cr>| " alternate

" switching windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
inoremap <c-j> <esc><c-w>j
inoremap <c-k> <esc><c-w>k
inoremap <c-h> <esc><c-w>h
inoremap <c-l> <esc><c-w>l

" no arrow keys in normal mode
noremap <up> <nop>| 
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

nmap <leader>/ :nohl<CR>

vmap <leader>c "*y<CR>

cnoremap %% <C-R>=expand('%:h').'/'<cr>| " expands to pwd in command mode
cnoremap %$ <C-R>=expand('%')<cr>| " expands to % in command mode

map <F1> <nop>| " disable F1 key
imap <F1> <nop>

" Options
" -------

set shell=/bin/zsh

" https://git.io/fNUg6
set re=1

" Automatically reload files that are changed outside vim
set autoread
au FocusGained,BufEnter * checktime

" set synmaxcol=2048 " long lines slow down highlighting
set linespace=1
set textwidth=78
set winwidth=84
set scrolloff=2 " off stands for offset, obviously

set nowrap

set formatoptions-=t

" Insert only one space when joining lines that contain sentence-terminating
" punctuation like `.`.
set nojoinspaces

" Use the same symbols as TextMate for tabstops and EOLs
" Also adds trailing markers
" set listchars=tab:▸\ ,eol:¬,trail:⋅
set list
set listchars=tab:▸\ ,trail:⋅

set number " show line numbers
set signcolumn=yes " always show sign column (gutter)
set cursorline " highlight current line
set isk+=- " treat dash-separated words as keywords (CSS classes)
set colorcolumn=+1 " mark the right border
set expandtab " use soft tabs (C-V<Tab> to insert tab character)
set showcmd
set showmode
set hidden
set wildmode=list:longest " autocomplete commands like a shell
set visualbell " no beeping
set ignorecase " case-insensitive search
set smartcase  "   (unless expression contains a capital letter)
set hlsearch  " highlight search matches
set complete+=k
set completeopt=menu,menuone,noselect " nvim-cmp
set dictionary+=/usr/share/dict/words
set re=1 " https://git.io/v6YxR
set nobackup
set nowritebackup
set noswapfile
set updatetime=100 " https://github.com/airblade/vim-gitgutter

" Allow gf on VCR cassettes
set suffixesadd+=.json

" if exists('*fugitive#statusline')
"   set statusline=[%n]\ %<%.99f\ %{fugitive#statusline()}\ %=%-16(\ %l,%c-%v\ %)%P
" end

set grepprg=rg\ --vimgrep
set grepformat=%f:%l:%c:%m

" Tree-sitter based folding.
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable " Unfold everything when opening a buffer

let test#strategy = "kitty"

command! -bar -nargs=+ -complete=tag Tgrep :tabnew | :grep <args> | :cw

"
" Ignores
" -------

set wildignore+=.bundle/**
set wildignore+=.gem/**
set wildignore+=build/**
set wildignore+=node_modules/*
set wildignore+=tmp/**


" File-specific settings
" ----------------------

if has("autocmd")
  " Taken from vim-elixir
  autocmd BufRead,BufNewFile *.ex,*.exs,mix.lock set filetype=elixir
  autocmd BufRead,BufNewFile *.eex,*.leex,*.lexs set filetype=eelixir
  autocmd BufRead,BufNewFile *.sface set filetype=surface

  " Thorfile, Rakefile and Gemfile are Ruby
  autocmd BufRead,BufNewFile
    \ {Rakefile,Thorfile,Guardfile,Vagrantfile,Envfile,config.ru,*.jbuilder}
    \ set ft=ruby

  " Direnv
  " autocmd BufRead,BufNewFile
  "   \ {.envrc,.direnvrc,direnvrc}
  "   \ set ft=sh
  autocmd BufRead,BufNewFile .envrc,.direnvrc,direnvrc set filetype=bash

  autocmd Filetype gitcommit setlocal spell textwidth=72
  autocmd Filetype markdown setlocal spell
  " autocmd FileType fish compiler fish
  autocmd FileType elixir setlocal textwidth=98 commentstring=#\ %s
  autocmd FileType fish setlocal commentstring=#\ %s

  " Don't keep fugitive buffers open
  " http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/
  autocmd BufReadPost fugitive://* set bufhidden=delete

  autocmd BufRead,BufNewFile schema.json setlocal noeol nofixeol

  autocmd BufWritePre
  \ *.rb,*.ex,*.exs,*.js,*.sass,*.haml,*.yml
  \ :call <SID>StripTrailingWhitespace()
endif


" Functions
" ---------

function LoadLocalConfig()
  let b:localrc_files = get(b:, 'localrc_files', [])
  let b:localrc_loaded = get(b:, 'localrc_loaded', 0)
  let l:lvimrcs = $DIRENV_EXTRA_VIMRC
  if empty(l:lvimrcs) | return | endif
  for l:file in split(l:lvimrcs, ':')
    if index(b:localrc_files, l:file) == -1
      source `=l:file`
      let b:localrc_loaded += 1
      let b:localrc_files += [l:file]
    endif
  endfor
endfunction
autocmd FileType * if exists('$DIRENV_EXTRA_VIMRC') | call LoadLocalConfig() | endif

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

function! ToCamelCase()
  :s#\(\%(\<\l\+\)\%(_\)\@=\)\|_\(\l\)#\u\1\2#g
endfunction
:command! ToCamelCase :call ToCamelCase()


" Projectionist.vim
" -----------------

let g:projectionist_heuristics = {
      \  "*config.fish": {
      \     "functions/*.fish": {"type": "function"},
      \   },
      \  "mix.exs": {
      \     "mix.exs": {
      \       "type": "deps",
      \       "alternate": "mix.lock",
      \       "make": "mix deps.get",
      \     },
      \     "mix.lock": {"alternate": "mix.exs"},
      \     "lib/*.ex": {
      \       "type": "lib",
      \       "alternate": "test/{}_test.exs",
      \     },
      \     "test/*_test.exs": {
      \       "alternate": "lib/{}.ex",
      \       "template": ["defmodule {camelcase|capitalize|dot}Test do", "  use ExUnit.Case, async: true", "end"]
      \     }
      \   },
      \  "mix.exs&web/": {
      \     "web/controllers/*_controller.ex": {
      \       "type": "controller",
      \       "alternate": "test/controllers/{}_controller_test.exs"
      \     },
      \     "web/models/*.ex": {
      \       "type": "model",
      \       "alternate": "test/models/{}_test.exs"
      \     },
      \     "web/templates/*.eex": {
      \       "type": "template",
      \     },
      \     "web/views/*_view.ex": {
      \       "type": "view",
      \       "alternate": "test/views/{}_view_test.exs"
      \     },
      \     "priv/repo/migrations/*.exs": {"type": "migration"},
      \     "test/*_test.exs": {"alternate": "web/{}.ex"},
      \     "web/router.ex": {"type": "routes"},
      \   },
      \   "Gemfile": {
      \     "Gemfile": {
      \       "type": "deps",
      \       "alternate": "Gemfile.lock",
      \     },
      \     "Gemfile.lock": {"alternate": "Gemfile"},
      \     "lib/*.rb": {"alternate": "test/{}_test.rb"},
      \     "test/*_test.rb": {"alternate": "lib/{}.rb"}
      \   },
      \   "spec/": {
      \     "lib/*.rb": {"alternate": "spec/{}_spec.rb"},
      \     "spec/*_spec.rb": {"alternate": "lib/{}.rb"},
      \   },
      \   "config/boot.rb": {
      \     "app/*.rb": {"alternate": "spec/{}_spec.rb"},
      \     "app/controllers/*.rb": {"type": "controller"},
      \     "app/models/*.rb": {"type": "model"},
      \     "lib/*.rb": {"alternate": "spec/lib/{}_spec.rb"},
      \     "spec/lib/*_spec.rb": {"alternate": "lib/{}.rb"},
      \     "spec/*_spec.rb": {"alternate": "app/{}.rb"},
      \     "db/migrate/*.rb": {"type": "migration"},
      \     "config/routes.rb": {"type": "routes"},
      \   },
      \   "ember-cli-build.js": {
      \     "app/routes/*.js": {"type": "route", "alternate": "tests/unit/routes/{}-.js"},
      \     "app/templates/*.hbs": {"type": "template"},
      \   },
      \ }
