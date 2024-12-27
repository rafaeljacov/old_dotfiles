return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
        },
    },
    init = function ()
        require('telescope').setup{}
    end,
    config = function ()
        require('telescope').load_extension('fzf')
        local builtin = require('telescope.builtin')
        local map = vim.keymap.set

        map('n', '<leader>ff', builtin.find_files,            { desc = 'Find Files' })
        map('n', '<leader>gf', builtin.git_files,             { desc = 'Git Files' })
        map('n', '<leader>fg', builtin.live_grep,             { desc = 'Live Grep' })
        map('n', '<leader>fh', builtin.help_tags,             { desc = 'Find Help' })

        map('n', '<leader>sd', builtin.lsp_document_symbols,  { desc = 'Show Document Symbols' })
        map('n', '<leader>sw', builtin.lsp_workspace_symbols, { desc = 'Show Workspace Symbols' })
    end
}
