local wk = require("which-key")

wk.register({
  t = {
    name = "Test",
  },
}, { prefix = "<leader>" })

return {
  "nvim-neotest/neotest",
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-rspec"),
        require("neotest-elixir"),
      },
    })
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "olimorris/neotest-rspec",
    "jfpedroza/neotest-elixir",
  },
  keys = {
    {
      "<leader>tt",
      function()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      desc = "File",
    },
    {
      "<leader>tn",
      function()
        require("neotest").run.run()
      end,
      desc = "Nearest",
    },
    {
      "<leader>ta",
      function()
        require("neotest").run.run(vim.fn.getcwd())
      end,
      desc = "All",
    },
    {
      "<leader>to",
      function()
        require("neotest").output.open({ enter = true })
      end,
      desc = "Open Output",
    },
    {
      "<leader>tO",
      function()
        require("neotest").output_panel.toggle()
      end,
      desc = "Open Output",
    },
    {
      "<leader>ts",
      function()
        require("neotest").summary.open()
      end,
      desc = "Summary",
    },
    {
      "<leader>tS",
      function()
        require("neotest").run.stop()
      end,
      desc = "Stop",
    },
  },
}
