return {
  {
    'rhysd/clever-f.vim',
    keys = { 'f', 'F', 't', 'T' },
    config = function()
        vim.g.clever_f_use_migemo = 1
        vim.api.nvim_set_keymap('n', ';', '<Plug>(clever-f-repeat-forward)', { noremap = false, silent = true })
        vim.api.nvim_set_keymap('n', ',', '<Plug>(clever-f-repeat-backward)', { noremap = false, silent = true })
    end,
  },
}

