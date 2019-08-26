" Snippets

iabbrev <buffer> pry require "pry"; binding.pry
iabbrev <buffer> des describe
iabbrev <buffer> de default:
iabbrev <buffer> nn null: false,
iabbrev <buffer> un unique: true,
iabbrev <buffer> ind index: true,
iabbrev <buffer> arr array: true,
iabbrev <buffer> ess < EssentialRecord
iabbrev <buffer> tref t.references
iabbrev <buffer> tint t.integer
iabbrev <buffer> tst t.string
iabbrev <buffer> tbo t.boolean
iabbrev <buffer> tind t.index

map <Leader>tf :wa \| :TestFile -strategy=neovim --next-failure<CR><c-\><c-n><c-w>T
map <Leader>ts :wa \|   TestSuite -strategy=neovim --next-failure<CR><c-\><c-n><c-w>T
