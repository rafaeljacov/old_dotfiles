---@diagnostic disable: missing-fields

return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
        'JoosepAlviste/nvim-ts-context-commentstring'
    },
    config = function()
        require 'nvim-treesitter.configs'.setup {
            -- A list of parser names, or "all" (the five listed parsers should always be installed)
            ensure_installed = {
                "c", "lua", "vim", "vimdoc",
                'astro', 'css', 'html', 'javascript',
                'python', 'scss', 'svelte', 'tsx',
                'typescript', 'vue', 'markdown',
                'markdown_inline', 'sql', 'hyprlang',
            },

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            auto_install = true,

            -- List of parsers to ignore installing (for "all")
            ignore_install = { "latex" },
            indent = { enable = true },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            autotag = {
                enable = true,
            },
            vim.filetype.add({
                pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
            })
        }
    end
}
