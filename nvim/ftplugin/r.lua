local opts = { buffer = true, silent = true }

-- Compile/Run
vim.keymap.set("n", "<C-T>", ":!R CMD BATCH '%' <CR>", opts)
vim.keymap.set("n", "<C-O>", ":!cat '%:p:r'.rout <CR>", opts)

-- Slime mappings
vim.keymap.set("n", ",l", "<Plug>SlimeLineSend", { buffer = true, remap = true })
vim.keymap.set("x", ",l", "<Plug>SlimeRegionSend", { buffer = true, remap = true })
vim.keymap.set("n", ",;", "<Plug>SlimeParagraphSend", { buffer = true, remap = true })

-- Tabs
vim.o.softtabstop=2
vim.o.shiftwidth=2
vim.o.tabstop=2
