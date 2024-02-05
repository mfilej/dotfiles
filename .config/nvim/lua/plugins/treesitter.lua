return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- Keep the defaults, but also add support for the following:
      local also_install = { "elixir", "fish", "heex", "ruby" }
      for _, entry in ipairs(also_install) do
        table.insert(opts.ensure_installed, entry)
      end

      -- Free up [f and ]f keymaps
      local move = opts.textobjects.move
      move.goto_next_start = nil
      move.goto_previous_start = nil
    end,
  },
}
