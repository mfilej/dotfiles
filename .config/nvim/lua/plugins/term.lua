return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = "TermExec",
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
