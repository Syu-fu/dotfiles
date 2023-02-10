vim.keymap.set('n', '<Space>b', '<Cmd>Telescope buffers<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Space>p', '<Cmd>Telescope project_files<CR>', { noremap = true, silent = true })
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
vim.keymap.set('n', '<Space>gt', '<Cmd>Telescope gitcommand<CR>', { noremap = true, silent = true })

-- memo
vim.keymap.set('n', '<Space>ml', '<Cmd>Telescope memo list<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Space>mg', '<Cmd>Telescope memo grep<CR>', { noremap = true, silent = true })

--file_browser
vim.keymap.set('n', '<Space>l', '<Cmd>Telescope file_browser<CR>', { noremap = true, silent = true })
