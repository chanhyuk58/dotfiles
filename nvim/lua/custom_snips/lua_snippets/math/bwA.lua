local ls = require("luasnip")
local t = ls.text_node
local i = ls.insert_node

local utils = require("utils.luasnip_utils")
local pipe = utils.pipe
local is_math = utils.is_math

local conds = require("luasnip.extras.expand_conditions")
local condition = pipe({ conds.line_begin, is_math })

local parse_snippet = ls.extend_decorator.apply(ls.parser.parse_snippet, {
  snippetType = "autosnippet",
  condition = condition,
}) --[[@as function]]

local s = ls.extend_decorator.apply(ls.snippet, {
  snippetType = "autosnippet",
  condition = condition,
}) --[[@as function]]

return {
  s(
    { trig = "ali", name = "Aligned" },
    { t({ "\\begin{aligned}", "\t" }), i(1), t("&="), i(2), t("\\\\"), t({ "", "\\end{aligned}" }) }
  ),
  s(
    { trig = "nali", name = "New Aligned line" },
    { i(1), t("&="), i(2), t("\\\\") }
  ),

  parse_snippet({ trig = "beg", name = "begin{} / end{}" }, "\\begin{$1}\n\t$0\n\\end{$1}"),
  parse_snippet({ trig = "case", name = "cases" }, "\\begin{cases}\n\t$1\n\\end{cases}"),
}
