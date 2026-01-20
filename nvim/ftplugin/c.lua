local opts = { buffer = true, silent = true }

-- Compile/Run
vim.keymap.set("n", "<C-T>", ":!clang '%' -o '%:t:r'<CR>", opts)
