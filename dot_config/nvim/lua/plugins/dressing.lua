return {
  {
    'stevearc/dressing.nvim',
    event = 'BufRead',
    config = function()
      require('dressing').setup({
        input = {
          mappings = {
            n = {
              ['<Esc>'] = 'Close',
              ['<CR>'] = 'Confirm',
            },
            i = {
              ['<C-c>'] = 'Close',
              ['<C-a>'] = '<Home>',
              ['<C-e>'] = '<End>',
              ['<C-h>'] = '<BS>',
              ['<C-d>'] = '<Del>',
              ['<C-f>'] = '<Right>',
              ['<C-b>'] = '<Left>',
              ['<CR>'] = 'Confirm',
              ['<Up>'] = 'HistoryPrev',
              ['<Down>'] = 'HistoryNext',
            },
          },
        },
      })
    end,
  },
}
