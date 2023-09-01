vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<leader>o', ':normal o<CR>k', {desc =  "Insert Line Below"})
vim.keymap.set('n', '<leader>O', ':normal O<CR>j', {desc =  "Insert Line Above"})

vim.keymap.set({ 'i', 'n', 'v' }, "<C-s>", "<Esc><Cmd>w<cr>")

vim.keymap.set('i', "<C-v>", '<Esc>"+p==')

vim.keymap.set('i', "<C-j>", '<Esc>la')

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set('x', '<leader>p', "\"_dP", { desc = "Paste and retain register" })
