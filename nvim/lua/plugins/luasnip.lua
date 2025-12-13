local ls = require("luasnip")
local config = vim.fn.stdpath("config")

require('luasnip.loaders.from_vscode').lazy_load({ paths = { config .. "/lua/custom_snips/vs_snippets" } })
require('luasnip.loaders.from_lua').lazy_load({ paths = { config .. "/lua/custom_snips/lua_snippets" } })
ls.setup({ enable_autosnippets = true })
ls.filetype_extend('rmd', { 'math' })
ls.filetype_extend('markdown', { 'math' })
ls.filetype_extend('tex', { 'math' })
