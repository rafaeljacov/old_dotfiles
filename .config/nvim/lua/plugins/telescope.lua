local builtin = require('telescope.builtin')
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
    keys = {
        { '<leader>ff', builtin.find_files,            desc = 'Find Files' },
        { '<leader>gf', builtin.git_files,             desc = 'Git Files' },
        { '<leader>fg', builtin.live_grep,             desc = 'Live Grep' },
        { '<leader>fh', builtin.help_tags,             desc = 'Find Help' },

        { '<leader>sd', builtin.lsp_document_symbols,  desc = 'Show Document Symbols' },
        { '<leader>sw', builtin.lsp_workspace_symbols, desc = 'Show Workspace Symbols' },
    },
    config = function ()
        require('telescope').load_extension('fzf')
    end
}
