local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>ha", function() harpoon:list():append() end, { desc = "Harpoon Append" })
vim.keymap.set("n", "<leader>hp", function() harpoon:list():prepend() end, { desc = "Harpoon Prepend" })
vim.keymap.set("n", "<leader>H", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon Menu" })

vim.keymap.set("n", "1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "4", function() harpoon:list():select(4) end)
vim.keymap.set("n", "5", function() harpoon:list():select(5) end)
vim.keymap.set("n", "6", function() harpoon:list():select(6) end)
vim.keymap.set("n", "7", function() harpoon:list():select(7) end)
vim.keymap.set("n", "8", function() harpoon:list():select(8) end)
vim.keymap.set("n", "9", function() harpoon:list():select(9) end)

-- Toggle previous & next buffers stored within Harpoon list
-- vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
-- vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
