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

    -- Developer configurations: Not meant for general override
    -- buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    -- history = { path = vim.fn.stdpath("state") .. "/databases/telescope_history.sqlite3", limit = 100 },
  },
  extensions = {
    media_files = {
      filetypes = { 'png', 'webp', 'jpg', 'jpeg' }, -- filetypes whitelist
      find_cmd = 'rg', -- find command
    },
    arecibo = {
      ['selected_engine'] = 'google',
      ['url_open_command'] = 'xdg-open',
      ['show_http_headers'] = false,
      ['show_domain_icons'] = false,
    },
    frecency = {
      db_root = vim.fn.stdpath('state'),
      ignore_patterns = { '*.git/*', '*/tmp/*', '*/node_modules/*' },
      db_safe_mode = false,
      auto_validate = true,
    },
  },
})
vim.keymap.set('n', '<Space>b', '<Cmd>Telescope buffers<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Space>p', '<Cmd>Telescope git_files<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Space>h', '<Cmd>Telescope help_tags<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Space>a', '<Cmd>Telescope live_grep<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Space>d', '<Cmd>Telescope diagnostics<CR>', { noremap = true, silent = true })
-- git
vim.keymap.set(
  'n',
  '<Space>gs',
  "<Cmd>lua require('telescope.builtin').git_status()<CR>",
  { noremap = true, silent = true }
)
vim.keymap.set(
  'n',
  '<Space>gl',
  "<Cmd>lua require('telescope.builtin').git_commits()<CR>",
  { noremap = true, silent = true }
)
vim.keymap.set(
  'n',
  '<Space>gC',
  "<Cmd>lua require('telescope.builtin').git_bcommits()<CR>",
  { noremap = true, silent = true }
)
vim.keymap.set(
  'n',
  '<Space>gb',
  "<Cmd>lua require('telescope.builtin').git_branches()<CR>",
  { noremap = true, silent = true }
)
-- github
vim.keymap.set('n', '<Space>gi', '<Cmd>Telescope gh issues<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Space>gp', '<Cmd>Telescope gh pull_request<CR>', { noremap = true, silent = true })
