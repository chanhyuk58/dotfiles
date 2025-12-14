local function bufmap(mode, lhs, rhs)
  vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, { noremap = true, silent = true })
end

-- Compile
bufmap("n", "<C-T>", ":!pandoc % -o %:p:r.pdf<CR>")
bufmap("n", "<C-O>", ":!open -a skim %:p:r.pdf<CR>")

-- Slime mappings
bufmap("n", ",l", "<Plug>SlimeLineSend")
bufmap("x", ",l", "<Plug>SlimeRegionSend")
bufmap("n", ",;", "<Plug>SlimeParagraphSend")

local bufnr = vim.api.nvim_get_current_buf()

vim.api.nvim_create_autocmd({ "BufWritePre", "FileWritePre" }, {
  buffer = bufnr,
  callback = function()
    local last_line = math.min(20, vim.fn.line("$"))
    for i = 1, last_line do
      local line = vim.fn.getline(i)
      if line:match("^modified:") then
        vim.fn.setline(i, "modified: " .. os.date("%Y-%m-%d %H:%M:%S"))
        break
      end
    end
  end,
})
