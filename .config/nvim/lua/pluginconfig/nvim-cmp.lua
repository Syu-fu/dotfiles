local cmp = require('cmp')
local types = require('cmp.types')
local luasnip = require('luasnip')
local dict = require('cmp_dictionary')

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

cmp.setup({
  formatting = {
    format = require('lspkind').cmp_format({
      with_text = true,
      menu = {
        buffer = '[Buffer]',
        nvim_lsp = '[LSP]',
        luasnip = '[LuaSnip]',
        nvim_lua = '[NeovimLua]',
        path = '[Path]',
        emoji = '[Emoji]',
        dictionary = '[Dictionary]',
        cmdline_history = '[History]',
      },
    }),
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      function(entry1, entry2)
        local kind1 = entry1:get_kind()
        kind1 = kind1 == types.lsp.CompletionItemKind.Text and 100 or kind1
        local kind2 = entry2:get_kind()
        kind2 = kind2 == types.lsp.CompletionItemKind.Text and 100 or kind2
        if kind1 ~= kind2 then
          if kind1 == types.lsp.CompletionItemKind.Snippet then
            return false
          end
          if kind2 == types.lsp.CompletionItemKind.Snippet then
            return true
          end
          local diff = kind1 - kind2
          if diff < 0 then
            return true
          elseif diff > 0 then
            return false
          end
        end
      end,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },

  mapping = {
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },

  sources = cmp.config.sources({
    { name = 'nvim_lsp', priority = 100 },
    { name = 'luasnip', priority = 20 },
    { name = 'path', priority = 100 },
    { name = 'emoji', insert = true, priority = 60 },
    { name = 'nvim_lua', priority = 50 },
    { name = 'nvim_lsp_signature_help', priority = 80 },
  }, {
    { name = 'buffer', priority = 50 },
    { name = 'dictionary', keyword_length = 2, priority = 10 },
    { name = 'git', priority = 60 },
  }),
})

-- Set configuration for specific filetype.
cmp.setup.filetype({ 'gitcommit', 'octo' }, {
  sources = cmp.config.sources({
    { name = 'git' },
  }, {
    { name = 'buffer' },
  }),
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'cmdline' },
    { name = 'cmdline_history' },
  }),
})

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'nvim_lsp_document_symbol' },
  }, {
    { name = 'buffer' },
  }),
})

-- autopairs
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

-- dictionary
dict.setup({
  dic = {
    ['*'] = { '/usr/share/dict/words' },
  },
  exact = 2,
  first_case_insensitive = false,
  document = false,
  document_command = 'wn %s -over',
  max_items = -1,
})

dict.switcher({
  spelllang = {
    en = '/usr/share/dict/words',
  },
})

-- git
require('cmp_git').setup()
