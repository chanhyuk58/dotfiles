require("nvim-treesitter.configs").setup({
  ensure_installed = { "c", "lua", "latex", "python", "vim", "r", "query", "vimdoc", "markdown" },
  sync_install = false,
  auto_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    disable = function(lang, buf)
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      return ok and stats and stats.size > 100 * 1024
    end,
  },
  indent = { enable = true },
})
vim.treesitter.language.register('markdown', 'rmd')
