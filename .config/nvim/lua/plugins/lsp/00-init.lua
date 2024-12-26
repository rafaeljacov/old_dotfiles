return {
    -- LSP Support
    { 'neovim/nvim-lspconfig' },
    { 'williamboman/mason.nvim' },
    {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            local lspconfig = require('lspconfig')

            -- Language Servers: (for Rust, see "plugins.rustaceanvim")
            local gopls = require("plugins.lsp.gopls")
            local tailwindcss = require("plugins.lsp.tailwindcss")

            -- add cmp_nvim_lsp capabilities settings to lspconfig
            -- this should be executed before you configure any language server
            local lspconfig_defaults = lspconfig.util.default_config
            lspconfig_defaults.capabilities = vim.tbl_deep_extend(
                'force',
                lspconfig_defaults.capabilities,
                require('cmp_nvim_lsp').default_capabilities()
            )
            require('mason').setup({})
            require('mason-lspconfig').setup({
                automatic_installation = false,
                ensure_installed = {
                    'cssls',
                    'ts_ls',
                    'emmet_ls',
                    'html',
                    -- 'htmx', not compatible
                    'eslint',
                    -- 'clangd', use termux pkg instead
                    'templ',
                    'tailwindcss',
                    'gopls',
                    'pyright',
                    'bashls',
                    -- 'lua_ls', use termux pkg instead
                    'marksman'
                },
                handlers = {
                    function(server_name)
                        lspconfig[server_name].setup({})
                    end,
                    gopls = function()
                        lspconfig.gopls.setup(gopls)
                    end,
                    tailwindcss = function()
                        lspconfig.tailwindcss.setup(tailwindcss)
                    end,
                },
            })
        end
    },
}
