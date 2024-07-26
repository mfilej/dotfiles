-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- nnoremap <leader><leader> <c-^>
local filenav = require("mf.filenav")
local wk = require("which-key")

wk.add({
  { "%%", "<C-R>=expand('%:h').'/'<cr>", desc = "Current directory", mode = "c" },
  { "<leader><space>", "<c-^>", desc = "Edit alternate file" },
  { "<leader>gw", "Gwrite", desc = ":Gwrite (fugitive)" },
  { "<C-s>", nil },
  { "<S-h>", "<cmd>tabp<cr>", desc = "Previous tab" },
  { "<S-l>", "<cmd>tabn<cr>", desc = "Next tab" },
  { "[f", filenav.prev_file, desc = "Previous file in directory" },
  { "]f", filenav.next_file, desc = "Next file in directory" },
})
