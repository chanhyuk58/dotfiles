local ls = require("luasnip")
local f = ls.function_node

package.path = "/Users/chanhyuk/.vim/custom_snips/lua_snippets/?.lua;" .. package.path
local utils = require("util.utils")
local pipe, no_backslash = utils.pipe, utils.no_backslash
local is_math = utils.is_math

local decorator = {
  snippetType = "autosnippet",
  wordTrig = false,
  condition = pipe({ no_backslash, is_math }),
}

local parse_snippet = ls.extend_decorator.apply(ls.parser.parse_snippet, decorator) --[[@as function]]
local s = ls.extend_decorator.apply(ls.snippet, decorator) --[[@as function]]

return {
  s(
    {
      trig = "(%a+)bar",
      wordTrig = false,
      regTrig = true,
      name = "bar",
      priority = 100,
    },
    f(function(_, snip)
      return string.format("\\overline{%s}", snip.captures[1])
    end, {})
  ),
    s(
        {
      trig = "(%a+)und",
      wordTrig = false,
      regTrig = true,
      name = "underline",
      priority = 100,
    },
    f(function(_, snip)
      return string.format("\\underline{%s}", snip.captures[1])
    end, {})
  ),
  s(
    {
      trig = "(%a)dot",
      wordTrig = false,
      regTrig = true,
      name = "dot",
      priority = 100,
    },
    f(function(_, snip)
      return string.format("\\dot{%s}", snip.captures[1])
    end, {})
  ),

  s(
    {
      trig = "(%a+)hat",
      wordTrig = false,
      regTrig = true,
      name = "hat",
      priority = 100,
    },
    f(function(_, snip)
      return string.format("\\hat{%s}", snip.captures[1])
    end, {})
  ),
  s(
    {
      trig = "(%a+)ora",
      wordTrig = false,
      regTrig = true,
      name = "ora",
      priority = 100,
    },
    f(function(_, snip)
      return string.format("\\overrightarrow{%s}", snip.captures[1])
    end, {})
  ),
  s(
    {
      trig = "(%a+)ola",
      wordTrig = false,
      regTrig = true,
      name = "ola",
      priority = 100,
    },
    f(function(_, snip)
      return string.format("\\overleftarrow{%s}", snip.captures[1])
    end, {})
  ),

  parse_snippet({ trig = "_", name = "subscript" }, "_{$1}$0"),
  parse_snippet({ trig = "^", name = "to the ... power ^{}" }, "^{$1}$0"),
  parse_snippet({ trig = "td", name = "to the ... power ^{}" }, "^{$1}$0"),
  parse_snippet({ trig = "rd", name = "to the ... power ^{()}" }, "^{($1)}$0"),
  parse_snippet({ trig = "cb", name = "Cube ^3" }, "^3"),
  parse_snippet({ trig = "sr", name = "Square ^2" }, "^2"),

  parse_snippet({ trig = "Ex", name = "exists" }, "\\exists "),
  parse_snippet({ trig = "AA", name = "forall" }, "\\forall"),
  parse_snippet({ trig = "xnn", name = "xn" }, "x_{n}"),
  parse_snippet({ trig = "ynn", name = "yn" }, "y_{n}"),
  parse_snippet({ trig = "xii", name = "xi" }, "x_{i}"),
  parse_snippet({ trig = "yii", name = "yi" }, "y_{i}"),
  parse_snippet({ trig = "xjj", name = "xj" }, "x_{j}"),
  parse_snippet({ trig = "yjj", name = "yj" }, "y_{j}"),
  parse_snippet({ trig = "xp1", name = "x" }, "x_{n+1}"),
  parse_snippet({ trig = "xmm", name = "x" }, "x_{m}"),
  parse_snippet({ trig = "R0+", name = "R0+" }, "\\mathbb{R}_0^+"),

  parse_snippet({ trig = "notin", name = "not in " }, "\\not\\in"),

  parse_snippet({ trig = "cc", name = "subset" }, "\\subset"),

  parse_snippet({ trig = "<->", name = "leftrightarrow", priority = 200 }, "\\leftrightarrow"),
  parse_snippet({ trig = "...", name = "ldots", priority = 100 }, "\\ldots"),
  parse_snippet({ trig = "!>", name = "mapsto" }, "\\mapsto"),
  parse_snippet({ trig = "iff", name = "iff" }, "\\iff"),
  parse_snippet({ trig = "siff", name = "short iff", priority = 100}, "\\Leftrightarrow"),
  parse_snippet({ trig = "ooo", name = "\\infty" }, "\\infty"),
  parse_snippet({ trig = "rij", name = "mrij" }, "(${1:x}_${2:n})_{${3:$2}\\in${4:\\N}}$0"),
  parse_snippet({ trig = "nabl", name = "nabla" }, "\\nabla"),
  parse_snippet({ trig = "<!", name = "normal" }, "\\triangleleft"),
  parse_snippet({ trig = "floor", name = "floor" }, "\\left\\lfloor $1 \\right\\rfloor$0"),
  parse_snippet({ trig = "//", name = "Fraction" }, "\\frac{$1}{$2}$0"),
  parse_snippet({ trig = "\\\\\\", name = "setminus" }, "\\setminus"),

  parse_snippet({ trig = "->", name = "to", priority = 100 }, "\\to "),
  parse_snippet({ trig = "-->", name = "long to", priority = 200 }, "\\longrightarrow "),

  parse_snippet({ trig = "mcal", name = "math caligraphy" }, "\\mathcal{$1}$0"),
  parse_snippet({ trig = "mbb", name = "math blackborad bold" }, "\\mathbb{$1}$0"),
  parse_snippet({ trig = "mbf", name = "math bold" }, "\\mathbf{$1}$0"),
  parse_snippet({ trig = "mrm", name = "math roman" }, "\\mathrm{$1}$0"),
  parse_snippet({ trig = "mit", name = "math italic" }, "\\mathit{$1}$0"),
  parse_snippet({ trig = "mtt", name = "math typewriter" }, "\\mathtt{$1}$0"),

  parse_snippet({ trig = "letw", name = "let omega" }, "Let $\\Omega \\subset \\C$ be open."),
  parse_snippet({ trig = "nnn", name = "bigcap" }, "\\bigcap_{${1:i \\in ${2: I}}} $0"),
  parse_snippet({ trig = "norm", name = "norm" }, "\\|$1\\|$0"),
  parse_snippet({ trig = "<>", name = "hokje" }, "\\diamond"),
  parse_snippet({ trig = ">>", name = ">>" }, "\\gg"),
  parse_snippet({ trig = "<<", name = "<<" }, "\\ll"),

  parse_snippet({ trig = "stt", name = "text subscript" }, "_\\text{$1} $0"),
  parse_snippet({ trig = "te", name = "text" }, "\\text{$1}$0"),

  parse_snippet({ trig = "xx", name = "cross" }, "\\times"),

  parse_snippet({ trig = "**", name = "cdot", priority = 100 }, "\\cdot"),

  parse_snippet({ trig = ":=", name = "colon equals (lhs defined as rhs)" }, "\\coloneqq"),

  parse_snippet(
    { trig = "cvec", name = "column vector" },
    "\\begin{pmatrix} ${1:x}_${2:1}\\\\ \\vdots\\\\ $1_${2:n} \\end{pmatrix}"
  ),
  parse_snippet({ trig = "ceil", name = "ceil" }, "\\left\\lceil $1 \\right\\rceil $0"),
  parse_snippet({ trig = "EE", name = "Expectation" }, "\\mathbb{E}\\left[$1\\right]"),
  parse_snippet({ trig = "PP", name = "Probability" }, "\\mathbb{P}\\left($1\\right)"),
  parse_snippet({ trig = "*", name = "asterisk" }, "\\ast"),
  parse_snippet({ trig = "ind", name = "independent" }, "\\perp\\\\!\\\\!\\\\!\\\\perp"),
  parse_snippet({ trig = "1i", name = "Indicator" }, "\\mathbb{1}_{\\{ $1 \\\\}\\}"),
  
  parse_snippet({ trig = "FF", name = "fency F" }, "\\mathcal{F}"),
  parse_snippet({ trig = "OO", name = "emptyset" }, "\\O"),
  parse_snippet({ trig = "RR", name = "R" }, "\\mathbb{R}"),
  parse_snippet({ trig = "QQ", name = "Q" }, "\\mathbb{Q}"),
  parse_snippet({ trig = "ZZ", name = "Z" }, "\\mathbb{Z}"),
  parse_snippet({ trig = "UU", name = "cup" }, "\\cup"),
  parse_snippet({ trig = "NN", name = "n" }, "\\mathbb{N}"),
  parse_snippet({ trig = "||", name = "mid" }, " \\mid"),
  parse_snippet({ trig = "Nn", name = "cap" }, "\\cap"),
  parse_snippet({ trig = "bmat", name = "bmat" }, "\\begin{bmatrix} $1 \\end{bmatrix} $0"),
  parse_snippet({ trig = "uuu", name = "bigcup" }, "\\bigcup_{${1:i \\in ${2: I}}} $0"),
  parse_snippet({ trig = "DD", name = "D" }, "\\mathbb{D}"),
  parse_snippet({ trig = "HH", name = "H" }, "\\mathbb{H}"),
  parse_snippet({ trig = "lll", name = "l" }, "\\ell"),

  parse_snippet({ trig = "==", name = "equals" }, [[&= $1 \\\\]]),
  parse_snippet({ trig = "!=", name = "not equals" }, "\\neq "),
  parse_snippet({ trig = "compl", name = "complement" }, "^{c}"),
  -- parse_snippet({ trig = "__", name = "subscript" }, "_{$1}$0"),
  parse_snippet({ trig = "=>", name = "implies" }, "\\implies"),
  parse_snippet({ trig = "Ra", name = "short implies" }, "\\Rightarrow"),
  parse_snippet({ trig = "simp", name = "short implies" }, "\\Rightarrow"),
  parse_snippet({ trig = "=<", name = "implied by" }, "\\impliedby"),
  parse_snippet({ trig = "<<", name = "<<" }, "\\ll"),

  parse_snippet({ trig = "times", name = "times" }, "\\times"),
  parse_snippet({ trig = "<=", name = "leq" }, "\\le"),
  parse_snippet({ trig = ">=", name = "geq" }, "\\ge"),
  parse_snippet({ trig = "invs", name = "inverse" }, "^{-1}"),
  parse_snippet({ trig = "~~", name = "~" }, "\\sim"),
  parse_snippet({ trig = "conj", name = "conjugate" }, "\\overline{$1}$0"),
}
