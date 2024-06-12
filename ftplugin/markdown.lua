-- require"nabla".enable_virt({
--   autogen = true, -- auto-regenerate ASCII art when exiting insert mode
--   silent = true,     -- silents error messages
--   align_center = true,
-- })
vim.opt_local.cole = 2
-- vim.opt_local.colorcolumn="0"
-- vim.opt_local.listchars={}
-- vim.opt_local.columns=81

local hooks = require "ibl.hooks"
  hooks.register(
    hooks.type.WHITESPACE,
    hooks.builtin.hide_first_space_indent_level
  )

require'nvim-treesitter.configs'.setup {
    highlight = {
    -- additional_vim_regex_highlighting = true,
    }
}
