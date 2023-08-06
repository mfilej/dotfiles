-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- nnoremap <leader><leader> <c-^>
local wk = require("which-key")
local filenav = require("mf.filenav")

wk.register({
  ["<leader><space>"] = { "<c-^>", "Edit alternate file" },
  ["<S-h>"] = { "<cmd>tabp<cr>", "Previous tab" },
  ["<S-l>"] = { "<cmd>tabn<cr>", "Next tab" },
  ["%%"] = { "<C-R>=expand('%:h').'/'<cr>", "Current directory", mode = "c" },
  ["[f"] = {
    function()
      filenav.prev_file()
    end,
    "Previous file in directory",
  },
  ["]f"] = {
    function()
      filenav.next_file()
    end,
    "Next file in directory",
  },
})
