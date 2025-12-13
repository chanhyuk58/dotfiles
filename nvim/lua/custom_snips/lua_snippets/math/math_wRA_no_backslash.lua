local ls = require("luasnip")
local f = ls.function_node

local M = {}

local vec_node = {
  f(function(_, snip)
    return string.format("\\vec{%s} ", snip.captures[1])
  end, {}),
}

M.math_wrA_no_backslash = {
  { "([%a][%a])(%.,)", vec_node },
  { "([%a][%a])(,%.)", vec_node },
  { "([%a])(%.,)", vec_node },
  { "([%a])(,%.)", vec_node },
}

M.decorator = {}

local utils = require("utils.luasnip_utils")
local pipe = utils.pipe
local no_backslash = utils.no_backslash
local is_math = utils.is_math

M.decorator = {
  wordTrig = true,
  trigEngine = "pattern",
  condition = pipe({ no_backslash, is_math }),
}

local s = ls.extend_decorator.apply(ls.snippet, M.decorator) --[[@as function]]

return vim.tbl_map(function(x)
  local trig, node = unpack(x)
  return s({ trig = trig }, vim.deepcopy(node))
end, M.math_wrA_no_backslash)
