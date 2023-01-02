-- jj = esc
vim.keymap.set('i', 'jj', '<ESC>', { noremap = true, silent = true })

-- pasteする際バッファを入れ替えない
vim.keymap.set({ 'n', 'x' }, 'p', 'P', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'P', 'p', { noremap = true, silent = true })

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
