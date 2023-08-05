return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "elixir",
        "fish",
        "heex",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "ruby",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-context" },
    },
  },
}
