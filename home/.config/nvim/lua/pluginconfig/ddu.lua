vim.keymap.set('n', '<Space>b', '<Cmd>Ddu buffer<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Space>p', '<Cmd>Ddu file_external<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Space>a', '<Cmd>Ddu rg<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Space>gs', '<Cmd>Ddu git_status<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Space>gb', '<Cmd>Ddu git_branch<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Space>gl', '<Cmd>Ddu git_log<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Space>d', '<Cmd>Ddu lsp_diagnostic<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Space>h', '<Cmd>Ddu help<CR>', { noremap = true, silent = true })
vim.fn['ddu#custom#patch_global']({
  ui = 'ff',
  sourceOptions = {
    _ = {
      ignoreCase = true,
      matchers = {
        'matcher_substring',
      },
    },
    file_external = {
      matchers = {
        'matcher_fzf',
      },
      converters = {
        'converter_devicon',
      },
    },
    buffer = {
      matchers = {
        'matcher_fzf',
      },
      converters = {
        'converter_devicon',
      },
    },
    rg = {
      matchers = {},
      volatile = true,
    },
    help = {
      matchers = {
        'matcher_fzf',
      },
    },
    -- lsp
    lsp_diagnostic = {
      converters = {
        'converter_lsp_diagnostic',
      },
    },
    -- git
    git_status = {
      matchers = {
        'matcher_substring',
      },
      converters = {
        'converter_git_status',
      },
    },
    git_branch = {
      matchers = {
        'matcher_substring',
      },
    },
    git_log = {
      matchers = {
        'matcher_substring',
      },
    },
  },
  sourceParams = {
    file_external = {
      cmd = { 'git', 'ls-files', '-co', '--exclude-standard' },
    },
    rg = {
      args = { '--column', '--no-heading', '--color', 'never' },
    },
    -- github
    github_repo_issue = {
      source = 'cwd',
    },
  },
  uiParams = {
    ff = {
      -- startFilter = true,
      prompt = '> ',
      split = 'floating',
      floatingBorder = 'rounded',
      filterFloatingPosition = 'top',
      autoAction = {
        name = 'preview',
      },
      startAutoAction = true,
      previewFloating = true,
      previewFloatingBorder = 'rounded',
      previewSplit = 'vertical',
      previewWindowOptions = {
        { '&signcolumn', 'no' },
        { '&foldcolumn', 0 },
        { '&foldenable', 0 },
        { '&number', 0 },
        { '&wrap', 0 },
        { '&scrolloff', 0 },
      },
      highlights = {
        floatingCursorLine = 'Visual',
        filterText = 'Statement',
        floating = 'Normal',
        floatingBorder = 'Single',
      },
    },
  },
  kindOptions = {
    file = {
      defaultAction = 'open',
    },
    action = {
      defaultAction = 'do',
    },
    git_status = {
      defaultAction = 'open',
    },
    github_issue = {
      defaultAction = 'edit',
    },
    git_branch = {
      defaultAction = 'switch',
    },
  },
  kindParams = {
    action = {
      quit = true,
    },
  },
})
vim.fn['ddu#custom#patch_global']({
  filterParams = {
    matcher_substring = {
      -- highlightMatched = 'Search',
    },
    matcher_fzf = {
      -- highlightMatched = 'Search',
    },
    converter_lsp_diagnostic = {
      iconMap = {
        Error = '',
        Warn = ' ',
        Hint = '',
        Info = ' ',
      },
    },
    converter_lsp_documentSymbol = {
      Text = '󰉿',
      Method = '󰆧',
      Function = '󰊕',
      Constructor = '',
      Field = '󰜢',
      Variable = '󰀫',
      Class = '󰠱',
      Interface = '',
      Module = '',
      Property = '󱈢',
      Unit = '󰑭',
      Value = '󰎠',
      Enum = '',
      Keyword = '󰌋',
      Snippet = '',
      Color = '󰏘',
      File = '󰈙',
      Reference = '󰈇',
      Folder = '󰉋',
      EnumMember = '',
      Constant = '󰏿',
      Struct = '󰙅',
      Event = '',
      Operator = '󰆕',
      TypeParameter = '',
    },
  },
})

local function resize()
  local lines = vim.opt.lines:get()
  local height, row = math.floor(lines * 0.8), math.floor(lines * 0.1)
  local columns = vim.opt.columns:get()
  local width, col = math.floor(columns * 0.8), math.floor(columns * 0.1)
  local previewWidth = math.floor(width / 2)

  vim.fn['ddu#custom#patch_global']({
    uiParams = {
      ff = {
        winHeight = height,
        winRow = row,
        winWidth = width,
        winCol = col,
        previewHeight = height,
        previewRow = row,
        previewWidth = previewWidth,
        previewCol = col + (width - previewWidth),
      },
    },
  })
end
resize()
vim.api.nvim_create_autocmd('VimResized', {
  callback = resize,
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'ddu-ff' },
  callback = function()
    vim.opt_local.cursorline = true

    vim.keymap.set({ 'n' }, '<CR>', function()
      vim.cmd('stopinsert')
      vim.fn['ddu#ui#do_action']('itemAction')
    end, { buffer = true })
    vim.keymap.set({ 'n' }, '<Space>', function()
      vim.fn['ddu#ui#do_action']('toggleSelectItem')
      vim.fn['ddu#ui#do_action']('cursorNext')
    end, { buffer = true })
    vim.keymap.set({ 'n' }, 'i', function()
      vim.fn['ddu#ui#do_action']('openFilterWindow')
    end, { buffer = true })
    vim.keymap.set({ 'n' }, '>', function()
      vim.cmd('stopinsert')
      vim.fn['ddu#ui#do_action']('chooseAction')
    end, { buffer = true })

    vim.keymap.set({ 'n' }, 'q', function()
      vim.fn['ddu#ui#do_action']('quit')
    end, { buffer = true })
    vim.keymap.set({ 'n' }, '<Esc><Esc>', function()
      vim.cmd('stopinsert')
      vim.fn['ddu#ui#do_action']('quit')
    end, { buffer = true })
    vim.keymap.set({ 'n', 'i' }, '<C-c>', function()
      vim.cmd('stopinsert')
      vim.fn['ddu#ui#do_action']('quit')
    end, { buffer = true })

    vim.keymap.set({ 'n' }, 'j', function()
      vim.fn['ddu#ui#do_action']('cursorNext')
    end, { buffer = true })
    vim.keymap.set({ 'n' }, 'k', function()
      vim.fn['ddu#ui#do_action']('cursorPrevious')
    end, { buffer = true })
    vim.keymap.set({ 'n', 'i' }, '<C-n>', function()
      vim.fn['ddu#ui#do_action']('cursorNext')
    end, { buffer = true })
    vim.keymap.set({ 'n', 'i' }, '<C-p>', function()
      vim.fn['ddu#ui#do_action']('cursorPrevious')
    end, { buffer = true })

    vim.keymap.set({ 'n', 'i' }, '<C-d>', function()
      local ctrl_d = vim.api.nvim_replace_termcodes('<C-d>', true, true, true)
      vim.fn['ddu#ui#do_action']('previewExecute', { command = 'normal! ' .. ctrl_d })
    end, { buffer = true })
    vim.keymap.set({ 'n', 'i' }, '<C-u>', function()
      local ctrl_u = vim.api.nvim_replace_termcodes('<C-u>', true, true, true)
      vim.fn['ddu#ui#do_action']('previewExecute', { command = 'normal! ' .. ctrl_u })
    end, { buffer = true })
    vim.keymap.set({ 'n', 'i' }, '?', function()
      vim.fn['ddu#ui#do_action']('toggleAutoAction')
    end, { buffer = true })
  end,
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'ddu-ff-filter' },
  callback = function()
    vim.keymap.set({ 'n', 'i' }, '<CR>', function()
      vim.cmd('stopinsert')
      vim.fn['ddu#ui#do_action']('itemAction')
    end, { buffer = true })
    vim.keymap.set({ 'n', 'i' }, '>', function()
      vim.cmd('stopinsert')
      vim.fn['ddu#ui#do_action']('chooseAction')
    end, { buffer = true })

    vim.keymap.set({ 'n' }, 'q', function()
      vim.fn['ddu#ui#do_action']('quit')
    end, { buffer = true })
    vim.keymap.set({ 'n' }, '<Esc><Esc>', function()
      vim.cmd('stopinsert')
      vim.fn['ddu#ui#do_action']('quit')
    end, { buffer = true })
    vim.keymap.set({ 'n', 'i' }, '<C-g>', function()
      vim.cmd('stopinsert')
      vim.fn['ddu#ui#do_action']('quit')
    end, { buffer = true, nowait = true })
    vim.keymap.set({ 'n', 'i' }, '<C-c>', function()
      vim.cmd('stopinsert')
      vim.fn['ddu#ui#do_action']('quit')
    end, { buffer = true })

    vim.keymap.set({ 'n', 'i' }, '<C-n>', function()
      vim.fn['ddu#ui#do_action']('cursorNext')
    end, { buffer = true })
    vim.keymap.set({ 'n', 'i' }, '<C-p>', function()
      vim.fn['ddu#ui#do_action']('cursorPrevious')
    end, { buffer = true })
    vim.keymap.set({ 'n', 'i' }, '<Tab>', function()
      vim.fn['ddu#ui#do_action']('toggleSelectItem')
      vim.fn['ddu#ui#do_action']('cursorNext')
    end, { buffer = true })

    vim.keymap.set({ 'n', 'i' }, '<C-d>', function()
      local ctrl_d = vim.api.nvim_replace_termcodes('<C-d>', true, true, true)
      vim.fn['ddu#ui#do_action']('previewExecute', { command = 'normal! ' .. ctrl_d })
    end, { buffer = true })
    vim.keymap.set({ 'n', 'i' }, '<C-u>', function()
      local ctrl_u = vim.api.nvim_replace_termcodes('<C-u>', true, true, true)
      vim.fn['ddu#ui#do_action']('previewExecute', { command = 'normal! ' .. ctrl_u })
    end, { buffer = true })
    vim.keymap.set({ 'n', 'i' }, '?', function()
      vim.fn['ddu#ui#do_action']('toggleAutoAction')
    end, { buffer = true })
  end,
})
