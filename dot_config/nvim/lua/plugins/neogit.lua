return {
  {
    'TimUntersberger/neogit',
    cmd = 'Neogit',
    init = function()
      vim.keymap.set('n', '<Space>gs', '<Cmd>Neogit<CR>', { noremap = true, silent = true })
    end,
    config = function()
      require('neogit').setup({
        integrations = {
          diffview = true,
        },
      })
    end,
    {
      'sindrets/diffview.nvim',
      cmd = 'DiffviewOpen',
    },
  },
}
