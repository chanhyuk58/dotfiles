local opts = { buffer = true, silent = true }
local bufnr = vim.api.nvim_get_current_buf()

-- Compile/Run
local function compile_beamer_with_style()
    local buf_content = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
    local filename = vim.fn.expand("%")
    local output = vim.fn.expand("%:r") .. ".pdf"
    
    -- Base command
    local cmd = "pandoc " .. vim.fn.shellescape(filename) .. " -o " .. vim.fn.shellescape(output)

    -- 1. Format Detection
    if buf_content:find("beamer") then
        cmd = cmd .. " -t beamer"
    end

    -- 2. Citation Detection & Styling
    if buf_content:find("bibliography:") then
        -- Add citeproc
        cmd = cmd .. " --citeproc"
        
        -- Add the Lua filter (update the path to where you saved cite-format.lua)
        local filter_path = vim.fn.expand("/Users/chanhyuk/.config/nvim/ftplugin/cite-format.lua")
        if vim.fn.filereadable(filter_path) == 1 then
            cmd = cmd .. " --lua-filter=" .. vim.fn.shellescape(filter_path)
        end
    end

    -- Execute
    print("Compiling...")
    vim.fn.jobstart(cmd, {
        on_exit = function(_, code)
            if code == 0 then
                print("Success: " .. output)
            else
                print("Pandoc Error: Check your YAML or Filter path")
            end
        end,
    })
end

vim.keymap.set("n", "<C-T>", compile_beamer_with_style, { desc = "Smart Pandoc Compile" })
vim.keymap.set("n", "<C-O>", ":!open -a skim %:.:r.pdf<CR>", opts)

-- Slime mappings
vim.keymap.set("n", ",l", "<Plug>SlimeLineSend", { buffer = true, remap = true })
vim.keymap.set("x", ",l", "<Plug>SlimeRegionSend", { buffer = true, remap = true })
vim.keymap.set("n", ",;", "<Plug>SlimeParagraphSend", { buffer = true, remap = true })

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
