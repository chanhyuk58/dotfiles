-- remember folds
vim.api.nvim_create_augroup("remember_folds", { clear = true })
vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
  pattern = "*",
  command = "silent! mkview"
})
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  pattern = "*",
  command = "silent! loadview"
})

-- cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line("'\"")
    if line > 0 and line <= vim.fn.line("$") then
      vim.cmd("normal! g`\"zz")
    end
  end
})
