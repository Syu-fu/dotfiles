function Go_org_imports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { 'source.organizeImports' } }
  local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, wait_ms)
  for cid, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or 'utf-16'
        vim.lsp.util.apply_workspace_edit(r.edit, enc)
      end
    end
  end
end

local augroup = vim.api.nvim_create_augroup('GoSave', { clear = true })

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.go' },
  group = augroup,
  callback = function()
    Go_org_imports(500)
    vim.lsp.buf.formatting_sync(nil, 500)
  end,
})

vim.opt_local.expandtab = false