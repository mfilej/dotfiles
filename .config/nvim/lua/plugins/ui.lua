return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function(_, opts)
      local center = opts.config.center
      center[1].key = "<leader>p"
      center[3].key = "<leader>fr"
      center[4].key = "<leader>sg"
      center[5].key = "<leader>fc"
    end,
  },
  { "rcarriga/nvim-notify", enabled = false },
  {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        format = {
          help = { conceal = false },
        },
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        mode = "tabs",
      },
    },
  },
  {
    "SmiteshP/nvim-navic",
    enabled = false,
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local c = opts.sections.lualine_c
      local x = opts.sections.lualine_x

      -- disable navic by removing last element of sections.lualine_c
      table.remove(c, #c)

      -- move git status near the branch name
      local lazy_status = table.remove(x, 5)
      table.insert(c, 1, lazy_status)

      -- disable the clock
      opts.sections.lualine_z = { "searchcount" }

      -- no pointy p
      opts.options.section_separators = ""
      opts.options.component_separators = ""

      return opts
    end,
  },
  { "yorickpeterse/nvim-pqf" },
}
