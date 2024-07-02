return {
    'nvimdev/lspsaga.nvim',
    config = function()
        require("lspsaga").setup()

        vim.keymap.set('n', "<leader>t", "<Cmd>Lspsaga term_toggle<cr>", { desc = 'Toggle Terminal' })

        vim.keymap.set('n', '[d', "<Cmd>Lspsaga diagnostic_jump_prev<cr>", { desc = 'Previous Diagnostic' })
        vim.keymap.set('n', ']d', "<Cmd>Lspsaga diagnostic_jump_next<cr>", { desc = 'Next Diagnostic' })

        vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<cr>', { desc = 'Show Details' })

        vim.keymap.set('n', '<leader>dl', '<Cmd>Lspsaga show_line_diagnostics<cr>', { desc = 'Show Line Diagnostics' })
        vim.keymap.set('n', '<leader>dw', '<Cmd>Lspsaga show_workspace_diagnostics<cr>',
            { desc = 'Show Workspace Diagnostics' })
        vim.keymap.set('n', '<leader>db', '<Cmd>Lspsaga show_buf_diagnostics<cr>', { desc = 'Show Buffer Diagnostics' })
        vim.keymap.set('n', '<leader>dc', '<Cmd>Lspsaga show_cursor_diagnostics<cr>', { desc = 'Show Cursor Diagnostics' })

        vim.keymap.set('n', 'gd', '<Cmd>Lspsaga goto_definition<cr>', { desc = 'Go to Definition' })
        vim.keymap.set('n', 'gt', '<Cmd>Lspsaga goto_type_definition<cr>', { desc = 'Go to Type Definition' })

        vim.keymap.set('n', '<leader>pd', '<Cmd>Lspsaga peek_definition<cr>', { desc = 'Peek Definition' })
        vim.keymap.set('n', '<leader>pt', '<Cmd>Lspsaga peek_type_definition<cr>', { desc = 'Peek Type Definition' })
        vim.keymap.set('n', "<leader>po", "<Cmd>Lspsaga outline<cr>", { desc = 'Project Outline' })

        vim.keymap.set('n', '<leader>?', '<Cmd>Lspsaga code_action<cr>', { desc = 'Code Actions' })

        vim.keymap.set('n', '<leader>fr', '<Cmd>Lspsaga finder<cr>', { desc = 'Find References' })

        vim.keymap.set('n', '<leader>r', '<Cmd>Lspsaga rename<cr>', { desc = 'Rename Symbol' })
    end
}
