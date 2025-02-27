return {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-telescope/telescope.nvim", -- optional
        "neovim/nvim-lspconfig",         -- optional
    },
    opts = {
        server = {
            settings = {
                includeLanguages = {
                    templ = "html",
                },
            }
        }
    }, -- your configuration
    keys = {
        { "<leader>T", "<cmd>TailwindConcealToggle<cr>", { desc = "Toggle Classes" } }
    }
}
