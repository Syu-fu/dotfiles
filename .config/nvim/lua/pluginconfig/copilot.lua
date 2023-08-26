require('copilot').setup({
  suggestion = {
    auto_trigger = true,
    keymap = {
      accept = '<C-j>',
      accept_word = false,
      accept_line = false,
      next = '<C-S-n>',
      prev = '<C-S-p>',
      dismiss = '<C-S-]>',
    },
    filetypes = {
      gitcommit = true,
    },
  },
})

vim.api.nvim_command('highlight link CopilotAnnotation LineNr')
vim.api.nvim_command('highlight link CopilotSuggestion LineNr')
