require('live-server').setup()

vim.keymap.set('n', '<leader>ls', '<Cmd>LiveServerStart<cr>');
vim.keymap.set('n', '<leader>lx', '<Cmd>LiveServerStop<cr>');
