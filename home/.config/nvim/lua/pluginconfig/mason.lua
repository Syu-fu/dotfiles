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
  'jsonnet-language-server',
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
