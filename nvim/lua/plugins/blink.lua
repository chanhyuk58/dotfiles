require("blink.cmp").setup({
  snippets = { preset = "luasnip" },
  sources = { default = { "path", "snippets", "buffer" } },
  fuzzy = {
    implementation = "lua",  -- force Lua fallback, disables warning
  },
  keymap = {
    preset = 'default',
    ['<CR>'] = { 'accept', 'fallback' },
  },
  cmdline = {
    keymap = { preset = 'inherit' },
    completion = { 
      menu = { auto_show = true },
      list = { selection = { preselect = false, auto_insert = false } },
    },
  },
})
