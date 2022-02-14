local on_attach = function(client)
  vim.wo.signcolumn = 'yes'
  local maps = {
    {'n', '<c-]>',     '<cmd>lua vim.lsp.buf.definition()<CR>'},
    {'n', 'K',         '<cmd>lua vim.lsp.buf.hover()<CR>'},
    {'n', 'gD',        '<cmd>lua vim.lsp.buf.implementation()<CR>'},
    {'n', '1gD',       '<cmd>lua vim.lsp.buf.type_definition()<CR>'},
    {'n', 'gW',        '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>'},
    {'n', 'gd',        '<cmd>lua vim.lsp.buf.declaration()<CR>'},
    {'n', '<Leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>'},
    {'n', '<Leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>'},
    {'n', 'gl',        '<cmd>lua vim.lsp.buf.document_highlight()<CR>'},
    {'n', 'gm',        '<cmd>lua vim.diagnostic.open_float()<CR>'},
    {'n', 'g0',        '<cmd>Denite lsp/document_symbol -auto-action=highlight<CR>'},
    {'n', 'gr',        '<cmd>Denite lsp/references -auto-action=preview_bat<CR>'},
  }
  for _, map in ipairs(maps) do
    vim.api.nvim_buf_set_keymap(0, map[1], map[2], map[3], {noremap = true})
  end

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
    }
  )
  -- require "lsp_signature".on_attach({
  --   floating_window = false,
  -- })  -- Note: add in lsp client on-attach

  vim.api.nvim_exec(
  [[
    augroup MyLspSettings
      autocmd!
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
  ]],
  false)
end

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

require'lspconfig'.clangd.setup{on_attach = on_attach, capabilities = capabilities}
require'lspconfig'.pylsp.setup{on_attach = on_attach, capabilities = capabilities}
require'lspconfig'.rls.setup{on_attach = on_attach, capabilities = capabilities}
-- require'lspconfig'.texlab.setup{on_attach = on_attach, capabilities = capabilities}
require'lspconfig'.gopls.setup{on_attach = on_attach, capabilities = capabilities}
require'lspconfig'.denols.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    lint = true,
    unstable = true,
  },
}

local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
  local opts = {}

  if server.name == 'sumneko_lua' then
    opts.settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          path = vim.split(package.path, ';'),
        },
        diagnostics = {
          globals = {'vim'},
        },
        workspace = {
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          },
        },
      },
    }
  end

  opts.on_attach = on_attach
  opts.capabilities = capabilities
  server:setup(opts)
end)
