require 'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        disable = {
            'toml',
        }
    },
    ensure_installed = {
        'bash',
        'css',
        'dockerfile',
        'go',
        'gomod',
        'graphql',
        'html',
        'javascript',
        'jsdoc',
        'json',
        'json5',
      --  'JSON with Comment',
        'python',
        'typescript',
        'tsx',
        'yaml',
        'vim'
    }
}
