return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },             -- Required
        { 'williamboman/mason.nvim' },           -- Optional
        { 'williamboman/mason-lspconfig.nvim' }, -- Optional

        -- Autocompletion
        { 'hrsh7th/nvim-cmp' }, -- Required
        { 'hrsh7th/cmp-nvim-lua' },
        { 'hrsh7th/cmp-buffer' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-nvim-lsp' }, -- Required
        {
            'L3MON4D3/LuaSnip',
            dependencies = {
                { 'rafamadriz/friendly-snippets' }
            }
        }, -- Required
    },
    config = function()
        local lsp_zero = require('lsp-zero')

        lsp_zero.on_attach(function(client, bufnr)
            -- see :help lsp-zero-keybindings
            -- to learn the available actions
            lsp_zero.default_keymaps({ buffer = bufnr })
            lsp_zero.highlight_symbol(client, bufnr)
        end)

        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = {
                'cssls',
                'ts_ls',
                'emmet_ls',
                'html',
                'htmx',
                'eslint',
                'clangd',
                -- 'rust_analyzer',
                -- 'texlab',
                'templ',
                'tailwindcss',
                'gopls',
                'pyright',
                'bashls',
                'lua_ls',
                'marksman'
            },
            handlers = {
                lsp_zero.default_setup,
                lua_ls = function()
                    local lua_opts = lsp_zero.nvim_lua_ls()
                    require('lspconfig').lua_ls.setup(lua_opts)
                end,
            }
        })

        require('luasnip.loaders.from_vscode').lazy_load()

        local cmp = require('cmp')
        local cmp_action = require('lsp-zero').cmp_action()
        local lspkind = require('lspkind')

        -- If you want insert `(` after select function or method item
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        cmp.event:on(
            'confirm_done',
            cmp_autopairs.on_confirm_done()
        )

        cmp.setup({
            sources = {
                { name = 'vim-dadbod-completion' },
                { name = 'nvim_lsp' },
                { name = 'buffer' },
                { name = 'luasnip' },
                { name = "path" },
                { name = "nvim_lua" }
            },
            preselect = 'item',
            completion = {
                completeopt = 'menu,menuone,noinsert'
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                -- confirm completion
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),

                -- scroll up and down the documentation window
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),

                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                ['<C-b>'] = cmp_action.luasnip_jump_backward(),
            }),
            formatting = {
                fields = { 'abbr', 'kind' },
                expandable_indicator = true,
                format = lspkind.cmp_format({
                    mode = 'symbol_text',  -- show symbol and text annotations
                    -- maxwidth = 70,         -- prevent the popup from showing more than provided characters
                    ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                    before = function(_, vim_item)
                        vim_item.menu = ""
                        return vim_item
                    end
                }),
            }
        })

        local lspconfig = require('lspconfig')
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        local util = require('lspconfig/util')

        -- Go
        lspconfig.gopls.setup {
            capabilities = capabilities,
            cmd = { 'gopls' },
            filetypes = { "go", "gomod", "gowork", "gotmpl", "templ" },
            root_dir = util.root_pattern('go.work', 'go.mod', '.git'),
            settings = {
                gopls = {
                    usePlaceholders = true,
                    analyses = {
                        unusedparams = true
                    }
                }
            }
        }

        -- Tailwind CSS
        lspconfig.tailwindcss.setup({
            capabilities = capabilities,
            settings = {
                tailwindCSS = {
                    includeLanguages = {
                        templ = "html",
                    },
                },
            },
        })

        -- Rust
        lspconfig.rust_analyzer.setup({
            -- on_attach = function(_, bufnr)
            --     vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            -- end,
            capabilities = capabilities,
            settings = {
                ["rust-analyzer"] = {
                    imports = {
                        granularity = {
                            group = "module",
                        },
                        prefix = "self",
                    },
                    cargo = {
                        buildScripts = {
                            enable = true,
                        },
                    },
                    procMacro = {
                        enable = true
                    },
                    check = {
                        command = "clippy"
                    }
                }
            }
        })
    end
}
