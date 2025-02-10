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
                null_ls.builtins.diagnostics.golangci_lint,
                null_ls.builtins.formatting.typstyle,
                null_ls.builtins.diagnostics.mypy,
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.clang_format,
                null_ls.builtins.formatting.prettier,
                null_ls.builtins.formatting.sqlfluff,
                null_ls.builtins.diagnostics.sqlfluff.with({
                    extra_args = { "--dialect", "postgres" }, -- change to your dialect
                }),
            }
        })

        vim.keymap.set('n', '<leader><cr>', vim.lsp.buf.format, { desc = "Format" })
    end
}
