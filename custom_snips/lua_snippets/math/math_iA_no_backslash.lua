package.path = "/Users/chanhyuk/.vim/custom_snips/lua_snippets/?.lua;" .. package.path
local ls = require("luasnip")
local utils = require("..util.utils")
local pipe, is_math, no_backslash = utils.pipe, utils.is_math, utils.no_backslash

local parse_snippet = ls.extend_decorator.apply(ls.parser.parse_snippet, {
  snippetType = "autosnippet",
  wordTrig = false,
  condition = pipe({no_backslash, is_math}),
}) --[[@as function]]

local with_priority = ls.extend_decorator.apply(parse_snippet, {
  priority = 10,
}) --[[@as function]]

return {
  parse_snippet({ trig = "sq", name = "\\sqrt{}" }, "\\sqrt{${1:${TM_SELECTED_TEXT}}}$0"),

  with_priority({ trig = "hat", name = "hat" }, "\\hat{$1}$0"),
  with_priority({ trig = "bar", name = "bar" }, "\\overline{$1}$0"),

  parse_snippet({ trig = "inf", name = "\\infty" }, "\\infty"),
  parse_snippet({ trig = "inn", name = "in" }, "\\in"),
  parse_snippet({ trig = "SI", name = "SI" }, "\\SI{$1}{$2}"),
}
