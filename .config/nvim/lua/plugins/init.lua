return {

    'onsails/lspkind.nvim',
    'tpope/vim-fugitive',
    'nanotee/zoxide.vim',
    'windwp/nvim-ts-autotag',
    { 'lewis6991/gitsigns.nvim', opts = {} },
    { 'numToStr/Comment.nvim',   opts = {} },
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy", -- Or `LspAttach`
        priority = 1000, -- needs to be loaded in first
        config = function()
            require('tiny-inline-diagnostic').setup()
            vim.diagnostic.config({ virtual_text = false })
        end
    }
}
