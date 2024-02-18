return {
  {
    'windwp/nvim-ts-autotag',
    event = { 'InsertEnter', 'CmdlineEnter', 'ModeChanged' },
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
}
