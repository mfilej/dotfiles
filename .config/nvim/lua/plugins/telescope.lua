local Builtin = require("telescope.builtin")
local Actions = require("telescope.actions")

local TelescopeAlternateMappings = {
  {
    "lib/(.*)_web/live/(.*)_live/(.*).ex",
    { { "lib/[1]_web/live/[2]_live/[3].html.heex", "Heex Template" } },
  },
  {
    "lib/(.*)_web/live/(.*)_live/(.*).html.heex",
    { { "lib/[1]_web/live/[2]_live/[3].ex", "Live View" } },
  },
  {
    "lib/(.*)/(.*).ex",
    { { "test/[1]/[2]_test.exs", "Test", true } },
  },
  {
    "test/(.*)_test.exs",
    { { "lib/[1].ex", "Implementation" } },
  },
}

local my_git_status_picker = function(opts)
  opts = opts or {}

  -- List files top to bottom
  opts.sorting_strategy = "ascending"

  -- Pre-select file loaded in current buffer
  local buf_path = vim.api.nvim_buf_get_name(0)
  opts.on_complete = {
    function(self)
      local selection_idx
      for i, entry in ipairs(self.finder.results) do
        if buf_path == entry.path then
          selection_idx = i
          break
        end
      end
      self:set_selection(self:get_row(selection_idx))
    end,
  }

  require("telescope.builtin").git_status(opts)
end

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-file-browser.nvim",
      },
      {
        "otavioschwanck/telescope-alternate",
      },
    },
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<c-h>"] = Actions.which_key,
            ["<c-t>"] = Actions.select_tab,
            ["<c-u>"] = false,
          },
        },
      },
      pickers = {
        git_status = {
          mappings = {
            n = {
              ["c"] = function()
                vim.api.nvim_cmd({ cmd = "TermExec", args = { " cmd='git commit -v'" } }, {})
              end,
            },
          },
        },
      },
      extensions = {
        file_browser = {
          hijack_netrw = true,
        },
        ["telescope-alternate"] = {
          mappings = TelescopeAlternateMappings,
          presets = { "rails", "rspec" },
        },
      },
    },
    keys = {
      { "<leader><space>", false },
      { "<leader>gs", false },
      { "<leader>sR", false },
      { "<leader>;", "<cmd>Telescope resume<cr>", desc = "Telescope Resume" },
      { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search Current Buffer" },
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
          require("telescope").extensions.file_browser.file_browser({ select_buffer = true, path = "%:p:h" })
        end,
        desc = "File Browser (current dir)",
      },
      {
        "<leader>fB",
        function()
          require("telescope").extensions.file_browser.file_browser()
        end,
        desc = "File Browser (root)",
      },
      {
        "<leader>.",
        "<cmd>Telescope telescope-alternate alternate_file<cr>",
        desc = "Alternate files",
      },
    },
  },
}
