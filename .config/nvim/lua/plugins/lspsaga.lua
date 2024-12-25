return {
    'nvimdev/lspsaga.nvim',
    opts = {},
    keys = {
        { "<leader>t",  "<Cmd>Lspsaga term_toggle<cr>",                desc = 'Toggle Terminal' },

        { '[d',         "<Cmd>Lspsaga diagnostic_jump_prev<cr>",       desc = 'Previous Diagnostic' },
        { ']d',         "<Cmd>Lspsaga diagnostic_jump_next<cr>",       desc = 'Next Diagnostic' },

        -- { 'K',          '<Cmd>Lspsaga hover_doc<cr>',                  desc = 'Show Details' },

        { '<leader>el', '<Cmd>Lspsaga show_line_diagnostics<cr>',      desc = 'Show Line Diagnostics' },
        { '<leader>ew', '<Cmd>Lspsaga show_workspace_diagnostics<cr>', desc = 'Show Workspace Diagnostics' },
        { '<leader>eb', '<Cmd>Lspsaga show_buf_diagnostics<cr>',       desc = 'Show Buffer Diagnostics' },
        { '<leader>ec', '<Cmd>Lspsaga show_cursor_diagnostics<cr>',    desc = 'Show Cursor Diagnostics' },

        { 'gd',         '<Cmd>Lspsaga goto_definition<cr>',            desc = 'Go to Definition' },
        { 'go',         '<Cmd>Lspsaga goto_type_definition<cr>',       desc = 'Go to Type Definition' },

        { '<leader>pd', '<Cmd>Lspsaga peek_definition<cr>',            desc = 'Peek Definition' },
        { '<leader>pt', '<Cmd>Lspsaga peek_type_definition<cr>',       desc = 'Peek Type Definition' },
        { "<leader>po", "<Cmd>Lspsaga outline<cr>",                    desc = 'Project Outline' },

        { '<leader>?',  '<Cmd>Lspsaga code_action<cr>',                desc = 'Code Actions' },

        { '<leader>gr', '<Cmd>Lspsaga finder<cr>',                     desc = 'Find References' },

        { '<leader>r',  '<Cmd>Lspsaga rename<cr>',                     desc = 'Rename Symbol' },
    }
}
