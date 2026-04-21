require("lazy").setup({
    {
    "romus204/tree-sitter-manager.nvim",
    lazy = false,
    opts = {
      ensure_installed = { 
        "c", "python", "latex", "r", "markdown", 
        "lua", "vim", "zsh", "bash" 
      },
    },
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
