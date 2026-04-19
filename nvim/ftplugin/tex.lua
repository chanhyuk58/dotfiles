local opts = { buffer = true, silent = true }

-- Tabs
vim.o.softtabstop=2
vim.o.shiftwidth=2
vim.o.tabstop=2

-- Compile/Run
vim.keymap.set("n", "<C-T>", ":!latexmk -pdflatex -quiet '%:p'<CR>", opts)
vim.keymap.set("n", "<C-C>", ":!latexmk -c '%:p'<CR>", opts)
vim.keymap.set("n", "<C-O>", ":!open -a skim '%:p:r.pdf'<CR>", opts)

-- Slime mappings
vim.keymap.set("n", ",l", "<Plug>SlimeLineSend", { buffer = true, remap = true })
vim.keymap.set("x", ",l", "<Plug>SlimeRegionSend", { buffer = true, remap = true })
vim.keymap.set("n", ",;", "<Plug>SlimeParagraphSend", { buffer = true, remap = true })
