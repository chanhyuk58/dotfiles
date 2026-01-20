local opts = { buffer = true, silent = true }

-- Slime mappings
vim.keymap.set("n", ",l", "<Plug>SlimeLineSend", { buffer = true, remap = true })
vim.keymap.set("x", ",l", "<Plug>SlimeRegionSend", { buffer = true, remap = true })
vim.keymap.set("n", ",;", "<Plug>SlimeParagraphSend", { buffer = true, remap = true })
