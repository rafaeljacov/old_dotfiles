local macro_group = vim.api.nvim_create_augroup('MacroRecording', { clear = true })
vim.api.nvim_create_autocmd('RecordingLeave', {
    group = macro_group,
    callback = function()
        -- Display a message when macro recording stops
        print('Macro recording done ')
    end,
})

return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        -- you can enable a preset for easier configuration
        presets = {
            bottom_search = true,         -- use a classic bottom cmdline for search
            command_palette = true,       -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            lsp_doc_border = false,       -- add a border to hover docs and signature help
        },
        routes = {
            {
                view = "mini",
                filter = {
                    event = "msg_showmode",
                    any = {
                        { find = "recording" },
                    }
                },
            },
        },
    },
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
}
