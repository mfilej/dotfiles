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

require('bindings')

vim.g.rsi_no_meta = 1

-- Neovim Terminal-mode settings
vim.cmd [[
        tnoremap <Esc> <C-\><C-n>
        tnoremap <C-v><Esc> <Esc>
        tnoremap <S-Tab> <C-\><C-n> :tabp<CR>

        augroup TerminalModeSetup
          au!
          autocmd TermOpen * setlocal nonumber norelativenumber
          autocmd TermOpen * set bufhidden=unload
        augroup END
]]
