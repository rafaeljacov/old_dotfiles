return {
    -- Autocompletion
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
    },
    {
        'hrsh7th/nvim-cmp',
        opts = function(_, opts)
            opts.sources = opts.sources or {}
            table.insert(opts.sources, {
                name = "lazydev",
                group_index = 0, -- set group index to 0 to skip loading LuaLS completions
            })
        end,
        config = function()
            local cmp = require('cmp')
            local lspkind = require('lspkind')
            require('luasnip.loaders.from_vscode').lazy_load()

            -- if you want insert `(` after select function or method item
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
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    -- confirm completion
                    ['<c-y>'] = cmp.mapping.confirm({ select = true }),

                    -- scroll up and down the documentation window
                    ['<c-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<c-d>'] = cmp.mapping.scroll_docs(4),

                    ['<c-space>'] = cmp.mapping.complete(),
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
        end
    },
}
