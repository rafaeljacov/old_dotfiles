return {
    'Wansmer/treesj',
    config = function()
        require('treesj').setup {
            use_default_keymaps = false,
            vim.keymap.set('n', '<leader>m', '<cmd>TSJToggle<cr>', { desc = 'Toggle Split/Join Block' })
        }
    end
}
