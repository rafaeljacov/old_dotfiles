local builtin = require('telescope.builtin')

require('telescope').load_extension('fzf')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = 'Find Files'})
vim.keymap.set('n', '<leader>gf', builtin.git_files, {desc = 'Git Files'})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {desc = 'Live Grep'})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {desc = 'Find Help'})

vim.keymap.set('n', '<leader>sd', builtin.lsp_document_symbols, {desc = 'Show Document Symbols'})
vim.keymap.set('n', '<leader>sw', builtin.lsp_workspace_symbols, {desc = 'Show Workspace Symbols'})
