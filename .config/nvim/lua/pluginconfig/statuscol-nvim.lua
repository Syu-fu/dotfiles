local builtin = require('statuscol.builtin')
require('statuscol').setup({
  bt_ignore = { 'terminal', 'nofile' },
  relculright = true,
  segments = {
    {
      sign = { name = { 'GitSigns' }, maxwidth = 1, colwidth = 1 },
      click = 'v:lua.ScSa',
    },
    {
      sign = { name = { 'Diagnostic' }, maxwidth = 1, colwidth = 1 },
      click = 'v:lua.ScSa',
    },
    { text = { builtin.lnumfunc }, click = 'v:lua.ScLa' },
    {
      sign = { name = { '.*' }, maxwidth = 2, colwidth = 2, wrap = true, auto = true },
      click = 'v:lua.ScSa',
    },
    { text = { '│' } },
  },
})
