return {
  -- Where we're going, we don't need trees
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        search = { enabled = false },
        char = { multi_line = false, jump_labels = true, label = { exclude = "hjkliardcs" }, autohide = true },
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
    "echasnovski/mini.files",
    opts = {
      options = {
        -- Use instead of neo-tree
        use_as_default_explorer = true,
      },
      mappings = {
        -- close       = 'q',
        go_in = "L",
        go_in_plus = "<CR>",
        go_out = "J",
        go_out_plus = "-",
        -- reset = "<BS>",
        -- reveal_cwd = "@",
        -- show_help = "g?",
        -- synchronize = "=",
        -- trim_left = "<",
        -- trim_right = ">",
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
    "stevearc/oil.nvim",
    enabled = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      default_file_explorer = true,
      keymaps = {
        ["<C-s>"] = "actions.select_split",
        ["<C-v>"] = "actions.select_vsplit",
      },
      float = {
        win_options = {
          winblend = 0,
        },
      },
      view_options = {
        show_hidden = true,
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
    opts = {
      mappings = nil,
      add_current_line_on_normal_mode = false, -- use visual mode to include the line
    },
    keys = {
      -- mnemonic: yank
      {
        "<leader>gy",
        function()
          require("gitlinker").get_buf_range_url("v")
        end,
        desc = "Copy file:line(s) URL to clipboard",
        mode = "x",
      },
      {
        "<leader>gy",
        function()
          require("gitlinker").get_buf_range_url("n")
        end,
        desc = "Copy file:line(s) URL to clipboard",
      },
      -- mnemonic: browse
      {
        "<leader>gb",
        function()
          require("gitlinker").get_buf_range_url(
            "v",
            { action_callback = require("gitlinker.actions").open_in_browser }
          )
        end,
        desc = "Open file in browser",
        mode = "x",
      },
      {
        "<leader>gb",
        function()
          require("gitlinker").get_buf_range_url(
            "n",
            { action_callback = require("gitlinker.actions").open_in_browser }
          )
        end,
        desc = "Open file in browser",
      },
      {
        "<leader>gB",
        function()
          require("gitlinker").get_repo_url({ action_callback = require("gitlinker.actions").open_in_browser })
        end,
        desc = "Open repository in browser",
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
