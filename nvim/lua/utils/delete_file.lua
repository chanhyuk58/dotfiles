local M = {}

-- delete current buffer and file
function M.delete_file()
  local choice = vim.fn.confirm("Delete file and close buffer?", "&Yes\n&No", 1)
  if choice == 1 then
    vim.fn.delete(vim.fn.expand("%:p"))
    vim.cmd("bd")
  end
end

return M
