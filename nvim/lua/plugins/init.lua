require("lazy").setup({
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = function() require("plugins.treesitter") end },
  { "L3MON4D3/LuaSnip", config = function() require("plugins.luasnip") end },
  { "lewis6991/gitsigns.nvim" },
  { "tpope/vim-fugitive" },
  { "jpalardy/vim-slime", config = function() require("plugins.slime") end },
  { "ivanesmantovich/xkbswitch.nvim", config = function() require('xkbswitch').setup() end },
  {"saghen/blink.cmp", version = "1.*", 
    dependencies = { "L3MON4D3/LuaSnip", version = "v2.*" },
    opts = function() require("plugins.blink") end,
  }
})
