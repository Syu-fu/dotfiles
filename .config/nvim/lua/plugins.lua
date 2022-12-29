vim.cmd([[packadd packer.nvim]])

return require('packer').startup(function(use)
  -- ------------------------------------------------------------
  -- Installer

  -- Plugin Manager
  use({ 'wbthomason/packer.nvim', opt = true })

  use({ 'nvim-lua/plenary.nvim' })
  -- ColorScheme
  use({ 'sainnhe/gruvbox-material' })

  -- Font
  use({ 'kyazdani42/nvim-web-devicons', after = { 'gruvbox-material' } })

  -- LSP
  use({
    'williamboman/mason.nvim',
    event = 'BufReadPre',
    config = function()
      require('pluginconfig/mason')
    end,
  })
  use({
    'williamboman/mason-lspconfig.nvim',
    after = { 'mason.nvim', 'nvim-lspconfig' },
    config = function()
      require('pluginconfig/mason-lspconfig')
    end,
  })
  use({
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre' },
    config = function()
      require('pluginconfig/nvim-lspconfig')
    end,
  })
  use({
    'jose-elias-alvarez/null-ls.nvim',
    after = 'mason.nvim',
    config = function()
      require('pluginconfig/null-ls')
    end,
  })

  -- LSP(UI)
  use({
    'glepnir/lspsaga.nvim',
    after = 'mason.nvim',
    config = function()
      require('pluginconfig/lspsaga')
    end,
  })
  use({
    'j-hui/fidget.nvim',
    after = 'mason.nvim',
    config = function()
      require('pluginconfig/fidget')
    end,
  })

  -- Auto Completion
  use({
    'hrsh7th/nvim-cmp',
    requires = {
      { 'L3MON4D3/LuaSnip', opt = true, event = 'VimEnter' },
      { 'windwp/nvim-autopairs', opt = true, event = 'VimEnter' },
    },
    after = { 'LuaSnip', 'nvim-autopairs' },
    config = function()
      require('pluginconfig/nvim-cmp')
    end,
  })
  use({
    'onsails/lspkind-nvim',
    module = 'lspkind',
    config = function()
      require('pluginconfig/lspkind-nvim')
    end,
  })
  use({ 'hrsh7th/cmp-nvim-lsp', module = 'cmp_nvim_lsp' })
  use({ 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp' })
  use({ 'hrsh7th/cmp-nvim-lsp-document-symbol', after = 'nvim-cmp' })
  use({ 'hrsh7th/cmp-emoji', after = 'nvim-cmp' })
  use({ 'hrsh7th/cmp-buffer', after = 'nvim-cmp' })
  use({ 'hrsh7th/cmp-path', after = 'nvim-cmp' })
  use({ 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' })

  use({ 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' })
  use({ 'dmitmel/cmp-cmdline-history', after = 'nvim-cmp' })

  -- FZF
  use({
    'nvim-telescope/telescope.nvim',
    after = { 'gruvbox-material' },
    config = function()
      require('pluginconfig/telescope')
    end,
  })
  use({
    'nvim-telescope/telescope-github.nvim',
    after = { 'telescope.nvim' },
    config = function()
      require('telescope').load_extension('gh')
    end,
  })
  use({
    'nvim-telescope/telescope-live-grep-args.nvim',
    after = { 'telescope.nvim' },
    config = function()
      require('telescope').load_extension('live_grep_args')
    end,
  })

  -- Treesitter
  use({
    'nvim-treesitter/nvim-treesitter',
    after = { 'gruvbox-material' },
    run = ':TSUpdate',
    config = function()
      require('pluginconfig/nvim-treesitter')
    end,
  })

  -- Statusline
  use({
    'nvim-lualine/lualine.nvim',
    after = { 'gruvbox-material' },
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('pluginconfig/lualine')
    end,
  })
  use({
    'akinsho/bufferline.nvim',
    after = { 'gruvbox-material' },
    config = function()
      require('pluginconfig/bufferline')
    end,
  })

  -- Git
  use({
    'lewis6991/gitsigns.nvim',
    event = 'VimEnter',
    config = function()
      require('pluginconfig/gitsigns')
    end,
  })

  -- TextEdit
  use({
    'windwp/nvim-autopairs',
    event = 'VimEnter',
    config = function()
      require('pluginconfig/nvim-autopairs')
    end,
  })
  use({
    'windwp/nvim-ts-autotag',
    requires = { { 'nvim-treesitter/nvim-treesitter', opt = true } },
    after = { 'nvim-treesitter' },
    config = function()
      require('pluginconfig/nvim-ts-autotag')
    end,
  })

  -- Terminal
  use({
    'akinsho/toggleterm.nvim',
    event = 'VimEnter',
    config = function()
      require('pluginconfig/toggleterm')
    end,
  })

  use({
    'folke/neodev.nvim',
    module = 'neodev',
  })
end)
