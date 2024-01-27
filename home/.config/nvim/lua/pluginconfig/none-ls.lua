local null_ls = require('null-ls')

-- https://zenn.dev/kawarimidoll/articles/2e99432d27eda3
-- $XDG_CONFIG_HOME/cspell
local cspell_config_dir = '~/.config/cspell'
-- $XDG_DATA_HOME/cspell
local cspell_data_dir = '~/.local/share/cspell'
local cspell_share_dir = '~/Dropbox/dev/cspell'
local cspell_files = {
  config = vim.call('expand', cspell_config_dir .. '/cspell.json'),
  dotfiles = vim.call('expand', cspell_share_dir .. '/dotfiles.txt'),
  vim = vim.call('expand', cspell_data_dir .. '/vim.txt.gz'),
  user = vim.call('expand', cspell_share_dir .. '/user.txt'),
}
--- vim辞書がなければダウンロード
if vim.fn.filereadable(cspell_files.vim) ~= 1 then
  local vim_dictionary_url = 'https://github.com/iamcco/coc-spell-checker/raw/master/dicts/vim/vim.txt.gz'
  io.popen('curl -fsSLo ' .. cspell_files.vim .. ' --create-dirs ' .. vim_dictionary_url)
end

-- ユーザー辞書がなければ作成
if vim.fn.filereadable(cspell_files.user) ~= 1 then
  io.popen('mkdir -p ' .. cspell_data_dir)
  io.popen('touch ' .. cspell_files.user)
end

-- cspellにwordを追加
local cspell_append = function(opts)
  local word = opts.args
  if not word or word == '' then
    -- 引数がなければcwordを取得
    word = vim.call('expand', '<cword>'):lower()
  end

  -- bangの有無で保存先を分岐
  local dictionary_name = opts.bang and 'dotfiles' or 'user'

  -- shellのechoコマンドで辞書ファイルに追記
  io.popen('echo ' .. word .. ' >> ' .. cspell_files[dictionary_name])

  -- 追加した単語および辞書を表示
  vim.notify('"' .. word .. '" is appended to ' .. dictionary_name .. ' dictionary.', vim.log.levels.INFO, {})

  -- cspellをリロードするため、現在行を更新してすぐ戻す
  if vim.api.nvim_get_option_value('modifiable', {}) then
    vim.api.nvim_set_current_line(vim.api.nvim_get_current_line())
    vim.api.nvim_command('silent! undo')
  end
end

vim.api.nvim_create_user_command('CSpellAppend', cspell_append, { nargs = '?', bang = true })

local cspell_custom_actions = {
  name = 'cspell-dictionary',
  method = null_ls.methods.CODE_ACTION,
  filetypes = {},
  generator = {
    fn = function(_)
      local lnum = vim.fn.getcurpos()[2] - 1
      local col = vim.fn.getcurpos()[3]
      local diagnostics = vim.diagnostic.get(0, { lnum = lnum })

      local word = ''
      local regex = '^%[%] Unknown word %((%w+)%) %(cspell%)'
      for _, v in pairs(diagnostics) do
        if v.source == 'cspell' and v.col < col and col <= v.end_col and string.match(v.message, regex) then
          word = string.gsub(v.message, regex, '%1'):lower()
          break
        end
      end

      if word == '' then
        return
      end

      return {
        {
          title = 'Append "' .. word .. '" to user dictionary',
          action = function()
            cspell_append({ args = word })
          end,
        },
        {
          title = 'Append "' .. word .. '" to dotfiles dictionary',
          action = function()
            cspell_append({ args = word, bang = true })
          end,
        },
      }
    end,
  },
}
null_ls.register(cspell_custom_actions)

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
  null_ls.builtins.diagnostics.cspell.with({
    diagnostics_postprocess = function(diagnostic)
      diagnostic.severity = vim.diagnostic.severity['WARN']
      local formatted = '[#{c}] #{m} (#{s})'
      formatted = formatted:gsub('#{m}', diagnostic.message)
      formatted = formatted:gsub('#{s}', diagnostic.source)
      formatted = formatted:gsub('#{c}', diagnostic.code or '')
      diagnostic.message = formatted
    end,
    condition = function()
      return vim.fn.executable('cspell') > 0
    end,
    extra_args = { '--config', cspell_files.config },
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
