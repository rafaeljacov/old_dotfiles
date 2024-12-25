return {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false,   -- This plugin is already lazy
    config = function()
        -- Update this path
        local extension_path = vim.env.HOME .. '/.local/share/nvim/mason/packages/codelldb/extension/'
        local codelldb_path = extension_path .. 'adapter/codelldb'
        local liblldb_path = extension_path .. 'lldb/lib/liblldb'
        local this_os = vim.uv.os_uname().sysname;

        -- The path is different on Windows
        if this_os:find "Windows" then
            codelldb_path = extension_path .. "adapter\\codelldb.exe"
            liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
        else
            -- The liblldb extension is .so for Linux and .dylib for MacOS
            liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
        end

        local cfg = require('rustaceanvim.config')
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
                adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
            },
        }
    end
}
