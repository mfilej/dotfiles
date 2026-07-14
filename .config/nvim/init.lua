vim.g.mapleader = " "

vim.o.autowrite = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.undofile = true

vim.o.cmdheight = 1
vim.o.colorcolumn = "+1"
vim.o.list = true
vim.o.listchars = "tab:→ ,trail:·,nbsp:␣"
vim.o.signcolumn = "yes"
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.title = true
vim.o.titlestring = [[%{fnamemodify(getcwd(), ':t')} • %{expand('%:t')}]]
vim.o.winborder = "rounded"

vim.o.number = true
vim.o.relativenumber = true

vim.o.tabstop = 2
vim.o.shiftwidth = 2

vim.o.scrolloff = 1

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.grepprg = "rg --vimgrep --smart-case"
vim.o.grepformat = "%f:%l:%c:%m"

vim.g.signify_sign_add = "⏵"
vim.g.signify_sign_change = "⏵"

-- treat dash-delimited strings (e.g. css classes) as single words
vim.opt.iskeyword = vim.opt.iskeyword + "-"

local map = vim.keymap.set

map("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
map("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
map("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
map("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
map("n", "<Esc><Esc>", vim.cmd.nohl, { noremap = true, silent = true })
map("n", "<leader><space>", "<c-^>")
map("n", "`", ":set relativenumber!<CR>")
map("n", "<leader>a", "<cmd>A<CR>", { desc = "Alternate File", nowait = true })

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
local function gh_browse_args(line1, line2)
	local file = vim.fn.fnamemodify(vim.fn.expand('%:p'), ':.')

	local ref = vim.fn.system(
	"jj log -r 'latest(::@ & bookmarks())' --no-graph -T 'local_bookmarks.map(|b| b.name()).join(\"\")' 2>/dev/null")
	ref = ref:gsub('%s+', '')

	if ref == '' then
		ref = vim.fn.system("jj log -r 'trunk()' --no-graph -T 'remote_bookmarks.map(|b| b.name()).join(\"\")' 2>/dev/null")
		ref = ref:gsub('%s+', '')
	end

	local location
	if line2 and line1 ~= line2 then
		location = string.format('%s:%d-%d', file, line1, line2)
	else
		location = string.format('%s:%d', file, line1)
	end

	return '--branch ' .. vim.fn.shellescape(ref) .. ' ' .. vim.fn.shellescape(location)
end

map('n', '<leader>yh', function()
	local url = vim.fn.system('gh browse --no-browser ' .. gh_browse_args(vim.fn.line('.'), vim.fn.line('.'))):gsub('%s+',
		'')
	vim.fn.setreg('+', url)
	print('Copied: ' .. url)
end, { desc = 'Copy GitHub URL' })

map('v', '<leader>yh', function()
	local s, e = vim.fn.line('v'), vim.fn.line('.')
	if s > e then s, e = e, s end
	local url = vim.fn.system('gh browse --no-browser ' .. gh_browse_args(s, e)):gsub('%s+', '')
	vim.fn.setreg('+', url)
	print('Copied: ' .. url)
end, { desc = 'Copy GitHub URL (selection)' })

map('n', '<leader>yH', function()
	vim.fn.system('gh browse ' .. gh_browse_args(vim.fn.line('.'), vim.fn.line('.')))
end, { desc = 'Open GitHub URL' })

map('v', '<leader>yH', function()
	local s, e = vim.fn.line('v'), vim.fn.line('.')
	if s > e then s, e = e, s end
	vim.fn.system('gh browse ' .. gh_browse_args(s, e))
end, { desc = 'Open GitHub URL (selection)' })

map("n", "gd", vim.lsp.buf.definition)
map("n", "<leader>li", "<cmd>checkhealth vim.lsp<cr>", { desc = "LSP status" })
map("n", "<leader>lf", function()
	local clients = vim.lsp.get_clients({ bufnr = 0, name = "dexter" })

	if not clients[1] then
		print("No dexter client attached")
		return
	end

	vim.lsp.buf.format({
		bufnr = 0,
		id = clients[1].id,
		timeout_ms = 1000,
	})
end, { desc = "Format with dexter" })
map("n", "<leader>tt", "<cmd>write<CR><cmd>TestFile<CR>", { desc = "Test file" })
map("n", "<leader>tn", "<cmd>write<CR><cmd>TestNearest<CR>", { desc = "Test nearest" })
map("n", "<leader>tl", "<cmd>write<CR><cmd>TestLast<CR>", { desc = "Test last" })
map("n", "<leader>ts", "<cmd>write<CR><cmd>TestSuite<CR>", { desc = "Test suite" })
map("n", "<leader>to", function()
	for _, buf in ipairs(vim.fn.getbufinfo({ bufloaded = 1 })) do
		if buf.variables and buf.variables._test_vim_neovim_sticky then
			vim.cmd("botright split")
			vim.cmd("buffer " .. buf.bufnr)
			vim.cmd("normal! G")
			return
		end
	end

	print("No vim-test output")
end, { desc = "Test output" })
map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Show diagnostic message", })
map("n", "<leader>oo", ":update<CR> :source ~/.config/nvim/init.lua<CR>")
map("n", "<leader>oi", ":tabe ~/.config/nvim/init.lua<CR> | tabmove $<CR>")
map("n", "<leader>qs", function() require("persistence").load() end)
map("n", "L", vim.cmd.tabnext)
map("n", "H", vim.cmd.tabprevious)
map("n", "[f", function() require("dirnav").next_file() end)
map("n", "]f", function() require("dirnav").next_file() end)
map("n", "[h", "<plug>(signify-prev-hunk)")
map("n", "]h", "<plug>(signify-next-hunk)")
map("n", "[H", "9999[h", { remap = true })
map("n", "]H", "9999]h", { remap = true })
map("n", "[t", ":tabmove -1<CR>")
map("n", "]t", ":tabmove +1<CR>")
map("c", "<C-a>", "<C-b>", { noremap = true })
map("c", "%%", "<C-R>=expand('%:h').'/'<cr>")
map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

map("o", "ih", "<plug>(signify-motion-inner-pending)")
map("x", "ih", "<plug>(signify-motion-inner-visual)")
map("o", "ah", "<plug>(signify-motion-outer-pending)")
map("x", "ah", "<plug>(signify-motion-outer-visual)")

local function show_current_hunk()
	local h = vim.fn["sy#util#get_hunk_stats"]()
	if h and not vim.tbl_isempty(h) then
		print(string.format("[Hunk %d/%d]", h.current_hunk, h.total_hunks))
	end
end

vim.api.nvim_create_augroup("signify_hunk", { clear = true })
vim.api.nvim_create_autocmd("User", {
	group = "signify_hunk",
	pattern = "SignifyHunk",
	callback = show_current_hunk,
})

-- <leader>*: highlight word (or selection) without jumping
local function set_search(pattern)
	vim.fn.setreg('/', pattern)
	vim.opt.hlsearch = true
end

-- Normal mode: word under cursor
vim.keymap.set('n', '<leader>*', function()
	local word = vim.fn.expand('<cword>')
	local escaped = vim.fn.escape(word, [[\]])
	set_search([[\V\C\<]] .. escaped .. [[\>]])
end, { noremap = true, silent = true, desc = "Highlight word without moving" })

-- Visual mode: selected text
vim.keymap.set('x', '<leader>*', function()
	local save_reg = vim.fn.getreg('"')
	vim.cmd('normal! "vy') -- copy visual selection to "
	local text = vim.fn.escape(vim.fn.getreg('"'), [[\]])
	vim.fn.setreg('"', save_reg)
	set_search([[\V\C]] .. text)
end, { noremap = true, silent = true, desc = 'Highlight selection without moving' })

vim.cmd [[
augroup numbertoggle
  autocmd!
  autocmd BufEnter,InsertEnter,WinEnter             * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertLeave,WinLeave   * if &nu                  | set nornu | endif
augroup END
]]

if not vim.pack then
	return
end

local packs = {
	"https://github.com/folke/persistence.nvim",
	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/lukas-reineke/indent-blankline.nvim",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mhinz/vim-signify",
	"https://github.com/murasakiwano/dracula-pro.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/vim-test/vim-test",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/smpallen99/elixir-projectionist.nvim",
	"https://github.com/tpope/vim-eunuch",
	"https://github.com/tpope/vim-projectionist",
	"https://github.com/tpope/vim-repeat",
	"https://github.com/tpope/vim-surround",
	"https://github.com/tpope/vim-vinegar.git",
	"https://github.com/xiyaowong/transparent.nvim",
}

vim.api.nvim_create_user_command("PackInstall", function()
	vim.pack.add(packs)
end, { desc = "Install vim.pack packages" })

vim.api.nvim_create_user_command("PackUpdate", function()
	vim.pack.update(nil, { force = true })
end, { desc = "Update vim.pack packages" })

vim.pack.add(packs)

require("mason").setup({})

require("persistence").setup({ branch = false })

local fzf = require("fzf-lua")
fzf.setup({ "max-perf" })
map("n", "<leader>p", fzf.global)
map("n", "<leader>sg", ":FzfLua live_grep_native resume=true<CR>")
map("n", "<leader>sw", ":FzfLua grep_cword<CR>")
map("n", "<leader>sW", ":FzfLua grep_cWORD<CR>")
map("n", "<leader>lg", function()
	fzf.lsp_document_symbols({ query = vim.fn.expand("<cword>") })
end, { desc = "FZF LSP Document Symbols (word under cursor)" })
map("n", "<leader>lG", function()
	fzf.live_workspace_symbols({ lsp_query = vim.fn.expand("<cword>") })
end, { desc = "FZF LSP Workspace Symbols (word under cursor)" })


require("ibl").setup({})
require("transparent").setup({})
require("elixir-projectionist").setup()

vim.g["test#strategy"] = "neovim_sticky"
vim.g["test#neovim_sticky#reopen_window"] = 1

require("nvim-treesitter").setup({})

local function start_treesitter(buf)
	if vim.bo[buf].filetype == "" or vim.treesitter.highlighter.active[buf] then
		return
	end

	local ok = pcall(vim.treesitter.start, buf)
	if ok then
		vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end
end

vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
	callback = function(args)
		start_treesitter(args.buf)
	end,
})


vim.lsp.config("dexter", {
	cmd = { "dexter", "lsp" },
	root_markers = { ".dexter/dexter.db", ".dexter.db", ".git", "mix.exs" },
	filetypes = { "elixir", "eelixir", "heex" },
	init_options = {
		followDelegates = true,
	},
})

local dexter_format_group = vim.api.nvim_create_augroup("dexter_format_on_save", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
	group = dexter_format_group,
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		if not client or client.name ~= "dexter" then
			return
		end

		if client:supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({
				group = dexter_format_group,
				buffer = args.buf,
				event = "BufWritePre",
			})

			vim.api.nvim_create_autocmd("BufWritePre", {
				group = dexter_format_group,
				buffer = args.buf,
				callback = function()
					vim.lsp.buf.format({
						bufnr = args.buf,
						id = client.id,
						timeout_ms = 1000,
					})
				end,
			})
		end
	end,
})

vim.lsp.enable("dexter")

vim.lsp.enable({ "lua_ls", "tailwindcss" })

vim.cmd.colorscheme("dracula")
vim.api.nvim_set_hl(0, "SignifySignAdd", { fg = "#4ffa7b", bg = "NONE" })
vim.api.nvim_set_hl(0, "SignifySignChange", { fg = "#ff79c6", bg = "NONE" })
vim.api.nvim_set_hl(0, "TabLineSel", { fg = "#f1fa8c", bold = true })
-- vim.api.nvim_set_hl(0, "SnacksIndent", { fg = "#111111", bold = true })
-- vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = "#333333", bold = true })
