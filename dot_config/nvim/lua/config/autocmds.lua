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

-- memo auto commit
vim.api.nvim_create_augroup('memo_auto_pull_push', { clear = true })
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  group = 'memo_auto_pull_push',
  pattern = '*.md',
  callback = function()
    local memo_dir = os.getenv('MEMODIR')
    if memo_dir then
      local current_dir = vim.fn.expand('%:p:h')
      if current_dir == memo_dir then
        local last_commit_time = vim.fn.system('git log -1 --format=%ct')
        local current_time = os.time()
        local diff_time = current_time - tonumber(last_commit_time)
        vim.notify(
          'diff_time: ' .. diff_time .. '\ncurrent_time:' .. current_time .. '\nlast_commit_time:' .. last_commit_time,
          vim.log.levels.INFO,
          { title = 'auto commit' }
        )
        if diff_time > 60 * 60 then
          vim.fn.system('memo pull && memo push')
          if vim.v.shell_error == 0 then
            vim.notify('memo pull & push success', vim.log.levels.INFO, { title = 'auto commit' })
          else
            vim.notify('memo pull & push failed', vim.log.levels.ERROR, { title = 'auto commit' })
          end
        end
      end
    end
  end,
  once = false,
})

-- Chezmoi auto apply
vim.api.nvim_create_augroup('chezmoi_auto_apply', { clear = true })
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  group = 'chezmoi_auto_apply',
  pattern = os.getenv('HOME') .. '/.local/share/chezmoi/*',
  callback = function()
    vim.fn.system('chezmoi apply')
    if vim.v.shell_error == 0 then
      vim.notify('chezmoi apply success', vim.log.levels.INFO, { title = 'auto apply' })
    else
      vim.notify('chezmoi apply failed', vim.log.levels.ERROR, { title = 'auto apply' })
    end
  end,
  once = false,
})
