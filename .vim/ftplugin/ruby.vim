" Snippets

iabbrev <buffer> pry require "pry"; binding.pry
iabbrev <buffer> des describe

map <Leader>tf :wa \| :TestFile -strategy=neovim --next-failure<CR><c-\><c-n><c-w>L
map <Leader>ts :wa \| :TestSuite -strategy=neovim --next-failure<CR><c-\><c-n><c-w>L
