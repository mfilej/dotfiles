function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

function vmap(shortcut, command)
  map('v', shortcut, command)
end

function cmap(shortcut, command)
  map('c', shortcut, command)
end

function tmap(shortcut, command)
  map('t', shortcut, command)
end

nmap('<leader>vi', '<cmd>vsplit ~/.config/nvim/init.lua<CR>')
nmap('<leader>vb', '<cmd>vsplit ~/.config/nvim/lua/bindings.lua<CR>')
nmap('<leader>vp', '<cmd>vsplit ~/.config/nvim/lua/plugins.lua<CR>')
nmap('<leader>vv', '<cmd>vsplit ~/.vimrc<CR>')

nmap('<leader>p', '<cmd>Telescope find_files<CR>')
nmap('<leader>kp', '<cmd>lua require("telescope.builtin").find_files({ cwd = vim.fn.expand("%:p:h") })<CR>')
nmap('<leader>kk', '<cmd>Telescope live_grep<CR>')
nmap('<leader>K', '<cmd>Telescope grep_string<CR>')
nmap('<leader>kb', '<cmd>Telescope buffers<CR>')
nmap('<leader>k/', '<cmd>Telescope search_history<CR>')
nmap('<leader>k:', '<cmd>Telescope command_history<CR>')
nmap('<leader>ks', '<cmd>Telescope lsp_document_symbols<CR>')
nmap('<leader>kd', '<cmd>Telescope diagnostics<CR>')
nmap('<leader>kgb', '<cmd>Telescope git_branches<CR>')
nmap('<leader>kgs', '<cmd>Telescope git_status<CR>')
nmap('<leader>kgc', '<cmd>Telescope git_commits<CR>')

nmap(']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
nmap('[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
nmap('g?', '<cmd>lua vim.diagnostic.open_float(0, { scope = "line", border = "single" })<CR>')

local bufopts = { noremap=true, silent=true, buffer=bufnr }
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
