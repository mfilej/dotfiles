local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

  -- Buffer local mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- local opts = { buffer = ev.buf }
  -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  -- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  -- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  -- vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
  -- vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
  -- vim.keymap.set("n", "<space>wl", function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, opts)
  -- vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
  -- vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
  -- vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
  -- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  -- vim.keymap.set("n", "<space>f", function()
  --   vim.lsp.buf.format { async = true }
  -- end, opts)
end

local lspconfig = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

lspconfig.elixirls.setup{
  cmd = { "/opt/homebrew/bin/elixir-ls" };
  capabilities = capabilities,
  on_attach = on_attach,
}

lspconfig.solargraph.setup{}

lspconfig.html.setup {
  capabilities = capabilities,
}
lspconfig.jsonls.setup {
  capabilities = capabilities,
}

lspconfig.cssls.setup {
  capabilities = capabilities,
}
lspconfig.tailwindcss.setup{
  capabilities = capabilities,
  on_attach = on_attach,
}
lspconfig.yamlls.setup{}
lspconfig.luau_lsp.setup{}

