return {
  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    event = 'BufReadPre',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = 'all',
        highlight = {
          enable = true,
          disable = {
            'gitcommit',
            'help',
          },
        },
      })
    end,
  },
}
