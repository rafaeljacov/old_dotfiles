require("nvim-tree").setup({
    view = {
        number = true,
        relativenumber = true
    },
    renderer = {
        root_folder_label = false
    }
})

vim.keymap.set({ 'n', 'v' }, "<C-n>", '<Cmd>NvimTreeToggle<cr>', {desc = "File Explorer"})
