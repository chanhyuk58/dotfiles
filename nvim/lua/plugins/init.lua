require("lazy").setup({
  {
    "romus204/tree-sitter-manager.nvim",
    dependencies = {}, -- tree-sitter CLI must be installed system-wide
    config = function()
      require("tree-sitter-manager").setup({
        -- Default Options
        -- ensure_installed = {}, -- list of parsers to install at the start of a neovim session
        -- border = nil, -- border style for the window (e.g. "rounded", "single"), if nil, use the default border style defined by 'vim.o.winborder'. See :h 'winborder' for more info.
        auto_install = false, -- if enabled, install missing parsers when editing a new file
        highlight = true, -- treesitter highlighting is enabled by default
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
