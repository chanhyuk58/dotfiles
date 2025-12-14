local function bufmap(mode, lhs, rhs)
  vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, { noremap = true, silent = true })
end

-- Slime mappings (optional)
bufmap("n", ",l", "<Plug>SlimeLineSend")
bufmap("x", ",l", "<Plug>SlimeRegionSend")
bufmap("n", ",;", "<Plug>SlimeParagraphSend")
