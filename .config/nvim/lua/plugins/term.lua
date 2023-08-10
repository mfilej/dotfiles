return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      open_mapping = [[<c-\>]],
      direction = "float",
    },
    keys = {
      { "<c-\\>", nil, desc = "Toggle Terminal" },
      { "<Esc>", "<C-\\><C-n>", mode = "t" },
    },
  },
}
