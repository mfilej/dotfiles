return {
  {
    "hrsh7th/nvim-cmp",
    enable = false,
    opts = function(_, opts)
      local cmp = require("cmp")

      opts.preselect = cmp.PreselectMode.None
      opts.completion.completeopt = "menu,menuone,noinsert,noselect"
      opts.mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
      }
      return opts
    end,
  },
  {
    "gbprod/yanky.nvim",
    dependencies = not LazyVim.is_win() and { "kkharji/sqlite.lua" } or {},
    opts = {},
    keys = {
      { "<leader>p", false },
      {
        '<leader>"',
        function()
          require("telescope").extensions.yank_history.yank_history({})
        end,
        desc = "Open Yank History",
      },
      { "<c-p>", "<Plug>(YankyPreviousEntry)", desc = "Cycle through yank ring backwards" },
      { "<c-n>", "<Plug>(YankyNextEntry)", desc = "Cycle through yank ring forwards" },
    },
  },
  {
    "echasnovski/mini.surround",
    opts = {
      custom_surroundings = {
        ["("] = { output = { left = "( ", right = " )" } },
        ["["] = { output = { left = "[ ", right = " ]" } },
        ["{"] = { output = { left = "{ ", right = " }" } },
        ["<"] = { output = { left = "< ", right = " >" } },
      },
      mappings = {
        add = "ys",
        delete = "ds",
        find = "gs",
        find_left = "",
        highlight = "",
        replace = "cs",
        update_n_lines = "",
      },
      search_method = "cover_or_next",
    },
  },
  -- {
  --   "rafamadriz/friendly-snippets",
  --   config = function()
  --     local luasnip = require("luasnip")
  --     luasnip.filetype_extend("heex", { "html" })
  --     luasnip.filetype_extend("elixir", { "html" })
  --
  --     require("luasnip.loaders.from_vscode").lazy_load()
  --   end,
  -- },
  {
    "Wansmer/sibling-swap.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      use_default_keymaps = false,
    },
    keys = {
      {
        "<,",
        function()
          require("sibling-swap").swap_with_left()
        end,
        desc = "Swap with left",
      },
      {
        ">,",
        function()
          require("sibling-swap").swap_with_right()
        end,
        desc = "Swap with right",
      },
    },
  },
}
