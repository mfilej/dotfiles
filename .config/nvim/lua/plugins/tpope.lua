return {
  { "tpope/vim-eunuch" },
  { "tpope/vim-rsi" },
  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git", "Gread", "Gwrite" },
    keys = {
      { "<leader>gs", "<cmd>tab Git<cr>", desc = "Fugitive" },
      { "<leader>gw", "Gwrite", desc = ":Gwrite (fugitive)" },
    },
  },
  { "tpope/vim-sleuth" },
}
