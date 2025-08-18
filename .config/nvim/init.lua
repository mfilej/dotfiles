vim.g.mapleader = " "
vim.g.sonokai_style = "maia"

vim.o.autowrite = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.undofile = true

vim.o.cmdheight = 0
vim.o.colorcolumn = "+1"
vim.o.signcolumn = "yes"
vim.o.winborder = "rounded"

vim.o.title = true
vim.o.titlestring = [[%{fnamemodify(getcwd(), ':t')} • %{expand('%:t')}]]

vim.o.number = true
vim.o.relativenumber = true

vim.o.tabstop = 2
vim.o.shiftwidth = 2

vim.o.scrolloff = 1

local map = vim.keymap.set

map('n', '<Esc><Esc>', vim.cmd.nohl, { noremap = true, silent = true})
map("n", "<leader><space>", "<c-^>")
map({ 'n', 'v' }, '<leader>y', '"+y')
map("n", "<leader>li", vim.cmd.LspInfo)
map("n", "<leader>oo", ":update<CR> :source ~/.config/nvim/init.lua<CR>")
map("n", "<leader>oi", ":tabe ~/.config/nvim/init.lua<CR> | tabmove $<CR>")
map("n", "<leader>p", ":Pick files<CR>")
map("n", "<leader>qs", function() require("persistence").load() end)
map("n", "L", vim.cmd.tabnext)
map("n", "H", vim.cmd.tabprevious)
map("n", "]t", ":tabmove +1<CR>")
map("n", "[t", ":tabmove -1<CR>")
map("c", "%%", "<C-R>=expand('%:h').'/'<cr>")

local aunum = vim.api.nvim_create_augroup("NumberToggle", { clear = true })
vim.api.nvim_create_autocmd("InsertEnter", { group = aunum, command = "set nornu" })
vim.api.nvim_create_autocmd("InsertLeave", { group = aunum, command = "set rnu" })

if not vim.pack then
  return
end

vim.pack.add({
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/folke/persistence.nvim" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/murasakiwano/dracula-pro.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/tpope/vim-repeat" },
	{ src = "https://github.com/tpope/vim-surround" },
	{ src = "https://github.com/tpope/vim-vinegar.git" },
	{ src = "https://github.com/xiyaowong/transparent.nvim" },
	{ src ="https://github.com/tpope/vim-eunuch" },
})

require("mason").setup({})

require("mini.pick").setup({
	mappings = {
		toggle_preview = "<C-;>",
	}
})

require("persistence").setup({ branch = false })
require("transparent").setup({})

---@diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup({
	auto_install = true,
	highlight = { enable = true },
	indent = { enable = true },
})

vim.lsp.enable({ "elixirls", "tailwindcss" })

vim.cmd.colorscheme("dracula")
vim.api.nvim_set_hl(0, "TabLineSel", { fg = "#f1fa8c", bold = true })
