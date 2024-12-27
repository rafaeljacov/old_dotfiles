return {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false,   -- This plugin is already lazy
    config = function()
        vim.g.rustaceanvim = {
            -- Plugin configuration
            tools = {
            },
            -- LSP configuration
            server = {
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
                default_settings = {
                    -- rust-analyzer language server configuration
                    ["rust-analyzer"] = {
                        imports = {
                            granularity = {
                                group = "module",
                            },
                            prefix = "self",
                        },
                        cargo = {
                            buildScripts = {
                                enable = true,
                            },
                        },
                        procMacro = {
                            enable = true
                        },
                        check = {
                            command = "clippy"
                        }
                    }
                },
                on_attach = function(client, bufnr)
                    local function toggle_inlay_hints()
                        local toggle = not vim.lsp.inlay_hint.is_enabled()
                        vim.lsp.inlay_hint.enable(toggle)
                    end

                    vim.keymap.set('n', '<leader>ih', toggle_inlay_hints, { desc = "Toggle inlay hints" })
                end,
            },
            -- DAP configuration
            dap = {
            },
        }
    end
}
