vim.api.nvim_create_augroup('ime_ctrl', { clear = true })
vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
  group = 'ime_ctrl',
  pattern = '*',
  callback = function()
    if vim.fn.has('linux') == 1 then
      local input_status = vim.fn.system('fcitx-remote')
      if input_status == '2\n' then
        vim.fn.system('fcitx-remote -c')
      end
    end
  end,
  once = false,
})
