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
    'jay-babu/mason-nvim-dap.nvim',
    'theHamsta/nvim-dap-virtual-text',
    { "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap"} },
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
            vim.keymap.set('n', '<leader>Db', '<Cmd>DBUIToggle<cr>')
        end,
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function ()
            require('gitsigns').setup()
        end
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        dependencies = {
            'JoosepAlviste/nvim-ts-context-commentstring'
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
        branch = 'v3.x',
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
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
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
    {
        'barrett-ruth/live-server.nvim',
        build = "npm i -g live-server",
        config = true,
        init = function()
            require('live-server').setup()
        end
    },
}
