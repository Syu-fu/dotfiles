--vim.cmd([[
-- function! s:select_type() abort
--   let line = substitute(getline('.'), '^;\s*', '', 'g')
--   let title = printf('%s: ', split(line, ' ')[0])
--   silent! normal! "_dip
--   silent! put! =title
--   silent! startinsert!
-- endfunction
-- nnoremap <buffer> <CR><CR> <Cmd>call <SID>select_type()<CR>
--]])
-- lua
function Select_type()
  local line = vim.fn.substitute(vim.fn.getline('.'), '^;s*', '', 'g')
  local title = string.format('%s: ', vim.fn.split(line, ' ')[1])
  vim.cmd('silent! normal! "_dip')
  vim.cmd('silent! put! =' .. title)
  vim.cmd('silent! startinsert!')
end
vim.api.nvim_buf_set_keymap(0, 'n', '<CR><CR>', '<Cmd>lua Select_type()<CR>', { noremap = true, silent = true })
