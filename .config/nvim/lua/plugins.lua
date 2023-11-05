return {
    -- Color Schemes
    'tiagovla/tokyodark.nvim',
    'AlexvZyl/nordic.nvim',
    { 'catppuccin/nvim', name = 'catppuccin' },

    'nvimdev/lspsaga.nvim',
    'onsails/lspkind.nvim',
    'mbbill/undotree',
    'tpope/vim-fugitive',
    'nvim-lualine/lualine.nvim',
    'lervag/vimtex',
    'barrett-ruth/live-server.nvim',
    {
        'kristijanhusak/vim-dadbod-ui',
        dependencies = {
            { 'tpope/vim-dadbod', lazy = true },
            { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
        },
        cmd = {
            'DBUI',
            'DBUIToggle',
            'DBUIAddConnection',
            'DBUIFindBuffer',
        },
        init = function()
            -- Your DBUI configuration
            vim.g.db_ui_use_nerd_fonts = 1
            vim.keymap.set('n', '<leader>DB', '<Cmd>DBUIToggle<cr>')
        end,
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function ()
            require('gitsigns').setup()
        end
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        dependencies = {
            'JoosepAlviste/nvim-ts-context-commentstring'
        }
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        }
    },
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        -- or                            , branch = '0.1.x',
        dependencies = { {'nvim-lua/plenary.nvim'} }
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},     -- Required
            {'hrsh7th/cmp-nvim-lua'},
            {'hrsh7th/cmp-buffer'},
            { 'saadparwaiz1/cmp_luasnip' },
            {'hrsh7th/cmp-path'},
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'L3MON4D3/LuaSnip', dependencies = {
                { 'rafamadriz/friendly-snippets' }
            }},     -- Required
        }
    },
    {
        'windwp/nvim-autopairs',
        config = function() require('nvim-autopairs').setup {} end
    },
    'windwp/nvim-ts-autotag',
    {
        'kylechui/nvim-surround',
        tag = '*', -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require('nvim-surround').setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
    },
    {'akinsho/bufferline.nvim', version = '*'},
    {
        'folke/which-key.nvim',
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 500
            require('which-key').setup {}
        end
    },
    {
        'norcalli/nvim-colorizer.lua',
        config = function ()
            require('colorizer').setup()
        end
    },
    {
        'glepnir/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('dashboard').setup {
                -- config
            }
        end,
        dependencies = {'nvim-tree/nvim-web-devicons'}
    },
}
