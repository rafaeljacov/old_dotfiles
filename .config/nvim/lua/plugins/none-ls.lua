return {
    'nvimtools/none-ls.nvim',
    dependencies = {
        'nvimtools/none-ls-extras.nvim',
    },
    config = function()
        local null_ls = require('null-ls')

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.gofumpt,
                null_ls.builtins.formatting.goimports,
                null_ls.builtins.diagnostics.mypy,
            }
        })

        vim.keymap.set('n', '<leader><cr>', vim.lsp.buf.format, { desc = "Format" })
    end
}
