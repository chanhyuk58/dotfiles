require("nvim-treesitter.configs").setup({
  ensure_installed = { "c", "lua", "latex", "python", "vim", "r", "markdown", "markdown_inline" },
  sync_install = false,
  auto_install = true,
  
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    disable = function(lang, buf)
      local max_filesize = 80 * 1024 
      local uv = vim.uv or vim.loop
      local ok, stats = pcall(uv.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
      local max_lines = 3000
      if vim.api.nvim_buf_line_count(buf) > max_lines then
        return true
      end
    end,
  },
  
  indent = {
    enable = false,
  },
})

vim.treesitter.language.register('markdown', 'rmd')
