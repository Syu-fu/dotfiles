return {
  {
    'Shougo/ddc.vim',
    lazy = false,
    config = function()
      local vimx = require('artemis')
      vimx.fn.ddc.custom.patch_global({
        ui = 'pum',
        autoCompleteEvents = {
          'InsertEnter',
          'TextChangedI',
          'CmdlineEnter',
          'CmdlineChanged',
        },
        backspaceCompletion = true,
        sources = {
          'lsp',
          'dictionary',
          'buffer',
        },
        sourceOptions = {
          _ = {
            ignoreCase = true,
            minAutoCompleteLength = 1,
            keywordPattern = [[(?:-?\d+(?:\.\d+)?|[a-zA-Z_]\w*(?:-\w*)*)]],
            matchers = {
              'matcher_fuzzy',
            },
            sorters = {
              'sorter_fuzzy',
            },
            converters = {
              'converter_fuzzy',
            },
            timeout = 500,
          },
          lsp = {
            mark = '[LSP]',
            keywordPattern = '\\k+',
            converters = {
              'converter_kind_labels',
            },
          },
          buffer = {
            mark = '[Buffer]',
          },
          around = {
            mark = '[Around]',
          },
          line = {
            mark = '[Line]',
          },
          path = {
            mark = '[Path]',
          },
          dictionary = {
            mark = '[Dict]',
          },
          ['git-commit'] = {
            mark = '[Git]',
          },
          ['git-file'] = {
            mark = '[Git]',
          },
          ['git-branch'] = {
            mark = '[Git]',
          },
          github_issue = {
            mark = '[GitHub]',
          },
          github_pull_request = {
            mark = '[GitHub]',
          },
        },
        sourceParams = {
          lsp = {
            lspEngine = 'nvim-lsp',
            snippetEngine = vimx.fn.denops.callback.register(function(body)
              vimx.fn.vsnip.anonymous(body)
            end),
            enableResolveItem = true,
            enableAdditionalTextEdit = true,
            confirmBehavior = 'replace',
          },
          dictionary = {
            paths = { '/usr/share/dict/words' },
            firstCaseInsensitive = true,
            documentCommand = { 'wn', '${item.word}', '-over' },
          },
        },
        filterParams = {
          converter_kind_labels = {
            kindLabels = {
              Text = '󰉿 Text',
              Method = '󰆧 Method',
              Function = '󰊕 Function',
              Constructor = ' Constructor',
              Field = '󰜢 Field',
              Variable = '󰀫 Variable',
              Class = '󰠱 Class',
              Interface = ' Interface',
              Module = ' Module',
              Property = '󱈢 Property',
              Unit = '󰑭 Unit',
              Value = '󰎠 Value',
              Enum = ' Enum',
              Keyword = '󰌋 Keyword',
              Snippet = ' Snippet',
              Color = '󰏘 Color',
              File = '󰈙 File',
              Reference = '󰈇 Reference',
              Folder = '󰉋 Folder',
              EnumMember = ' EnumMember',
              Constant = '󰏿 Constant',
              Struct = '󰙅 Struct',
              Event = ' Event',
              Operator = '󰆕 Operator',
              TypeParameter = '',
            },
            kindHlGroups = {
              Method = 'Function',
              Function = 'Function',
              Constructor = 'Function',
              Field = 'Identifier',
              Variable = 'Identifier',
              Class = 'Structure',
              Interface = 'Structure',
            },
          },
        },
      })

      vimx.fn.ddc.custom.patch_global({
        sourceOptions = {
          cmdline = {
            mark = '[Cmd]',
            keywordPattern = '[\\w#:~_-]*',
            matchers = { 'matcher_fuzzy' },
            sorters = { 'sorter_fuzzy' },
            converters = { 'converter_cmdline' },
          },
          ['cmdline-history'] = { mark = '[Hist]' },
        },
        cmdlineSources = {
          [':'] = { 'cmdline', 'cmdline-history', 'around', 'git-commit', 'git-file', 'git-branch' },
          ['/'] = { 'around', 'buffer', 'line' },
          ['?'] = { 'cmdline', 'cmdline-history' },
          ['@'] = { 'cmdline-history', 'buffer' },
          ['='] = { 'input' },
        },
      })

      vimx.fn.ddc.custom.patch_filetype({ 'gitcommit' }, {
        sources = { 'github_issue', 'github_pullrequest', 'git-commit', 'dictionary' },
      })

      vimx.fn.pum.set_option({
        item_orders = { 'kind', 'space', 'abbr', 'space', 'menu' },
        scrollbar_char = '┃',
      })

      vim.api.nvim_create_autocmd('BufEnter', {
        callback = function()
          vimx.fn.ddc.custom.patch_buffer(function()
            if vimx.fn.ddc.syntax_in('comment') then
              return { sources = { 'buffer', 'dictionary' } }
            end
            return {}
          end)
        end,
      })

      -- gh buffer
      function OnGh()
        local tmpdir = vim.fn.empty(vim.env.TMPDIR) and '/tmp' or vim.env.TMPDIR
        if vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':h') ~= tmpdir or vim.fn.getcwd() == tmpdir then
          return
        end
        vimx.fn.ddc.custom.patch_buffer({
          sources = { 'github_issue', 'github_pull_request' },
        })
      end

      vim.api.nvim_create_autocmd('FileType', { pattern = 'markdown', callback = OnGh })
      vim.keymap.set({ 'n', 'x' }, ':', '<Cmd>call ddc#enable_cmdline_completion()<CR>:')
      vim.keymap.set({ 'n', 'x' }, '/', '<Cmd>call ddc#enable_cmdline_completion()<CR>/')
      vim.keymap.set({ 'n', 'x' }, '?', '<Cmd>call ddc#enable_cmdline_completion()<CR>?')

      --pum
      vim.keymap.set({ 'i', 'c' }, '<Tab>', function()
        if vimx.fn.pum.visible() then
          return '<Cmd>call pum#map#insert_relative(+1)<CR>'
        end
        return '<Tab>'
      end, { expr = true })
      vim.keymap.set({ 'i', 'c' }, '<s-tab>', function()
        if vimx.fn.pum.visible() then
          return '<Cmd>call pum#map#insert_relative(-1)<CR>'
        end
        return '<S-Tab>'
      end, { expr = true })

      vim.keymap.set({ 'i', 'c' }, '<c-n>', function()
        if vimx.fn.pum.visible() then
          return '<Cmd>call pum#map#insert_relative(+1)<CR>'
        end
        return ''
      end, { expr = true })
      vim.keymap.set({ 'i', 'c' }, '<c-p>', function()
        if vimx.fn.pum.visible() then
          return '<Cmd>call pum#map#insert_relative(-1)<CR>'
        end
        return ''
      end, { expr = true })
      vim.keymap.set({ 'i', 'c' }, '<c-y>', function()
        if vimx.fn.pum.visible() then
          return '<Cmd>call pum#map#confirm()<CR>'
        end
        return '<C-Y>'
      end, { expr = true })
      vim.keymap.set({ 'i', 'c' }, '<c-c>', function()
        if vimx.fn.pum.visible() then
          return '<Cmd>call pum#map#cancel()<CR>'
        end
        if vim.api.nvim_get_mode().mode == 'c' then
          return '<c-u><c-c>'
        end
        return '<c-c>'
      end, { expr = true })
      -- cmdline keymap
      vim.keymap.set('c', '<Tab>', function()
        if vimx.fn.ddc.visible() then
          vimx.fn.pum.map.insert_relative(1, 'loop')
        else
          return vimx.fn.ddc.map.manual_complete()
        end
      end, { expr = true, replace_keycodes = false })
      vim.keymap.set('c', '<S-Tab>', "<Cmd>call pum#map#insert_relative(-1, 'loop')<CR>")
      vim.keymap.set('c', '<C-n>', "<Cmd>call pum#map#insert_relative(+1, 'loop')<CR>")
      vim.keymap.set('c', '<C-p>', "<Cmd>call pum#map#insert_relative(-1, 'loop')<CR>")
      vim.keymap.set('c', '<C-y>', '<Cmd>call pum#map#confirm()<CR>')
      vimx.fn.ddc.enable()
      vimx.fn.popup_preview.enable()
    end,
    dependencies = {
      { 'vim-denops/denops.vim' },
      { 'tani/vim-artemis' },
      { 'matsui54/denops-popup-preview.vim' },
      { 'hrsh7th/vim-vsnip' },
      { 'uga-rosa/ddc-source-vsnip' },
      { 'Shougo/ddc-source-lsp' },
      { 'Shougo/ddc-buffer' },
      { 'Shougo/ddc-source-around' },
      { 'tani/ddc-path' },
      { 'Shougo/ddc-line' },
      { 'uga-rosa/ddc-source-dictionary' },
      { 'Shougo/ddc-source-cmdline', event = { 'CmdlineEnter' } },
      { 'Shougo/ddc-source-cmdline-history', event = { 'CmdlineEnter' } },
      { 'tani/ddc-git' },
      { '4513ECHO/ddc-github' },
      { 'tani/ddc-fuzzy' },
      { 'Shougo/pum.vim' },
      { 'Shougo/ddc-ui-pum' },
    },
  },
}
