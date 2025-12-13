local ls = require("luasnip")
local auto = {
  snippetType = "autosnippet",
  wordTrig = false,
}
local auto_lsp_snip = ls.extend_decorator.apply(ls.parser.parse_snippet, auto)

----------------------------
return{
  -- auto_lsp_snip({trig="lib", name="load library"}, "library(${1:package})")
}
