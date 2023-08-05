return {
  -- disabled in favour of vim-vinegar
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        char = {
          enabled = false,
        },
      },
    },
    keys = {
      { "s", mode = { "n", "x", "o" }, false },
    },
  },
  {
    "sindrets/diffview.nvim",
    keys = {
      {
        "<leader>gd",
        "<cmd>DiffviewOpen<cr>",
        desc = "Diffview",
      },
    },
  },
  {
    "ruifm/gitlinker.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
      {
        "<leader>gy",
        function()
          require("gitlinker").get_buf_range_url("v")
        end,
        desc = "Copy GitHub URL to system clipboard",
        mode = "x",
      },
      {
        "<leader>gy",
        function()
          require("gitlinker").get_buf_range_url("n")
        end,
        desc = "Copy GitHub URL to system clipboard",
      },
      {
        "<leader>gY",
        function()
          require("gitlinker").get_repo_url({ action_callback = require("gitlinker.actions").open_in_browser })
        end,
        desc = "Open GitHub repository in browser",
      },
    },
  },
}
