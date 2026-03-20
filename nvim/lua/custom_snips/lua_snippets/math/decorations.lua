local ls = require("luasnip")
local f = ls.function_node
local ctx = require("utils.factory").math_nb
local s = ctx.s

local decos = {
  bar = "\\overline{%s}",
  und = "\\underline{%s}",
  hat = "\\hat{%s}",
  dot = "\\dot{%s}",
  ora = "\\overrightarrow{%s}",
  ola = "\\overleftarrow{%s}",
}

local snippets = {}

for trig, command in pairs(decos) do
  table.insert(snippets, s({
    trig = "(%a+)" .. trig,
    regTrig = true,
    wordTrig = false,
    name = trig,
  }, f(function(_, snip)
    return string.format(command, snip.captures[1])
  end, {})))
end

return snippets
