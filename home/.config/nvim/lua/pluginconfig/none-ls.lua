local null_ls = require('null-ls')

local ignored_filetypes = {
  'TelescopePrompt',
  'diff',
  'gitcommit',
  'qf',
  'help',
  'markdown',
  'minimap',
  'packer',
  'dashboard',
  'telescope',
  'lsp-installer',
  'lspinfo',
  'null-ls-info',
  'mason',
  'notify',
}

local ignored_buftype = {
  'nofile',
}

local groupname = 'vimrc_null_ls'
vim.api.nvim_create_augroup(groupname, { clear = true })
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = groupname,
  pattern = '*',
  callback = function()
    if vim.tbl_contains(ignored_filetypes, vim.bo.filetype) then
      return
    end
    if vim.tbl_contains(ignored_buftype, vim.bo.buftype) then
      return
    end

    vim.fn.matchadd('DiffDelete', '\\v\\s+$')
  end,
  once = false,
})

local sources = {
  -- LuaFormatter off
  null_ls.builtins.formatting.trim_whitespace.with({
    disabled_filetypes = ignored_filetypes,
    runtime_condition = function()
      local count = tonumber(vim.api.nvim_exec("execute 'silent! %s/\\v\\s+$//gn'", true):match('%w+'))
      if count then
        return vim.fn.confirm('Whitespace found, delete it?', '&No\n&Yes', 1, 'Question') == 2
      end
    end,
  }),
  null_ls.builtins.formatting.stylua.with({
    condition = function()
      return vim.fn.executable('stylua') > 0
    end,
  }),
  null_ls.builtins.formatting.prettier.with({
    condition = function()
      return vim.fn.executable('prettier') > 0 or vim.fn.executable('./node_modules/.bin/prettier') > 0
    end,
  }),
  null_ls.builtins.diagnostics.eslint.with({
    condition = function()
      vim.o.fixendofline = true -- Error: [prettier/prettier] Insert `⏎`
      return vim.fn.executable('eslint') > 0 or vim.fn.executable('./node_modules/.bin/eslint') > 0
    end,
  }),
  null_ls.builtins.formatting.stylelint.with({
    condition = function()
      return vim.fn.executable('stylelint') > 0 or vim.fn.executable('./node_modules/.bin/stylelint') > 0
    end,
    filetypes = { 'css', 'scss', 'sass', 'less' },
  }),
  null_ls.builtins.diagnostics.zsh,
  null_ls.builtins.formatting.beautysh.with({
    extra_args = { '-t' },
    condition = function()
      return vim.fn.executable('beautysh') > 0
    end,
  }),
  null_ls.builtins.diagnostics.shellcheck.with({
    condition = function()
      return vim.fn.executable('shellcheck') > 0
    end,
  }),
  null_ls.builtins.formatting.markdownlint.with({
    condition = function()
      return vim.fn.executable('markdownlint') > 0
    end,
  }),
  null_ls.builtins.formatting.jq.with({
    condition = function()
      return vim.fn.executable('jq') > 0
    end,
  }),
  null_ls.builtins.diagnostics.textlint.with({
    condition = function()
      return vim.fn.executable('textlint') > 0
    end,
    filetypes = { 'markdown' },
  }),
  --require('typescript.extensions.null-ls.code-actions'),
}

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      return client.name ~= 'vtsls' and client.name ~= 'lua_ls'
    end,
    bufnr = bufnr,
  })
end

local augroup = vim.api.nvim_create_augroup('LspFormatting', { clear = true })
local on_attach = function(client, bufnr)
  if client.supports_method('textDocument/formatting') then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
      group = augroup,
      buffer = bufnr,
      callback = function()
        lsp_formatting(bufnr)
      end,
    })
  end
end

null_ls.setup({
  diagnostics_format = '[#{c}] #{m} (#{s})',
  sources = sources,
  on_attach = on_attach,
})
