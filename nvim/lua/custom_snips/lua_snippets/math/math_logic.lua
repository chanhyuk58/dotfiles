local ls = require("luasnip")
local f, i, t = ls.function_node, ls.insert_node, ls.text_node
local ctx = require("utils.factory").math -- Use the 'math' context (allows backslash)
local s, p = ctx.s, ctx.p
local latex_utils = require("utils.latex")

local snippets = {}

----------------------------------------------------------------------------
-- 1. Standard Fractions
----------------------------------------------------------------------------

-- The basic // trigger
table.insert(snippets, p({ trig = "//", name = "fraction" }, "\\frac{$1}{$2}$0"))

-- The visual fraction (select text, then type 'ff')
table.insert(snippets, s({ trig = "ff", name = "visual fraction" }, {
  t("\\frac{"),
  f(function(_, snip) return snip.env.TM_SELECTED_TEXT[1] or "" end),
  t("}{"), i(1), t("}"), i(0)
}))

----------------------------------------------------------------------------
-- 2. Smart Fractions (The Logic Engine)
----------------------------------------------------------------------------

-- This function is shared by both Parentheses and No-Parentheses triggers
local smart_frac_node = {
  f(function(_, snip)
    local prefix, num = latex_utils.parse_smart_frac(snip.trigger)
    return prefix .. "\\frac{" .. num .. "}"
  end),
  t("{"), i(1), t("}"), i(0)
}

-- Trigger A: Parentheses (a+b)/ -> \frac{a+b}{}
table.insert(snippets, s({
  trig = ".*%)/", 
  regTrig = true,
  name = "smart fraction (parens)",
}, vim.deepcopy(smart_frac_node)))

-- Trigger B: No Parentheses (Step 3 code)
-- Handles: x/ -> \frac{x}{}, \alpha/ -> \frac{\alpha}{}, x_n/ -> \frac{x_n}{}
local frac_no_parens_triggers = {
  "[%w\\]+/",              -- matches x/ or \alpha/
  "[%w\\]+[%^_]{[%w]+}/",  -- matches x^{12}/
  "[%w\\]+[%^_][%w]+/",    -- matches x_n/
}

for _, trig in ipairs(frac_no_parens_triggers) do
  table.insert(snippets, s({
    trig = trig,
    regTrig = true,
    name = "smart fraction (no parens)",
    priority = 500, -- Higher priority to catch triggers before they are treated as plain text
  }, vim.deepcopy(smart_frac_node)))
end

----------------------------------------------------------------------------
-- 3. Auto Subscripts
----------------------------------------------------------------------------

-- x1 -> x_{1}
table.insert(snippets, s({
  trig = "([%a])(%d)",
  regTrig = true,
  name = "auto subscript",
}, {
  f(function(_, snip)
    return string.format("%s_{%s}", snip.captures[1], snip.captures[2])
  end),
  i(0)
}))

-- x_nn -> x_{nn}
table.insert(snippets, s({
  trig = "([%a])_(%d%d)",
  regTrig = true,
  name = "auto subscript 2",
}, {
  f(function(_, snip)
    return string.format("%s_{%s}", snip.captures[1], snip.captures[2])
  end),
  i(0)
}))

----------------------------------------------------------------------------
-- 4. Delimiters & Visual Wrappers
----------------------------------------------------------------------------

-- Map of trigger -> { left_delimiter, right_delimiter }
local wrappers = {
  ["lr("] = { "\\left( ", " \\right)" },
  ["lr["] = { "\\left[ ", " \\right]" },
  ["lr{"] = { "\\left\\{ ", " \\right\\}" },
  ["lr|"] = { "\\left\\lvert ", " \\right\\rvert" },
  ["lra"] = { "\\left\\langle ", " \\right\\rangle" },
  
  ["abs"] = { "\\left\\lvert ", " \\right\\rvert" },
  ["norm"] = { "\\left\\lVert ", " \\right\\rVert" },
  ["set"] = { "\\left\\{ ", " \\right\\}" },
  ["ceil"] = { "\\left\\lceil ", " \\right\\rceil" },
  ["floor"] = { "\\left\\lfloor ", " \\right\\rfloor" },
}

for trig, delimiters in pairs(wrappers) do
  table.insert(snippets, s({
    trig = trig,
    name = trig .. " wrapper",
  }, {
    t(delimiters[1]),
    -- If text was visually selected, insert it here. Otherwise, leave a blank insert node.
    f(function(_, snip) return snip.env.TM_SELECTED_TEXT[1] or "" end),
    i(1),
    t(delimiters[2]),
    i(0)
  }))
end

return snippets
