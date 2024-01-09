return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        ["<leader>t"] = { name = "+test" },
      },
    },
  },
  {
    "nvim-neotest/neotest",
    enabled = false,
  },
  {
    "vim-test/vim-test",
    event = "VeryLazy",
    cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
    keys = {
      {
        "<leader>tt",
        ":w<cr><cmd>TestLast -strategy=toggleterm<cr>",
        desc = "Last",
      },
      {
        "<leader>tn",
        ":w<cr><cmd>TestNearest -strategy=toggleterm<cr>",
        desc = "Nearest",
      },
      {
        "<leader>tf",
        ":w<cr><cmd>TestFile -strategy=toggleterm<cr>",
        desc = "File",
      },
      {
        "<leader>ts",
        ":w<cr><cmd>TestSuite -strategy=toggleterm<cr>",
        desc = "Suite",
      },
      {
        "<leader>tv",
        ":w<cr><cmd>TestVisit<cr>",
        desc = "Visit last test file",
      },
    },
  },
}
