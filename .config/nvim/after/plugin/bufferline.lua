require("bufferline").setup{
    options = {
        close_icon = "",
        buffer_close_icon = "",
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                separator = true -- use a "true" to enable the default, or set your own character
            },
        }
    }
}

vim.keymap.set({'v', 'n' }, '<leader>x', vim.cmd.bd, {desc = 'Close Current Buffer'})
vim.keymap.set({'v', 'n'}, '<Tab>', '<Cmd>BufferLineCycleNext<cr>')
vim.keymap.set({'v', 'n'}, '<S-Tab>', '<Cmd>BufferLineCyclePrev<cr>')

vim.keymap.set({'v', 'n'}, '<leader><Tab>', '<Cmd>BufferLinePick<cr>', {desc = 'Pick Buffer'})
