local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>ha", function() harpoon:list():append() end, { desc = "Harpoon Append" })
vim.keymap.set("n", "<leader>hp", function() harpoon:list():prepend() end, { desc = "Harpoon Prepend" })
vim.keymap.set("n", "<leader>hm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon Menu" })

for i = 1, 9 do
    vim.keymap.set("n", string.format("<leader>h%d",i), function() harpoon:list():select(i) end, { desc = "select" })
end

-- Toggle previous & next buffers stored within Harpoon list
-- vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
-- vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
