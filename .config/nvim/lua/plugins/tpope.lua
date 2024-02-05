return {
  { "tpope/vim-eunuch" },
  { "tpope/vim-rsi" },
  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git" },
    keys = {
      { "<leader>gs", "<cmd>tab Git<cr>", desc = "Fugitive" },
    },
  },
  { "tpope/vim-sleuth" },
}
