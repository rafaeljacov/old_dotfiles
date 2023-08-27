-- This is necessary for VimTeX to load properly. The "indent" is optional.
-- Note that most plugin managers will do this automatically.
vim.cmd('filetype plugin indent on')

-- This enables Vim's and Neovim's syntax-related features. Without this, some
-- VimTeX features will not work.
vim.cmd('syntax enable')

-- Viewer options: One may configure the viewer either by specifying a built-in
-- viewer method:
-- vim.g.vimtex_view_method = 'zathura'

-- Or with a generic interface:
vim.g.vimtex_view_general_viewer = 'okular'
vim.g.vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'

-- VimTeX uses latexmk as the default compiler backend. You can comment out or remove
-- the following line, as VimTeX will automatically use the appropriate TeX Live
-- compiler (pdfTeX, XeTeX, or LuaTeX) based on the file's content.
-- vim.g.vimtex_compiler_method = 'latexrun'

-- Most VimTeX mappings rely on localleader and this can be changed with the
-- following line. The default is usually fine and is the symbol "\".
-- vim.g.maplocalleader = ','
