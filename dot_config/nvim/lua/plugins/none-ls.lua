return {
  {
    'nvimtools/none-ls.nvim',
    event = 'VeryLazy',
    config = function()
      local null_ls = require('null-ls')

      local ignored_filetypes = {
        'diff',
        'gitcommit',
        'NeogitCommitMessage',
        'markdown',
        'qf',
        'help',
        'lsp-installer',
        'lspinfo',
        'null-ls-info',
        'mason',
        'notify',
        'ddu-ff',
        'ddu-ff-filter',
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
        null_ls.builtins.diagnostics.stylelint.with({
          filetypes = { 'css', 'scss', 'sass', 'less' },
        }),
        null_ls.builtins.formatting.stylelint.with({
          condition = function()
            return vim.fn.executable('stylelint') > 0 or vim.fn.executable('./node_modules/.bin/stylelint') > 0
          end,
          filetypes = { 'css', 'scss', 'sass', 'less' },
        }),
        null_ls.builtins.diagnostics.zsh,
        null_ls.builtins.formatting.shfmt.with({
          -- extra_args = { '-t' },
          condition = function()
            return vim.fn.executable('shfmt') > 0
          end,
          filetypes = { 'sh', 'bash', 'zsh' },
        }),
        --null_ls.builtins.diagnostics.shellcheck.with({
        --  condition = function()
        --    return vim.fn.executable('shellcheck') > 0
        --  end,
        --}),
        null_ls.builtins.formatting.markdownlint.with({
          condition = function()
            return vim.fn.executable('markdownlint') > 0
          end,
        }),
        --null_ls.builtins.formatting.jq.with({
        --  condition = function()
        --    return vim.fn.executable('jq') > 0
        --  end,
        --}),
        null_ls.builtins.diagnostics.textlint.with({
          condition = function()
            return vim.fn.executable('textlint') > 0
          end,
          filetypes = { 'markdown' },
        }),
        null_ls.builtins.diagnostics.actionlint,
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
    end,
  },
  {
    'jose-elias-alvarez/typescript.nvim',
    lazy = true,
  },
}
