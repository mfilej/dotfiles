return {
  "voldikss/vim-floaterm",
  lazy = "true",
  keys = {
    { "<c-\\>", nil, desc = "Toggle Floaterm" },
  },
  init = function()
    vim.g.floaterm_width = 0.85
    vim.g.floaterm_height = 0.9
    vim.g.floaterm_opener = "tabe"
    vim.g.floaterm_keymap_toggle = "<c-\\>"
  end,
}
