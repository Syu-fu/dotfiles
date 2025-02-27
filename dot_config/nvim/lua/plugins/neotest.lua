return {
  {
    'nvim-neotest/neotest',
    event = 'VeryLazy',
    config = function()
      vim.keymap.set('n', '<space>,', '<cmd>lua Neotest_watch()<cr>', { silent = true, desc = 'neotest summary' })
      require('neotest').setup({
        adapters = {
          require('neotest-golang')({
            runner = 'gotestsum',
            go_test_args = {
              '-v',
              '-race',
              '-count=1',
              '-coverprofile=' .. vim.fn.getcwd() .. '/coverage.out',
            },
          }),
        },
      })
      local neotest = require('neotest')
      function Neotest_watch()
        local test_file = Test_file_name()
        neotest.watch.watch(test_file)
        neotest.summary.toggle()
      end
      function Test_file_name()
        if vim.bo.filetype == 'go' then
          -- _test.goでない場合は_test.goをwatchする
          if not vim.fn.expand('%:t'):match('_test.go') then
            return vim.fn.expand('%:r') .. '_test.go'
          else
            return vim.fn.expand('%')
          end
        else
          return vim.fn.expand('%')
        end
      end
    end,
  },
  {
    'nvim-neotest/nvim-nio',
    lazy = true,
  },
  {
    'antoinemadec/FixCursorHold.nvim',
    lazy = true,
  },
  {
    'fredrikaverpil/neotest-golang',
    lazy = true,
  },
}
