local map = vim.keymap.set
local utils = require("utils")

-- Copy/Paste
map("n", "<leader>y", '"+y')
map("v", "<leader>y", '"+y')
map("n", "<leader>p", '"+p')
map("v", "<leader>p", '"+p')

-- Split navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- LuaSnip edit snippet files
map("n", ",se", function()
  require("luasnip.loaders").edit_snippet_files()
end, { noremap = true, silent = true })

-- New Note
map("n", ",nn", function()
  utils.new_note()
  -- require("utils.new_note").new_note()
end, { noremap = true, silent = true })

-- Delete file + buffer
map("n", "<leader>bd", function()
  require("utils.delete_file").delete_file()
end, { noremap = true, silent = true })
