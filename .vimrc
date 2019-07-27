" VIMRC
" =====

aug AutoloadVimrc
  au!
  au BufWritePost ~/.vimrc source $MYVIMRC
aug END

set nocompatible
set exrc   " load project-specific .vimrc
set secure "   (but disallow shell execution)

let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
set rtp+=/usr/local/opt/fzf " load plugin that comes with fzf

execute pathogen#infect()

source ~/.vim/vimrc-local


" Colors & Theme
" --------------

syntax enable
set t_Co=256
color vividchalk

highlight Comment     ctermfg=103
highlight CursorLine  guibg=#333333 guifg=NONE gui=NONE
                    \ ctermbg=235 ctermfg=NONE cterm=NONE
highlight Search      guibg=black gui=underline cterm=underline
highlight LineNr      ctermfg=246 ctermbg=234

hi DiffAdd guifg=NONE ctermfg=NONE guibg=#464632 ctermbg=022 gui=NONE cterm=NONE
hi DiffChange guifg=NONE ctermfg=NONE guibg=#335261 ctermbg=236 gui=NONE cterm=NONE
hi DiffDelete guifg=#f43753 ctermfg=052 guibg=#79313c ctermbg=237 gui=NONE cterm=NONE
hi DiffText guifg=NONE ctermfg=NONE guibg=NONE ctermbg=NONE gui=reverse cterm=reverse

" Bindings
" --------

let mapleader = " "

nmap <leader>p :FZF<cr>
nmap <leader>P :FZF %%<cr>
nmap <leader>fd :Sdeps<cr>| " mnemonic: f=file, d=deps
nmap <leader>fr :Sroutes<cr>| " relies on projections setting `:Eroutes`
nmap <leader>fm :sp db/migrate<cr>
nmap <leader>gb :Gblame<cr>| " mnemonic: git
nmap <leader>gh :Gbrowse<cr>
nmap <leader>gk :Gcommit -v<cr>
nmap <leader>gw :Gwrite<cr>
nmap <leader>gs Gtabedit :<cr>
nmap <leader>v :vs ~/.vimrc<CR>
nmap <leader>r :w\|:!reload_chromium<cr><cr>
nmap <leader>R :nmap <lt>cr> :w<Bslash><Bar>!
nmap <leader>N :set paste!<CR>
nmap <leader>K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
nmap <Tab> :tabn<CR>
nmap <S-Tab> :tabp<CR>
nmap <leader>y ysiw
nmap <leader>Y ysaW
nmap <leader>w :set nowrap!<CR>| " toggle line wrapping

map <Leader>tt :wa \| :TestFile<CR>| " test.vim mappings
map <Leader>tn :wa \| :TestNearest<CR>

nnoremap <leader><leader> <c-^>
nnoremap <leader>. :A<cr>| " alternate
nnoremap <c-j> <c-w>j| " switching windows
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
noremap <up> <nop>| " no arrow keys in normal mode
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

vmap <leader>c "*y<CR>

cnoremap %% <C-R>=expand('%:h').'/'<cr>| " expands to pwd in command mode
cnoremap %$ <C-R>=expand('%')<cr>| " expands to % in command mode
cnoremap <c-a> <home>| " move to beginning of the line in command mode too

map <F1> <nop>| " disable F1 key
imap <F1> <nop>

xmap <leader>a <Plug>(EasyAlign)
nmap <leader>a <Plug>(EasyAlign)

" Options
" -------

" https://git.io/fNUg6
set re=1

" Automatically reload files that are changed outside vim
set autoread

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

set nowrap

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
set complete+=k
set dictionary+=/usr/share/dict/words
set re=1 " https://git.io/v6YxR
set nobackup
set nowritebackup
set noswapfile

set statusline=[%n]\ %<%.99f\ %{fugitive#statusline()}\ %=%-16(\ %l,%c-%v\ %)%P

set grepprg=rg\ --vimgrep
set grepformat=%f:%l:%c:%m

" Mouse & iTerm2 support
" ----------------------

if !has('nvim')
  " Configure vim in iterm2 (http://usevim.com/2012/05/16/mouse/)
  " Send more characters for redraws
  set ttyfast
  " Enable mouse use in all modes
  set mouse=a
  " Set this to the name of your terminal that supports mouse codes.
  " Must be one of: xterm, xterm2, netterm, dec, jsbterm, pterm
  set ttymouse=xterm2
endif

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
  " Thorfile, Rakefile and Gemfile are Ruby
  autocmd BufRead,BufNewFile
    \ {Rakefile,Thorfile,Guardfile,Vagrantfile,Envfile,config.ru,*.jbuilder}
    \ set ft=ruby

  autocmd BufRead,BufNewFile
    \ {.envrc,.direnvrc}
    \ set ft=sh

  " gitconfig uses hard tabs
  autocmd FileType gitconfig setlocal noexpandtab shiftwidth=8

  autocmd Filetype gitcommit setlocal spell textwidth=72
  autocmd Filetype markdown setlocal spell
  autocmd FileType fish compiler fish

  " Don't keep fugitive buffers open
  " http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/
  autocmd BufReadPost fugitive://* set bufhidden=delete

  autocmd BufRead,BufNewFile schema.json setlocal noeol nofixeol

  autocmd BufWritePre
  \ *.rb,*.ex,*.exs,*.js,*.sass,*.haml,*.yml
  \ :call <SID>StripTrailingWhitespace()
endif


" Commands
" --------

" Fuzzy find open buffers
command! Buffers call fzf#run({'source': map(range(1, bufnr('$')), 'bufname(v:val)'),
            \ 'sink': 'e', 'down': '30%'})
nmap <leader>b :Buffers<cr>

" Fuzzy find subdirectories (up to two levels) and open :lcd to the selected
" directory in a new tab
command! -nargs=* -complete=dir Lcd call fzf#run(fzf#wrap(
  \ {'source': 'find . -type d -maxdepth 1 -or -type d -maxdepth 2 | grep -v -E "^\./\."',
  \  'sink': 'lcd'}))
nmap <leader>l :$tabe .<bar>Lcd<cr>

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
      \     "test/*_test.exs": {"alternate": "lib/{}.ex"}
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
