return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        elixirls = {},
        solargraph = {},
        html = {},
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      PATH = "skip",
    },
  },
}
