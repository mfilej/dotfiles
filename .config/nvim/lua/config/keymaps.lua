-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Admvaps here

local filenav = require("mf.filenav")
local wk = require("which-key")
local function open_github_or_default()
  local cfile = vim.fn.expand("<cfile>")
  -- Check if the string matches the GitHub repository format
  if cfile:match("^[%w%-%.]+/[%w%-%.]+$") then
    local url = "https://github.com/" .. cfile
    vim.ui.open(url)
  else
    -- Fallback to default gx behavior
    vim.ui.open(cfile)
  end
end

wk.add({
  { "%%", "<C-R>=expand('%:h').'/'<cr>", desc = "Current directory", mode = "c" },
  { "<leader><space>", "<c-^>", desc = "Edit alternate file" },
  { "<leader>gw", "Gwrite", desc = ":Gwrite (fugitive)" },
  { "<C-s>", nil },
  { "<S-h>", "<cmd>tabp<cr>", desc = "Previous tab" },
  { "<S-l>", "<cmd>tabn<cr>", desc = "Next tab" },
  { "[f", filenav.prev_file, desc = "Previous file in directory" },
  { "]f", filenav.next_file, desc = "Next file in directory" },
  { "gx", open_github_or_default, desc = "Open current filepath or URL" },
})
