return {
  {
    'williamboman/mason.nvim',
    event = 'BufReadPre',
    config = function()
      require('mason').setup({
        ui = {
          icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗',
          },
        },
      })

      local packages = {
        'actionlint',
        'docker-compose-language-service',
        'dockerfile-language-server',
        'eslint-lsp',
        'golangci-lint-langserver',
        'gopls',
        'hadolint',
        'jq',
        'jq-lsp',
        'json-lsp',
        'lua-language-server',
        'markdownlint',
        'prettier',
        'python-lsp-server',
        'shellcheck',
        'shfmt',
        'stylelint-lsp',
        'stylua',
        'taplo',
        'typos-lsp',
        'vim-language-server',
        'vint',
        'vtsls',
        'yaml-language-server',
        'yamllint',
      }

      local registry = require('mason-registry')

      registry.refresh(function()
        for _, pkg_name in ipairs(packages) do
          local pkg = registry.get_package(pkg_name)
          if not pkg:is_installed() then
            pkg:install()
          end
        end
      end)
    end,
  },
  {
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    config = function()
      local signs = { Error = '', Warn = ' ', Hint = '', Info = ' ' }
      for type, icon in pairs(signs) do
        local hl = 'DiagnosticSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
    end,
    dependencies = {
      { 'b0o/schemastore.nvim' },
      {
        'williamboman/mason-lspconfig.nvim',
        config = function()
          local function format_diagnostics(diag)
            if diag.code then
              return string.format('[%s](%s): %s', diag.source, diag.code, diag.message)
            else
              return string.format('[%s]: %s', diag.source, diag.message)
            end
          end

          vim.diagnostic.config({
            underline = true,
            update_in_insert = true,
            float = {
              focusable = true,
              border = 'rounded',
              format = format_diagnostics,
              header = {},
              source = true,
              scope = 'line',
            },
            signs = true,
            severity_sort = true,
          })

          local lspconfig = require('lspconfig')

          ---@param names string[]
          ---@return string[]
          local function get_plugin_paths(names)
            local plugins = require('lazy.core.config').plugins
            local paths = {}
            for _, name in ipairs(names) do
              if plugins[name] then
                table.insert(paths, plugins[name].dir .. '/lua')
              else
                vim.notify('Invalid plugin name: ' .. name)
              end
            end
            return paths
          end

          ---@param plugins string[]
          ---@return string[]
          local function library(plugins)
            local paths = get_plugin_paths(plugins)
            table.insert(paths, vim.fn.stdpath('config') .. '/lua')
            table.insert(paths, vim.env.VIMRUNTIME .. '/lua')
            table.insert(paths, '${3rd}/luv/library')
            table.insert(paths, '${3rd}/busted/library')
            table.insert(paths, '${3rd}/luassert/library')
            return paths
          end

          require('mason-lspconfig').setup_handlers({
            function(server_name)
              lspconfig[server_name].setup({})
            end,
            ['lua_ls'] = function()
              lspconfig.lua_ls.setup({
                settings = {
                  Lua = {
                    diagnostics = {
                      globals = { 'vim' },
                    },
                    runtime = {
                      version = 'LuaJIT',
                      pathStrict = true,
                      path = { '?.lua', '?/init.lua' },
                    },
                    workspace = {
                      library = library({ 'lazy.nvim' }),
                      checkThirdParty = 'Disable',
                    },
                  },
                },
              })
            end,
            ['jsonls'] = function()
              lspconfig.jsonls.setup({
                schemaStore = {
                  enable = false,
                },
                schemas = require('schemastore').json.schemas(),
              })
            end,
            ['yamlls'] = function()
              lspconfig.yamlls.setup({
                schemaStore = {
                  enable = false,
                },
                schemas = require('schemastore').yaml.schemas(),
              })
            end,
            ['gopls'] = function()
              lspconfig.gopls.setup({
                settings = {
                  gopls = {
                    gofumpt = true,
                  },
                },
              })
            end,
            ['stylelint_lsp'] = function()
              lspconfig.stylelint_lsp.setup({
                filetypes = { 'css', 'scss', 'sass', 'less' },
              })
            end,
            ['denols'] = function()
              lspconfig.denols.setup({
                auto_start = lspconfig.util.root_pattern('deno.json') == nil,
                root_dir = lspconfig.util.root_pattern('deno.json', 'tsconfig.json', '.git'),
                init_options = {
                  lint = true,
                  unstable = true,
                },
              })
            end,
            ['vtsls'] = function()
              lspconfig.vtsls.setup({
                single_file_support = false,
                auto_start = lspconfig.util.root_pattern('deno.json') ~= nil,
                root_dir = lspconfig.util.root_pattern('package.json', 'node_modules'),
              })
            end,
            ['eslint'] = function()
              lspconfig.eslint.setup({
                auto_start = lspconfig.util.root_pattern('deno.json') ~= nil,
                root_dir = lspconfig.util.root_pattern('package.json', 'node_modules'),
              })
            end,
          })
        end,
      },
    },
    lazy = true,
  },
}
