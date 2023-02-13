-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

-- Run :PackerCompile when plugins.lua is updated
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Dependencies
  use 'nvim-lua/plenary.nvim'

  -- Add some sensibility
  use 'tpope/vim-sensible'

  -- A generous pinch of tpope
  use 'tpope/vim-commentary'
  use 'tpope/vim-endwise'
  use 'tpope/vim-eunuch'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-projectionist'
  use 'tpope/vim-ragtag'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-rsi'
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-vinegar'
  use { 'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'} }
  use 'tpope/vim-sleuth'

  -- Git status
  use 'airblade/vim-gitgutter'

  -- Adds support for opening on a buffer on a given line with the file:line syntax
  use 'bogado/file-line'

  -- The essential testing plugin
  use 'janko-m/vim-test'

  -- swap objects with cx
  use 'tommcdo/vim-exchange'

  -- telescope
  use 'natecraddock/telescope-zf-native.nvim'
  use 'nvim-telescope/telescope.nvim'

  -- diagnostics
  use {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {}
    end
  }
  use 'folke/lsp-colors.nvim'

  -- kitty
  use { 'knubie/vim-kitty-navigator', run = 'cp ./*.py ~/.config/kitty/' }

  -- supercharge neovim
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-context'
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use 'github/copilot.vim'

  -- Local plugins can be included
  -- use '~/projects/personal/hover.nvim'

  -- Post-install/update hook with call of vimscript function with argument
  -- use { 'glacambre/firenvim', run = function() vim.fn'firenvim#install'(0) end }

  -- You can alias plugin names
  -- use {'dracula/vim', as = 'dracula'}

  vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

  -- Statusline
  -- vim.o.laststatus = 3 -- single statusline across entire display
  -- require('lualine').setup {
  --   options = {
  --     globalstatus = true,
  --     theme = 'dracula'
  --   },
  --   sections = {
  --     lualine_x = {'encoding', 'filetype'},
  --   }
  -- }

  require('telescope').load_extension('zf-native')

  local actions = require("telescope.actions")
  require("telescope").setup{
    defaults = {
      mappings = {
        i = {
          ["<C-u>"] = false
        },
      },
    }
  }

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  require'lspconfig'.elixirls.setup{
    cmd = { "/opt/elixir-ls/release/elixir-ls" };
    capabilities = capabilities,
  }

  require'lspconfig'.ruby_ls.setup{
    capabilities = capabilities,
  }

  require'lspconfig'.html.setup {
    capabilities = capabilities,
  }

  require'lspconfig'.cssls.setup {
    capabilities = capabilities,
  }
  require'lspconfig'.yamlls.setup{}
  require'lspconfig'.luau_lsp.setup{}

  local cmp = require'cmp'

  cmp.setup({
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
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    }, {
      { name = 'buffer' },
    })
  })

  require'nvim-treesitter.configs'.setup {
    highlight = {
      enable = true,
      custom_captures = {
        -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
        ["foo.bar"] = "Identifier",
      },
      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
    indent = {
      enable = true
    },
    context_commentstring = {
      enable = true
    },
    textobjects = {
      select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["ad"] = "@block.outer",
          ["id"] = "@block.inner",
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner",
        },
      },
    },
  }
  require'treesitter-context'.setup{
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
}

end)
