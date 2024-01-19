vim.keymap.set({ 'i', 'n', 'v' }, "<C-s>", "<Esc><Cmd>w<cr>")

vim.keymap.set('i', "<C-v>", '<Esc>"+p==')

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set('x', '<leader>p', "\"_dP", { desc = "Paste and retain register" })
