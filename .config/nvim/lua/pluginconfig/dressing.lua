require('dressing').setup({
  input = {
    -- Set to `false` to disable
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
