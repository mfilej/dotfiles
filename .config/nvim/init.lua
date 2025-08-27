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

vim.o.list = true
vim.o.listchars = "tab:→ ,trail:·,nbsp:␣"

vim.o.tabstop = 2
vim.o.shiftwidth = 2

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.grepprg = "rg --vimgrep --smart-case"
vim.o.grepformat = "%f:%l:%c:%m"

-- treat dash-delimited strings (e.g. css classes) as single words
vim.opt.iskeyword = vim.opt.iskeyword + "-"

vim.o.scrolloff = 1

local map = vim.keymap.set

map("n", "<Esc><Esc>", vim.cmd.nohl, { noremap = true, silent = true })
map("n", "<leader><space>", "<c-^>")
map("n", "`", ":set relativenumber!<CR>")
map({ 'n', 'v' }, '<leader>yy', '"+y')
map("n", "<leader>yf", function()
	local relpath = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")
	vim.fn.setreg("+", relpath)
	print("Copied: " .. relpath)
end, { silent = true })
map("v", "<leader>yf", function()
	local relpath = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")
	local start_line = vim.fn.line("v")
	local end_line = vim.fn.line(".")

	if start_line > end_line then
		start_line, end_line = end_line, start_line
	end

	local out
	if start_line == end_line then
		out = string.format("%s:%d", relpath, start_line)
	else
		out = string.format("%s:%d-%d", relpath, start_line, end_line)
	end

	vim.fn.setreg("+", out)
	print("Copied: " .. out)
end, { silent = true })
map("n", "<leader>li", vim.cmd.LspInfo)
map("n", "<leader>lf", vim.lsp.buf.format)
map("n", "<leader>oo", ":update<CR> :source ~/.config/nvim/init.lua<CR>")
map("n", "<leader>oi", ":tabe ~/.config/nvim/init.lua<CR> | tabmove $<CR>")
map("n", "<leader>p", ":Pick files<CR>")
map("n", "<leader>qs", function() require("persistence").load() end)
map("n", "L", vim.cmd.tabnext)
map("n", "H", vim.cmd.tabprevious)
map("n", "[f", function() require("dirnav").prev_file() end)
map("n", "]f", function() require("dirnav").next_file() end)
map("n", "[t", ":tabmove -1<CR>")
map("n", "]t", ":tabmove +1<CR>")
map("c", "<C-a>", "<C-b>", { noremap = true })
map("c", "%%", "<C-R>=expand('%:h').'/'<cr>")

vim.cmd [[
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END
]]

if not vim.pack then
	return
end

vim.pack.add({
	"https://github.com/echasnovski/mini.pick",
	"https://github.com/folke/persistence.nvim",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/murasakiwano/dracula-pro.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/tpope/vim-eunuch",
	"https://github.com/tpope/vim-repeat",
	"https://github.com/tpope/vim-surround",
	"https://github.com/tpope/vim-vinegar.git",
	"https://github.com/xiyaowong/transparent.nvim",
	"https://github.com/martintrojer/jj-fugitive"
})

require("mason").setup({})

require("mini.pick").setup({
	mappings = {
		toggle_preview = "<C-;>",
	}
})

require("persistence").setup({ branch = false })
require("transparent").setup({})

require("nvim-treesitter.configs").setup({
	auto_install = true,
	highlight = { enable = true },
	indent = { enable = true },
})

local elixirls_path = vim.fn.stdpath("data") .. "/mason/bin/elixir-ls"
vim.lsp.config('elixirls', { cmd = { elixirls_path } })

vim.lsp.enable({ "lua_ls", "elixirls", "tailwindcss", "biome" })

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('my.lsp', {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client:supports_method('textDocument/implementation') then
			-- Create a keymap for vim.lsp.buf.implementation ...
		end
		-- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
		if client:supports_method('textDocument/completion') then
			-- Optional: trigger autocompletion on EVERY keypress. May be slow!
			-- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
			-- client.server_capabilities.completionProvider.triggerCharacters = chars
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = false })
		end
		-- Auto-format ("lint") on save.
		-- Usually not needed if server supports "textDocument/willSaveWaitUntil".
		if not client:supports_method('textDocument/willSaveWaitUntil')
				and client:supports_method('textDocument/formatting') then
			vim.api.nvim_create_autocmd('BufWritePre', {
				group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
				buffer = args.buf,
				callback = function()
					vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
				end,
			})
		end
	end,
})

vim.cmd.colorscheme("dracula")
vim.api.nvim_set_hl(0, "TabLineSel", { fg = "#f1fa8c", bold = true })
