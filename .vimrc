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

set wildignore+=build/**
set wildignore+=*/tmp/**
set wildignore+=db/development/**
set wildignore+=db/test/**
set wildignore+=public/uploads/**
set wildignore+=*/vendor/ruby/*
set wildignore+=*/node_modules/*

nmap <leader>P :CtrlP %%<cr>
nmap <leader>gv :CtrlP app/views<cr>
nmap <leader>gc :CtrlP app/controllers<cr>
nmap <leader>gm :CtrlP app/models<cr>
nmap <leader>ga :CtrlP app/assets<cr>
nmap <leader>gb :CtrlPBuffer<cr>
nmap <leader>gr :topleft :split config/routes.rb<cr>
nmap <leader>gg :topleft 100 :split Gemfile<cr>

vmap <C-c> :w !pbcopy<CR><CR>

nmap <leader>v :vs ~/.vimrc<CR>

nmap <leader>r :w\|:!reload_chromium<cr><cr>
nmap <leader>R :w\|:!touch tmp/restart.txt<cr>

nmap <leader>N :set paste!<CR>
nmap <leader>K :Ag "\b<C-R><C-W>\b"<CR>:cw<CR>

nmap <leader>[ :tabp<CR>
nmap <leader>] :tabn<CR>

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
set listchars=tab:▸\ ,eol:¬,trail:⋅

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

" if has("vms")
"   set nobackup  " do not keep a backup file, use versions instead
" else
"   set backup    " keep a backup file
" endif

" Key mappings
" Taking the training wheels off - no arrow keys in normal mode
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

" vim-hardmode
" autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
" nnoremap <leader>H <Esc>:call ToggleHardMode()<CR>

" Thorfile, Rakefile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Thorfile,Guardfile,config.ru,*.jbuilder} set ft=ruby

" gitconfig uses hard tabs
autocmd FileType gitconfig setl noexpandtab shiftwidth=8

" wrap git messages to 72 chars
autocmd Filetype gitcommit setlocal spell textwidth=72

map <leader>W :call <SID>StripTrailingWhitespaces()<CR>

if has("autocmd")
  autocmd BufWritePre *.rb,*.js,*.sass,*.haml :call <SID>StripTrailingWhitespaces()
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

" Running tests
function! RunTests(filename)
    " Write the file and run tests for the given filename
    :w
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    if match(a:filename, '\.feature$') != -1
        exec ":!bin/acceptance " . a:filename
    else
        if filereadable(".spin")
            exec ":!spin push " . a:filename
        else
            exec ":!rspec --color " . a:filename
        end
    end
endfunction

function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
    let g:bjo_test_file=@%
endfunction

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\)$') != -1
    if in_test_file
        call SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number)
endfunction

map <leader>t :call RunTestFile()<cr>
map <leader>s :call RunNearestTest()<cr>
map <leader>a :call RunTests('spec')<cr>
map <leader>c :w\|:!script/features<cr>

" Test running from @r00k
function! RunCurrentTest()
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
  if in_test_file
    call SetTestFile()

    if match(expand('%'), '\.feature$') != -1
      call SetTestRunner("!cucumber")
      exec g:bjo_test_runner g:bjo_test_file
    elseif match(expand('%'), '_spec\.rb$') != -1
      call SetTestRunner("!rspec")
      exec g:bjo_test_runner g:bjo_test_file
    else
      call SetTestRunner("!ruby -Itest")
      exec g:bjo_test_runner g:bjo_test_file
    endif
  else
    exec g:bjo_test_runner g:bjo_test_file
  endif
endfunction

function! SetTestRunner(runner)
  let g:bjo_test_runner=a:runner
endfunction

function! RunCurrentLineInTest()
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
  if in_test_file
    call SetTestFileWithLine()
  end

  exec "!rspec" g:bjo_test_file . ":" . g:bjo_test_file_line
endfunction
map <leader>; :call RunCurrentLineInTest()<cr>

function! SetTestFileWithLine()
  let g:bjo_test_file=@%
  let g:bjo_test_file_line=line(".")
endfunction

function! CorrectTestRunner()
  if match(expand('%'), '\.feature$') != -1
    return "cucumber"
  elseif match(expand('%'), '_spec\.rb$') != -1
    return "rspec"
  else
    return "ruby"
  endif
endfunction
