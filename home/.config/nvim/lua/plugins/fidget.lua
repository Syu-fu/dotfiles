return {
  {
    'j-hui/fidget.nvim',
    event = 'VeryLazy',
    branch = 'legacy',
    config = function()
      require('fidget').setup({
        sources = {
          ['null-ls'] = {
            ignore = true,
          },
        },
      })
    end,
  },
}
