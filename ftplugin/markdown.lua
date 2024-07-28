----- Setting for the nabla plugin
-- require"nabla".enable_virt({
--   autogen = true, -- auto-regenerate ASCII art when exiting insert mode
--   silent = true,     -- silents error messages
--   align_center = true,
-- })

vim.opt_local.cole = 2
-- vim.opt_local.numberwidth = 10
-- vim.opt_local.colorcolumn="0"
-- vim.opt_local.listchars={}
-- vim.opt_local.columns=81

----- Settings for Indent Blank Line
-- no line for the 
local hooks = require "ibl.hooks"
hooks.register(
  hooks.type.WHITESPACE,
  hooks.builtin.hide_first_space_indent_level
)

----- Set Wrapwidth when entering a buffer with the filetype
vim.api.nvim_create_autocmd({"BufEnter"},
    {
        callback = function()
            vim.cmd(":Wrapwidth 100")
        end,
        group = autocmd_group,
    })
