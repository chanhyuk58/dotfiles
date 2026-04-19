local opts = { buffer = true, silent = true }

-- Compile/Run
vim.keymap.set("n", "<C-T>", ":!R -e \"rmarkdown::render('%:p')\"<CR>", opts)
vim.keymap.set("n", "<C-O>", ":!open -a skim '%:p:r.pdf'<CR>", opts)

-- Slime mappings
vim.keymap.set("n", ",l", "<Plug>SlimeLineSend", { buffer = true, remap = true })
vim.keymap.set("x", ",l", "<Plug>SlimeRegionSend", { buffer = true, remap = true })
vim.keymap.set("n", ",;", "<Plug>SlimeParagraphSend", { buffer = true, remap = true })

-- Tabs
vim.o.softtabstop=2
vim.o.shiftwidth=2
vim.o.tabstop=2

-- Modification dates
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
