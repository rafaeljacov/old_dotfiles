local capabilities = require('cmp_nvim_lsp').default_capabilities()
local util = require('lspconfig/util')

return {
    capabilities = capabilities,
    cmd = { 'gopls' },
    filetypes = { "go", "gomod", "gowork", "gotmpl", "templ" },
    root_dir = util.root_pattern('go.work', 'go.mod', '.git'),
    settings = {
        gopls = {
            usePlaceholders = true,
            analyses = {
                unusedparams = true
            }
        }
    }
}
