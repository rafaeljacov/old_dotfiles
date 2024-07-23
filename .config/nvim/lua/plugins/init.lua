return {
    { "folke/neodev.nvim",    opts = {} },

    'onsails/lspkind.nvim',
    'tpope/vim-fugitive',

    -- Debugger
    { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
    'jay-babu/mason-nvim-dap.nvim',
    'theHamsta/nvim-dap-virtual-text',

    { 'lewis6991/gitsigns.nvim', opts = {} },
    {'numToStr/Comment.nvim', opts = {}},
    {'windwp/nvim-autopairs', event = "InsertEnter", opts = {}},
    'windwp/nvim-ts-autotag',
}
