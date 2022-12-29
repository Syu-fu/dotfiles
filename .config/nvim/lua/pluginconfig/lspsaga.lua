local lspsaga = require('lspsaga')
lspsaga.init_lsp_saga({
  code_action_icon = '',
  finder_action_keys = {
    open = 'o',
    vsplit = 's',
    split = 'i',
    tabe = 't',
    quit = 'q',
    scroll_down = '<C-f>',
    scroll_up = '<C-b>', -- quit can be a table
  },
  vim.keymap.set('n', '<space>rn', '<cmd>Lspsaga rename<cr>', { silent = true, noremap = true }),
  vim.keymap.set('n', ';a', '<cmd>Lspsaga code_action<cr>', { silent = true, noremap = true }),
  vim.keymap.set('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<cr>', { silent = true, noremap = true }),
  vim.keymap.set('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<cr>', { silent = true, noremap = true }),
  vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', { silent = true, noremap = true }),
  vim.keymap.set('n', '<Space>o', '<cmd>Lspsaga outline<CR>', { silent = true, noremap = true }),
  vim.keymap.set('n', '<Space>e', '<cmd>Lspsaga show_cursor_diagnostics<CR>', { silent = true, noremap = true }),
})
