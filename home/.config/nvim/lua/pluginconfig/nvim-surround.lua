require('nvim-surround').setup({
  move_cursor = false,
  keymaps = { -- vim-surround style keymaps
    normal = 'sa',
    normal_line = 'saa',
    delete = 'sd',
    change = 'sr',
  },
})
