local ls = require("luasnip")
local snip_utils = require("utils.snip")

local M = {}

-- Helper to create a decorated environment
local function create_context(common_opts)
  local s = ls.extend_decorator.apply(ls.snippet, common_opts)
  local p = ls.extend_decorator.apply(ls.parser.parse_snippet, common_opts)
  
  -- Helper for priority
  local prio = function(priority, snip_table)
    snip_table.priority = priority
    return snip_table
  end

  return { s = s, p = p, prio = prio }
end

-- 1. Math + No Backslash
M.math_nb = create_context({
  snippetType = "autosnippet",
  wordTrig = false,
  condition = snip_utils.pipe({ snip_utils.no_backslash, snip_utils.is_math }),
})

-- 2. Math Only
M.math = create_context({
  snippetType = "autosnippet",
  wordTrig = false,
  condition = snip_utils.is_math,
})

-- 3. Text Only
M.text = create_context({
  snippetType = "autosnippet",
  condition = snip_utils.is_text,
})

-- 4. Math + Line Begin
local conds = require("luasnip.extras.expand_conditions")
M.math_begin = create_context({
  snippetType = "autosnippet",
  condition = snip_utils.pipe({ conds.line_begin, snip_utils.is_math }),
})

return M
