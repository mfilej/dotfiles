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

local bufopts = { noremap=true, silent=true, buffer=bufnr }

nmap('<leader>vi', '<cmd>vsplit ~/.config/nvim/init.lua<CR>')
nmap('<leader>vb', '<cmd>vsplit ~/.config/nvim/lua/bindings.lua<CR>')
nmap('<leader>vp', '<cmd>vsplit ~/.config/nvim/lua/plugins.lua<CR>')
nmap('<leader>vv', '<cmd>vsplit ~/.vimrc<CR>')

local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>p', function() telescope.find_files({ hidden = true }) end)
vim.keymap.set('n', '<leader>kp', function() telescope.find_files({ hidden = true, cwd = vim.fn.expand("%:p:h") }) end)
vim.keymap.set('n', '<leader>kk', telescope.live_grep)
vim.keymap.set('n', '<leader>K', telescope.grep_string)
vim.keymap.set('n', '<leader>kb', telescope.buffers)
vim.keymap.set('n', '<leader>k/', telescope.search_history)
vim.keymap.set('n', '<leader>k:', telescope.command_history)
vim.keymap.set('n', '<leader>ks', telescope.lsp_document_symbols)
vim.keymap.set('n', '<leader>kd', telescope.diagnostics)
vim.keymap.set('n', '<leader>kgb', telescope.git_branches)
vim.keymap.set('n', '<leader>kgs', telescope.git_status)
vim.keymap.set('n', '<leader>kgc', telescope.git_commits)

nmap(']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
nmap('[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
nmap('g?', '<cmd>lua vim.diagnostic.open_float(0, { scope = "line", border = "single" })<CR>')

local neotest = require('neotest')
vim.keymap.set('n', 'tt', function() neotest.run.run(vim.fn.expand("%")) end)
vim.keymap.set('n', 'tn', function() neotest.run.run() end)
vim.keymap.set('n', 'to', function() neotest.output_panel.toggle() end)
vim.keymap.set('n', 'tp', function() neotest.summary.toggle() end)
vim.keymap.set('n', '[e', function() neotest.jump.prev({ status = "failed" }) end)
vim.keymap.set('n', ']e', function() neotest.jump.next({ status = "failed" }) end)
vim.keymap.set('n', ']e', function() neotest.jump.next({ status = "failed" }) end)

vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
