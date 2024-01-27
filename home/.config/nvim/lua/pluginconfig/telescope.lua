require('telescope').setup({
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
    },
    prompt_prefix = '> ',
    selection_caret = '> ',
    entry_prefix = '  ',
    initial_mode = 'insert',
    selection_strategy = 'reset',
    sorting_strategy = 'ascending',
    layout_strategy = 'flex',
    layout_config = {
      width = 0.8,
      horizontal = {
        mirror = false,
        prompt_position = 'top',
        preview_cutoff = 120,
        preview_width = 0.5,
      },
      vertical = {
        mirror = false,
        prompt_position = 'top',
        preview_cutoff = 120,
        preview_width = 0.5,
      },
    },
    file_sorter = require('telescope.sorters').get_fuzzy_file,
    file_ignore_patterns = { 'node_modules/*' },
    generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
    path_display = { 'truncate' },
    dynamic_preview_title = true,
    winblend = 0,
    color_devicons = true,
    use_less = true,
    scroll_strategy = 'cycle',
    mappings = {
      n = {
        ['q'] = require('telescope.actions').close,
      },
    },

    -- Developer configurations: Not meant for general override
    -- buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    -- history = { path = vim.fn.stdpath("state") .. "/databases/telescope_history.sqlite3", limit = 100 },
  },
  pickers = {
    git_status = {
      mappings = {
        n = {
          ['<C-z>'] = { '<cmd>Git commit<CR>', type = 'command' },
        },
        i = {
          ['<C-z>'] = { '<cmd>Git commit<CR>', type = 'command' },
        },
      },
    },
  },
  extensions = {},
})

require('telescope.builtin').project_files = function()
  local opts = {
    show_untracked = true,
    git_command = { 'git', 'ls-files', '--exclude-standard', '--cached' },
  }
  vim.fn.system('git rev-parse --is-inside-work-tree')
  if vim.v.shell_error == 0 then
    require('telescope.builtin').git_files(opts)
  else
    require('telescope.builtin').find_files(opts)
  end
end
