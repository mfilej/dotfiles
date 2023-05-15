local cmp = require'cmp'

cmp.setup({
  performance = {
    debounce = 150,
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<TAB>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'omni' }
  }, {
      { name = 'copilot' },
    })
})


-- cmp.setup.cmdline({ "/", "?" }, {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = {
--     {
--       name = "buffer",
--       option = { keyword_pattern = [[\k\+]] }
--     }
--   }
-- })

-- https://github.com/amarakon/nvim-cmp-buffer-lines
-- Enable `buffer` and `buffer-lines` for `/` and `?` in the command-line
cmp.setup.cmdline({ "/", "?" }, {
  mapping = require "cmp".mapping.preset.cmdline(),
  sources = {
    {
      name = "buffer",
      option = { keyword_pattern = [[\k\+]] }
    },
    { name = "buffer-lines" }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
      { name = 'buffer' },
      {
        name = 'cmdline',
        option = {
          ignore_cmds = { 'Man', '!' }
        }
      }
    })
})
