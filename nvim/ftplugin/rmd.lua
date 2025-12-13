local function bufmap(mode, lhs, rhs)
  vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, { noremap = true, silent = true })
end

bufmap("n", "<C-T>", ":!R -e \"rmarkdown::render('%:p')\"<CR>")
bufmap("n", "<C-O>", ":!open -a skim '%:p:r.pdf'<CR>")

vim.opt_local.filetype = "markdown"

-- tabs
vim.o.softtabstop=2
vim.o.shiftwidth=2
vim.o.tabstop=2
