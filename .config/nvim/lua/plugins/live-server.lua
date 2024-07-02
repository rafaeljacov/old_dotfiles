return {
    'barrett-ruth/live-server.nvim',
    build = "npm i -g live-server",
    ft = { 'html' },
    lazy = true,
    config = function()
        require('live-server').setup()

        vim.keymap.set('n', '<leader>ls', '<Cmd>LiveServerStart<cr>');
        vim.keymap.set('n', '<leader>lx', '<Cmd>LiveServerStop<cr>');
    end
}
