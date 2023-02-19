-- jj = esc
vim.keymap.set('i', 'jj', '<ESC>', { noremap = true, silent = true })

-- pasteする際バッファを入れ替えない
vim.keymap.set('x', 'p', 'P', { noremap = true, silent = true })
vim.keymap.set('x', 'P', 'p', { noremap = true, silent = true })

-- Spaceでカーソルを動かさない
vim.keymap.set({ 'n', 'x' }, '<Space>', '<Nop>', { noremap = true, silent = true })

-- 折返しの挙動を変更
vim.keymap.set({ 'n', 'x' }, 'j', 'gj', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'k', 'gk', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'gj', 'j', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'gk', 'k', { noremap = true, silent = true })

-- 検索ハイライトを解除
vim.keymap.set('n', '<ESC><ESC>', ':nohlsearch<CR>', { noremap = false, silent = true })

-- Terminal
vim.keymap.set('t', '<ESC>', '<C-\\><C-n>', { noremap = false, silent = true })

-- Lspの設定(null-lsのみ起動の場合でも動作するようにこちらに置く)
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-K>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', { noremap = true, silent = true })
vim.keymap.set(
  'n',
  '<space>wr',
  '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',
  { noremap = true, silent = true }
)
vim.keymap.set(
  'n',
  '<space>wl',
  '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
  { noremap = true, silent = true }
)
vim.keymap.set('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', ';a', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', { noremap = true, silent = true })
