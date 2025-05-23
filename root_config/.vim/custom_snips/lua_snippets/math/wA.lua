package.path = "/Users/chanhyuk/.vim/custom_snips/lua_snippets/?.lua;"..package.path
local ls = require("luasnip")
local utils = require("util.utils")
local pipe = utils.pipe
local not_math = utils.not_math

local parse_snippet = ls.extend_decorator.apply(ls.parser.parse_snippet, {
  snippetType = "autosnippet",
  condition = pipe({ not_math }),
}) --[[@as function]]

return {
  parse_snippet({ trig = "mk", name = "Math" }, "\\$${1:${TM_SELECTED_TEXT}}\\$$0"),
  parse_snippet({ trig = "dm", name = "Block Math" }, "\\$\\$\n\t${1:${TM_SELECTED_TEXT}}\n\\$\\$ $0"),
  parse_snippet({ trig = "-->", name = "arrows" }, "$\\rightarrow\\$"),
}
