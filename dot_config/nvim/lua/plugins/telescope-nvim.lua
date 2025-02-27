return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    init = function()
      vim.keymap.set('n', '<Space>b', '<Cmd>Telescope buffers<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<Space>p', '<Cmd>Telescope project_files<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<Space>h', '<Cmd>Telescope help_tags<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<Space>a', '<Cmd>Telescope live_grep<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<Space>d', '<Cmd>Telescope diagnostics<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<Space>t', '<Cmd>Telescope telescope-tabs list_tabs<CR>', { noremap = true, silent = true })
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

      --file_browser
      vim.keymap.set('n', '<Space>l', '<Cmd>Telescope file_browser<CR>', { noremap = true, silent = true })
    end,
    config = function()
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
        pickers = {},
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
          },
        },
      })
      require('telescope-tabs').setup({})

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
      require('telescope').load_extension('fzf')
    end,
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    lazy = true,
  },
  {
    'LukasPietzschmann/telescope-tabs',
    lazy = true,
  },
}
