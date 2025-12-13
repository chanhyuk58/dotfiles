local function bufmap(mode, lhs, rhs)
  vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, { noremap = true, silent = true })
end

bufmap("n", "<C-T>", ":!clang '%' -o '%:t:r'<CR>")
