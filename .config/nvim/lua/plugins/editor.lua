local flash = require("flash")

return {
  -- Where we're going, we don't need trees
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        win = {
          input = {
            keys = {
              ["<c-t>"] = {
                "edit_tab",
                mode = { "n", "i" },
              },
            },
          },
        },
      },
    },
    keys = {
      { "<leader>p", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
    },
  },
  {
    "folke/flash.nvim",
    keys = {
      { "<leader>/", mode = { "n" }, flash.jump, desc = "Flash" },
      { "s", mode = { "n", "x", "o" }, false },
    },
    opts = {
      modes = {
        char = {
          multi_line = false,
        },
      },
    },
  },
  {
    "echasnovski/mini.files",
    opts = {
      windows = {
        width_preview = 80,
      },
      options = {
        -- Use instead of neo-tree
        use_as_default_explorer = true,
      },
      mappings = {
        go_in = "L",
        go_in_plus = "<CR>",
        go_out = "J",
        go_out_plus = "-",
      },
    },
    keys = {
      {
        "-",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = "Open mini.files (Directory of Current File)",
      },
      {
        "<leader>fM",
        function()
          require("mini.files").open(vim.uv.cwd(), true)
        end,
        desc = "Open mini.files (cwd)",
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
    {
      "willothy/flatten.nvim",
      config = true,
      -- or pass configuration with
      -- opts = {  }
      -- Ensure that it runs first to minimize delay when opening file from terminal
      lazy = false,
      priority = 1001,
    },
  },
}
