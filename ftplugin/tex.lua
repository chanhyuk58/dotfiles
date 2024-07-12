-- require"nabla".enable_virt({
--   autogen = true, -- auto-regenerate ASCII art when exiting insert mode
--   silent = true,     -- silents error messages
--   align_center = true,
-- })
-- vim.opt_local.cole = 0
-- vim.opt_local.numberwidth = 10

local hooks = require "ibl.hooks"
  hooks.register(
    hooks.type.WHITESPACE,
    hooks.builtin.hide_first_space_indent_level
  )

vim.api.nvim_create_autocmd({"BufEnter"},
    {
        callback = function()
            vim.cmd(":Wrapwidth 100")
        end,
        group = autocmd_group,
    })
