vim.keymap.set('n', '<Space>b', '<Cmd>Telescope buffers<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Space>p', '<Cmd>Telescope git_files<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Space>h', '<Cmd>Telescope help_tags<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Space>a', '<Cmd>Telescope live_grep<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Space>d', '<Cmd>Telescope diagnostics<CR>', { noremap = true, silent = true })
-- git
vim.keymap.set(
  'n',
  '<Space>gs',
  "<Cmd>lua require('telescope.builtin').git_status()<CR>",
  { noremap = true, silent = true }
)
vim.keymap.set(
  'n',
  '<Space>gl',
  "<Cmd>lua require('telescope.builtin').git_commits()<CR>",
  { noremap = true, silent = true }
)
vim.keymap.set(
  'n',
  '<Space>gC',
  "<Cmd>lua require('telescope.builtin').git_bcommits()<CR>",
  { noremap = true, silent = true }
)
vim.keymap.set(
  'n',
  '<Space>gb',
  "<Cmd>lua require('telescope.builtin').git_branches()<CR>",
  { noremap = true, silent = true }
)
-- github
vim.keymap.set('n', '<Space>gi', '<Cmd>Telescope gh issues<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Space>gp', '<Cmd>Telescope gh pull_request<CR>', { noremap = true, silent = true })
