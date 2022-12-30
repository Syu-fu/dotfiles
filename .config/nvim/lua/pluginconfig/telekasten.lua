local home = vim.fn.expand('~/Documents/Projects/github.com/Syu-fu/memo')
local templ_dir = home .. '/templates'
require('telekasten').setup({
  home = home,
  templates = templ_dir,
  extension = '.md',

  template_new_note = templ_dir .. '/new_note.md',
  template_new_daily = templ_dir .. '/daily.md',
  template_new_weekly = templ_dir .. '/weekly.md',

  follow_creates_nonexisting = false,
  dailies_create_nonexisting = false,
  weeklies_create_nonexisting = false,

  image_link_style = 'markdown',
})
