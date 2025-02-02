return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'main',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      {
        'zbirenbaum/copilot.lua',
        event = { 'InsertEnter', 'CmdlineEnter' },
        config = function()
          vim.defer_fn(function()
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
          end, 100)
        end,
      },
      { 'nvim-lua/plenary.nvim' },
    },
    opts = {
      debug = false,
    },
  },
}
