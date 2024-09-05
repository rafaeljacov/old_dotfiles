return {
    'barrett-ruth/live-server.nvim',
    build = "npm i -g live-server",
    ft = { 'html' },
    lazy = true,
    opts = {},
    keys = {
        { '<leader>ls', '<Cmd>LiveServerStart<cr>' },
        { '<leader>lx', '<Cmd>LiveServerStop<cr>' },
    }
}
