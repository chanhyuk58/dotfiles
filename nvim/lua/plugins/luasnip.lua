local ls = require("luasnip")
local config = vim.fn.stdpath("config")

require("luasnip.loaders.from_vscode").lazy_load({ paths = { config .. "/lua/custom_snips/vs_snippets" } })
require("luasnip.loaders.from_lua").lazy_load({ paths = { config .. "/lua/custom_snips/lua_snippets" } })

ls.filetype_extend("rmd", { "math" })
ls.filetype_extend("markdown", { "math" })
ls.filetype_extend("tex", { "math" })
ls.filetype_extend("rmd", { "tex" })
ls.filetype_extend("markdown", { "tex" })

ls.config.set_config({
  enable_autosnippets = true,
  update_events = "TextChanged,TextChangedI",
})
