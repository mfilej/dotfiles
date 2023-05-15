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
  use 'tpope/vim-eunuch'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-projectionist'
  -- use 'tpope/vim-ragtag'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-rsi'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-vinegar'
  use 'tpope/vim-repeat'
  use { 'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'} }
  use 'tpope/vim-sleuth'

  -- mini.vim
  use 'echasnovski/mini.splitjoin'
  use 'echasnovski/mini.comment'

  -- Git status
  use 'airblade/vim-gitgutter'

  -- Terminal ergonomics
  use({
    'akinsho/toggleterm.nvim',
    tag = '*',
    config = function()
      require("toggleterm").setup{
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<c-\>]],
        shell = "/opt/homebrew/bin/fish",
        direction = 'vertical',
      }
      function _G.set_terminal_keymaps()
        local opts = {buffer = 0}
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      end
    end
  })

  -- Adds support for opening on a buffer on a given line with the file:line syntax
  use 'bogado/file-line'

  -- The essential testing plugin
  -- use 'janko-m/vim-test'
  use 'antoinemadec/FixCursorHold.nvim' -- probably not needed after v0.9
  use {
    'nvim-neotest/neotest',
    requires = {
      'jfpedroza/neotest-elixir',
      'olimorris/neotest-rspec',
    },
    config = function()
      require('neotest').setup({
        adapters = {
          require("neotest-elixir"),
          require('neotest-rspec'),
        }
      })
    end
  }

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

  -- cmp
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'amarakon/nvim-cmp-buffer-lines'
  use { 'hrsh7th/cmp-cmdline', commit = 'e1ba818534a357b77494597469c85030c7233c16' }
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'hrsh7th/cmp-omni'
  
  -- one day I will use snippets
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  -- supercharge neovim
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-context'
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use 'neovim/nvim-lspconfig'
  use({
    "kylechui/nvim-surround",
    tag = "*",
    config = function()
      require("nvim-surround").setup({})
    end
  })

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use {
    "zbirenbaum/copilot.lua",
    config = function()
      require("copilot").setup({
        -- suggestion = { enabled = false },
        -- panel = { enabled = false },
        filetypes = {
          gitcommit = true,
        },
        copilot_node_command = '/opt/homebrew/opt/node@16/bin/node'
      })
    end,
  }
  use {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function ()
      require("copilot_cmp").setup()
    end
  }
  use {
    "RRethy/nvim-treesitter-endwise",
    config = function() 
      require('nvim-treesitter.configs').setup {
        endwise = {
          enable = true,
        },
      }
    end
  }
  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }
  use {
    "windwp/nvim-ts-autotag",
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  }

  -- Local plugins can be included
  -- use '~/projects/personal/hover.nvim'

  -- Post-install/update hook with call of vimscript function with argument
  -- use { 'glacambre/firenvim', run = function() vim.fn'firenvim#install'(0) end }

  -- You can alias plugin names
  -- use {'dracula/vim', as = 'dracula'}

  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = buffer,
    callback = function()
      vim.lsp.buf.format { async = false }
    end
  })

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
    },
    pickers = {
      find_files = {
        theme = "ivy",
        previewer = false,
      },
    }
  }

  require('mini.splitjoin').setup()
  require('mini.comment').setup()

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

end)
