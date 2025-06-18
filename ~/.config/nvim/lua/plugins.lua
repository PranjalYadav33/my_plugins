-- ~/.config/nvim/lua/plugins.lua

local fn = vim.fn
local use = require('packer').use

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Utility plugin
  use 'nvim-lua/plenary.nvim'

  -- Fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.x', -- Or latest stable
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Syntax highlighting and more
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate' -- Installs and updates parsers
  }

  -- Colorscheme
  use 'folke/tokyonight.nvim'

  -- LSP, Linters, Formatters
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'neovim/nvim-lspconfig'

  -- Autocompletion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'hrsh7th/cmp-buffer'   -- Buffer source for nvim-cmp
  use 'hrsh7th/cmp-path'     -- Path source for nvim-cmp
  use 'hrsh7th/cmp-cmdline'  -- Command line source for nvim-cmp

  -- Snippets
  use 'L3MON4D3/LuaSnip'                -- Snippet engine
  use 'saadparwaiz1/cmp_luasnip'        -- Snippet source for nvim-cmp

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if fn.filereadable(fn.stdpath('config') .. '/lua/plugins.lua') then
    require('packer').sync()
  end
end)
