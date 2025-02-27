return {
  'kdheepak/lazygit.nvim',
  keys = {
    { '<Space>gg', ':LazyGit<CR>', silent = true },
  },
  init = function()
    if vim.fn.has('nvim') and vim.fn.executable('nvr') then
      vim.env.GIT_EDITOR = 'nvr -cc split --remote-wait +"set bufhidden=wipe"'
    end
  end,
  config = function()
    vim.g.lazygit_floating_window_scaling_factor = 0.97

    local bkey = vim.api.nvim_buf_set_keymap

    vim.api.nvim_create_augroup('LazygitKeyMapping', {})
    vim.api.nvim_create_autocmd('TermOpen', {
      group = 'LazygitKeyMapping',
      pattern = '*',
      callback = function()
        local filetype = vim.bo.filetype
        if filetype == 'lazygit' then
          bkey(0, 't', '<ESC>', '<ESC>', { silent = true })
          bkey(0, 't', '<C-v><ESC>', [[<C-\><C-n>]], { silent = true })
        end
      end,
    })
  end,
}
