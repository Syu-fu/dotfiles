local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--single-branch',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

---@param opts LazyConfig
return function(opts)
  opts = vim.tbl_deep_extend('force', {
    spec = {
      {
        import = 'plugins',
      },
    },
    defaults = { lazy = true },
    install = { colorscheme = { 'gruvbox-material' } },
    performance = {
      cache = {
        enabled = true,
      },
      rtp = {
        disabled_plugins = {
          'gzip',
          'rplugin',
          'tarPlugin',
          'tohtml',
          'tutor',
          'zipPlugin',
        },
      },
    },
    debug = false,
  }, opts or {})
  require('lazy').setup(opts)
end
