local ls = require("luasnip")
local t, i, f = ls.text_node, ls.insert_node, ls.function_node
local factory = require("utils.factory")

-- Contexts
local math_begin = factory.math_begin -- Math mode + Start of line
local math = factory.math             -- Math mode anywhere
local text = factory.text             -- Text mode (for lists)

return {
  ----------------------------------------------------------------------------
  -- 1. Math Block Environments (Trigger at start of line)
  ----------------------------------------------------------------------------

  -- Generic \begin{} \end{}
  math_begin.p({ trig = "beg", name = "begin/end" }, "\\begin{$1}\n\t$0\n\\end{$1}"),

  -- Aligned environment
  math_begin.s({ trig = "ali", name = "aligned" }, {
    t({ "\\begin{aligned}", "\t" }),
    i(1), t(" &= "), i(2), t(" \\\\"),
    t({ "", "\\end{aligned}" }),
  }),

  -- Cases environment
  math_begin.p({ trig = "case", name = "cases" }, "\\begin{cases}\n\t$1\n\\end{cases}"),

  ----------------------------------------------------------------------------
  -- 2. Internal Environment Helpers (Trigger anywhere in math)
  ----------------------------------------------------------------------------

  -- New aligned line (&=)
  math.s({ trig = "nali", name = "new aligned line" }, {
    i(1), t("&= "), i(2), t(" \\\\"),
  }),

  ----------------------------------------------------------------------------
  -- 3. List Environments (Trigger in text mode)
  ----------------------------------------------------------------------------

  -- Smart Item (Trigger '--' only if inside a list environment)
  -- This uses the 'is_list' check we built in utils/ts.lua
  ls.snippet({ 
    trig = "--", 
    name = "item", 
    snippetType = "autosnippet",
    condition = require("utils.snip").is_list 
  }, {
    t("\\item "), i(0)
  }),

  ----------------------------------------------------------------------------
  -- 4. Inline Math (Trigger in text mode)
  ----------------------------------------------------------------------------

  -- mk -> $ $
  text.p({ trig = "mk", name = "inline math" }, "\\$${1:${TM_SELECTED_TEXT}}\\$$0"),

  -- dm -> $$ $$
  text.p({ trig = "dm", name = "block math" }, "\\$\\$\n\t${1:${TM_SELECTED_TEXT}}\n\\$\\$ $0"),
}
