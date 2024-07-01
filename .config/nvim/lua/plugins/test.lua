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
    keys = {
      {
        "<leader>tt",
        function()
          vim.cmd.wall()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Run File",
      },
    },
  },
  {
    "vim-test/vim-test",
    enabled = false,
    event = "VeryLazy",
    cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
    init = function()
      -- Like the built-in toggleterm strategy, except it always runs in terminal window #1
      local lazyterm = function(cmd)
        local Util = require("lazyvim.util")
        Util.terminal(cmd, { count = 1, cwd = Util.root() })
      end

      vim.g["test#custom_strategies"] = { mytoggleterm = lazyterm }
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
