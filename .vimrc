" VIMRC
" =====

augroup AutoloadVimrc
  au!
  autocmd BufWritePost ~/.vimrc source $MYVIMRC
aug END

set nocompatible
set exrc   " load project-specific .vimrc
set secure "   (but disallow shell execution)

" Plugins
" --------------

function! PackInit() abort
  packadd minpac

  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " Add some sensibility
  call minpac#add('tpope/vim-sensible')

  " A generous pinch of tpope
  call minpac#add('tpope/vim-commentary')
  call minpac#add('tpope/vim-endwise')
  call minpac#add('tpope/vim-eunuch')
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('tpope/vim-projectionist')
  call minpac#add('tpope/vim-ragtag')
  call minpac#add('tpope/vim-rails')
  call minpac#add('tpope/vim-rhubarb')
  call minpac#add('tpope/vim-rsi')
  call minpac#add('tpope/vim-surround')
  call minpac#add('tpope/vim-unimpaired')
  call minpac#add('tpope/vim-vinegar')
  call minpac#add('tpope/vim-dispatch')

  " Languages
  call minpac#add('chr4/nginx.vim')
  call minpac#add('dag/vim-fish')
  call minpac#add('pangloss/vim-javascript')

  " The essential testing plugin
  call minpac#add('janko-m/vim-test')
  call minpac#add('kassio/neoterm')

  " Adds support for opening on a buffer on a given line with the file:line syntax
  call minpac#add('bogado/file-line')

  call minpac#add('sinetoami/fzy.nvim')
  call minpac#add('tommcdo/vim-exchange')
  call minpac#add('AndrewRadev/splitjoin.vim')
  call minpac#add('mhinz/vim-mix-format')

  " Experimental
  call minpac#add('nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'})
endfunction

" Utility commands

command! PackUpdate call PackInit() | call minpac#update()
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus packadd minpac | call minpac#status()


" Colors & Theme
" --------------

packadd! dracula_pro

syntax enable
let g:dracula_colorterm = 0
colorscheme dracula_pro

highlight ColorColumn   ctermbg=234
highlight CursorLine  guibg=#333333 guifg=NONE gui=NONE
                    \ ctermbg=235 ctermfg=NONE cterm=NONE

highlight TabLineFill ctermfg=235
highlight TabLine ctermfg=246 ctermbg=235 cterm=NONE


" Settings
" --------

let g:mix_format_on_save = 1
let g:neoterm_shell = "/usr/local/bin/fish"
let g:test#strategy = "neoterm"


" Bindings
" --------

let mapleader = " "

nnoremap <leader>p <cmd>Fzy<CR>
nnoremap <leader>P <cmd>Fzy %:h<CR>

nmap <leader>gb :Git blame<cr>| " mnemonic: git
nmap <leader>gh :GBrowse<cr>| " mnemonic: GitHub
nmap <leader>gk :Git commit -v<cr>
nmap <leader>gw :Gwrite<cr>
nmap <leader>dm :wa \| :Make<CR>
nmap <leader>dd :wa \| :Dispatch<CR>
nmap <leader>of :silent !open %%<CR>
nmap <leader>v :vs ~/.vimrc<CR>
nmap <leader>V :vs ~/.vim/packages.vim<CR>
nmap <leader>R :nmap <lt>cr> :w<Bslash><Bar>!
nmap <leader>N :set paste!<CR>
nmap <leader>K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
nmap <leader>y ysiw
nmap <leader>Y ysaW
nmap <leader>w :set nowrap!<CR>| " toggle line wrapping

nmap <Tab> :tabn<CR>
nmap <S-Tab> :tabp<CR>
" <Tab> and <C-i> are the same and can not be bound independently at the
" moment: https://github.com/neovim/neovim/issues/5916
" Work around the issue by mapping <C-i> to <a-i> outside of vim (e.g.
" BetterTouchTool) and then make vim listen to <a-i> instead.
nnoremap <a-i> <C-i>

" test.vim mappings
map <Leader>tt :wa \| :Tclear \| :TestFile<CR>
map <Leader>tn :wa \| :Tclear \| :TestNearest<CR>
map <Leader>tl :wa \| :Tclear \| :TestLast<CR>
map <Leader>ts :wa \| :Tclear \| :TestSuite<CR>
map <Leader>tfo :wa \| :Tclear \| :TestSuite --only-failures<CR>
map <Leader>tfn :wa \| :Tclear \| :TestSuite --next-failure<CR>

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

nmap <leader>/ :nohl<CR>

vmap <leader>c "*y<CR>

cnoremap %% <C-R>=expand('%:h').'/'<cr>| " expands to pwd in command mode
cnoremap %$ <C-R>=expand('%')<cr>| " expands to % in command mode

map <F1> <nop>| " disable F1 key
imap <F1> <nop>

xmap <leader>a <Plug>(EasyAlign)
nmap <leader>a <Plug>(EasyAlign)


" Options
" -------

set shell=/bin/zsh

" https://git.io/fNUg6
set re=1

" Automatically reload files that are changed outside vim
set autoread

set synmaxcol=2048 " long lines slow down highlighting
set linespace=1
set textwidth=78
set winwidth=84

" Do not wrap lines automatically.
set formatoptions-=t

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

if exists('*fugitive#statusline')
  set statusline=[%n]\ %<%.99f\ %{fugitive#statusline()}\ %=%-16(\ %l,%c-%v\ %)%P
end

set grepprg=rg\ --vimgrep
set grepformat=%f:%l:%c:%m

" Tree-sitter based folding.
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable " Unfold everything when opening a buffer

if has('nvim')
  set inccommand=nosplit " Live preview for :s[ubstitute]
end

command! -bar -nargs=+ -complete=tag Tgrep :tabnew | :grep <args> | :cw

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
  " Taken from vim-elixir
  au BufRead,BufNewFile *.ex,*.exs set filetype=elixir
  au BufRead,BufNewFile *.eex,*.heex,*.leex,*.sface,*.lexs set filetype=eelixir
  au BufRead,BufNewFile mix.lock set filetype=elixir

  " Thorfile, Rakefile and Gemfile are Ruby
  autocmd BufRead,BufNewFile
    \ {Rakefile,Thorfile,Guardfile,Vagrantfile,Envfile,config.ru,*.jbuilder}
    \ set ft=ruby

  " Direnv
  autocmd BufRead,BufNewFile
    \ {.envrc,.direnvrc,direnvrc}
    \ set ft=sh

  " gitconfig uses hard tabs
  autocmd FileType gitconfig setlocal noexpandtab shiftwidth=8

  autocmd Filetype gitcommit setlocal spell textwidth=72
  autocmd Filetype markdown setlocal spell
  autocmd FileType fish compiler fish
  autocmd FileType elixir setlocal textwidth=98

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

" Plugin config
" -------------

let g:rsi_no_meta = 1

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF
lua <<EOF
require'nvim-treesitter.configs'.setup {
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
EOF
lua <<EOF
require'nvim-treesitter.configs'.setup {
  indent = {
    enable = true
  }
}
EOF


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
