return {
  {
    "ahmedkhalf/project.nvim",
    enabled = false,
  },
  {
    "mikesmithgh/kitty-scrollback.nvim",
    enabled = true,
    lazy = true,
    cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
    event = { "User KittyScrollbackLaunch" },
    config = function()
      require("kitty-scrollback").setup()
    end,
  },
  {
    "knubie/vim-kitty-navigator",
    init = function()
      vim.g.kitty_navigator_no_mappings = 1
      vim.g.kitty_navigator_enable_stack_layout = 1
    end,
    keys = {
      { "<c-h>", "<cmd>KittyNavigateLeft<cr>", desc = "Go to Left Window" },
      { "<c-j>", "<cmd>KittyNavigateDown<cr>", desc = "Go to Lower Window" },
      { "<c-k>", "<cmd>KittyNavigateUp<cr>", desc = "Go to Upper Window" },
      { "<c-l>", "<cmd>KittyNavigateRight<cr>", desc = "Go to Right Window" },
    },
  },
}
