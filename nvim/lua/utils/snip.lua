local M = {}
local ts = require("utils.ts")

-- Logic Combinator: All functions must return true
M.pipe = function(fns)
  return function(...)
    for _, fn in ipairs(fns) do
      if not fn(...) then return false end
    end
    return true
  end
end

-- Predicates
M.is_math = function() return ts.in_context("math") end
M.is_list = function() return ts.in_context("list") end
M.is_code = function() return ts.in_context("code") end

-- "Text" is defined as NOT math and NOT code
M.is_text = function()
  return not ts.in_context("math") and not ts.in_context("code")
end

-- Trigger helper
M.no_backslash = function(line_to_cursor, _)
  return not line_to_cursor:find("\\%a+$", -#line_to_cursor)
end

return M
