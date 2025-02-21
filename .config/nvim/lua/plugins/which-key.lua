return {
    'folke/which-key.nvim',
    dependencies = {
        { 'echasnovski/mini.icons', version = false },
    },
    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 400
        require('mini.icons').setup()
        require('which-key').setup({
            preset = "helix"
        })
    end
}
