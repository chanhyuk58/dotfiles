local function bufmap(mode, lhs, rhs)
  vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, { noremap = true, silent = true })
end

-- Compile
bufmap("n", "<C-T>", ":!latexmk -pdflatex -quiet '%:p'<CR>")
bufmap("n", "<C-C>", ":!latexmk -c '%:p'<CR>")
bufmap("n", "<C-O>", ":!open -a skim '%:p:r.pdf'<CR>")

-- Slime mappings (optional)
bufmap("n", ",l", "<Plug>SlimeLineSend")
bufmap("x", ",l", "<Plug>SlimeRegionSend")
bufmap("n", ",;", "<Plug>SlimeParagraphSend")
