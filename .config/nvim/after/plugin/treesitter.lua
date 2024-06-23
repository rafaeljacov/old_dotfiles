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

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    -- List of parsers to ignore installing (for "all")
    ignore_install = { "latex" },

    highlight = {
        enable = true,

        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
    autotag = {
        enable = true,
    },
    vim.filetype.add({
        pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
    })
}
