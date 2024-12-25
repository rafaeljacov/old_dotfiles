local keymap = vim.keymap.set

keymap('i', "<C-v>", '<Esc>"+p==')

keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

keymap("n", "J", "mzJ`z")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

keymap("n", "Q", "<nop>")
keymap("n", "<leader>n", ":normal ")

keymap('x', '<leader>p', "\"_dP", { desc = "Paste and retain register" })
