-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.autowrite = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

vim.opt.title = true
vim.opt.titlestring = [[%{expand("%:~:.")} · %{substitute(getcwd(),$HOME,'~','')}]]

vim.opt.colorcolumn = "+1"
vim.opt.conceallevel = 0 -- don't hide quotes in JSON files
vim.opt.exrc = true -- see :h exrc
vim.opt.iskeyword = vim.opt.iskeyword + "-" -- treat dash-delimited strings (e.g. css classes) as single words
vim.opt.clipboard = "" -- don't pollute system clipboard
-- vim.opt.clipboard = "unnamedplus"
vim.opt.list = true
vim.opt.relativenumber = false
-- vim.cmd([[ set listchars=tab:→,trail:⋅,eol:⏎,nbsp:⎵ ]])

vim.g.lazyvim_ruby_lsp = "ruby_lsp"
vim.g.lazyvim_ruby_formatter = "rubocop"

vim.filetype.add({
  filename = {
    ["PULLREQ_EDITMSG"] = "hubmessage",
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "kitty-scrollback" },
  callback = function()
    vim.opt_local.laststatus = 0
  end,
})
