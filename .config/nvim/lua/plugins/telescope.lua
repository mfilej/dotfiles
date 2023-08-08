local Builtin = require("telescope.builtin")
local Actions = require("telescope.actions")

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
      {
        "nvim-telescope/telescope-file-browser.nvim",
      },
    },
    -- init = function()
    --   require("telescope").load_extension("file_browser")
    -- end,
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = Actions.close,
            ["<c-h>"] = Actions.which_key,
            ["<c-t>"] = Actions.select_tab,
            ["<c-u>"] = false,
          },
        },
      },
      {
        extensions = {
          file_browser = {
            hijack_netrw = true,
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
      {
        "<leader>fb",
        function()
          require("telescope").extensions.file_browser.file_browser()
        end,
        desc = "File Browser",
      },
      {
        "-",
        function()
          require("telescope").extensions.file_browser.file_browser({ select_buffer = true, path = "%:p:h" })
        end,
        desc = "File Browser (current dir)",
      },
    },
  },
}
