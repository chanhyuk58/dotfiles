vim.opt_local.cole = 2
vim.opt_local.columns=100
-- vim.opt_local.numberwidth = 10
-- vim.opt_local.colorcolumn="0"
-- vim.opt_local.listchars={}

----- Settings for Indent Blank Line
local hooks = require "ibl.hooks"
hooks.register(
  hooks.type.WHITESPACE,
  hooks.builtin.hide_first_space_indent_level
)
