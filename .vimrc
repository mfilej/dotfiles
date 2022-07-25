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

  " Dependencies
  call minpac#add('nvim-lua/plenary.nvim')

  " Add some sensibility
  call minpac#add('tpope/vim-sensible')

  " A generous pinch of tpope
  call minpac#add('tpope/vim-commentary')
  call minpac#add('tpope/vim-endwise')
  call minpac#add('tpope/vim-eunuch')
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('tpope/vim-projectionist')
  call minpac#add('tpope/vim-ragtag')
  " call minpac#add('tpope/vim-rails')
  call minpac#add('tpope/vim-rhubarb')
  call minpac#add('tpope/vim-rsi')
  call minpac#add('tpope/vim-surround')
  call minpac#add('tpope/vim-unimpaired')
  call minpac#add('tpope/vim-vinegar')
  call minpac#add('tpope/vim-dispatch')
  call minpac#add('tpope/vim-sleuth')

  " Languages
  call minpac#add('chr4/nginx.vim')
  " call minpac#add('dag/vim-fish')
  " call minpac#add('pangloss/vim-javascript')

  " The essential testing plugin
  call minpac#add('janko-m/vim-test')
  call minpac#add('kassio/neoterm')

  " Adds support for opening on a buffer on a given line with the file:line syntax
  call minpac#add('bogado/file-line')

  call minpac#add('sinetoami/fzy.nvim')
  call minpac#add('tommcdo/vim-exchange')
  call minpac#add('AndrewRadev/splitjoin.vim')
  call minpac#add('JoosepAlviste/nvim-ts-context-commentstring')

  " Experimental
  call minpac#add('nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'})
  call minpac#add('nvim-treesitter/nvim-treesitter-context')
  call minpac#add('nvim-treesitter/nvim-treesitter-textobjects')

  call minpac#add('neovim/nvim-lspconfig')
  call minpac#add('hrsh7th/nvim-cmp' )
  call minpac#add('hrsh7th/cmp-nvim-lsp' )
  call minpac#add('L3MON4D3/LuaSnip')
  call minpac#add('saadparwaiz1/cmp_luasnip')
endfunction

" Utility commands

command! PackUpdate call PackInit() | call minpac#update()
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus packadd minpac | call minpac#status()


" Colors & Theme
" --------------

packadd! dracula_pro

syntax off " Let treesitter handle highlighting

try
  let g:dracula_colorterm = 0
  colorscheme dracula_pro
catch
endtry

highlight ColorColumn   ctermbg=234
highlight CursorLine  guibg=#333333 guifg=NONE gui=NONE
                    \ ctermbg=235 ctermfg=NONE cterm=NONE

highlight TabLineFill ctermfg=235
highlight TabLine ctermfg=246 ctermbg=235 cterm=NONE


" Settings
" --------

let g:neoterm_shell = "/opt/homebrew/bin/fish"
let g:neoterm_default_mod = "botright"
let g:neoterm_automap_keys = '<leader>ed'
let g:neoterm_autoscroll = 1
let g:neoterm_clear_cmd = ["clear", ""]
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
nmap <leader>gg :Gstatus :<cr>
nmap <leader>gG :Gtabedit :<cr>
nmap <leader>gl <cmd>0Gclog<cr>
nmap <leader>gco :G checkout 
nmap <leader>dm :wa \| :Make<CR>
nmap <leader>dd :wa \| :Dispatch<CR>
nmap <leader>of :silent !open %%<CR>
nmap <leader>v :vs ~/.vimrc<CR>
nmap <leader>V :source $MYVIMRC<CR>
nmap <leader>R :nmap <lt>cr> :w<Bslash><Bar>!
nmap <leader>N :set paste!<CR>
nmap <leader>K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
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
map <Leader>tt :wa \| :Topen \| :Tclear \| :TestLast<CR>
map <Leader>tn :wa \| :Topen \| :Tclear \| :TestNearest<CR>
map <Leader>tf :wa \| :Topen \| :Tclear \| :TestFile<CR>
map <Leader>tv :TestVisit<CR>
map <Leader>ts :wa \| :Topen \| :Tclear \| :TestSuite<CR>
map <Leader>tfo :wa \| :Topen \| :Tclear \| :TestSuite --only-failures<CR>
map <Leader>tfn :wa \| :Topen \| :Tclear \| :TestSuite --next-failure<CR>

" Always center after jumping to next/prev search result.
" For * and g*, stay on current result.
nnoremap * *N
nnoremap # #n
nnoremap g* g*N
nnoremap g# g#n

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
au FocusGained,BufEnter * checktime

set synmaxcol=2048 " long lines slow down highlighting
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

" Allow gf on VCR cassettes
set suffixesadd+=.json

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
  autocmd BufRead,BufNewFile *.ex,*.exs,mix.lock set filetype=elixir
  autocmd BufRead,BufNewFile *.eex,*.heex,*.leex,*.lexs set filetype=eelixir
  autocmd BufRead,BufNewFile *.sface set filetype=surface

  " Thorfile, Rakefile and Gemfile are Ruby
  autocmd BufRead,BufNewFile
    \ {Rakefile,Thorfile,Guardfile,Vagrantfile,Envfile,config.ru,*.jbuilder}
    \ set ft=ruby

  " Direnv
  " autocmd BufRead,BufNewFile
  "   \ {.envrc,.direnvrc,direnvrc}
  "   \ set ft=sh

  autocmd Filetype gitcommit setlocal spell textwidth=72
  autocmd Filetype markdown setlocal spell
  " autocmd FileType fish compiler fish
  autocmd FileType elixir setlocal textwidth=98 commentstring=#\ %s

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

" Plugin config
" -------------

let g:rsi_no_meta = 1

nnoremap <silent> g? <cmd>lua vim.diagnostic.open_float(0, { scope = "line", border = "single" })<CR>

lua <<EOF
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]]

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

require'lspconfig'.elixirls.setup{
    cmd = { "/opt/elixir-ls/release/elixir-ls" };
    capabilities = capabilities,
}

require'lspconfig'.html.setup {
  capabilities = capabilities,
}

require'lspconfig'.cssls.setup {
  capabilities = capabilities,
}

local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})

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
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true
  },
  context_commentstring = {
    enable = true
  },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["ad"] = "@block.outer",
        ["id"] = "@block.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
  },
}
require'treesitter-context'.setup{
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
        -- For all filetypes
        -- Note that setting an entry here replaces all other patterns for this entry.
        -- By setting the 'default' entry below, you can control which nodes you want to
        -- appear in the context window.
        default = {
            'class',
            'function',
            'method',
            -- 'for', -- These won't appear in the context
            -- 'while',
            -- 'if',
            -- 'switch',
            -- 'case',
        },
        -- Example for a specific filetype.
        -- If a pattern is missing, *open a PR* so everyone can benefit.
        --   rust = {
        --       'impl_item',
        --   },
    },
    exact_patterns = {
        -- Example for a specific filetype with Lua patterns
        -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
        -- exactly match "impl_item" only)
        -- rust = true,
    },

    -- [!] The options below are exposed but shouldn't require your attention,
    --     you can safely ignore them.

    zindex = 20, -- The Z-index of the context window
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
