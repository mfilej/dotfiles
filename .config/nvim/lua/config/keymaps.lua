-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- nnoremap <leader><leader> <c-^>
local wk = require("which-key")

wk.register({
  ["<leader><space>"] = { "<c-^>", "Edit alternate file" },
  ["<S-h>"] = { "<cmd>tabp<cr>", "Previous tab" },
  ["<S-l>"] = { "<cmd>tabn<cr>", "Next tab" },
  ["%%"] = { "<C-R>=expand('%:h').'/'<cr>", "Current directory", mode = "c" },
})
