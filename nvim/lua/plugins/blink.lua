require("blink.cmp").setup({
  snippets = { preset = "luasnip" },
  sources = { default = { "lsp", "path", "snippets", "buffer" } },
  fuzzy = {
    implementation = "lua",  -- force Lua fallback, disables warning
  },
  keymap = {
    preset = 'default',
    ['<CR>'] = { 'accept', 'fallback' },
  },
})
