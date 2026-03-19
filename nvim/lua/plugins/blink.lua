require("blink.cmp").setup({
  snippets = { preset = "luasnip" },
  sources = { 
      default = { "path", "snippets", "buffer" },
      providers = {
          snippets = {
              score_offset = 100,
              max_items = 4
          }
      }
  },
  fuzzy = {
    implementation = "lua",  -- force Lua fallback, disables warning
  },
  keymap = {
    preset = 'default',
    ['<CR>'] = { 'accept', 'fallback' },
  },
  completion = {
    ghost_text = { enabled = true, },
  },
  cmdline = {
    keymap = { preset = 'inherit' },
    completion = { 
      menu = { auto_show = true },
      list = { selection = { preselect = false, auto_insert = false } },
      ghost_text = { enabled = true, },
    },
  },
})
