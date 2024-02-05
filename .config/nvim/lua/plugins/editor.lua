return {
  -- Where we're going, we don't need trees
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        search = { enabled = false },
        char = { multi_line = false },
      },
    },
    keys = {
      {
        "<C-/>",
        mode = { "n" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      { "s", mode = { "n", "x", "o" }, false },
    },
  },
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      keymaps = {
        ["<C-s>"] = "actions.select_split",
        ["<C-v>"] = "actions.select_vsplit",
      },
      float = {
        win_options = {
          winblend = 0,
        },
      },
    },
    keys = {
      {
        "-",
        function()
          require("oil").open_float()
        end,
        desc = "Cover parent directory in Oil",
      },
    },
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      {
        "<leader>gD",
        "<cmd>DiffviewOpen<cr>",
        desc = "Diffview",
      },
    },
  },
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    opts = {
      default_mappings = {
        next = "]n",
        prev = "[n",
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
