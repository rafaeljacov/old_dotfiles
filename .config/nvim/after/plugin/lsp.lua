local lsp_zero = require('lsp-zero')
local lspconfig = require('lspconfig')

lsp_zero.on_attach(function(client, bufnr)
-- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
  lsp_zero.highlight_symbol(client, bufnr)
end)

vim.keymap.set('n', '<leader><CR>', '<Cmd>LspZeroFormat<cr>')

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'cssls',
    'tsserver',
    'emmet_ls',
    'html',
    'eslint',
    'clangd',
    'rust_analyzer',
    'texlab',
    'gopls',
    'pyright',
    'bashls',
    'lua_ls'
},
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
  }
})

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local lspkind = require('lspkind')

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
    sources = {
        { name = 'vim-dadbod-completion' },
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'luasnip' },
        { name = "path" },
        { name = "nvim_lua" }
    },
    preselect = 'item',
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
    mapping = cmp.mapping.preset.insert({
        -- confirm completion
        ['<C-y>'] = cmp.mapping.confirm({select = true}),

        -- scroll up and down the documentation window
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),

        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    }),
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol_text',  -- show symbol and text annotations
            maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
        })
    }
})

lspconfig.gopls.setup {
    cmd = {'gopls'},
    settings = {
        gopls = {
            usePlaceholders = true,
            analyses = {
                unusedparams = true
            }
        }
    }
}
