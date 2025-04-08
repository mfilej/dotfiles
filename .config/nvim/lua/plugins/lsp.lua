return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruby_lsp = {
          enabled = false,
        },
        solargraph = {
          enabled = false,
          mason = false,
        },
        rubocop = {
          enabled = true,
          mason = false,
        },
      },
    },
  },
}
