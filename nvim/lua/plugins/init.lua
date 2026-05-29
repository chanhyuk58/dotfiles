require("lazy").setup({
  {
    "romus204/tree-sitter-manager.nvim",
    dependencies = {},
    config = function()
      require("tree-sitter-manager").setup({
        -- ensure_installed = {},
        -- border = nil,
        auto_install = true,
        highlight = true,
        -- languages = {}, -- override or add new parser sources
        -- parser_dir = vim.fn.stdpath("data") .. "/site/parser",
        -- query_dir = vim.fn.stdpath("data") .. "/site/queries",
      })
    end
  },
  { "L3MON4D3/LuaSnip", lazy = false, config = function() require("plugins.luasnip") end },
  { "lewis6991/gitsigns.nvim", lazy = false },
  { "tpope/vim-fugitive" },
  { "jpalardy/vim-slime", config = function() require("plugins.slime").setup() end },
  {
    "ivanesmantovich/xkbswitch.nvim",
    lazy = false,
    cond = function() return vim.fn.has("mac") == 1 end,
    config = function() require("xkbswitch").setup() end,
  },
  { "saghen/blink.cmp", 
  lazy = false,
  version = "1.*",
  opts = function() require("plugins.blink") end,
}, 
{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
})
