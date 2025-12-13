local ls = require("luasnip")
local utils = require("utils.luasnip_utils")
local parse_snippet = ls.extend_decorator.apply(ls.parser.parse_snippet, 
  {
  snippetType = "autosnippet",
  condition = utils.is_math,
  show_condition = utils.is_math,
  }
)
return {
  parse_snippet({ trig = "exp", name = "exponential" }, "\\exp \\left( $1 \\right)"),
  parse_snippet({ trig = "sum", name = "sum" }, "\\sum"),
  parse_snippet({ trig = "\\sume", name = "sum with from to" }, "\\sum_{${1:n}=${2:1}}^{${3:\\infty}} $0"),

  parse_snippet({ trig = "int", name = "integral", priority = 300 }, "\\int"),
  parse_snippet({ trig = "\\inte", name = "integral with from to"}, "\\int_{${1:-\\infty}}^{${2:\\infty}} ${3:${TM_SELECTED_TEXT}} $0"),
  parse_snippet(
    { trig = "taylor", name = "taylor" },
    "\\sum_{${1:k}=${2:0}}^{${3:\\infty}} ${4:c_$1} (x-a)^$1 $0"
  ),

  parse_snippet({ trig = "lim", name = "limit" }, "\\lim"),
  parse_snippet({ trig = "\\lime", name = "limit with to" }, "\\lim_{${1:n} \\to ${2:\\infty}}"),
  parse_snippet({ trig = "\\limsup", name = "limsup" }, "\\limsup"),
  parse_snippet({ trig = "\\limsupe", name = "limsup" }, "\\limsup_{${1:n} \\to ${2:\\infty}}"),
  parse_snippet({ trig = "\\liminf", name = "liminf" }, "\\liminf"),
  parse_snippet({ trig = "\\liminfe", name = "liminf" }, "\\liminf_{${1:n} \\to ${2:\\infty}}"),

  parse_snippet(
    { trig = "prod", name = "product" },
    "\\prod_{${1:n=${2:1}}}^{${3:\\infty}} ${4:${TM_SELECTED_TEXT}} $0"
  ),

  parse_snippet(
    { trig = "part", name = "d/dx" },
    "\\frac{\\partial ${1:V}}{\\partial ${2:x}}$0"
  ),
  parse_snippet(
    { trig = "ddx", name = "d/dx" },
    "\\frac{\\mathrm{d/${1:V}}}{\\mathrm{d${2:x}}}$0"
  ),

  parse_snippet({ trig = "pmat", name = "pmat" }, "\\begin{pmatrix} $1 \\end{pmatrix}$0"),

  parse_snippet(
    { trig = "lr(", name = "left( right)" },
    "\\left( ${1:${TM_SELECTED_TEXT}} \\right)$0"
  ),
  parse_snippet(
    { trig = "lr|", name = "left| right|" },
    "\\left| ${1:${TM_SELECTED_TEXT}} \\right|$0"
  ),
  parse_snippet(
    { trig = "lr[", name = "left[ right]" },
    "\\left[ ${1:${TM_SELECTED_TEXT}} \\right]$0"
  ),
  parse_snippet(
    { trig = "lra", name = "leftangle rightangle" },
    "\\left< ${1:${TM_SELECTED_TEXT}} \\right>$0"
  ),
  parse_snippet(
    { trig = "lr{", name = "left\\{ right\\}" },
    "\\left\\{ ${1:${TM_SELECTED_TEXT}} \\right\\\\}$0"
  ),
  parse_snippet(
    { trig = "sequence", name = "Sequence indexed by n, from m to infinity" },
    "(${1:a}_${2:n})_{${2:n}=${3:m}}^{${4:\\infty}}"
  ),
}
