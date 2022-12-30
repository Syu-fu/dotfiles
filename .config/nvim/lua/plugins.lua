local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--single-branch',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

require('lazy').setup({
  -- ------------------------------------------------------------
  -- Installer

  -- Plugin Manager
  { 'folke/lazy.nvim' },

  { 'nvim-lua/plenary.nvim' },
  -- ColorScheme
  { 'sainnhe/gruvbox-material' },

  -- Font
  { 'kyazdani42/nvim-web-devicons' },

  -- LSP
  {
    'williamboman/mason.nvim',
    event = 'BufReadPre',
    config = function()
      require('pluginconfig/mason')
    end,
  },
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre' },
    config = function()
      require('pluginconfig/nvim-lspconfig')
    end,
    dependencies = {
      {
        'williamboman/mason-lspconfig.nvim',
        config = function()
          require('pluginconfig/mason-lspconfig')
        end,
      },
      {
        'ray-x/lsp_signature.nvim',
        config = function()
          require('pluginconfig/lsp_signature')
        end,
      },
    },
    lazy = true,
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    event = 'VimEnter',
    config = function()
      require('pluginconfig/null-ls')
    end,
  },

  -- LSP(UI)
  {
    'glepnir/lspsaga.nvim',
    event = 'VimEnter',
    config = function()
      require('pluginconfig/lspsaga')
    end,
  },
  {
    'j-hui/fidget.nvim',
    event = 'VimEnter',
    config = function()
      require('pluginconfig/fidget')
    end,
  },

  -- Auto Completion
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter, CmdlineEnter' },
    config = function()
      require('pluginconfig/nvim-cmp')
    end,
    dependencies = {
      { 'L3MON4D3/LuaSnip', event = { 'InsertEnter, CmdlineEnter' } },
      { 'windwp/nvim-autopairs', lazy = true, event = { 'InsertEnter, CmdlineEnter' } },
      { 'hrsh7th/cmp-nvim-lsp', module = 'cmp_nvim_lsp' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help', event = { 'InsertEnter, CmdlineEnter' } },
      { 'hrsh7th/cmp-nvim-lsp-document-symbol', event = { 'InsertEnter, CmdlineEnter' } },
      { 'hrsh7th/cmp-emoji', after = 'nvim-cmp', event = { 'InsertEnter, CmdlineEnter' } },
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp', event = { 'InsertEnter, CmdlineEnter' } },
      { 'hrsh7th/cmp-path', after = 'nvim-cmp', event = { 'InsertEnter, CmdlineEnter' } },
      { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp', event = { 'InsertEnter, CmdlineEnter' } },
      {
        'onsails/lspkind-nvim',
        event = { 'InsertEnter', 'CmdlineEnter' },
        config = function()
          require('pluginconfig/lspkind-nvim')
        end,
      },
    },
  },

  { 'hrsh7th/cmp-cmdline', event = 'CmdlineEnter' },
  { 'dmitmel/cmp-cmdline-history', event = 'CmdlineEnter' },

  -- FZF
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    config = function()
      require('pluginconfig/telescope')
    end,
    init = function()
      require('pluginconfig/keymap/telescope')
    end,
    dependencies = {
      {
        'nvim-telescope/telescope-github.nvim',
        config = function()
          require('telescope').load_extension('gh')
        end,
        lazy = true,
      },
      {
        'nvim-telescope/telescope-live-grep-args.nvim',
        config = function()
          require('telescope').load_extension('live_grep_args')
        end,
        lazy = true,
      },
    },
  },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    event = 'BufReadPre',
    dependencies = {
      {
        'windwp/nvim-ts-autotag',
        config = function()
          require('pluginconfig/nvim-ts-autotag')
        end,
      },
    },
    config = function()
      require('pluginconfig/nvim-treesitter')
    end,
  },

  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    event = 'VimEnter',
    config = function()
      require('pluginconfig/lualine')
    end,
  },
  {
    'akinsho/bufferline.nvim',
    event = 'VimEnter',
    config = function()
      require('pluginconfig/bufferline')
    end,
  },

  -- Git
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPre',
    config = function()
      require('pluginconfig/gitsigns')
    end,
  },

  -- TextEdit
  {
    'windwp/nvim-autopairs',
    event = { 'InsertEnter', 'CmdlineEnter' },
    config = function()
      require('pluginconfig/nvim-autopairs')
    end,
  },

  -- Terminal
  {
    'akinsho/toggleterm.nvim',
    cmd = 'ToggleTerm',
    init = function()
      require('pluginconfig/keymap/toggleterm')
    end,
    config = function()
      require('pluginconfig/toggleterm')
    end,
  },
  {
    'folke/neodev.nvim',
    event = 'InsertEnter',
    module = 'neodev',
  },
})
