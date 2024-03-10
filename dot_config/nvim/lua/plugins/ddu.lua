return {
  {
    'Shougo/ddu.vim',
    lazy = false,
    config = function()
      vim.keymap.set('n', '<Space>b', '<Cmd>Ddu buffer<CR>', { noremap = true, silent = true })
      vim.keymap.set(
        'n',
        '<Space>p',
        '<Cmd>Ddu file_external -ui-param-ff-startFilter=v:true<CR>',
        { noremap = true, silent = true }
      )
      vim.keymap.set(
        'n',
        '<Space>a',
        '<Cmd>Ddu rg -ui-param-ff-startFilter=v:true<CR>',
        { noremap = true, silent = true }
      )
      vim.keymap.set('n', '<Space>gb', '<Cmd>Ddu git_branch<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<Space>gl', '<Cmd>Ddu git_log<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<Space>d', '<Cmd>Ddu lsp_diagnostic<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<Space>h', '<Cmd>Ddu help<CR>', { noremap = true, silent = true })

      local vimx = require('artemis')
      vimx.fn.ddu.custom.patch_global({
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
            sorters = {
              'sorter_fzf',
            },
            converters = {
              'converter_devicon',
            },
          },
          buffer = {
            matchers = {
              'matcher_fzf',
            },
            sorters = {
              'sorter_fzf',
            },
            converters = {
              'converter_devicon',
            },
          },
          rg = {
            matchers = {},
            converters = {
              'converter_devicon',
            },
            volatile = true,
          },
          help = {
            matchers = {
              'matcher_fzf',
            },
            sorters = {
              'sorter_fzf',
            },
          },
          -- lsp
          lsp_diagnostic = {
            converters = {
              'converter_lsp_diagnostic',
            },
          },
          lsp_documentSymbol = {
            converters = {
              'converter_lsp_symbol',
            },
          },
          lsp_workspaceSymbol = {
            converters = {
              'converter_lsp_symbol',
            },
          },
          -- git
          git_status = {
            matchers = {
              'matcher_fzf',
            },
            sorters = {
              'sorter_fzf',
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
            startAutoAction = false,
            previewFloating = false,
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
          lsp = {
            defaultAction = 'open',
          },
          lsp_codeAction = {
            defaultAction = 'apply',
          },
        },
        kindParams = {
          action = {
            quit = true,
          },
        },
        filterParams = {
          matcher_substring = {
            highlightMatched = 'GreenBold',
          },
          matcher_fzf = {
            highlightMatched = 'GreenBold',
          },
          matcher_kensaku = {
            highlightMatched = 'GreenBold',
          },
          converter_lsp_diagnostic = {
            iconMap = {
              Error = '',
              Warning = '',
              Hint = '',
              Info = '',
            },
            hlGroupMap = {
              Error = 'ErrorMsg',
              Warning = 'WarningMsg',
              Hint = 'HintFloat',
              Info = 'InfoFloat',
            },
          },
          converter_lsp_documentSymbol = {
            iconMap = {
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
        },
      })

      local function resize()
        local lines = vim.opt.lines:get()
        local height, row = math.floor(lines * 0.8), math.floor(lines * 0.1)
        local columns = vim.opt.columns:get()
        local width, col = math.floor(columns * 0.8), math.floor(columns * 0.1)
        local previewWidth = math.floor(width / 2)

        vimx.fn.ddu.custom.patch_global({
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
            -- vim.fn['ddu#ui#do_action']('itemAction')
            vimx.fn.ddu.ui.do_action('itemAction')
          end, { buffer = true })
          vim.keymap.set({ 'n' }, '<Space>', function()
            vimx.fn.ddu.ui.do_action('toggleSelectItem')
            vimx.fn.ddu.ui.do_action('cursorNext')
          end, { buffer = true })
          vim.keymap.set({ 'n' }, '<Tab>', function()
            vimx.fn.ddu.ui.do_action('toggleSelectItem')
            vimx.fn.ddu.ui.do_action('cursorNext')
          end, { buffer = true })
          vim.keymap.set({ 'n' }, 'i', function()
            vimx.fn.ddu.ui.do_action('openFilterWindow')
          end, { buffer = true })
          vim.keymap.set({ 'n' }, '>', function()
            vim.cmd('stopinsert')
            vimx.fn.ddu.ui.do_action('chooseAction')
          end, { buffer = true })

          vim.keymap.set({ 'n' }, 'q', function()
            vimx.fn.ddu.ui.do_action('quit')
          end, { buffer = true })
          vim.keymap.set({ 'n' }, '<Esc><Esc>', function()
            vim.cmd('stopinsert')
            vimx.fn.ddu.ui.do_action('quit')
          end, { buffer = true })
          vim.keymap.set({ 'n', 'i' }, '<C-c>', function()
            vim.cmd('stopinsert')
            vimx.fn.ddu.ui.do_action('quit')
          end, { buffer = true })

          vim.keymap.set({ 'n' }, 'j', function()
            vimx.fn.ddu.ui.do_action('cursorNext')
          end, { buffer = true })
          vim.keymap.set({ 'n' }, 'k', function()
            vimx.fn.ddu.ui.do_action('cursorPrevious')
          end, { buffer = true })
          vim.keymap.set({ 'n', 'i' }, '<C-n>', function()
            vimx.fn.ddu.ui.do_action('cursorNext')
          end, { buffer = true })
          vim.keymap.set({ 'n', 'i' }, '<C-p>', function()
            vimx.fn.ddu.ui.do_action('cursorPrevious')
          end, { buffer = true })

          vim.keymap.set({ 'n', 'i' }, '<C-d>', function()
            local ctrl_d = vim.api.nvim_replace_termcodes('<C-d>', true, true, true)
            vimx.fn.ddu.ui.do_action('previewExecute', { command = 'normal! ' .. ctrl_d })
          end, { buffer = true })
          vim.keymap.set({ 'n', 'i' }, '<C-u>', function()
            local ctrl_u = vim.api.nvim_replace_termcodes('<C-u>', true, true, true)
            vimx.fn.ddu.ui.do_action('previewExecute', { command = 'normal! ' .. ctrl_u })
          end, { buffer = true })
          vim.keymap.set({ 'n', 'i' }, '?', function()
            vimx.fn.ddu.ui.do_action('toggleAutoAction')
          end, { buffer = true })
        end,
      })
      vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = { 'ddu-ff-filter' },
        callback = function()
          vim.keymap.set({ 'n', 'i' }, '<CR>', function()
            vim.cmd('stopinsert')
            vimx.fn.ddu.ui.do_action('itemAction')
          end, { buffer = true })
          vim.keymap.set({ 'n', 'i' }, '>', function()
            vim.cmd('stopinsert')
            vimx.fn.ddu.ui.do_action('chooseAction')
          end, { buffer = true })

          vim.keymap.set({ 'n' }, 'q', function()
            vimx.fn.ddu.ui.do_action('quit')
          end, { buffer = true })
          vim.keymap.set({ 'n' }, '<Esc><Esc>', function()
            vim.cmd('stopinsert')
            vimx.fn.ddu.ui.do_action('quit')
          end, { buffer = true })
          vim.keymap.set({ 'n', 'i' }, '<C-g>', function()
            vim.cmd('stopinsert')
            vimx.fn.ddu.ui.do_action('quit')
          end, { buffer = true, nowait = true })
          vim.keymap.set({ 'n', 'i' }, '<C-c>', function()
            vim.cmd('stopinsert')
            vimx.fn.ddu.ui.do_action('quit')
          end, { buffer = true })

          vim.keymap.set({ 'n', 'i' }, '<C-n>', function()
            vimx.fn.ddu.ui.do_action('cursorNext')
          end, { buffer = true })
          vim.keymap.set({ 'n', 'i' }, '<C-p>', function()
            vimx.fn.ddu.ui.do_action('cursorPrevious')
          end, { buffer = true })
          vim.keymap.set({ 'n', 'i' }, '<Tab>', function()
            vimx.fn.ddu.ui.do_action('toggleSelectItem')
            vimx.fn.ddu.ui.do_action('cursorNext')
          end, { buffer = true })

          vim.keymap.set({ 'n', 'i' }, '<C-d>', function()
            local ctrl_d = vim.api.nvim_replace_termcodes('<C-d>', true, true, true)
            vimx.fn.ddu.ui.do_action('previewExecute', { command = 'normal! ' .. ctrl_d })
          end, { buffer = true })
          vim.keymap.set({ 'n', 'i' }, '<C-u>', function()
            local ctrl_u = vim.api.nvim_replace_termcodes('<C-u>', true, true, true)
            vimx.fn.ddu.ui.do_action('previewExecute', { command = 'normal! ' .. ctrl_u })
          end, { buffer = true })
          vim.keymap.set({ 'n', 'i' }, '?', function()
            vimx.fn.ddu.ui.do_action('toggleAutoAction')
          end, { buffer = true })
        end,
      })
    end,
    dependencies = {
      { 'vim-denops/denops.vim' },
      { 'tani/vim-artemis' },
      { 'Shougo/ddu-ui-ff' },
      { 'Shougo/ddu-kind-file' },
      { 'yuki-yano/ddu-filter-fzf' },
      { 'Shougo/ddu-filter-matcher_substring' },
      { 'uga-rosa/ddu-filter-converter_devicon' },
      { 'Shougo/ddu-filter-matcher_hidden' },
      { 'matsui54/ddu-source-file_external' },
      { 'Shougo/ddu-source-buffer' },
      { 'Shougo/ddu-source-action' },
      { 'shun/ddu-source-rg' },
      { 'uga-rosa/ddu-source-lsp' },
      { 'kuuote/ddu-source-git_status' },
      { 'kyoh86/ddu-source-git_log' },
      { 'kyoh86/ddu-source-git_branch' },
      { 'peacock0803sz/ddu-source-git_stash' },
      { 'kyoh86/ddu-source-github' },
      { 'uga-rosa/ddu-source-help' },
      { 'Shougo/ddu-commands.vim' },
      {
        'Milly/ddu-filter-kensaku',
        dependencies = {
          {
            'lambdalisue/kensaku.vim',
          },
        }
      }
    },
  },
}
