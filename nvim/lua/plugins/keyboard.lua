if vim.fn.has("mac") ~= 1 then
  return
end

local M = {}

-- Async layout switch function using hidutil
function M.switch(layout)
  -- Build JSON string for hidutil
  local json = string.format([[
    {
      "KeyboardInputSource": {
        "InputSourceKind":"Keyboard Layout",
        "KeyboardLayout":"%s"
      }
    }
  ]], layout)

  -- Async system call (non-blocking)
  vim.system({ "hidutil", "property", "--set", json }, { detach = true })
end

-- Automatically switch on InsertEnter / InsertLeave
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function() M.switch("U.S.") end
})

vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function() M.switch("ABC") end
})

return M
