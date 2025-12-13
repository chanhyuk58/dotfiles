local ls = require("luasnip")

local utils = require("utils.luasnip_utils")
local pipe = utils.pipe
local no_backslash = utils.no_backslash
local is_math = utils.is_math

local parse_snippet = ls.extend_decorator.apply(ls.parser.parse_snippet, {
  snippetType = "autosnippet",
  condition = pipe({ no_backslash, is_math }),
}) --[[@as function]]

local with_priority = ls.extend_decorator.apply(parse_snippet, {
  priority = 10,
}) --[[@as function]]

return {
  with_priority({ trig = "arcsin", name = "arcsin" }, "\\arcsin"),
  with_priority({ trig = "arctan", name = "arctan" }, "\\arctan"),
  with_priority({ trig = "arcsec", name = "arcsec" }, "\\arcsec"),
  with_priority({ trig = "asin", name = "asin" }, "\\arcsin"),
  with_priority({ trig = "atan", name = "atan" }, "\\arctan"),
  with_priority({ trig = "asec", name = "asec" }, "\\arcsec"),

  parse_snippet({ trig = "set", name = "set" }, "\\{$1\\\\}$0"),
  parse_snippet({ trig = "fun", name = "function map" }, "f \\colon $1 \\R \\to \\R \\colon $0"),

  parse_snippet(
    { trig = "abs", name = "absolute value \\abs{}" },
    "|${1:${TM_SELECTED_TEXT}}|$0"
  ),
}
