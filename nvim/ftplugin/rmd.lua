local function bufmap(mode, lhs, rhs)
  vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, { noremap = true, silent = true })
end

-- Compile
bufmap("n", "<C-T>", ":!R -e \"rmarkdown::render('%:p')\"<CR>")
bufmap("n", "<C-O>", ":!open -a skim '%:p:r.pdf'<CR>")

-- Slime mappings
bufmap("n", ",l", "<Plug>SlimeLineSend")
bufmap("x", ",l", "<Plug>SlimeRegionSend")
bufmap("n", ",;", "<Plug>SlimeParagraphSend")

-- tabs
vim.o.softtabstop=2
vim.o.shiftwidth=2
vim.o.tabstop=2
