local Util = require("lazyvim.util")
local Builtin = require("telescope.builtin")
local Actions = require("telescope.actions")

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-h>"] = Actions.which_key,
            ["<C-t>"] = Actions.select_tab,
            ["<C-u>"] = false,
          },
        },
      },
    },
    keys = {
      { "<leader><space>", false },
      { "<leader>sR", false },
      { "<leader>;", "<cmd>Telescope resume<cr>", desc = "Telescope Resume" },
      {
        "<leader>fc",
        function()
          Builtin.find_files({ cwd = "~/.config/nvim" })
        end,
        desc = "Find nvim Config (mnemonic: lua)",
      },
      {
        "<leader>p",
        function()
          Builtin.find_files({ hidden = true })
        end,
        desc = "Find Files (root dir)",
      },
      {
        "<leader>P",
        function()
          Builtin.find_files({ cwd = vim.fn.expand("%:p:h") })
        end,
        desc = "Find Files (current dir)",
      },
    },
  },
}
