function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

HOME = os.getenv('HOME')

require('plugins')

vim.cmd('source ' .. HOME .. '/.vimrc')

require('config.autopairs')
require('config.cmp')
require('config.lsp')
require('config.treesitter')

require('bindings')

vim.g.rsi_no_meta = 1

vim.diagnostic.config({
  signs = true,
  virtual_text = true,
}, vim.api.nvim_create_namespace("neotest"))

-- Neovim Terminal-mode settings
-- commented out, superseded by toggleterm
-- vim.cmd [[
--         tnoremap <Esc> <C-\><C-n>
--         tnoremap <C-v><Esc> <Esc>
--         tnoremap <S-Tab> <C-\><C-n> :tabp<CR>
--
--         augroup TerminalModeSetup
--           au!
--           autocmd TermOpen * setlocal nonumber norelativenumber
--           autocmd TermOpen * set bufhidden=unload
--         augroup END
-- ]]
