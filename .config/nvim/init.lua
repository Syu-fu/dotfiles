require('plugins')
require('keymaps')

vim.opt.number = true
vim.opt.laststatus = 2
vim.opt.showtabline = 2
vim.opt.termguicolors = true
vim.opt.fileencodings = 'utf-8'
vim.opt.clipboard:append({ 'unnamedplus' })
vim.opt.signcolumn = 'yes:2'
vim.opt.syntax = 'enable'
vim.opt.background = 'dark'
vim.opt.hidden = true
vim.opt.showcmd = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.list = true
vim.opt.listchars = 'tab:▸-'
vim.opt.backup = false
vim.opt.swapfile = false
vim.cmd.colorscheme('gruvbox-material')
