return {
    -- LSP Support
    { 'neovim/nvim-lspconfig' },
    { 'williamboman/mason.nvim' },
    {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            local lspconfig = require('lspconfig')

            -- Language Servers: (for Rust, see "plugins.rustaceanvim")
            -- mason-lspconfig
            local gopls = require("plugins.lsp.gopls")
            local htmx = require("plugins.lsp.htmx")
            local html = require("plugins.lsp.html")
            local emmet = require("plugins.lsp.emmet")
            -- lspconfig
            local nixd = require("plugins.lsp.nixd")

            -- add cmp_nvim_lsp capabilities settings to lspconfig
            -- this should be executed before you configure any language server
            local lspconfig_defaults = lspconfig.util.default_config
            lspconfig_defaults.capabilities = vim.tbl_deep_extend(
                'force',
                lspconfig_defaults.capabilities,
                require('cmp_nvim_lsp').default_capabilities()
            )

            -- Setup lsp using lspconfig
            lspconfig['lua_ls'].setup({}) -- use system installed lua_ls package for NixOS compat
            lspconfig.nixd.setup(nixd)

            -- Setup lsp using mason-lspconfig
            require('mason').setup({})
            require('mason-lspconfig').setup({
                automatic_installation = false,
                ensure_installed = {
                    'cssls',
                    'ts_ls',
                    'emmet_ls',
                    'html',
                    'htmx',
                    'eslint',
                    'clangd',
                    'templ',
                    'tailwindcss',
                    'gopls',
                    'pyright',
                    'bashls',
                    'tinymist',
                    'marksman'
                },
                handlers = {
                    function(server_name)
                        lspconfig[server_name].setup({})
                    end,
                    lua_ls = function()
                    end,
                    html = function()
                        lspconfig.html.setup(html)
                    end,
                    emmet_ls = function()
                        lspconfig.emmet_ls.setup(emmet)
                    end,
                    gopls = function()
                        lspconfig.gopls.setup(gopls)
                    end,
                    htmx = function()
                        lspconfig.htmx.setup(htmx)
                    end,
                },
            })
        end
    },
}
