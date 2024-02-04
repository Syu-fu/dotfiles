vim.fn['ddc#custom#patch_global']({
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
      --dup = 'keep',
      keywordPattern = '\\k+',
      matchers = {
        'matcher_fuzzy',
      },
      sorters = {
        'sorter_fuzzy',
      },
      converters = {
        'converter_kind_labels',
      },
    },
    dictionary = {
      mark = '[Dict]',
      matchers = { 'matcher_fuzzy' },
    },
  },
  sourceParams = {
    lsp = {
      lspEngine = 'nvim-lsp',
      snippetEngine = vim.fn['denops#callback#register'](function(body)
        vim.fn['vsnip#anonymous'](body)
      end),
      enableResolveItem = true,
      enableAdditionalTextEdit = true,
      confirmBehavior = 'replace',
    },
    dictionary = {
      paths = { '/usr/share/dict/words' },
      firstCaseInsensitive = true,
      documentCommand = { 'wn', '${item.word}', '-over' },
      --databasePath = vim.fs.joinpath(vim.fn.stdpath('data'), 'ddc-source-dictionary.db'),
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

vim.fn['pum#set_option']({
  item_orders = { 'kind', 'space', 'abbr', 'space', 'menu' },
  scrollbar_char = '┃',
})

vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    vim.fn['ddc#custom#patch_buffer'](function()
      if vim.fn['ddc#syntax_in']('comment') then
        return { sources = { 'buffer', 'dictionary' } }
      end
      return {}
    end)
  end,
})
--pum
vim.keymap.set({ 'i', 'c' }, '<Tab>', function()
  if vim.fn['pum#visible']() then
    return '<Cmd>call pum#map#insert_relative(+1)<CR>'
  end
end, { expr = true })
vim.keymap.set({ 'i', 'c' }, '<s-tab>', function()
  if vim.fn['pum#visible']() then
    return '<Cmd>call pum#map#insert_relative(-1)<CR>'
  end
  return '<S-Tab>'
end, { expr = true })

vim.keymap.set({ 'i', 'c' }, '<c-n>', function()
  if vim.fn['pum#visible']() then
    return '<Cmd>call pum#map#insert_relative(+1)<CR>'
  end
  return ''
end, { expr = true })
vim.keymap.set({ 'i', 'c' }, '<c-p>', function()
  if vim.fn['pum#visible']() then
    return '<Cmd>call pum#map#insert_relative(-1)<CR>'
  end
  return ''
end, { expr = true })
vim.keymap.set({ 'i', 'c' }, '<c-y>', function()
  if vim.fn['pum#visible']() then
    return '<Cmd>call pum#map#confirm()<CR>'
  end
  return '<C-Y>'
end, { expr = true })
vim.keymap.set({ 'i', 'c' }, '<c-c>', function()
  if vim.fn['pum#visible']() then
    return '<Cmd>call pum#map#cancel()<CR>'
  end
  if vim.api.nvim_get_mode().mode == 'c' then
    return '<c-u><c-c>'
  end
  return '<c-c>'
end, { expr = true })
vim.fn['ddc#enable']()
vim.fn['ddc#enable_cmdline_completion']()
vim.fn['popup_preview#enable']()
