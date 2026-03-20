local ls = require("luasnip")
local t, i, f = ls.text_node, ls.insert_node, ls.function_node
local ctx = require("utils.factory").math
local p, s = ctx.p, ctx.s

return {
  ----------------------------------------------------------------------------
  -- 1. Sums, Products, and Integrals
  ----------------------------------------------------------------------------
  
  -- Basic Operators
  p({ trig = "sum", name = "sum" }, "\\sum"),
  p({ trig = "prod", name = "product" }, "\\prod"),
  p({ trig = "int", name = "integral", priority = 300 }, "\\int"),

  -- Operators with Bounds (The 'e' suffix stands for 'extended')
  p({ trig = "\\sume", name = "sum with bounds" }, "\\sum_{${1:n}=${2:1}}^{${3:\\infty}} $0"),
  p({ trig = "\\prode", name = "product with bounds" }, "\\prod_{${1:n}=${2:1}}^{${3:\\infty}} $0"),
  
  -- Integral with bounds and visual selection support
  s({ trig = "\\inte", name = "integral with bounds" }, {
    t("\\int_{"), i(1, "-\\infty"), t("}^{"), i(2, "\\infty"), t("} "),
    f(function(_, snip) return snip.env.TM_SELECTED_TEXT[1] or "" end),
    i(3), t(" \\,\\mathrm{d}"), i(4, "x"), i(0)
  }),

  -- Double/Triple Integrals
  p({ trig = "iint", name = "double integral" }, "\\iint"),
  p({ trig = "iiint", name = "triple integral" }, "\\iiint"),
  p({ trig = "oint", name = "contour integral" }, "\\oint"),

  ----------------------------------------------------------------------------
  -- 2. Limits
  ----------------------------------------------------------------------------

  -- Basic Limits
  p({ trig = "lim", name = "limit" }, "\\lim"),
  p({ trig = "\\limsup", name = "limsup" }, "\\limsup"),
  p({ trig = "\\liminf", name = "liminf" }, "\\liminf"),

  -- Limits with 'to infinity' bounds
  p({ trig = "\\lime", name = "limit with bounds" }, "\\lim_{${1:n} \\to ${2:\\infty}} $0"),
  p({ trig = "\\limsupe", name = "limsup with bounds" }, "\\limsup_{${1:n} \\to ${2:\\infty}} $0"),
  p({ trig = "\\liminfe", name = "liminf with bounds" }, "\\liminf_{${1:n} \\to ${2:\\infty}} $0"),

  ----------------------------------------------------------------------------
  -- 3. Derivatives and Differentials
  ----------------------------------------------------------------------------

  -- Partial Derivative (Fraction)
  p({ trig = "part", name = "partial derivative" }, "\\frac{\\partial ${1:V}}{\\partial ${2:x}} $0"),
  
  -- Total Derivative (Fraction with roman 'd')
  p({ trig = "ddx", name = "d/dx" }, "\\frac{\\mathrm{d} ${1:V}}{\\mathrm{d} ${2:x}} $0"),

  -- Differential operator (roman 'd' with proper spacing for the end of integrals)
  p({ trig = "dd", name = "differential d" }, "\\,\\mathrm{d}"),

  -- Gradient / Nabla
  p({ trig = "nabl", name = "nabla" }, "\\nabla"),

  ----------------------------------------------------------------------------
  -- 4. Evaluation and Sequences (From .sty and math_i.txt)
  ----------------------------------------------------------------------------

  -- Evaluation Bar (Replaces \eval{expr}{lower}{upper})
  s({ trig = "eval", name = "evaluation bar" }, {
    t("\\left. "),
    f(function(_, snip) return snip.env.TM_SELECTED_TEXT[1] or "" end),
    i(1),
    t(" \\right|_{"), i(2), t("}^{"), i(3), t("} "), i(0)
  }),

  -- Taylor Series Expansion
  p({ trig = "taylor", name = "taylor series" }, "\\sum_{${1:k}=${2:0}}^{${3:\\infty}} ${4:c_$1} (x-a)^$1 $0"),

  -- Sequence Definition
  p({ trig = "sequence", name = "sequence indexed by n" }, "(${1:a}_${2:n})_{${2:n}=${3:1}}^{${4:\\infty}} $0"),
}
