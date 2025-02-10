local capabilities = require('cmp_nvim_lsp').default_capabilities()

return {
    capabilities = capabilities,
    filetypes = { "html", "templ", "astro", "javascript", "typescript", "react" },
    settings = {
        emmet = {
            includeLanguages = {
                templ = "html",
            },
        },
    },
}
