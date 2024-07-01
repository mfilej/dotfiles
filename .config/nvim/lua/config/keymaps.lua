-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- nnoremap <leader><leader> <c-^>
local Util = require("lazyvim.util")
local filenav = require("mf.filenav")
local lazyterm = function(count)
  local args = { cwd = Util.root(), border = "rounded", esc_esc = true }
  if count ~= nil then
    args.count = count
  end
  Util.terminal(nil, args)
end
local wk = require("which-key")

-- lazyterm bindings
vim.keymap.set("t", "<c-\\>", "<cmd>close<cr>")
wk.register({
  ["<c-\\>"] = { lazyterm, "Terminal (root dir)" },
  -- stylua: ignore start
  ["<c-1>"] = { function () lazyterm(1) end, "Toggle lazyterm #1", mode = { "n", "t"}},
  ["<c-2>"] = { function () lazyterm(2) end, "Toggle lazyterm #1", mode = { "n", "t"}},
  ["<c-3>"] = { function () lazyterm(3) end, "Toggle lazyterm #1", mode = { "n", "t"}},
  -- stylua: ignore end
})

wk.register({
  ["<leader><space>"] = { "<c-^>", "Edit alternate file" },
  ["<leader>gw"] = { "Gwrite", ":Gwrite (fugitive)" },
  ["<C-s>"] = nil,
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
