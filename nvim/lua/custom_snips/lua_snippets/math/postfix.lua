local ls = require("luasnip")
local f = ls.function_node
local ctx = require("utils.factory").math_nb
local s = ctx.s

local snippets = {}

-- The logic: takes "alpha" and returns "\alpha"
local postfix_node = f(function(_, snip)
  return string.format("\\%s", snip.captures[1])
end, {})

-- List of all words that should trigger a backslash prefix
local words = {
  -- Greek
  "alpha", "beta", "gamma", "delta", "epsilon", "zeta", "eta", "theta", 
  "iota", "kappa", "lambda", "mu", "nu", "xi", "pi", "rho", "sigma", 
  "tau", "phi", "chi", "psi", "omega",
  -- Trig / Math functions
  "sin", "cos", "tan", "csc", "sec", "cot", "ln", "log", "exp", "star", "perp"
}

for _, word in ipairs(words) do
  -- Add lowercase version
  table.insert(snippets, s({ 
    trig = "(" .. word .. ")", 
    regTrig = true, 
    wordTrig = false, 
    priority = 100 
  }, vim.deepcopy(postfix_node)))
  
  -- Add Uppercase version (Alpha -> \Alpha)
  local capitalized = word:gsub("^%l", string.upper)
  table.insert(snippets, s({ 
    trig = "(" .. capitalized .. ")", 
    regTrig = true, 
    wordTrig = false, 
    priority = 100 
  }, vim.deepcopy(postfix_node)))
end

return snippets
