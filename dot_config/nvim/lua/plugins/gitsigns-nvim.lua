return {
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPre',
    config = function()
      require('gitsigns').setup({
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '-' },
          topdelete = { text = '-' },
          changedelete = { text = '~' },
          untracked = { text = '?' },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
      })
    end,
  },
}
