local ctx = require("utils.factory").math_nb
local p = ctx.p

-- 1. Define the Map: { trigger = "latex_command", priority = optional_number }
local symbol_map = {
  -- Blackboard Bold
  RR = "\\mathbb{R}",
  QQ = "\\mathbb{Q}",
  ZZ = "\\mathbb{Z}",
  NN = "\\mathbb{N}",
  CC = "\\mathbb{C}",
  DD = "\\mathbb{D}",
  HH = "\\mathbb{H}",

  -- Bold Font
  ["11"] = "\\mathbf{1}",
  ["00"] = "\\mathbf{0}",
  II = "\\mathbf{I}",

  -- Caligraphy & Logic
  FF = "\\mathcal{F}",
  OO = "\\emptyset",
  AA = "\\forall",
  Ex = "\\exists ",
  notin = "\\not\\in",
  cc = "\\subset",
  inn = "\\in",
  BB = "\\mathcal{B}",
  PP = "\\mathcal{P}",
  
  -- Operators & Misc
  ooo = "\\infty",
  inf = "\\infty",
  nabl = "\\nabla",
  xx = "\\times",
  TT = "^{\\intercal}",
  ["**"] = { res = "\\cdot", prio = 100 },
  ["||"] = " \\mid",
  ["\\\\\\"] = "\\setminus",
  indep = "\\perp\\!\\!\\!\\perp",
  iid = "\\overset{\\text{i.i.d.}}{\\sim}",
  
  -- Arrows
  ["->"] = { res = "\\to ", prio = 100 },
  ["-->"] = { res = "\\longrightarrow ", prio = 200 },
  ["=>"] = "\\implies",
  ["Ra"] = "\\Rightarrow",
  ["iff"] = "\\iff",
  ["siff"] = { res = "\\Leftrightarrow", prio = 100 },
  ["->p"] = "\\xrightarrow{p}",
  ["->d"] = "\\xrightarrow{d}",
  ["->as"] = "\\xrightarrow{\\text{a.s.}}",
  ["as"] = "\\text{a.s.}",

  -- Comparisons
  ["=="] = "&=$1 \\\\",
  ["!="] = "\\neq ",
  ["<="] = "\\le",
  [">="] = "\\ge",
  ["~~"] = "\\sim",
}

-- 2. The Generator Logic
local snippets = {}

for trig, data in pairs(symbol_map) do
  local res = type(data) == "table" and data.res or data
  local prio = type(data) == "table" and data.prio or nil
  
  local snip_opts = { trig = trig, name = res }
  if prio then snip_opts.priority = prio end

  table.insert(snippets, p(snip_opts, res))
end

-- 3. Add manual/complex snippets that don't fit the map
table.insert(snippets, p({ trig = "sq", name = "sqrt" }, "\\sqrt{${1:${TM_SELECTED_TEXT}}}$0"))

return snippets
