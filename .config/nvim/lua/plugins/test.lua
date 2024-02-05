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
    init = function()
      -- Like the built-in toggleterm strategy, except it always runs in terminal window #1
      local toggleterm = function(cmd)
        local Util = require("lazyvim.util")
        Util.terminal(cmd, { count = 1, cwd = Util.root() })
      end

      vim.g["test#custom_strategies"] = { mytoggleterm = toggleterm }
      vim.g["test#strategy"] = "mytoggleterm"
    end,
    keys = {
      {
        "<leader>tt",
        ":w<cr><cmd>TestLast<cr>",
        desc = "Last",
      },
      {
        "<leader>tn",
        ":w<cr><cmd>TestNearest<cr>",
        desc = "Nearest",
      },
      {
        "<leader>tf",
        ":w<cr><cmd>TestFile<cr>",
        desc = "File",
      },
      {
        "<leader>ts",
        ":w<cr><cmd>TestSuite<cr>",
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
