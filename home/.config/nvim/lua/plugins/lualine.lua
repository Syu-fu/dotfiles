return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    config = function()
require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = 'gruvbox-material',
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'filename', 'branch' },
    lualine_c = {},
    lualine_x = {
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        sections = { 'error', 'warn', 'info', 'hint' },
        symbols = { error = '', warn = ' ', info = '', hint = ' ' },
        colored = true,
        update_in_insert = true,
        always_visible = false,
      },
    },
    lualine_y = { 'encoding', 'fileformat', { 'filetype', colored = false }, 'progress' },
    lualine_z = { 'location' },
  },
  inactive_sections = {},
  tabline = {},
})
    end,
  },
}
