return {
  'linrongbin16/gitlinker.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  cmd = { 'GitLink' },
  config = function()
    require('gitlinker').setup({})
  end,
}
