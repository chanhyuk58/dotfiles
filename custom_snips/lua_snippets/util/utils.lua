local M = {}

-- local s = ls.snippet
-- local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
-- local t = ls.text_node
-- local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local events = require("luasnip.util.events")
-- local r = require("luasnip.extras").rep
-- local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta

M.pipe = function(fns)
  return function(...)
    for _, fn in ipairs(fns) do
      if not fn(...) then
        return false
      end
    end
    return true
  end
end

M.no_backslash = function(line_to_cursor, matched_trigger)
  return not line_to_cursor:find("\\%a+$", -#line_to_cursor)
end

local ts_utils = require("util/ts_utils")
M.is_math = function(...)
    return ts_utils.in_mathzone()
end

M.not_math = function(...)
    return ts_utils.in_text()
end

M.with_priority = function(snip, priority)
  snip.priority = priority
  return snip
end

M.with_opts = function(fn, opts)
  return function()
    return fn(opts)
  end
end

return M
