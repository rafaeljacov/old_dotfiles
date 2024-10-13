return {
    'folke/which-key.nvim',
    dependencies = {
        { 'echasnovski/mini.icons', version = false },
    },
    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 500
        require('mini.icons').setup()
        require('which-key').setup()
    end
}
