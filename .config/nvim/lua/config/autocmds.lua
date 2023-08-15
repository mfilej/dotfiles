-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local nvr_augroup = vim.api.nvim_create_augroup("bufhidden_nvr", { clear = true })

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = nvr_augroup,
  pattern = "gitcommit,gitrebase,gitconfig,hubmessage",
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_option(buf, "bufhidden", "delete")
  end,
})
