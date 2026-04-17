local ls = require("luasnip")
local f = ls.function_node
local ctx = require("utils.factory").math_nb
local s, p = ctx.s, ctx.p

local snippets = {}

-- 1. The Word List (Greek letters and Math functions)
local words = {
  -- Greek
  "alpha", "beta", "gamma", "delta", "epsilon", "zeta", "eta", "theta", 
  "iota", "kappa", "lambda", "mu", "nu", "xi", "pi", "rho", "sigma", 
  "tau", "phi", "chi", "psi", "omega",
  -- Trig / Math functions
  "sin", "cos", "tan", "csc", "sec", "cot", "ln", "log", "exp", "star", "perp"
}

-- 2. Loop to generate direct word triggers (alpha -> \alpha)
for _, word in ipairs(words) do
  -- Lowercase version
  table.insert(snippets, p({ 
    trig = word, 
    wordTrig = true,
    priority = 100 
  }, "\\" .. word))
  
  -- Uppercase version (Alpha -> \Alpha)
  local capitalized = word:gsub("^%l", string.upper)
  table.insert(snippets, p({ 
    trig = capitalized, 
    wordTrig = true, 
    priority = 100 
  }, "\\" .. capitalized))
end

-- 3. Unified Quad Snippet (quad -> \quad, qquad -> \qquad)
table.insert(snippets, s({ 
  trig = "(q?quad)", 
  regTrig = true, 
  wordTrig = false, 
  priority = 200 
}, {
  f(function(_, snip)
    return "\\" .. snip.captures[1]
  end),
}))

return snippets
