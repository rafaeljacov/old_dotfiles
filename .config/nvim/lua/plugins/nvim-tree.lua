return {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
        'nvim-tree/nvim-web-devicons', -- optional
    },
    config = function()
        require("nvim-tree").setup({
            view = {
                number = true,
                relativenumber = true
            },
            renderer = {
                root_folder_label = false
            }
        })

        vim.keymap.set({ 'n', 'v' }, "<C-n>", '<Cmd>NvimTreeToggle<cr>', { desc = "File Explorer" })
    end
}
