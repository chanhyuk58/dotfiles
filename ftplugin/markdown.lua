vim.opt_local.cole = 2
vim.opt_local.columns=100
-- vim.opt_local.numberwidth = 10
-- vim.opt_local.colorcolumn='0'
-- vim.opt_local.listchars={}

----- Settings for Indent Blank Line
local hooks = require 'ibl.hooks'
hooks.register(
  hooks.type.WHITESPACE,
  hooks.builtin.hide_first_space_indent_level
)

-- telescope-bibtex 
local bibtex_actions = require('telescope-bibtex.actions')
local bibtex_add = dofile('/Users/chanhyuk/.vim/custom_functions/bibtex_add.lua')
require('telescope').setup {
  extensions = {
    bibtex = {
      format = 'obsidian',
      mappings = {
        n = {
          ['<CR>'] = bibtex_add.citation_note(),
          ['<C-c>'] = bibtex_actions.key_append('[%s](../Reading_Notes/%s.md)'),
        },
        i = {
          ['<CR>'] = bibtex_add.citation_note(),
          ['<C-c>'] = bibtex_actions.key_append('[%s](../Reading_Notes/%s.md)'),
        },
      },
    },
  }
}
