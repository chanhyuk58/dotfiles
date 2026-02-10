require("lazy").setup({
  { "nvim-treesitter/nvim-treesitter", lazy = false, build = ":TSUpdate", 
    config = function() require("plugins.treesitter") end },
  { "L3MON4D3/LuaSnip", lazy = false, config = function() require("plugins.luasnip") end },
  { "lewis6991/gitsigns.nvim", lazy = false },
  { "tpope/vim-fugitive" },
  { "jpalardy/vim-slime", config = function() require("plugins.slime").setup() end },
  {
    "ivanesmantovich/xkbswitch.nvim",
    lazy = false,
    cond = function() return vim.fn.has("mac") == 1 end,
  },
  { "saghen/blink.cmp", 
    lazy = false,
    dependencies = { "L3MON4D3/LuaSnip", version = "v2.*" },
    opts = function() require("plugins.blink") end,
  }, 
})
