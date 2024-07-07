return {
  {
    'luukvbaal/statuscol.nvim',
    event = 'BufReadPre',
    config = function()
      local builtin = require('statuscol.builtin')
      require('statuscol').setup({
        bt_ignore = { 'terminal', 'nofile', 'ddu-ff', 'ddu-ff-filter' },

        relculright = true,
        segments = {
          {
            sign = {
              namespace = { 'diagnostic/signs' },
              maxwidth = 1,
            },
          },
          {
            sign = {
              namespace = { 'gitsigns' },
              maxwidth = 1,
              colwidth = 1,
              wrap = true,
            },
          },
          {
            text = { builtin.lnumfunc },
          },
          { text = { '│' } },
        },
      })
    end,
  },
}
