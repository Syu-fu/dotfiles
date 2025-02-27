return {
  {
    'stevearc/oil.nvim',
    cmd = 'Oil',
    config = function()
      require('oil').setup({
        view_options = {
          -- Show files and directories that start with "."
          show_hidden = true,
        },
      })
    end,
  },
}
