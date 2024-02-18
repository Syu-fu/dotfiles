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
      require('pluginconfig/nvim-lspconfig')
    end,
    dependencies = {
      { 'b0o/schemastore.nvim' },
      {
        'williamboman/mason-lspconfig.nvim',
        config = function()
          -- Use an on_attach function to only map the following keys
          -- after the language server attaches to the current buffer
          local on_attach = function(_, bufnr)
            local function buf_set_option(...)
              vim.api.nvim_buf_set_option(bufnr, ...)
            end

            -- Enable completion triggered by <c-x><c-o>
            buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
          end

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

          local capabilities = require('ddc_source_lsp').make_client_capabilities()

          require('mason-lspconfig').setup_handlers({
            function(server_name)
              lspconfig[server_name].setup({ capabilities = capabilities, on_attach = on_attach })
            end,
            ['lua_ls'] = function()
              lspconfig.lua_ls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
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
                capabilities = capabilities,
                on_attach = on_attach,
                schemaStore = {
                  enable = false,
                },
                schemas = require('schemastore').json.schemas(),
              })
            end,
            ['yamlls'] = function()
              lspconfig.yamlls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                schemaStore = {
                  enable = false,
                },
                schemas = require('schemastore').yaml.schemas(),
              })
            end,
            ['gopls'] = function()
              lspconfig.gopls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                  gopls = {
                    gofumpt = true,
                  },
                },
              })
            end,
            ['stylelint_lsp'] = function()
              lspconfig.stylelint_lsp.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                filetypes = { 'css', 'scss', 'sass', 'less' },
              })
            end,
          })
        end,
      },
    },
    lazy = true,
  },
}
