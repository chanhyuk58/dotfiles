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

-- Trigger helper: Checks if we are at the beginning of a line
M.no_backslash = function(line_to_cursor, _)
  return not line_to_cursor:find("\\%a+$", -#line_to_cursor)
end

-- Trigger helper: Checks if we are at the beginning of a word
M.word_begin = function(line_to_cursor, matched_trigger)
  -- Get the text immediately before the trigger
  local prefix = line_to_cursor:sub(1, -(#matched_trigger + 1))
  
  -- If the prefix is empty, we are at the start of the line
  if prefix == "" then return true end
  
  -- Return true if the last character of the prefix is NOT a letter/number 
  -- and NOT a backslash. (e.g., it is a space, bracket, or equals sign)
  return prefix:match("[^%w\\]$") ~= nil
end

return M
